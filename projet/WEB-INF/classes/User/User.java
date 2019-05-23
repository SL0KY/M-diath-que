package User;

import mediatheque.*;

public class User implements Utilisateur{
	private String user_login;
	private String user_password;
	private String user_status;

	public User()
	{
		
	}
	
	public User(String login, String password, String status)
	{
		this.user_login = login;
		this.user_password = password;
		this.user_status = status;
	}
	
	public String getLogin()
	{
		return this.user_login;
	}

	@Override
	public boolean bibliothecaire() {
		if(this.user_status.equals("0"))
		{
			return true;
		}
		else
		{
			return false;
		}
	}

	public String toString() {
		return this.getLogin();
	}

	@Override
	public String name() {
		// TODO Auto-generated method stub
		return null;
	}
}
