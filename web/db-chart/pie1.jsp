<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Title</title>
    <style>
        canvas {
            -moz-user-select: none;
            -webkit-user-select: none;
            -ms-user-select: none;
            user-select: none;
        }
    </style>
    <sql:setDataSource var="conn" driver="org.mariadb.jdbc.Driver"
                       url="jdbc:mariadb://localhost:3307/classdb"
                       user="scott" password="1234" />
    <sql:query var="rs" dataSource="${conn}">
        select name, count(*) cnt from board
        group by name
        having count(*) > 1
        order by cnt desc
    </sql:query>
</head>
<body>

<div id="container" style="width: 75%">
    <canvas id="canvas"></canvas>
</div>

<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.9.4/Chart.min.js"></script>
<script>
    const randomColorFactor = function() {
        return Math.round(Math.random() * 255);
    }

    const randomColor = function(opacity) {
        return "rgba(" + randomColorFactor() + ","
                + randomColorFactor() + ","
                + randomColorFactor() + ","
                + (opacity || '.3') + ")";
    }

    const chartData = {
        labels: [
            <c:forEach items="${rs.rows}" var="m">
            "${m.name}",
            </c:forEach>
        ],
        datasets: [
            {
                borderWidth: 2,
                backgroundColor: [
                    <c:forEach items="${rs.rows}" var="m">
                    randomColor(1),
                    </c:forEach>
                ],
                label: '건수',
                fill: false,
                data: [
                    <c:forEach items="${rs.rows}" var="m">
                    "${m.cnt}",
                    </c:forEach>
                ],
            },
        ]
    }

    window.onload = function() {
        const ctx = document.getElementById("canvas").getContext("2d");
        window.myBar = new Chart(ctx, {
            type: "pie",
            data: chartData,
            options: {
                responsive: true,
                title: {
                    display: true,
                    text: "글쓴이 별 게시판 등록 건수",
                    position: "bottom"
                },
                legend: {
                    position: "top"
                },
            }
        })
    }
</script>
</body>
</html>