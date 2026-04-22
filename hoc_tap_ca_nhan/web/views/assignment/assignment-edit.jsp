<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="model.Assignment" %>
<%@ page import="model.Subject" %>

<div style="margin-left:240px; padding:20px;">
            <%
                Assignment a = (Assignment) request.getAttribute("assignment");
                Subject subject = (Subject) request.getAttribute("subject");
            %>

            <h2>Chỉnh sửa nhiệm vụ
                <% if (subject != null) { %>
                    <span style="color:#888;">|</span>
                    <span style="color:#4CAF50;"><%= subject.getSubjectName() %></span>
                <% } %>
            </h2>

            <% if (request.getAttribute("error") != null) { %>
                <p style="color:red;"><%= request.getAttribute("error") %></p>
            <% } %>

            <form method="post" action="assignments">
                <input type="hidden" name="action" value="update"/>
                <input type="hidden" name="id" value="<%=a.getId()%>"/>
                <input type="hidden" name="subjectId" value="<%=a.getSubjectId()%>"/>

                <label>Loại:</label><br/>
                <select name="type">
                    <option value="ASSIGNMENT" <%= "ASSIGNMENT".equalsIgnoreCase(a.getType()) ? "selected" : "" %>>
                        📚 Task
                    </option>
                    <option value="EXAM" <%= "EXAM".equalsIgnoreCase(a.getType()) ? "selected" : "" %>>
                        📝 Exam
                    </option>
                </select>

                <br/><br/>

                <label>Tên:</label><br/>
                <input type="text" name="title" value="<%=a.getTitle()%>" required/>

                <br/><br/>

                <label>Mô tả:</label><br/>
                <input type="text" name="description"
                       value="<%= a.getDescription() != null ? a.getDescription() : "" %>"
                       placeholder="Mô tả (không bắt buộc)"/>

                <br/><br/>

                <label>Ngày đến hạn:</label><br/>
                <input type="date" name="dueDate"
                       value="<%= a.getDueDate() != null ? a.getDueDate().toLocalDate().toString() : "" %>"/>

                <br/><br/>

                <button type="submit">Lưu</button>

                <a href="assignments?subjectId=<%=a.getSubjectId()%>">
                    <button type="button">Hủy</button>
                </a>
            </form>

        </div>