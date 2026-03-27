<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.*, model.Assignment" %>

<h2>Danh sách Assignment</h2>

<form method="post" action="assignments">
    <input type="hidden" name="action" value="create"/>
    <input type="hidden" name="subjectId" value="<%= request.getParameter("subjectId") %>"/>

    <input type="text" name="title" placeholder="Tiêu đề" required/>
    <input type="datetime-local" name="dueDate"/>

    <button type="submit">Thêm</button>
</form>

<hr>

<table border="1">
    <tr>
        <th>Title</th>
        <th>Due</th>
        <th>Status</th>
        <th>Action</th>
    </tr>

<%
    List<Assignment> list = (List<Assignment>) request.getAttribute("assignments");

    for (Assignment a : list) {
%>
    <tr>
        <td><%= a.getTitle() %></td>
        <td><%= a.getDueDate() %></td>
        <td><%= a.getStatus() %></td>

        <td>
            <!-- update status -->
            <form method="post" action="assignments" style="display:inline;">
                <input type="hidden" name="action" value="updateStatus"/>
                <input type="hidden" name="id" value="<%= a.getId() %>"/>
                <input type="hidden" name="subjectId" value="<%= a.getSubjectId() %>"/>

                <select name="status" onchange="this.form.submit()">
                    <option>PENDING</option>
                    <option>DONE</option>
                    <option>OVERDUE</option>
                </select>
            </form>

            <!-- delete -->
            <form method="post" action="assignments" style="display:inline;">
                <input type="hidden" name="action" value="delete"/>
                <input type="hidden" name="id" value="<%= a.getId() %>"/>
                <input type="hidden" name="subjectId" value="<%= a.getSubjectId() %>"/>

                <button onclick="return confirm('Xóa?')">Xóa</button>
            </form>
        </td>
    </tr>
<%
    }
%>
</table>