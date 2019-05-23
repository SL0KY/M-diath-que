package Documents;

public class JeuxVideo extends Documents {
	public JeuxVideo(String titre, String num, String user, String etat) {
		super(titre, num, user, etat, "Jeux vidéos");
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
