package reservation.DAO;

import reservation.DTO.UserDTO;

public class UserDAOImpl extends JDBConnection implements UserDAO {

	/* 로그인 */
	@Override
	public UserDTO login(String name, String password) {
		// TODO Auto-generated method stub
		return null;
	}
	/* 회원가입 */
	@Override
	public int signup(UserDTO user) {
		// TODO Auto-generated method stub
		return 0;
	}
	/* 마이페이지 회원 조회 */
	@Override
	public UserDTO findById(String id) {
		// TODO Auto-generated method stub
		return null;
	}
	/* 마이페이지 회원 수정 */
	@Override
	public int mypageupdate(UserDTO user) {
		// TODO Auto-generated method stub
		return 0;
	}
	


}
