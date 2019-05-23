package persistentdata;


import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import Documents.*;
import User.User;
import mediatheque.*;

// classe mono-instance  dont l'unique instance n'est connue que de la bibliotheque
// via une auto-déclaration dans son bloc static

public class MediathequeData implements PersistentMediatheque {
// Jean-François Brette 01/01/2018
	private Connection connect;
	
	static {
		Mediatheque.getInstance().setData(new MediathequeData());
	}

	private MediathequeData() {

		//String url = "jdbc:oracle:thin:@vs-oracle2:1521:ORCL";
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
	
	}
	
	// renvoie la liste de tous les documents de la bibliothèque
	@Override
	public List<Document> tousLesDocuments() {
		List<Document> Docs = new ArrayList<Document>();
		String req = "SELECT * FROM documents";
		PreparedStatement res;
		try {
			res = connect.prepareStatement(req);
			ResultSet set = res.executeQuery();
			if(set.next())
			{
				do {
					switch(set.getString("typeDocuments_id"))
					{
						case "0":
							Docs.add(new DVD(set.getString("documents_titre"), set.getString("documents_numDocument"), set.getString("user_login"), set.getString("documents_etat")));
							break;
						case "1":
							Docs.add(new BD(set.getString("documents_titre"), set.getString("documents_numDocument"), set.getString("user_login"), set.getString("documents_etat")));
							break;
						case "2":
							Docs.add(new Livre(set.getString("documents_titre"), set.getString("documents_numDocument"), set.getString("user_login"), set.getString("documents_etat")));
							break;
						case "3":
							Docs.add(new JeuxVideo(set.getString("documents_titre"), set.getString("documents_numDocument"), set.getString("user_login"), set.getString("documents_etat")));
							break;
					}
				}while(set.next());
				
			}
			else
			{
				Docs = null;
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return Docs;
	}

	// va récupérer le User dans la BD et le renvoie
	// si pas trouvé, renvoie null
	@Override
	public Utilisateur getUser(String login, String password) {
		User user = null;
		String req = "SELECT * FROM users WHERE user_login=? AND user_password=?";
		PreparedStatement res;
		try {
			res = connect.prepareStatement(req);
			res.setString(1, login);
			res.setString(2, password);
			ResultSet set = res.executeQuery();
			if(set.next())
			{
				user = new User(set.getString("user_login"), set.getString("user_password"), set.getString("status_id"));
			}
			else
			{
				user = null;
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return user;
	}

	// va récupérer le document de numéro numDocument dans la BD
	// et le renvoie
	// si pas trouvé, renvoie null
	@Override
	public Document getDocument(int numDocument) {
		Documents document = null;
		String req = "SELECT * FROM documents WHERE documents_numDocument=?";
		PreparedStatement res;
		try {
			res = connect.prepareStatement(req);
			res.setInt(1, numDocument);
			ResultSet set = res.executeQuery();
			if(set.next())
			{
				switch(set.getString("typeDocuments_id"))
				{
					case "0":
						document = new DVD(set.getString("documents_titre"), set.getString("documents_numDocument"), set.getString("user_login"), set.getString("documents_etat"));
						break;
					case "1":
						document = new BD(set.getString("documents_titre"), set.getString("documents_numDocument"), set.getString("user_login"), set.getString("documents_etat"));
						break;
					case "2":
						document = new Livre(set.getString("documents_titre"), set.getString("documents_numDocument"), set.getString("user_login"), set.getString("documents_etat"));
						break;
					case "3":
						document = new JeuxVideo(set.getString("documents_titre"), set.getString("documents_numDocument"), set.getString("user_login"), set.getString("documents_etat"));
						break;
				}
				
			}
			else
			{
				document = null;
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return document;
	}

	@Override
	public void nouveauDocument(int type, Object... args) {
		String req = "INSERT INTO documents (documents_numDocument, documents_titre, user_login, documents_etat, typeDocuments_id) VALUES (seq_documents.nextval, ?, NULL, 'Disponible', ?)";
		PreparedStatement res;
		
		try {
			res = connect.prepareStatement(req);
			res.setString(1, (String) args[0]);
			res.setInt(2, type);
			ResultSet set = res.executeQuery();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	@Override
	public void supprimeDocument(int arg0) throws SuppressionException {
		String req = "DELETE FROM documents WHERE documents_numDocument=?";
		PreparedStatement res;	
		try {
			res = connect.prepareStatement(req);
			res.setInt(1, arg0);
			ResultSet set = res.executeQuery();
			System.out.println(set);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

}
