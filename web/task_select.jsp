<%-- 
    Document   : service
    Created on : 09.04.2015, 22:01:16
    Author     : БОСС ЗДЕСЬ
--%>

<%@page import="org.hibernate.Transaction,hiber.NewHibernateUtil,hiber.*,org.hibernate.Session,java.util.List"%>
<%@page import="hiber.Department"%>
<%@page import="hiber.Department0"%>
<%@page import="java.util.List"%>
<%@page import="hiber.Service0"%>
<%@page import="hiber.Person"%>
<%@page import="hiber.Person0"%>
<%@page import="org.hibernate.criterion.Restrictions"%>
<%@page import="hiber.Service,org.hibernate.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
   <link rel="stylesheet" type="text/css" href="in.css">
  <script>
      function selectedRow(checked_id){
          
          
          alert(checked_id);
          
      }
       
    
  </script>
    </head>
    <body>
    <%! private int accessCount = 0;
                %>
        <%
        String id = (String) request.getAttribute("id");
        String choiceTable = (String) request.getAttribute("choiceTable");
        switch(choiceTable){
            case "service.jsp": 
                List<Department> d=Service0.getListById(Integer.valueOf(id));
                out.print(d.size());
                out.println("<table border=1>");
                            out.println("<tr id='ttl'><TD>Название Подразделения</TD><TD>ID подразделения</TD></tr>");
                            for (int i = 0; i < d.size(); i++) {
                                out.println(
                                        "<tr><td>" + d.get(i).getNameDepartment() + "</td>"
                                        + "<td>" + d.get(i).getIdDepartment() + "</td>"
                                        + "</tr>"
                                );
                            }
                            out.println("</table>");
                break;
            case "department.jsp":
                List<Person> l = Department0.getListById(Integer.valueOf(id));
                 out.println(l.size());    
                 out.println("<table border=1>");
                                out.println("<tr id='ttl'><TD>ФИО</TD><TD>Местоположение</TD><TD>Должность</TD><TD>Телефон городской</TD><TD>Телефон внутренний</TD></tr>");
                                for (int i = 0; i < l.size(); i++) {
                                    out.println(
                                            "<tr id='" + l.get(i).getIdPerson() + "' onclick='selectedRow(this.id)'><td>" + l.get(i).getPersonName() + "</td>"
                                            + "<td>" + l.get(i).getPersonPosition() + "</td>"
                                            + "<td>" + l.get(i).getPersonPost() + "</td>"
                                            + "<td>" + l.get(i).getTelGor() + "</td>"
                                            + "<td>" + l.get(i).getTelVn() + "</td>"
                                            + "</tr>"
                                    );
                                }
                                out.println("</table>");
               
                break;
            case "person.jsp":
                out.println("нет потомков");
                break;
        }
                 
            %> 
            
            
            
        Количество обращений к странице с момента загрузки сервера: 
        <%= ++accessCount %>
    </body>
</html>
