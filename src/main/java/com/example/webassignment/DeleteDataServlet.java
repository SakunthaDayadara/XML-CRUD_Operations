
package com.example.webassignment;

import java.io.*;
import java.util.regex.Pattern;
import java.util.regex.Matcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
import org.xml.sax.SAXException;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerConfigurationException;
import javax.xml.transform.TransformerException;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.dom.DOMSource;
import javax.xml.transform.stream.StreamResult;

@WebServlet(name = "deleteDataServlet", value = "/deleteData-servlet")
public class DeleteDataServlet extends HttpServlet {




    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String id = request.getParameter("id");
        //String fname = request.getParameter("fname");
        File xmlFile = new File(getServletContext().getRealPath("/") + "patient_details.xml");
        // To obtain DocumentBuilder instances
        DocumentBuilderFactory documentBuilderFactory = DocumentBuilderFactory.newInstance();
        try {
            // DocumentBuilder instance
            DocumentBuilder documentBuilder = documentBuilderFactory.newDocumentBuilder();
            Document document;

            // Check for XML file
            if (xmlFile.exists()) {
                document = documentBuilder.parse(xmlFile);

                NodeList personList = document.getElementsByTagName("patient");
                for (int i = 0; i < personList.getLength(); i++) {
                    Node patientNode = personList.item(i);

                    if (patientNode.getNodeType() == Node.ELEMENT_NODE) {
                        Element personElement = (Element) patientNode;
                        String existingId = personElement.getElementsByTagName("id").item(0).getTextContent();
                       // String existingName = personElement.getElementsByTagName("fname").item(0).getTextContent();


                        // Assuming you want to delete the person with a specific id
                        if (existingId.equals(id) ) {
                            patientNode.getParentNode().removeChild(patientNode);

                            // Save the changes to the XML file
                            TransformerFactory transformerFactory = TransformerFactory.newInstance();
                            Transformer transformer = transformerFactory.newTransformer();
                            DOMSource domSource = new DOMSource(document);
                            StreamResult streamResult = new StreamResult(xmlFile);
                            transformer.transform(domSource, streamResult);

                            // Log statement for debugging
                            System.out.println("Patient with ID " + id + " deleted.");

                            // Send a response
                            response.setContentType("text/html");
                            PrintWriter out = response.getWriter();
                            out.println("<html><body>");
                            out.println("<script type=\"text/javascript\">");
                            out.println("window.location.href = 'patients.jsp';");  // Redirect to patients.jsp
                            out.println("alert('Data deleted successfully!!');");
                            out.println("</script>");
                            out.println("</body></html>");

                            break;
                        }
                    }
                }
            }
        } catch (TransformerConfigurationException e) {
            throw new RuntimeException(e);
        } catch (ParserConfigurationException e) {
            throw new RuntimeException(e);
        } catch (TransformerException e) {
            throw new RuntimeException(e);
        } catch (SAXException e) {
            throw new RuntimeException(e);
        }
    }
    public void destroy() {
    }
}
