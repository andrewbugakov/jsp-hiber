<%-- 
    Document   : department
    Created on : 09.04.2015, 22:01:36
    Author     : БОСС ЗДЕСЬ
--%>

<%@page import="hiber.Department0"%>
<%@page import="hiber.Department"%>
<%@page import="hiber.Service0"%>
<%@page import="hiber.Service"%>
<%@page import="java.util.List"%>
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
        List<Department> l=Department0.GetDepartments();
                %>
        <%
                 out.println ("<table border=1>");
                 out.println("<tr id='ttl'><TD>Название Подразделения</TD><TD>ID подразделения</TD></tr>");
                 for(int i=0;i<l.size();i++){
                     out.println(
                         "<tr><td>"  + l.get(i).getNameDepartment()+"</td>"
                         + "<td>"  + l.get(i).getIdDepartment()+"</td>"
                         + "</tr>"
                         );
                 }
                 out.println ("</table>");
            %> 
            
            
        Количество обращений к странице с момента загрузки сервера: 
        <%= ++accessCount %>
    </body>
</html>

