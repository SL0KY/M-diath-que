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
		if((session.getAttribute("user") != null) && (session.getAttribute("mediatheque") != null))
		{
			Utilisateur user = (Utilisateur)session.getAttribute("user");
			Mediatheque med = (Mediatheque)session.getAttribute("mediatheque");
			String type = request.getParameter("type");
			
			if(!type.equals(""))
			{
				Document doc = med.getDocument(Integer.parseInt(type));
				if(doc != null)
				{
					if(doc.affiche()[2].equals("Disponible"))
					{
						med.supprimeDocument(Integer.parseInt(type));
						response.sendRedirect("login.jsp?suppr=ok");
					}
					else
					{
						response.sendRedirect("login.jsp?suppr=error");
					}
				}
				else
				{
					response.sendRedirect("login.jsp?suppr=error2");
				}
			}
			else
			{
				response.sendRedirect("login.jsp?suppr=data");
			}
		}
		else
		{
	%>
			<div class="container-fluid">
				<div clas="row">
					<div class="col-12 text-center">	
						<h1>Une erreur est survenue</h1>
						<a href="auth.jsp">Se reconnecter</a>
					</div>
				</div>
			</div>
	<%
		}
	%>
	</body>
</html>