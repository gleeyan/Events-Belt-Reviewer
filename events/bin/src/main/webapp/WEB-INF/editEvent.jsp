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
				<div class="col-md-10">
					<h2>Update <c:out value="${event.getName()}"/></h2>
					<p><form:errors path="event.*"/></p>
					<form:form action="/events/update/${event.getId()}" method="post" modelAttribute="event">
						<form:hidden path="id"/>
						<form:hidden path="createdBy" value="${user.getId()}"/>
						<div class="input-group mb-2">
							<div class="input-group-prepend">
								<span class="input-group-text">Name</span>
							</div>
							<form:input path="name" class="form-control"/>
						</div>
						<div class="input-group mb-2">
							<div class="input-group-prepend">
								<span class="input-group-text">Date</span>
							</div>
							<form:input type="date" path="eventDate" class="form-control"/>
						</div>
						<div class="input-group mb-2">
							<div class="input-group-prepend">
								<span class="input-group-text">Location</span>
							</div>
							<form:input path="city" class="form-control"/>
							<form:select path="state" class="custom-select">
								<c:forEach var="state" items="${states}">
									<form:option label="${state}" value="${state}"/>
								</c:forEach>
							</form:select>
						</div>
						<input type="submit" class="btn btn-primary" value="Update Event">
					</form:form>
				</div>
				<div class="col-md-1"></div>
			</div>
		</div>
	</body>
</html>