<html>
	<head>
		<title>Connexion</title>
	</head>
	
	<body>
		<form method="post" action="login.jsp">
			<%
				if(request.getParameter("error") != null)
				{
					String error = request.getParameter("error");
					if(error.equals("auth"))
					{
						out.println("<p class='error'>Identifiant ou mot de passe invalide</p>");
					}
					else
					{
						out.println("<p class='error'>Ce n'est pas bien de trafiquer l'url</p>");
					}
				}
				
			%>
			<input type="text" name="login" placeholder="Entrez votre login" />
			<input type="password" name="password" placeholder="Entrez votre mot de passe" />
			<input type="submit" value="Connexion" />
		</form>
	</body>
</html>