<%@page import="mediatheque.*, java.util.ArrayList, java.util.List"%>
<%@ page pageEncoding="UTF-8" %>
<html lang="fr">
	<head>
		<title>Retour</title>
		<meta charset="UTF-8">
		<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
		<link rel="stylesheet" type="text/css" href="css/style.css">
	</head>
	
	<body>
		<%
				String login = (String)session.getAttribute("login");
				String password = (String)session.getAttribute("password");
				Mediatheque med = (Mediatheque)session.getAttribute("mediatheque");
				List docs = med.tousLesDocuments();
		%>
		<div class="container-fluid">
			<div class="row justify-content-center">
				<div class="col-12">
					<h1 style="margin-top: 80px" class="text-center">Bienvenue <% out.println(login); %> sur votre espace de retour</h1>
				</div>
				<div class="col-md-4">
					<h3 class="text-center">Retourner un document</h3>
					<%
						if(request.getParameter("success") != null)
						{
							String success = request.getParameter("success");
							if(success.equals("ok"))
							{
								out.println("<p class='text-center success'>Votre document à bien été retourné</p>");
							}
							else if(success.equals("ko"))
							{
								out.println("<p class='text-center error'>Merci de sélectionner un document</p>");
							}
							else
							{
								out.println("<p class='text-center error'>Ce n'est pas bien de trafiquer l'url</p>");
							}
						}
						
					%>
					<form method="post" action="retourConfirmation.jsp">
						<select name="document">
							<option value="-1">--Sélectionner--</option>
								
								<%
								if(docs != null)
								{
									for(int i = 0; i < docs.size(); ++i)
									{
										Document eDoc = (Document)docs.get(i);
										if( (eDoc.affiche()[2].equals("Emprunte")) && (eDoc.affiche()[3].equals(login)))
										{
											out.println("<option value='" + eDoc.affiche()[0] + "'>" + eDoc.affiche()[1] + "</option>");
										}
									}
								}
								%>

							
						</select>
						<input class="btn btn-primary" type="submit" value="Ajouter"/>
						<a href="login.jsp"> Retour vers la page d'accueil </a>
					</form>	
				</div>
			</div>
		</div>