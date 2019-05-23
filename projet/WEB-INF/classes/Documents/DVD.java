package Documents;

public class DVD extends Documents {
	public DVD(String titre, String num, String user, String etat) {
		super(titre, num, user, etat, "DVD");
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
