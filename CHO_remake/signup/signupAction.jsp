<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%
    request.setCharacterEncoding("UTF-8");
    
    // 파라미터 수집
    String userId = request.getParameter("id");
    String userPw = request.getParameter("pw");
    String email = request.getParameter("email");
    String fullName = request.getParameter("name");
    String phone = request.getParameter("phone");
    String birthYear = request.getParameter("birthYear");
    String birthMonth = request.getParameter("birthMonth");
    String birthDay = request.getParameter("birthDay");
    String gender = request.getParameter("gender");
    String nationality = request.getParameter("nation");
    
    // 생년월일 처리
    String birthStr = birthYear + "-" + 
                      String.format("%02d", Integer.parseInt(birthMonth)) + "-" + 
                      String.format("%02d", Integer.parseInt(birthDay)) + " 00:00:00";
    
    // 데이터베이스 연결 설정
    String url = "jdbc:mysql://localhost:3306/hairshop?serverTimezone=UTC&useSSL=false&allowPublicKeyRetrieval=true";
    String dbId = "root";
    String dbPw = "123456";
    
    Connection conn = null;
    PreparedStatement pstmt = null;
    
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(url, dbId, dbPw);
        
        // SQL 실행
        String sql = "INSERT INTO users (id, password, email, full_name, birth, gender, nationality, phonenumber) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, userId);
        pstmt.setString(2, userPw);
        pstmt.setString(3, email);
        pstmt.setString(4, fullName);
        pstmt.setString(5, birthStr);
        pstmt.setString(6, gender);
        pstmt.setString(7, nationality);
        pstmt.setString(8, phone);
        
        int result = pstmt.executeUpdate();
        
        if (result > 0) {
            // 세션 저장
            session.setAttribute("userId", userId);
            session.setAttribute("userName", fullName);
%>
            <script>
                alert("등록되었습니다!");
                location.href = "../mypage_user/reserve.jsp";  // 회원가입 완료시 예약페이지로 이동!
            </script>
<%
        }
    } catch (Exception e) {
        e.printStackTrace();
        out.println("<script>alert('회원가입 중 오류가 발생했습니다.'); history.back();</script>");
    } finally {
        if (pstmt != null) try { pstmt.close(); } catch (Exception e) {}
        if (conn != null) try { conn.close(); } catch (Exception e) {}
    }
%>