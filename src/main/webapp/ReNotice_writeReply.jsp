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
	Date now = new Date();
	SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");

	String today = sf.format(now);
	
	request.setCharacterEncoding("UTF-8"); // 한글 처리
	Class.forName("com.mysql.cj.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/kopoctc", "root", "koposw31");
	Statement stmt = conn.createStatement();
	String title = request.getParameter("title");
	String content = request.getParameter("content");
	String id = request.getParameter("id");
	String rootid = request.getParameter("rootid");
	String date = request.getParameter("date");
	int relevel = 0;
	relevel = Integer.parseInt(request.getParameter("relevel"));
	String sql="";
	int recnt = 0;

  	//원글로 댓글 및 대댓글 판별하기!


	String query1 = "select g.* from notice_re as g, (select recnt from notice_re where id=?) as r where rootid=? and r.recnt <=g.recnt order by g.recnt;";
    PreparedStatement pstmt = conn.prepareStatement(query1);
    pstmt.setInt(1, Integer.parseInt(id));
    pstmt.setInt(2, Integer.parseInt(rootid)); 
    ResultSet rset = pstmt.executeQuery();


    // 첫번째 record는 댓글달고자하는 글
    rset.next();
    relevel = rset.getInt("relevel") + 1;   
    recnt = rset.getInt("recnt");           // 해당 글의 recnt

    while (rset.next()) {                       // 아래 record를 접근하며 relevel이 같거나 높으면 recnt 갱신, 낮으면 break
      if (rset.getInt("relevel") >= relevel) {
        recnt = rset.getInt("recnt");
      } else {
        break;
      }
    }
    recnt++;                                    // 그 다음에 와야하므로 +1


    // 추가할 댓글 아래 위치할 댓글들의 recnt +1 증가
    String query2 = "update notice_re set recnt = recnt + 1 where rootid=? and recnt >= ?;";
    pstmt = conn.prepareStatement(query2);
    pstmt.setString(1, rootid);
    pstmt.setInt(2, recnt);
    pstmt.executeUpdate();


    // DB에 저장
    String query3 = "insert into notice_re(title, date, content, rootid, relevel, recnt) values(?, ?, ?, ?, ?, ?);";
    pstmt = conn.prepareStatement(query3);
    pstmt.setString(1, title);
    pstmt.setString(2, date);
    pstmt.setString(3, content);
    pstmt.setString(4, rootid);
    pstmt.setInt(5, relevel);
    pstmt.setInt(6, recnt);
    pstmt.executeUpdate();


    // 자동부여된 ID 조회
    String query4 = "select id from notice_re order by id desc limit 1";
    pstmt = conn.prepareStatement(query4);
    rset = pstmt.executeQuery();
    rset.next();
    int newId = rset.getInt(1);


    rset.close();
    pstmt.close();
    conn.close();
  %>
	<script>
		alert("등록완료");
		window.location.href = "ReNotice_list.jsp?=from=0&cnt=15&page=1"; //특정페이지로의 이동
	</script>
</body>
</html>