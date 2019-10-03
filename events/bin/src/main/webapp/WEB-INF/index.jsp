<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css" integrity="sha384-WskhaSGFgHYWDcbwN70/dfYBj47jz9qbsMId/iRN3ewGhXQFZCSftd1LZCfmhktB" crossorigin="anonymous">
		<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.min.js" integrity="sha384-smHYKdLADwkXOn1EmN1qk/HfnUcbVRZyYmZ4qpPea6sjB/pTJ0euyQp0Mk8ck+5T" crossorigin="anonymous"></script>
		<title>Events | Welcome</title>
	</head>
	<body>
		<div class="container-fluid">
			<div class="row" align="center">
				<div class="col-md-1"></div>
				<div class="col-md-10">
					<h1>Welcome to Events!</h1>
				</div>
				<div class="col-md-1"></div>
			</div>
			<div class="row">
				<div class="col-md-1"></div>
				<div class="col-md-4 bg-primary text-white rounded-top">
					<h2>Register</h2>
				</div>
				<div class="col-md-2"></div>
				<div class="col-md-4 bg-primary text-white rounded-top">
					<h2>Login</h2>
				</div>
				<div class="col-md-1"></div>
			</div>
			<div class="row">
				<div class="col-md-1"></div>
				<div class="col-md-4">
					<p><form:errors path="user.*"/></p>
					<form:form action="/register" method="post" modelAttribute="user">
						<div class="input-group mb-2">
							<div class="input-group-prepend">
								<span class="input-group-text">First and Last Name</span>
							</div>
							<form:input path="firstName" class="form-control"/>
							<form:input path="lastName" class="form-control"/>
						</div>
						<div class="input-group mb-2">
							<div class="input-group-prepend">
								<span class="input-group-text">Email</span>
							</div>
							<form:input path="username" class="form-control"/>
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
						<div class="input-group mb-2">
							<div class="input-group-prepend">
								<span class="input-group-text">Password</span>
							</div>
							<form:input type="password" path="password" class="form-control"/>
						</div>
						<div class="input-group mb-2">
							<div class="input-group-prepend">
								<span class="input-group-text">Confirm Password</span>
							</div>
							<form:input type="password" path="passwordConfirm" class="form-control"/>
						</div>
						<button type="submit" class="btn btn-primary">Register</button>
					</form:form>
				</div>
				<div class="col-md-4 offset-md-2">
					<p><c:if test="${errorMessage != null}">
					        <c:out value="${errorMessage}"></c:out>
					    </c:if>
					</p>
					<form action="/" method="post">
						<div class="input-group mb-2">
							<div class="input-group-prepend">
								<span class="input-group-text">Username</span>
							</div>
							<input type="text" class="form-control" name="username"/>
						</div>
						<div class="input-group mb-2">
							<div class="input-group-prepend">
								<span class="input-group-text">Password</span>
							</div>
							<input type="password" class="form-control" name="password"/>
						</div>
						<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
						<input type="submit" class="btn btn-primary" value="Sign In">
					</form>
				</div>
				<div class="col-md-1"></div>
			</div>
		</div>
	</body>
</html>