<%@page import="mediatheque.*, java.util.ArrayList, java.util.List"%>
<%@ page pageEncoding="UTF-8" %>
<html lang="fr">
	<head>
		<title>Account</title>
		<meta charset="UTF-8">
		<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
		<link rel="stylesheet" type="text/css" href="css/style.css">
	</head>
	
	<body>
	<%
		String login = request.getParameter("login");
		String password = request.getParameter("password");
		Mediatheque med;
		System.out.println(login);
		if(login == null)
		{
			login = (String)session.getAttribute("login");
			password = (String)session.getAttribute("password");
			med = (Mediatheque)session.getAttribute("mediatheque");
		}
		else
		{
			med = Mediatheque.getInstance();
		}
		Utilisateur user ;
		

		user = med.getUser(login, password);
		
		session.setAttribute("user", user);
		session.setAttribute("mediatheque", med);
		session.setAttribute("login", login);
		session.setAttribute("password", password);
		


		List docs = med.tousLesDocuments();

		if(user == null)
		{
			response.sendRedirect("auth.jsp?error=auth");
		}
		else
		{
			if(user.bibliothecaire() == true)
			{
		%>
		<div class="container-fluid">
			<div class="row justify-content-center">
				<div class="col-12">
					<h1 style="margin-top: 80px" class="text-center">Bienvenue <% out.println(user.toString()); %> sur votre espace bibliothécaire</h1>
				</div>
				<div class="col-md-4">
					<h3 class="text-center">Ajouter un document</h3>
					<%
						if(request.getParameter("success") != null)
						{
							String success = request.getParameter("success");
							if(success.equals("ok"))
							{
								out.println("<p class='text-center success'>Votre document à bien été ajouté</p>");
							}
							else if(success.equals("ko"))
							{
								out.println("<p class='text-center error'>Merci de renseigner tous les champs</p>");
							}
							else
							{
								out.println("<p class='text-center error'>Ce n'est pas bien de trafiquer l'url</p>");
							}
						}
						
					%>
					<form method="post" action="ajout.jsp">
						<input type="text" name="titre" placeholder="Entrer le titre du document"/>
						<select name="type"> 
							<option value="-1">--Sélectionner--</option>
							<option value="0">DVD</option>
							<option value="1">Bande dessinée</option>
							<option value="2">Livre</option>
							<option value="3">Jeux vidéos</option>
						</select>
						<input class="btn btn-primary" type="submit" value="Ajouter"/>
					</form>	
				</div>
				<div class="col-md-4">
					<h3 class="text-center">Supprimer un document</h3>
					<%
						if(request.getParameter("suppr") != null)
						{
							String success = request.getParameter("suppr");
							if(success.equals("ok"))
							{
								out.println("<p class='text-center success'>Suppression effectuée</p>");
							}
							else if(success.equals("error"))
							{
								out.println("<p class='text-center error'>Suppression impossible, document en cours d'emprunt</p>");
							}
							else if(success.equals("error2"))
							{
								out.println("<p class='text-center error'>Suppression impossible, document inexistant</p>");
							}
							else if(success.equals("data"))
							{
								out.println("<p class='text-center error'>Merci de renseigner un numéro</p>");
							}
							else
							{
								out.println("<p class='text-center error'>Ce n'est pas bien de trafiquer l'url</p>");
							}
						}
						
					%>
					<form method="post" action="suppr.jsp">
						<input type="number" name="type" placeholder="Enter un numéro de document"/>
						<input class="btn btn-primary" type="submit" value="Supprimer"/>
					</form>	
				</div>
			</div>
		</div>
		<%

			}
			else
			{
		%>
			<div class="container-fluid">
				<div class="row">
					<div class="section col-12 text-center">
						<h1>Espace abonné</h1>
						<a class="btn btn-primary" href="emprunt.jsp">Emprunter un document</a>
						<a class="btn btn-primary" href="retour.jsp">Rendre un document</a>
					</div>
					<div class="section col-12">
						<h1 class="text-center">Vos emprunts</h1>
						<div class="row">
						<div class="col-sm-4 offset-sm-2">
						<%
						int compteur = 0;
						if(docs != null)
						{
						for(int i = 0; i < docs.size(); ++i)
						{
							Document eDoc = (Document)docs.get(i);
							if( (eDoc.affiche()[2].equals("Emprunte")) && (eDoc.affiche()[3].equals(login)))
							{
								out.println("<span>" + eDoc.affiche()[1] + " - " + eDoc.affiche()[4] + "</span></br>");
								compteur += 1;
								if (compteur == 8) 
								{
									compteur = 0;
									%>
									</div>
									<div class="col-sm-4  offset-sm-2">
									<%
								}

							}
						}
						}
						%>
					</div>
					</div>
					</div>
				</div>
			</div>
		<%
			}
		}
	%>
	</body>
</html>