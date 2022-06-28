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
	<%
	/* 테이블 생성 */
/* 	try {
		stmt.execute("create table notice( id int not null primary key auto_increment, title varchar(70),"
		+ "date date, content text)DEFAULT CHARSET=utf8");
		out.println("table 생성 완료");
	} catch (Exception e) {
		out.println("table 생성 실패");
		out.println(e.toString());
	} */
	%>

	<%
try {
	String sql ="";
	sql = "insert into notice(title, date, content) values ('공지사항1', date(now()), '공지사항내용1')";
	stmt.execute(sql);
	sql = "insert into notice(title, date, content) values ('공지사항2', date(now()), '공지사항내용2')";
	stmt.execute(sql);
	sql = "insert into notice(title, date, content) values ('공지사항3', date(now()), '공지사항내용3')";
	stmt.execute(sql);
	sql = "insert into notice(title, date, content) values ('공지사항4', date(now()), '공지사항내용4')";
	stmt.execute(sql);
	sql = "insert into notice(title, date, content) values ('공지사항5', date(now()), '공지사항내용5')";
	stmt.execute(sql);
	out.println("data 입력 완료");
} catch (Exception e) {
	out.println("data 입력 실패");
}


stmt.close();
conn.close();
%>

</body>
</html>