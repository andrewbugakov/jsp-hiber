<%-- 
    Document   : insert
    Created on : 10.04.2015, 14:32:24
    Author     : БОСС ЗДЕСЬ
--%>

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
        <script>
            function onstart() {
                var url = location.search;
                alert(url);
                var tmp = new Array();
            }
            function onsub(){
                var s=$("input[name='table']").val();
                alert(s);
                return true;
            }
            function doit(title) {
                document.getElementById("form_cont").submit();
            }
        </script>
        <style>
            body{
                background-color: darkgrey;
            }
        </style>
    </head>
    <body >
        <form action="insert.jsp" onsubmit="onsub()">
            <%
                String choiceTable = (String) request.getAttribute("choiceTable");%>
            <INPUT name='table' id='tablee' type='hidden' value="<%=choiceTable%>"><%
                String id = (String) request.getAttribute("id");
            %>
            <INPUT name='id' type='hidden' value="<%=id%>"><%
                String type = (String) request.getAttribute("type");
            %>
            <INPUT name='type' type='hidden' value="<%=type%>"><%
                String nav = (String) request.getParameter("action");%>
            <INPUT name='table' type='hidden' value="<%=nav%>"><%
                String name = (String) request.getParameter("a1");
                String place = (String) request.getParameter("a2");
                String post = (String) request.getParameter("a3");
                String tel_gor = (String) request.getParameter("a4");
                String tel_vn = (String) request.getParameter("a5");
                String dept = (String) request.getParameter("departso");
                String pers = (String) request.getParameter("persono");
%>
            <INPUT name='pers' type='hidden'  value="<%=pers%>"><%
                if (type == null) {
                    type = request.getParameter("type");
                }
                if (id == null) {
                    id = request.getParameter("id");
                }
                //out.println(id + " " + type + " " + nav + " " + name + " persono " + pers);
                if (type.equals("update")) {
                    switch (nav) {
                        case "service":
                            Service0.updService(Integer.valueOf(id), name);
                            request.getRequestDispatcher("index.jsp").forward(request, response);
                            break;
                        case "depart":
                            Department0.updDepartment(Integer.parseInt(id), dept, name);
                            request.getRequestDispatcher("index.jsp").forward(request, response);
                            break;
                        case "person":
                            Person0.updPerson(Integer.parseInt(id), Integer.parseInt(pers), name, place, post, tel_gor, tel_vn);
                            request.getRequestDispatcher("index.jsp").forward(request, response);
                            break;
                    }

                } else {
                    if (type.equals("insert")) {
                        if (nav.equals("service")) {
                            Service0.createService(name);
                            request.getRequestDispatcher("index.jsp").forward(request, response);
                        } else {
                            if (nav.equals("depart")) {
                                Department0.createDepartment(name, Integer.valueOf(dept));
                                request.getRequestDispatcher("index.jsp").forward(request, response);
                            } else {
                                if (nav.equals("person")) {
                                    Person0.createPerson( Integer.valueOf(pers), name, place, post, tel_vn, tel_gor);
                                    
                                     request.getRequestDispatcher("index.jsp").forward(request, response);

                                }
                            }
                        }
                    }
                }
            %>
            //<h1><%=choiceTable%></h1>


            <%
                if ("service.jsp".equals(choiceTable) | choiceTable == null) {
                    out.println("ТАБЛИЦА SERVICE");  //Service0.createService(azaz);
                } else {
                    if ("department.jsp".equals(choiceTable)) {
                        out.println("ТАБЛИЦА DEPARTMENT");
                    } else {
                        if ("person.jsp".equals(choiceTable)) {
                            out.println("ТАБЛИЦА PERSON");
                        }
                    }
                }


            %>
            <table><%                if ("service.jsp".equals(choiceTable) | choiceTable == null) {

                    if (type.equals("update")) {
                        Service s = Service0.getById(Integer.valueOf(id));

                        out.println(
                                "<tr id='insert'><td>Название службы</td>"
                                + "<td><input name='a1' id='in' size='40' value=" + s.getNameService() + "></td>"
                                + "</tr></table>"
                        );%>
                        <INPUT name='action' type="submit" value= "service" title="Сохранить">
                <%
                } else {
                    out.println(
                            "<tr id='insert'><td>Название службы</td>"
                            + "<td><input name='a1' id='in' size='40'></td>"
                            + "</tr></table>"
                    );%>
                <INPUT name='action' type="submit" value= "service" title="Сохранить">
                <% }

                } else {
                    if ("department.jsp".equals(choiceTable)) {
                %><select name="departso" id="dept">
                    <%
                        if (type.equals("update")) {
                            List<Service> d = Service0.GetServices();
                            Department d1 = (Department) Department0.getById(Integer.parseInt(id));
                            for (int i = 0; i < d.size(); i++) {
                    %>
                    <option value="<%= d.get(i).getIdService()%>"><%=d.get(i).getNameService()%></option>
                    <%
                        }
                    %>
                </select><%
                    //Department d= Department0.getById(Integer.valueOf(id));
                    out.println("<tr id='insert'><td>Название подразделения</td>"
                            + "<td><input name='a1' id='in' size='40' value='" + d1.getNameDepartment() + "'></td>"
                            + "</tr></table>"
                    );
                %>
                <INPUT name='action' type="submit" value= "depart">
                <%
                } else {
                    List<Service> d = Service0.GetServices();
                    for (int i = 0; i < d.size(); i++) {
                %>
                <option value="<%= d.get(i).getIdService()%>"><%=d.get(i).getNameService()%></option>
                <%
                    }
                %>
                </select><%
                    //Department d= Department0.getById(Integer.valueOf(id));
                    out.println("<tr id='insert'><td>Название подразделения</td>"
                            + "<td><input name='a1' id='in' size='40'></td>"
                            + "</tr></table>"
                    );
                %>
                <INPUT name='action' type="submit" value= "depart">
                <%
                    }
                } else {
                    if ("person.jsp".equals(choiceTable)) {%>
                    <%
                    if (type.equals("update")) {
                        %><tr><td>Подразделение</td><td><select name='persono'><%
                                //out.println("<select name='persono' id='pers'>");
                                List<Department> d = Department0.GetDepartments();
                                Person p = (Person) Person0.getById(Integer.parseInt(id));
                                for (int i = 0; i < d.size(); i++) {
                                    out.println("<option value=" + d.get(i).getIdDepartment() + ">" + d.get(i).getNameDepartment() + "</option>");
                                }
                                //out.println("</select>");%></select>
                    
                    </td></tr><%
                                    out.println("<tr id='insert'><td>ФИО работника</td>"
                                            + "<td><input name='a1' id='in' size='40' value='" + p.getPersonName() + "'></td>"
                                            + "</tr>"
                                            + "<tr><td>Местоположение</td>"
                                            + "<td><input name='a2' id='in' size='40' value='" + p.getPersonPosition() + "'></td>"
                                            + "</tr>"
                                            + "<tr><td>Занимаемый пост</td>"
                                            + "<td><input name='a3' id='in' size='40' value='" + p.getPersonPost() + "'></td>"
                                            + "</tr>"
                                            + "<tr><td>Городской телефон</td>"
                                            + "<td><input name='a4' id='in' size='40' value='" + p.getTelGor() + "'></td>"
                                            + "</tr>"
                                            + "<tr><td>Внутренний телефон</td>"
                                            + "<td><input name='a5' id='in' size='40' value='" + p.getTelVn() + "'></td>"
                                            + "</tr>"
                                            + "</table>"
                                    );
                            %>
                    <button name='action' onclick="onperson()" value= "person">Вставить запись</button>    
                    <!--<INPUT name='action' type="submit" value= "person">-->
                    <%
                        //out.println("upd");
                        
                    } else {
                    %><tr><td>Подразделение</td><td>
                            <%
                                //out.println("<select id='pers'>");
                                List<Department> d = Department0.GetDepartments();
                                %><select name='persono'><%
                                for (int i = 0; i < d.size(); i++) {
                                    out.println("<option value=" + d.get(i).getIdDepartment() + ">" + d.get(i).getNameDepartment() + "</option>");
                                }
                                //out.println("</select>");%></select>
                        
                    
                    </td></tr><%
                                    out.println("<tr id='insert'><td>ФИО работника</td>"
                                            + "<td><input name='a1' id='in' size='40'></td>"
                                            + "</tr>"
                                            + "<tr><td>Местоположение</td>"
                                            + "<td><input name='a2' id='in' size='40'></td>"
                                            + "</tr>"
                                            + "<tr><td>Занимаемый пост</td>"
                                            + "<td><input name='a3' id='in' size='40'></td>"
                                            + "</tr>"
                                            + "<tr><td>Городской телефон</td>"
                                            + "<td><input name='a4' id='in' size='40'></td>"
                                            + "</tr>"
                                            + "<tr><td>Внутренний телефон</td>"
                                            + "<td><input name='a5' id='in' size='40'></td>"
                                            + "</tr>"
                                            + "</table>"
                                    );
                            %>
                    <button name='action' onclick="onperson()" value= "person">Вставить запись</button>
                    <!--<INPUT name='action' type="submit" value= "">-->
                    <%
                                        //out.println("ins");
                                    }
                                }
                            }
                        }

                    %>
                    </form>
                    </body>
                    </html>
