<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, javax.sql.*, java.net.*, java.io.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

	<%
	Class.forName("com.mysql.cj.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/kopoctc", "root", "koposw31");
	Statement stmt = conn.createStatement();
	%>
<%-- 	<%
	try {
		stmt.execute("create table notice_re ( id int not null primary key auto_increment, title varchar(70),"
		+ "date date, content text)DEFAULT CHARSET=utf8");
		out.println("table 생성 완료");
	} catch (Exception e) {
		out.println("table 생성 실패");
		out.println(e.toString());
	}
	%> --%>
	
<%-- 	<%
	try {
	stmt.execute("alter table notice_re add rootid int;");
	stmt.execute("alter table notice_re add relevel int;");
	stmt.execute("alter table notice_re add recnt int;");
	stmt.execute("alter table notice_re add viewcnt int;");
	out.println("table 칼럼 추가 완료");
	} catch (Exception e) {
		out.println("table 생성 실패");
		out.println(e.toString());
	}
	%> --%>

	
<%--  <% try {
	String sql ="";
	sql = "insert into notice_re(title, date, content) values ('공지사항1', date(now()), '공지사항내용1')";
	stmt.execute(sql);
	sql = "insert into notice_re(title, date, content) values ('공지사항2', date(now()), '공지사항내용2')";
	stmt.execute(sql);
	sql = "insert into notice_re(title, date, content) values ('공지사항3', date(now()), '공지사항내용3')";
	stmt.execute(sql);
	sql = "insert into notice_re(title, date, content) values ('공지사항4', date(now()), '공지사항내용4')";
	stmt.execute(sql);
	sql = "insert into notice_re(title, date, content) values ('공지사항5', date(now()), '공지사항내용5')";
	stmt.execute(sql);
	out.println("data 입력 완료");
} catch (Exception e) {
	out.println("data 입력 실패");
} %> --%>


<%
stmt.close();
conn.close();
%>

		<table width=540>
			<td width=500></td>
			<td><input type=button value="목록으로 돌아가기"
				OnClick="location.href='ReNotice_list.jsp'"></td>
		</table>

</body>
</html>