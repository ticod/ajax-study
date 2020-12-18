<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<fmt:requestEncoding value="UTF-8"/>
<sql:setDataSource var="conn" driver="org.mariadb.jdbc.Driver"
                   url="jdbc:mariadb://localhost:3307/classdb"
                   user="scott" password="1234" />
<sql:query var="rs" dataSource="${conn}">
    select * from member where id like ?
    <sql:param>${param.id}%</sql:param>
</sql:query>

<ul>
    <c:forEach var="data" items="${rs.rows}">
        <li>${data.id}</li>
    </c:forEach>
</ul>