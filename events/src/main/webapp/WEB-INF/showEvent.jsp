<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css" integrity="sha384-WskhaSGFgHYWDcbwN70/dfYBj47jz9qbsMId/iRN3ewGhXQFZCSftd1LZCfmhktB" crossorigin="anonymous">
		<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.min.js" integrity="sha384-smHYKdLADwkXOn1EmN1qk/HfnUcbVRZyYmZ4qpPea6sjB/pTJ0euyQp0Mk8ck+5T" crossorigin="anonymous"></script>
		<title>Events | <c:out value="${event.getName()}"/></title>
	</head>
	<body>
		<div class="container-fluid">
			<div class="row bg-dark" align="center">
				<div class="col-md-11 text-white">
					<h1>Welcome <c:out value="${user.getFirstName()}"/>!</h1>
				</div>
				<div class="col-md-1">
					<form id="logoutForm" method="POST" action="/logout">
				        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
				        <input type="submit" value="Logout" class="btn" />
				    </form>
				</div>
			</div>
			<div class="row">
				<div class="col-md-1"></div>
				<div class="col-md-4">
					<h2><c:out value="${event.getName()}"/></h2>
					<c:if test="${event.getCreatedBy() == user}">
						<a href='/events/update/<c:out value="${event.getId()}"/>'>Edit</a> | <a href='/events/delete/<c:out value="${event.getId()}"/>'>Delete</a>
					</c:if>
					<p>Host: <c:out value="${event.getCreatedBy().getFullName()}"/></p>
					<p>Date: <fmt:formatDate pattern = "MMMM dd, yyyy" value="${event.getEventDate()}"/></p>
					<p>Location: <c:out value="${event.getLocation()}"/></p>
					<p>People Attending: <c:out value="${event.getUsersEvents().size()}"/></p>
					<table>
						<thead>
							<th>Name</th>
							<th>Location</th>
						</thead>
						<tbody>
							<c:forEach var="userEvent" items="${event.getUsersEvents()}">
								<tr>
									<td><c:out value="${userEvent.getUser().getFullName()}"/></td>
									<td><c:out value="${userEvent.getUser().getLocation()}"/></td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
				<div class="col-md-4 offset-mb-1" align="center">
					<h3>Message Wall</h3>
					<div class="card">
						<c:forEach var="message" items="${event.getMessages()}">
							<p><c:out value="${message.getAuthor().getFullName()}"/>: <c:out value="${message.getContent()}"/></p>
						</c:forEach>
					</div>
					<form:form action="/messages/create" modelAttribute="message" method="post">
						<div class="input-group mb-2">
							<div class="input-group-prepend">
								<span class="input-group-text">Message</span>
							</div>
								<form:textarea path="content" class="form-control"/>
							</div>
							<input type="hidden" name="eventId" value='<c:out value="${event.getId()}"/>'>
							<input type="submit" class="btn btn-primary" value="Post Message">
					</form:form>
				</div>
				<div class="col-md-1"></div>
			</div>
		</div>
	</body>
</html>