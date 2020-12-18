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
    select * from member where id = ? and pass = ?
    <sql:param>${param.id}</sql:param>
    <sql:param>${param.password}</sql:param>
</sql:query>

<c:if test="${!empty rs.rows}">
<c:forEach var="data" items="${rs.rows}">
    <h1>반갑습니다! ${data.name}님</h1>
</c:forEach>
</c:if>

<c:if test="${empty rs.rows}">
    <h1>아이디 혹은 비밀번호가 틀렸습니다.</h1>
</c:if>