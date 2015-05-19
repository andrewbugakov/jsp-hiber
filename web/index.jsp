<%-- 
    Document   : index
    Created on : 09.04.2015, 9:32:35
    Author     : БОСС ЗДЕСЬ
--%>


<%@page import="org.hibernate.Transaction,hiber.NewHibernateUtil,hiber.*,org.hibernate.Session,java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <script type="text/javascript" src="jquery-1.11.2.min.js"></script>
        <link rel="stylesheet" type="text/css" href="in.css">
        <script >
            function deleted(delete_id) {
                //alert(delete_id);
                var w = window.open('insert.jsp?' + delete_id, "Результат");
            }
            function onopen(){
                document.getElementByName('input').disabled = true;
            }
            function d1() {
                // alert($("#del_b").val());
            }
            function selectedRow(checked_id, item0) {

                if ($("#" + checked_id).hasClass("selected")) {
                    $('#' + checked_id).removeClass('selected');
                    $('#del_b').val('');
                } else {
                    $('tr').removeClass('selected');
                    $('#' + checked_id).addClass('selected');
                    $('#deltable').val(item0);
                    $('#del_b').val(checked_id);

                }
                //alert(checked_id);
            }


            function doit(title) {
                //document.getElementById("sel").value=title;
                //this.input.val( $("#sel option:selected").text());    

                //$("#my_select :last").attr("selected", "selected");
                document.getElementById("form_cont").submit();
                //alert($("#sel :selected").val());
            }
            function dofirst() {

                window.open("service.jsp");
            }
            function dosecond() {
                window.open("department.jsp");
            }
            function dothird() {
                window.open("person.jsp");
            }
        </script>
        <style>
            body{
                background-color: aquamarine;
            }
            input{
                width: 15%;
            }
            input#in{
                width: 100%;
                //background: #fff; /* Цвет фона */
                //color: #333;  /* Цвет текста */
            }
            .selected{
                background: #333; /* Цвет фона */
                color: #f3bd48;
            }
            tr#insert{
                background: #fff; /* Цвет фона */
                color: #333;  /* Цвет текста */
            }
        </style>
    </head>
    <body onchange="onopen()">
        <%! private int accessCount = 0;
            String choiceTable;
        %>
        <form name='ff' method= "GET" action="index.jsp"><!-- method= "GET" action="insert.jsp"-->


            <!--<input name='deltable' id='del_t' size='40'-->
        </form>
        <form name='ff' id='form_cont' action="index.jsp">
            <%                String parametrlist = request.getParameter("ttype");
                if (parametrlist == null) {
                    parametrlist = "service.jsp";
                }

            %>
            <INPUT name='set' type='hidden' value="<%=parametrlist%>">
            <input name='del_text' type='hidden' id='del_b' >
            <button name='action' onclick="d1()" value= "update">Редактировать</button>
            <button name='action' onclick="d1()" value= "delete">Удалить</button>
            <button name='action' onclick="d1()" value= "showthiskids">Показать связанные записи</button>
            <%
                String action = request.getParameter("action");
                //out.println("action= " + action);
                try {
                    if (action.equals("delete")) {

                    }
                } catch (Exception e) {
                    e.printStackTrace();
                }
            %>
            <select   id="sel" name="ttype" onchange="doit(this.options[this.selectedIndex].value)"  >
                <%
                    if ("service.jsp".equals(parametrlist) | choiceTable == null) {%>
                <option value="service.jsp">Служба</option>
                <option value="department.jsp">Подразделение</option>
                <option value="person.jsp">Служащий</option>
                <%
                } else {
                    if ("department.jsp".equals(parametrlist)) {%>
                <option value="department.jsp">Подразделение</option>
                <option value="service.jsp" >Служба</option>
                <option value="person.jsp">Служащий</option>
                <%
                } else {
                    if ("person.jsp".equals(parametrlist)) {
                %>
                <option value="person.jsp">Служащий</option>
                <option value="department.jsp">Подразделение</option>
                <option value="service.jsp" >Служба</option>

                <%
                } else {%>
                <option value="service.jsp">Служба</option>
                <option value="department.jsp">Подразделение</option>
                <option value="person.jsp">Служащий</option><%
                            }
                        }
                    }
                %>

            </select>
            <INPUT name='set' type="submit" value= "Обновить">
            <INPUT name='action' type="submit"  value= "insert">
            <div>



                <% String url = request.getRequestURI() + ((request.getQueryString() != null) ? "?" + request.getQueryString() : "");
                    // out.println(url);
                    String choices = request.getParameter("del_text");
                    //out.println(choices);

                    choiceTable = request.getParameter("ttype");

                    //request.setAttribute(name, o);
                    if (choiceTable != null) {
                        request.setAttribute("type", choiceTable);
                    } else {
                        request.setAttribute("type", request.getAttribute("type"));
                    }

                    //out.println("vivod " + choiceTable + request.getAttribute("type") + choices);

                    if ("service.jsp".equals(choiceTable) | choiceTable == null) {
                        try {
                            if ((!choices.equals(null)) && (action.equals("delete"))) {
                                Service0.deleteService(Integer.valueOf(choices));
                            } else {
                                if (action.equals("update")) {
                                    request.setAttribute("choiceTable", choiceTable);
                                    request.setAttribute("id", request.getParameter("del_text"));
                                    request.setAttribute("type", "update");
                                    request.getRequestDispatcher("insert.jsp").forward(request, response);
                                }else {
                                        if (action.equals("insert")) {
                                            request.setAttribute("choiceTable", choiceTable);
                                            request.setAttribute("type", "insert");
                                            request.getRequestDispatcher("insert.jsp").forward(request, response);
                                        }else{
                                            if (action.equals("showthiskids")){
                                                request.setAttribute("choiceTable", choiceTable);
                                                request.setAttribute("type", "showkids");
                                                request.setAttribute("id", request.getParameter("del_text"));
                                                request.getRequestDispatcher("task_select.jsp").forward(request, response);
                                            }
                                        }
                                    }
                            }
                        } catch (Exception e) {
                            e.printStackTrace();
                        }
                        List<Service> s = Service0.GetServices();
                        out.println("<table border=1>");
                        out.println("<tr id='ttl'><TD>Название Службы</TD><TD>ID службы</TD></tr>");
                        for (int i = 0; i < s.size(); i++) {
                            out.println(
                                    "<tr id='" + s.get(i).getIdService() + "' onclick='selectedRow(this.id)'><td>" + s.get(i).getNameService() + "</td>"
                                    + "<td>" + s.get(i).getIdService() + "</td>"
                                    + "</tr>"
                            );
                        }
                        out.println("</table>");
                    } else {
                        if ("department.jsp".equals(choiceTable)) {
                            try {
                                if ((!choices.equals(null)) && (action.equals("delete"))) {
                                    Department0.deleteDepartment(Integer.valueOf(choices));

                                } else {
                                    if (action.equals("update")) {
                                        request.setAttribute("choiceTable", choiceTable);
                                        request.setAttribute("id", request.getParameter("del_text"));
                                        request.setAttribute("type", "update");
                                        request.getRequestDispatcher("insert.jsp").forward(request, response);
                                    } else {
                                        if (action.equals("insert")) {
                                            request.setAttribute("choiceTable", choiceTable);
                                            request.setAttribute("type", "insert");
                                            request.getRequestDispatcher("insert.jsp").forward(request, response);
                                        }else{
                                            if (action.equals("showthiskids")){
                                                request.setAttribute("choiceTable", choiceTable);
                                                request.setAttribute("type", "showkids");
                                                request.setAttribute("id", request.getParameter("del_text"));
                                                request.getRequestDispatcher("task_select.jsp").forward(request, response);
                                            }
                                        }
                                    }
                                }
                            } catch (Exception e) {
                                e.printStackTrace();
                            }
                            List<Department> d = Department0.GetDepartments();
                            out.println("<table border=1>");
                            out.println("<tr id='ttl'><TD>Название Подразделения</TD><TD>ID подразделения</TD></tr>");
                            for (int i = 0; i < d.size(); i++) {
                                out.println(
                                        "<tr id='" + d.get(i).getIdDepartment() + "' onclick='selectedRow(this.id)'><td>" + d.get(i).getNameDepartment() + "</td>"
                                        + "<td>" + d.get(i).getIdDepartment() + "</td>"
                                        + "</tr>"
                                );
                            }
                            out.println("</table>");
                        } else {
                            if ("person.jsp".equals(choiceTable)) {
                                try {
                                    if ((!choices.equals(null)) && (action.equals("delete"))) {
                                        Person0.deletePerson(Integer.valueOf(choices));

                                    } else {
                                        if (action.equals("update")) {
                                            request.setAttribute("choiceTable", "person.jsp");
                                            request.setAttribute("id", request.getParameter("del_text"));
                                            request.setAttribute("type", "update");
                                            request.getRequestDispatcher("insert.jsp").forward(request, response);
                                        }else {
                                        if (action.equals("insert")) {
                                            request.setAttribute("choiceTable", "person.jsp");
                                            request.setAttribute("type", "insert");
                                            request.getRequestDispatcher("insert.jsp").forward(request, response);
                                        }else{
                                            if (action.equals("showthiskids")){
                                                request.setAttribute("choiceTable", choiceTable);
                                                request.setAttribute("type", "showkids");
                                                request.setAttribute("id", request.getParameter("del_text"));
                                                request.getRequestDispatcher("task_select.jsp").forward(request, response);
                                            }
                                        }
                                    }
                                } }catch (Exception e) {
                                    e.printStackTrace();
                                }
                                List<Person> l = Person0.getPersons();
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
                            }
                        }
                    }
                %>
            </div>
        </form>



        <p>Количество обращений к странице с момента загрузки сервера: 
            <%= ++accessCount%></p>
        <form>
            <table>
                <%--
                String azaz=request.getParameter("a1");
                try{
                if(azaz.length()>0){
                if("service.jsp".equals(choiceTable)|choiceTable==null){
                Service0.createService(azaz);
                }
                else{
                   if("department.jsp".equals(choiceTable)){
                   %>DEPT
                   <%}
                   else{
                       if("person.jsp".equals(choiceTable)){
                       %>PERS
                   <%}
                       }
                }
                }
                }
                catch(NullPointerException e){
                    e.printStackTrace();
                }
               out.println (azaz);
               if("service.jsp".equals(choiceTable)|choiceTable==null){
              out.println(
                                "<tr id='insert'><td>Название службы</td>"
                                + "<td><input name='a1' id='in' size='40'></td>"
                                + "</tr>"
                                );
              
               
               }else{
                   if("department.jsp".equals(choiceTable)){
                   out.println(
                                "<tr id='insert'><td>Название подразделения</td>"
                                + "<td><input name='a1' id='in' size='40'></td>"
                                + "</tr>"
                                );
                  
                   }
                   else{
                       if("person.jsp".equals(choiceTable)){
                           out.println(
                                "<tr id='insert'><td>ФИО</td>"
                                + "<td><input name='a1' id='in' size='40'></td>"
                                + "</tr>"+
                               "<tr id='insert'><td>Местоположение</td>"
                                + "<td><input name='a1' id='in' size='40'></td>"
                                + "</tr>"+
                               "<tr id='insert'><td>Должность</td>"
                                + "<td><input name='a1' id='in' size='40'></td>"
                                + "</tr>"+
                                "<tr id='insert'><td>Телефон городской</td>"
                                + "<td><input name='a1' id='in' size='40'></td>"
                                + "</tr>"+
                               "<tr id='insert'><td>Телефон домашний</td>"
                                + "<td><input name='a1' id='in' size='40'></td>"
                                + "</tr>"
                                );
                          
                       }
                       }
                   }
                --%></table>
        </form>
    </body>
</html>
