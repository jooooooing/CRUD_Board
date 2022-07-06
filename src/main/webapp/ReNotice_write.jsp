<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*,javax.sql.*,java.io.*,java.util.Date,java.text.SimpleDateFormat" %> 
<!--라이브러리 불러오기-->
<% request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>write</title>
</head>
<body>
	<%
	request.setCharacterEncoding("UTF-8"); // 한글 처리
	Class.forName("com.mysql.cj.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/kopoctc", "root", "koposw31");
	Statement stmt = conn.createStatement();
	Statement stmt2 = conn.createStatement();
	
	String title = request.getParameter("title");
	String today = new java.text.SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
	String content = request.getParameter("content");
	String rootid = request.getParameter("rootid");
	int relevel = 0;
	relevel = Integer.parseInt(request.getParameter("relevel"));
	String recnt = request.getParameter("recnt");
	String sql = "";


	if (relevel != 0) {
		sql = "insert into notice_re(title, date, content, rootid, recnt, viewcnt) values ('" + title + "',,date(now()),'"
		+ content + "'," + rootid + "," + relevel + "," + recnt + ",0)";
		stmt.execute(sql);
	} else {
		sql = "insert into notice_re(title,date,content,relevel,recnt,viewcnt) values('" + title + "',date(now()),'" + content
		+ "',0,0,0)";
		stmt.execute(sql);
		sql = "select max(id) from notice_re;";
		ResultSet rset = stmt2.executeQuery(sql);
		rset.next();
		int setRootid = rset.getInt(1);
		rset.close();
		stmt2.close();
		sql = "update notice_re set rootid = " + setRootid + " where id = " + setRootid + ";";
		stmt.execute(sql);
	}
	stmt.close();
	conn.close();
	%>
	<script>
		alert("등록완료");
		window.location.href = "ReNotice_list.jsp?=from=0&cnt=15&page=1"; //특정페이지로의 이동
	</script>
</body>
</html>