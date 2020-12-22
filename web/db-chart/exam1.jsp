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
        SELECT DATE_FORMAT(regdate, "%Y-%m-%d") date, COUNT(*) cnt FROM board
        GROUP BY date
        HAVING COUNT(*) > 1
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
            "${m.date}",
            </c:forEach>
        ],
        datasets: [
            {
                type: 'line',
                borderWidth: 2,
                borderColor: [
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
            {
                type: 'bar',
                backgroundColor: [
                    <c:forEach items="${rs.rows}" var="m">
                    randomColor(1),
                    </c:forEach>
                ],
                data: [
                    <c:forEach items="${rs.rows}" var="m">
                    "${m.cnt}",
                    </c:forEach>
                ],
                borderWidth: 2
            }
        ]
    }

    window.onload = function() {
        const ctx = document.getElementById("canvas").getContext("2d");
        window.myBar = new Chart(ctx, {
            type: "bar",
            data: chartData,
            options: {
                responsive: true,
                title: {
                    display: true,
                    text: "등록 일자 별 게시판 등록 건수"
                },
                legend: {display: false},
                scales: {
                    xAxes: [{
                        display: true,
                        scaleLabel: {
                            display: true,
                            labelString: "게시물 작성일"
                        },
                        stacked: true
                    }],
                    yAxes: [{
                        display: true,
                        scaleLabel: {
                            display: true,
                            labelString: "게시물 작성 건수"
                        },
                        stacked: true
                    }],
                }
            }
        })
    }
</script>
</body>
</html>