<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>write</title>
</head>
<body>
	<%
	request.setCharacterEncoding("UTF-8"); // 한글 처리
	String title = request.getParameter("title");
	String today = new java.text.SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
	String content = request.getParameter("content");

	Class.forName("com.mysql.cj.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/kopoctc", "root", "koposw31");


	String sql = "insert into notice (title, date, content) values (?, ?, ?);";
	PreparedStatement pstmt = conn.prepareStatement(sql);
	pstmt.setString(1, title);
	pstmt.setString(2, today);
	pstmt.setString(3, content);

	pstmt.executeUpdate();
	pstmt.close();
	conn.close();
	%>

	<script>
		alert("등록완료");
		window.location.href = "notice_list.jsp"; //특정페이지로의 이동
	</script>
</body>
</html>