<%@page import="mediatheque.*"%>
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
			String titre = request.getParameter("titre");
			String type = request.getParameter("type");
			if(!titre.equals("") && !type.equals("-1"))
			{
				med.nouveauDocument(Integer.parseInt(type), titre);
				response.sendRedirect("login.jsp?success=ok");
			}
			else
			{
				response.sendRedirect("login.jsp?success=ko");
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