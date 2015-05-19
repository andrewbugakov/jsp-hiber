<%-- 
    Document   : person
    Created on : 09.04.2015, 22:02:06
    Author     : БОСС ЗДЕСЬ
--%>

<%@page import="org.hibernate.Transaction,hiber.*,org.hibernate.Session,java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
  <link rel="stylesheet" type="text/css" href="in.css">
    </head>
    <body>
    <%! private int accessCount = 0;
    List<Person> l=Person0.getPersons();
                %>
        <%
                 out.println ("<table border=1>");
                 out.println("<tr id='ttl'><TD>ФИО</TD><TD>Местоположение</TD><TD>Должность</TD><TD>Телефон городской</TD><TD>Телефон внутренний</TD></tr>");
                 for(int i=0;i<l.size();i++){
                     out.println(
                         "<tr><td>"  + l.get(i).getPersonName()+"</td>"
                         + "<td>"  + l.get(i).getPersonPosition()+"</td>"
                         + "<td>"  + l.get(i).getPersonPost()+"</td>"
                         + "<td>"  + l.get(i).getTelGor()+"</td>"
                         + "<td>"  + l.get(i).getTelVn()+"</td>"
                         + "</tr>"
                         );
                 }
                 out.println ("</table>");
            %> 
            
            
        Количество обращений к странице с момента загрузки сервера: 
        <%= ++accessCount %>
    </body>
</html>

