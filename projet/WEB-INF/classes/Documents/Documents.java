package Documents;
import mediatheque.Document;
import mediatheque.EmpruntException;
import mediatheque.RetourException;
import mediatheque.Utilisateur;

import java.sql.*;
public abstract class Documents implements Document {
	private String numDoc;
	private String document_titre;
	private String user_login;
	private String document_etat;
	private String dicument_type;
	private Connection connect;
	
	public Documents(String titre, String num, String user, String etat, String type) {
		this.numDoc = num;
		this.document_titre = titre;
		this.document_etat = etat;
		this.user_login = user;
		this.dicument_type = type;
	}
		
	@Override
	public Object[] affiche() {
		return new Object[] {getNum(), getTitre(), getEtat(), getUserLogin(), getType(), numDoc, document_titre, document_etat, user_login, dicument_type};
	}

	@Override
	public void emprunter(Utilisateur arg0) throws EmpruntException {
		String url = "jdbc:oracle:thin:@localhost:1521:XE";
		String user ="ETUDIANT";
		String password = "ETUDIANT";
		
		try {
			Class.forName("oracle.jdbc.OracleDriver");
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
		
		try {
			connect = DriverManager.getConnection(url, user, password);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		if (this.document_etat.equals("Disponible")) {
			String req = "UPDATE documents SET user_login=?, documents_etat='Emprunte' WHERE documents_numDocument = ? ";
			PreparedStatement res;
			try {
				res = connect.prepareStatement(req);
				res.setString(1, arg0.toString());
				res.setInt(2, Integer.parseInt(this.getNum()));
				ResultSet set = res.executeQuery();
				System.out.println(set);
				this.user_login = arg0.name(); 
				this.document_etat = "Emprunte";
			}
			catch(SQLException e) {
				e.printStackTrace();
			}
		}
		else {
			
		}
	}

	@Override
	public void retour(Utilisateur arg0) throws RetourException {
		String url = "jdbc:oracle:thin:@localhost:1521:XE";
		String user ="ETUDIANT";
		String password = "ETUDIANT";
		
		try {
			Class.forName("oracle.jdbc.OracleDriver");
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
		
		try {
			connect = DriverManager.getConnection(url, user, password);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		if (this.document_etat.equals("Emprunte")) {
			String req = "UPDATE documents SET user_login = '', documents_etat = 'Disponible' WHERE documents_numDocument = ? ";
			PreparedStatement res;
			try {
				res = connect.prepareStatement(req);
				res.setInt(1, Integer.parseInt(this.getNum()));
				res.executeQuery();
				this.user_login = null; 
				this.document_etat = "Disponible";
			}
			catch(SQLException e) {
				e.printStackTrace();
			}
			}
			else {

		}
	}
	
	public String getTitre()
	{
		return this.document_titre;
	}
	
	public String getEtat()
	{
		return this.document_etat;
	}
	
	public String getNum()
	{
		return this.numDoc;
	}
	
	public String getUserLogin()
	{
		return this.user_login;
	}
	
	public String getType() {
		return this.dicument_type;
	}
}
