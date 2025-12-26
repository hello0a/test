package reservation.DAO;

import reservation.DTO.UserDTO;

public interface UserDAO{
	// 로그인 : 입력 (id(name), password) -> 출력 (UserDTO or null)
	UserDTO login(String name, String password);
	// 회원가입 : 입력(UserDTO) -> 출력 (성공 수 or boolean)
	int signup(UserDTO user);
	// 마이페이지 조회 : 입력(로그인한 유저 id) -> 출력(UserDTO)
	UserDTO findById(String id);
	// 마이페이지 회원 정보 수정 : 입력(UserDTO) -> 출력(성공 수)
	int mypageupdate(UserDTO user);
	
}
