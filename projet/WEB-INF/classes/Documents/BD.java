package Documents;

public class BD extends Documents {
	
	public BD(String titre, String num, String user, String etat) {
		super(titre, num, user, etat, "Bande dessinée");
	}

	public String getType() {
		return super.getType();
	}
	
	public String getTitre()
	{
		return super.getTitre();
	}
	
	public String getEtat()
	{
		return super.getEtat();
	}
	
	public String getNum()
	{
		return super.getNum();
	}
}
