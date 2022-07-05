<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.sql.*,javax.sql.*, java.io.*"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.Date"%>

<html>
<head>
</head>
<body>
	<%
	String today = new java.text.SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());

	Class.forName("com.mysql.cj.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/kopoctc", "root", "koposw31");

	String id = request.getParameter("key");
	String sql = "select * from notice_re where id= " + id + ";";

	PreparedStatement pstmt = conn.prepareStatement(sql);

	ResultSet rset = pstmt.executeQuery();
	rset.next();

	int rootid = rset.getInt("rootid");
	int relevel = rset.getInt("relevel") + 1;
	int recnt = rset.getInt("recnt");
	%>

	<div>
		<h3>댓글 등록</h3>

		<FORM METHOD=POST name='fm' action="ReNotice_writeReply.jsp">
			<table width=650 border=1 cellspacing=0 cellpadding=5>
				<tr>
					<td>
						<b>번호</b>
					</td>
					<td>신규</td>
				</tr>
				<tr>
					<td>
						<b>제목</b>
					</td>
					<td>
						<input type="text" name=title size=70 maxlength=70 onkeyup="characterCheck(this)" onkeydown="characterCheck(this)" required>
					</td>
				</tr>
				<tr>
					<td>
						<b>일자</b>
					</td>
					<td><%=today%><input type="hidden" name="date" value="<%=today%>">
					</td>
				</tr>
				<tr>
					<td>
						<b>내용</b>
					</td>
					<td>
						<textarea style='width: 500px; height: 250px; overflow-y: scroll' name=content cols=70 row=600 required></textarea>
						<input type="hidden" name="relevel" value="0">
					</td>
				</tr>
				</tr>
				<tr>
					<td >
						<b>원글</b>
					</td>
					<td>
						<input type="number" name="rootid" value="<%=rootid%>" readonly> <input type="hidden" name="id" value="<%=id%>">
					</td>
				</tr>
				<tr>
					<td>
						<b>댓글 수준</b>
					</td>
					<td>
						<input type="number" name="relevel" value="<%=relevel%>" readonly>
					</td>
					<td>
						<b>댓글 순서</b>
					</td>
					<td>
						<input type="text" value="저장시 부여" readonly> <input type="hidden" name="recnt" value="<%=recnt%>">
					</td>
				</tr>
			</table>
			<table width=650>
				<tr>
					<td width=600></td>
					<td>
						<input type=button value="취소" onClick="window.location='ReNotice_list.jsp?from=0&cnt=15&page=1'">
					</td>
					<td>
						<input type=submit value="쓰기" onClick="window.location='ReNotice_list.jsp?from=0&cnt=15&page=1'">
					</td>
				</tr>
				<%
				rset.close();
				pstmt.close();
				conn.close();
				%>

			</table>
	</div>
	</FORM>
</body>
</html>