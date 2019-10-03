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
		<title>Events | Dashboard</title>
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
			<div class="row" align="center">
				<div class="col-md-1"></div>
				<div class="col-md-10">
					<h5>Here are some events in your state</h5>
					<table>
						<thead>
							<th>Name</th>
							<th>Date</th>
							<th>Location</th>
							<th>Host</th>
							<th>Action / Status</th>
						</thead>
						<tbody>
							<c:forEach var="event" items="${inStateEvents.content}">
								<tr>
									<td><a href='/events/show/<c:out value="${event.getId()}"/>'><c:out value="${event.getName()}"/></a></td>
									<td><fmt:formatDate pattern = "MMMM dd, yyyy" value="${event.getEventDate()}"/></td>
									<td><c:out value="${event.getLocation()}"/></td>
									<td><c:out value="${event.getCreatedBy().getFullName()}"/></td>
									<c:choose>
										<c:when test="${user.getEventsCreated().contains(event)}">
											<td><a href='/events/update/<c:out value="${event.getId()}"/>'>Edit</a> | <a href='/events/delete/<c:out value="${event.getId()}"/>'>Delete</a></td>
										</c:when>
										<c:when test="${event.getUsersEvents().size() > 0}">
											<c:forEach var="userEvent" items="${event.getUsersEvents()}">
												<c:if test="${userEvent.getUser() == user}">
													<td>Joining | <a href="/events/cancel/${event.getId()}">Cancel</a></td>
												</c:if>
											</c:forEach>
										</c:when>
										<c:otherwise>
											<td><a href='/events/join/<c:out value="${event.getId()}"/>'>Join</a></td>
										</c:otherwise>
									</c:choose>
								</tr>
							</c:forEach>
						</tbody>
					</table>
					<div class="col-1 input-group">
						<c:forEach begin="1" end="${inStatePages}" var="index">
							<form action="/events" method="post" class="form-inline">
								<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
								<input type="hidden" value='<c:out value="${index}"/>' name="inStateIndex">
								<c:choose>
									<c:when test="${inStatePage == index}">
										<input type="submit" value='<c:out value="${index}"/>' class="btn btn-info">
									</c:when>
									<c:otherwise>
										<input type="submit" value='<c:out value="${index}"/>' class="btn">
									</c:otherwise>
								</c:choose>
							</form>
						</c:forEach>
					</div>
				</div>
				<div class="col-md-1"></div>
			</div>
			<div class="row" align="center">
				<div class="col-md-1"></div>
				<div class="col-md-10">
					<h5>Here are some events in other states</h5>
					<table>
						<thead>
							<th>Name</th>
							<th>Date</th>
							<th>Location</th>
							<th>Host</th>
							<th>Action / Status</th>
						</thead>
						<tbody>
							<c:forEach var="event" items="${outOfStateEvents.content}">
								<tr>
									<td><a href='/events/show/<c:out value="${event.getId()}"/>'><c:out value="${event.getName()}"/></a></td>
									<td><fmt:formatDate pattern = "MMMM dd, yyyy" value="${event.getEventDate()}"/></td>
									<td><c:out value="${event.getLocation()}"/></td>
									<td><c:out value="${event.getCreatedBy().getFullName()}"/></td>
									<c:choose>
										<c:when test="${user.getEventsCreated().contains(event)}">
											<td><a href='/events/update/<c:out value="${event.getId()}"/>'>Edit</a> | <a href="">Delete</a></td>
										</c:when>
										<c:when test="${event.getUsersEvents().size() > 0}">
											<c:forEach var="userEvent" items="${event.getUsersEvents()}">
												<c:if test="${userEvent.getUser() == user}">
													<td>Joining | <a href="/events/cancel/${event.getId()}">Cancel</a></td>
												</c:if>
											</c:forEach>
										</c:when>
										<c:otherwise>
											<td><a href='/events/join/<c:out value="${event.getId()}"/>'>Join</a></td>
										</c:otherwise>
									</c:choose>
								</tr>
							</c:forEach>
						</tbody>
					</table>
					<div class="col-1 input-group">
						<c:forEach begin="1" end="${outOfStatePages}" var="index">
							<form action="/events" method="post">
								<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
								<input type="hidden" value='<c:out value="${index}"/>' name="outOfStateIndex">
								<c:choose>
									<c:when test="${outOfStatePage == index}">
										<input type="submit" value='<c:out value="${index}"/>' class="btn btn-info">
									</c:when>
									<c:otherwise>
										<input type="submit" value='<c:out value="${index}"/>' class="btn">
									</c:otherwise>
								</c:choose>
							</form>
						</c:forEach>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="col-md-1"></div>
				<div class="col-md-10">
					<h2>Create an Event</h2>
					<p><form:errors path="event.*"/></p>
					<form:form action="/events/create" method="post" modelAttribute="event">
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
						<input type="submit" class="btn btn-primary" value="Create Event">
					</form:form>
				</div>
				<div class="col-md-1"></div>
			</div>
		</div>
	</body>
</html>