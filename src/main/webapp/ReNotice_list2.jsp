<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.sql.*,javax.sql.*,java.io.*,java.util.Date,java.text.SimpleDateFormat"%>

<html>
<head>
<title>공지사항 게시판</title>
<%
Class.forName("com.mysql.cj.jdbc.Driver");
Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/kopoctc", "root", "koposw31");
Statement stmt = conn.createStatement();//Statement 객체 생성
int frontNum = 0;
int cnt = 15;
int k = 1;
ResultSet rset2 = stmt.executeQuery("select count(*) from notice_re;");

double total = 0; //math.ceil써야해서 double 사용
while (rset2.next()) { //쿼리 돌려서 전체 갯수 구함
	total = rset2.getInt(1);
} 

double finalPage = Math.ceil(total / cnt); //전체 갯수를 한 페이지 당 출력갯수로 나눈것을 올림= 마지막 페이지 번호 (21개를 20개씩 출력하면 2페이지 필요)
rset2.close();
String dateCheck = "";
String title = "";
Date now = new Date();
SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");
String today = sf.format(now);

ResultSet rset = stmt.executeQuery(
		"select * from notice_re order by rootid desc, recnt asc, relevel asc limit " + frontNum + "," + cnt + ";");
%>
</head>
<body>
	<table cellspacing=1 width=650 border=1 style="margin-left: auto; margin-right: auto;">
		<tr>
			<td width=50>
				<p align=center>번호</p>
			</td>
			<td width=400>
				<p align=center>제목</p>
			</td>
			<td width=100>
				<p align=center>조회수</p>
			</td>
			<td width=100>
				<p align=center>등록일</p>
			</td>
		</tr>
		<%
		while (rset.next()) {
			dateCheck = rset.getString(3);
			title = rset.getString(2);
			if (today.equals(dateCheck)) {
				title = title + "[New]";
			}

			if (rset.getInt(6) == 0) {
				out.println("<tr>");
				out.println("<td width = 50><p align='center'>" + rset.getInt(1) + "</p></td>");
		%>
		<td width=50>
			<p>
				<a href="ReNotice_view.jsp?key=<%=rset.getInt(1)%>"><%=title%></a>
			</p>
		</td>
		<%
		out.println("<td width = 50 align='center'><p>" + rset.getInt(8) + "</p></td>");
		out.println("<td width = 50 align='center'><p>" + rset.getDate(3) + "</p></td>");
		out.println("</tr>");
		} else {
		out.println("<tr>");
		out.println("<td width = 50><p  align='center'>" + rset.getInt(1) + "</p></td>");
		%>
		<td width=50>
			<p>
				<a href="ReNotice_view.jsp?key=<%=rset.getInt(1)%>">
					<%
					for (int i = 0; i < rset.getInt(6); i++) {
					%>
					-
					<%
					}
					%>>[Re]<%=rset.getString(2)%></a>
			</p>
		</td>

		<%
		out.println("<td width = 50 align='center'><p>" + rset.getInt(8) + "</p></td>");
		out.println("<td width = 50 align='center'><p>" + rset.getDate(3) + "</p></td>");
		out.println("</tr>");
		}
		}
		%>
	</table>
	<div class="page">
		<br>
		<center>
	<%
			if (total != 0) {
				if (total / cnt > 2) {
					if (k > 1) {
				out.print("<a href='ReNotice_list.jsp?from=" + ((k - 2) * (10 * cnt)) + "&cnt=" + cnt + "&page=" + (k - 1)
						+ "'>" + "<<" + "</a>");
					} else {
				out.print("<a href='ReNotice_list.jsp?from=0&cnt=" + cnt + "&page=1'>" + "<<" + "</a>"); //
					}
				}

				for (int i = 1; i < 11; i++) {
					out.print("<a href='ReNotice_list.jsp?from=" + ((k - 1) * (10 * cnt) + ((i - 1) * cnt)) + "&cnt=" + cnt
					+ "&page=" + k + "'>" + (((k - 1) * 10) + i) + "  </a>");
					if ((((k - 1) * 10) + i) == finalPage) {
				break;
					}
				}

				if (k < (finalPage / 10)) {
					out.print("<a href='ReNotice_list.jsp?from=" + ((k) * (10 * cnt)) + "&cnt=" + cnt + "&page=" + (k + 1) + "'>"
					+ ">>" + "</a>"); // k값 1 늘어남
				}

			}
		%> 
		</center>
	</div>
	<table style="margin-left:auto; margin-right:auto;">
		<tr>
			<td width=600></td>
			<td>
				<input align=right type=submit OnClick="window.location.href='ReNotice_insert.jsp'" value=신규></input>
			</td>
		</tr>
	</table>

	<%
rset.close();
stmt.close();
conn.close();
%>

</body>
</html>
</head>