package Documents;

public class Livre extends Documents {
	public Livre(String titre, String num, String user, String etat) {
		super(titre, num, user, etat, "Livre");
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
