<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.sql.*,javax.sql.*, java.io.*"%>
<%@ page import="java.util.Calendar"%>

<html>
<head>
<%
Class.forName("com.mysql.cj.jdbc.Driver");
Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/kopoctc", "root", "koposw31");
Statement stmt = conn.createStatement();
Statement stmt2 = conn.createStatement();
String id = request.getParameter("key");
String addViewCnt = "update notice_re set viewcnt = viewcnt+1 where id = " + id + ";";
stmt2.execute(addViewCnt);
String viewOne = "select * from notice_re where id = '" + id + "';"; //해당 번호만 조회
ResultSet rset = stmt.executeQuery(viewOne); //쿼리문을 실행하고 반환한 값을 저장.
String title = "";
String contents = "";
String rootid = "";
int recnt, relevel, viewcnt = 0;

rset.next();
title = rset.getString(2);
contents = rset.getString(4);
recnt = rset.getInt(7);
relevel = rset.getInt(6);
viewcnt = rset.getInt(8);
rootid = rset.getString(5);
%>
<title>글 보기</title>
</head>
<body>

		<table cellspacing=1 width=650 border="1" style="margin-left: auto; margin-right: auto;">

		<tr>
			<td>
				<b>번호</b>
			</td>
			<td width=480 colspan=3 align=left>
				<input type='hidden' name="id" value=<%=id%>><%=id%></td>
		</tr>

		<tr>
			<td>
				<b>제목</b>
			</td>
			<td width=480 colspan=3 align=left>
				<input type='hidden' name="title" value=<%=title%>><%=title%></td>
		</tr>

		<tr>
			<td>
				<b>일자</b>
			</td>
			<td width=480 colspan=3 align=left>
				<input type='hidden' name="today" value=<%=rset.getDate(3)%>><%=rset.getDate(3)%></td>
		</tr>
		<tr>
			<td>조회수</td>
			<td><%=viewcnt%></td>
		</tr>

		<td>내용</td>
		<td width=480 colspan=3 align=left>
			<textarea rows="10px" cols="70px" readonly><%=contents%>
		</textarea>
		</td>
		</tr>
		<tr>
			<td>원글</td>
			<td><%=rootid%></td>
		</tr>
		<tr>
			<td>댓글수준</td>
			<td><%=relevel%>
				<b>댓글내 순서<%=recnt%></b>
			</td>
			<%
			rset.close();
			stmt.close();
			conn.close();
			%>
		</tr>
	</table> 

	<table width="650" style="margin-left: auto; margin-right: auto;">

		<tr>
			<td width=500></td>
			<td>
				<input type=button value="목록" OnClick="location.href='ReNotice_list.jsp?from=0&cnt=15&page=1'">
			</td>
			<td>
				<input type=button value="수정" OnClick="location.href='ReNotice_updateView.jsp?key=<%=id%>'">
			</td>
			<td>
				<input type=button value="삭제" OnClick="location.href='ReNotice_delete.jsp?key=<%=id%>&relevel=<%=relevel%>'">
			</td>
			<td>
				<input type=button value="댓글" OnClick="location.href='ReNotice_reinsert.jsp?key=<%=id%>&relevel=<%=relevel%>&recnt=<%=recnt%>&rootid=<%=rootid%>'">
			</td>
		</tr>
	</table>

</body>
</html>


