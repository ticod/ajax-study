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
    select * from member where id = ?
    <sql:param>${param.id}</sql:param>
</sql:query>

<c:if test="${!empty rs.rows}">
    <h1 class="find">이미 존재하는 아이디입니다.</h1>
</c:if>

<c:if test="${empty rs.rows}">
    <h1 class="notfound">회원가입 가능한 아이디입니다.</h1>
</c:if>