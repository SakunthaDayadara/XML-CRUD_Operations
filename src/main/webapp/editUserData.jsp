<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<html>
<head>
    <title></title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js" integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.min.js" integrity="sha384-BBtl+eGJRgqQAUMxJ7pMwbEyER4l1g+O15P+16Ep7Q9Q+zqX6gSbd85u4mG4QzX+" crossorigin="anonymous"></script>


</head>
<body>
<jsp:include page="header.jsp" />

<div class="container">
    <br>
    <h2>Edit details</h2>
    <br>
<form action="${pageContext.request.contextPath}/editData-servlet" name="myForm" method="post">

    <input type="hidden" name="id" value="<%= request.getParameter("id") %>">
    <div class="field form-group">
    <label for="fname">First Name: </label><br>
    <input type="text" id="fname" class="formElement" name="fname" placeholder="Your First Name" value="<%= request.getParameter("fname") %>"><br>
    </div>

    <div class="field form-group">
    <label for="lname">Last Name: </label><br>
    <input type="text" id="lname" class="formElement" name="lname" placeholder="Your Last Name" value="<%= request.getParameter("lname") %>"><br>
    </div>


    <div class="field form-group">
    <label for="NIC">NIC: </label><br>
    <input type="text" id="NIC" class="formElement" name="NIC" placeholder="Your NIC" value="<%= request.getParameter("NIC") %>"><br>
    </div>


    <div class="field form-group">
    <label for="phone">Phone: </label><br>
    <input type="text" id="phone" class="formElement" name="phone" placeholder="Your phone number" value="<%= request.getParameter("phone") %>"><br><br>
    </div>


    <input type="submit" value="SUBMIT" class="btn btn-primary">
</form>

</div>

</body>
</html>
