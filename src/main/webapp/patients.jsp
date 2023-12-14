<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.io.File" %>
<%@ page import="javax.xml.parsers.DocumentBuilder" %>
<%@ page import="javax.xml.parsers.DocumentBuilderFactory" %>
<%@ page import="org.w3c.dom.Document" %>
<%@ page import="org.w3c.dom.NodeList" %>
<%@ page import="org.w3c.dom.Node" %>
<%@ page import="org.w3c.dom.Element" %>

<%
    // Load the XML file
    String xmlFilePath = request.getServletContext().getRealPath("/") + "patient_details.xml";
    File xmlFile = new File(xmlFilePath);
    DocumentBuilderFactory dbFactory = DocumentBuilderFactory.newInstance();
    DocumentBuilder dBuilder = dbFactory.newDocumentBuilder();
    Document doc = dBuilder.parse(xmlFile);

    // Normalize the document
    doc.getDocumentElement().normalize();

    // Get the list of person elements
    NodeList nodeList = doc.getElementsByTagName("patient");
%>

<!DOCTYPE html>
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
    <h1>Patient List</h1>
    <br>
<table id="data-table" class="table table-striped table-hover">
    <thead class="table table-dark">
    <tr>
        <th>ID</th>
        <th>First Name</th>
        <th>Last Name</th>
        <th>NIC</th>
        <th>Phone</th>
        <th></th>
    </tr>
    </thead>

    <!-- Iterate over each person element and display details -->
    <% for (int i = 0; i < nodeList.getLength(); i++) {
        Node patientNode = nodeList.item(i);
        if (patientNode.getNodeType() == Node.ELEMENT_NODE) {
            Element patientElement = (Element) patientNode;
    %>

    <tr>
        <td><%= patientElement.getElementsByTagName("id").item(0).getTextContent() %></td>
        <td><%= patientElement.getElementsByTagName("fname").item(0).getTextContent() %></td>
        <td><%= patientElement.getElementsByTagName("lname").item(0).getTextContent() %></td>
        <td><%= patientElement.getElementsByTagName("NIC").item(0).getTextContent() %></td>
        <td><%= patientElement.getElementsByTagName("phone").item(0).getTextContent() %></td>
        <td><button class="btn btn-primary" onclick="deleteUser(event, '<%= patientElement.getElementsByTagName("id").item(0).getTextContent() %>', '<%= patientElement.getElementsByTagName("fname").item(0).getTextContent() %>', '<%= patientElement.getElementsByTagName("lname").item(0).getTextContent() %>', '<%= patientElement.getElementsByTagName("NIC").item(0).getTextContent() %>', '<%= patientElement.getElementsByTagName("phone").item(0).getTextContent() %>')">DELETE</button></td>

    </tr>

    <% }
    } %>
</table>
</div>

<script>
    async function deleteUser(event, id, fname,lname,NIC,phone) {
        event.stopPropagation();


           try {
               console.log("id: "+id)
               console.log("\nfname: "+fname)
               console.log("\nlname: "+lname)
               console.log("\nNIC: "+NIC)
               console.log("\nphone: "+phone)

               var url = "${pageContext.request.contextPath}/deleteUserData.jsp?id="+id+"&fname="+fname+"&lname="+lname+"&NIC="+NIC+"&phone="+phone;
               window.location.href=url;



            } catch (error) {
                console.error('Error during fetch:', error);
            }


    }

</script>
<script>
    document.addEventListener('DOMContentLoaded', function () {
        var table = document.getElementById('data-table');
        var rows = table.getElementsByTagName('tr');

        for (var i = 0; i < rows.length; i++) {
            rows[i].addEventListener('click', function () {
                // Get the data from the clicked row
                var cells = this.getElementsByTagName('td');
                var rowData = [];

                // Loop through each cell in the row
                for (var j = 0; j < cells.length; j++) {
                    // Store the value in the rowData array
                    rowData.push(cells[j].textContent);
                }

                // Do something with the rowData
                // access individual values like this:
                var id = rowData[0]
                var fname = rowData[1];
                var lname = rowData[2];
                var NIC = rowData[3];
                var phone = rowData[4];

                var url = "${pageContext.request.contextPath}/editUserData.jsp?id="+id+"&fname="+fname+"&lname="+lname+"&NIC="+NIC+"&phone="+phone;
                window.location.href=url;
            });
        }
    });
</script>


</body>
</html>
