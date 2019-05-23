<%@page import="mediatheque.*"%>
<%@ page pageEncoding="UTF-8" %>
<html lang="fr">
	<head>
		<title>Confirmation de retour</title>
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
			Integer document = Integer.parseInt(request.getParameter("document"));
			if(document != -1)
			{
				med.getDocument(document).retour(user);
				response.sendRedirect("retour.jsp?success=ok");
			}
			else
			{
				response.sendRedirect("emprunt.jsp?success=ko");
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