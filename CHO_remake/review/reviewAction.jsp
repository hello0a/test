<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%
    request.setCharacterEncoding("UTF-8");
    
    // 파라미터 수집
    String designerNo = request.getParameter("designer_no");
    String visitDate = request.getParameter("visitDate");
    String content = request.getParameter("content");
    
    // 세션에서 사용자 아이디 가져오기 (현재는 테스트를 위해 'testuser' 고정 또는 세션 확인)
    String userId = (String) session.getAttribute("userId");
    if (userId == null) {
        userId = "testuser"; // 테스트용 기본값
    }
    
    // 데이터베이스 연결 설정
    String url = "jdbc:mysql://localhost:3306/hairshop?serverTimezone=UTC&useSSL=false&allowPublicKeyRetrieval=true";
    String dbId = "root";
    String dbPw = "123456";
    
    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;
    
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(url, dbId, dbPw);
        
        // 1. 해당 유저의 가장 최근 예약 번호(reserved_no) 가져오기
        // (리뷰를 쓰려면 예약이 있어야 하므로)
        String resSql = "SELECT no FROM reserved WHERE user_no = (SELECT no FROM users WHERE id = ?) " +
                        "AND designer_no = ? ORDER BY no DESC LIMIT 1";
        
        pstmt = conn.prepareStatement(resSql);
        pstmt.setString(1, userId);
        pstmt.setString(2, designerNo);
        rs = pstmt.executeQuery();
        
        int reservedNo = 0;
        if (rs.next()) {
            reservedNo = rs.getInt("no");
        }
        
        if (reservedNo == 0) {
            out.println("<script>alert('해당 디자이너에게 예약한 내역이 없습니다.'); history.back();</script>");
            return;
        }
        
        // 2. 리뷰 테이블에 삽입
        String insertSql = "INSERT INTO review (reserved_no, designer_no, content) VALUES (?, ?, ?)";
        pstmt = conn.prepareStatement(insertSql);
        pstmt.setInt(1, reservedNo);
        pstmt.setInt(2, Integer.parseInt(designerNo));
        pstmt.setString(3, content);
        
        int result = pstmt.executeUpdate();
        
        if (result > 0) {
%>
            <script>
                alert("리뷰가 등록되었습니다!");
                location.href = "review_list.jsp";
            </script>
<%
        }
     // reviewAction.jsp의 catch 블록 수정
    } catch (Exception e) {
        e.printStackTrace();
        // 에러 메시지 내의 따옴표(')를 역슬래시(\')로 치환하여 자바스크립트 오류 방지
        String errMsg = e.getMessage().replace("'", "\\'"); 
        out.println("<script>");
        out.println("alert('리뷰 등록 실패: " + errMsg + "');");
        out.println("history.back();");
        out.println("</script>");
    }
%>