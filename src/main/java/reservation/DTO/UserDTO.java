package reservation.DTO;

import java.sql.Timestamp;
import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;


@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class UserDTO {
	private int no;
	private String name;
	private String password;
	private String email;
	private String full_name;
	private Date birth;
	private boolean gender;
	private boolean nationality;
	private int phonenumber;
	private Timestamp created_at;
	private Timestamp updated_at;
	
}

