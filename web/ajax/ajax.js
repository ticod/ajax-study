let ajax = (function getAjaxObject() {
    if (window.ActiveXObject) {
        try {
            return new ActiveXObject("Msxml2.XMLHTTP");
        } catch (e) {
            try {
                return new ActiveXObject("Microsoft.XMLHTTP");
            } catch (e2) {
                return null;
            }
        }
    } else if (window.XMLHttpRequest) {
        return new XMLHttpRequest();
    } else {
        return null;
    }
})()

function sendRequest(url, params, callback, method) {
    let httpMethod = method ? method : "GET";
    if (httpMethod !== "GET" && httpMethod !== "POST") {
        httpMethod = "GET";
    }
    let httpParams = (params === null || params === '') ? null : params;
    let httpUrl = url;
    if (httpMethod === "GET" && httpParams !== null) {
        httpUrl = httpUrl + "?" + httpParams;
    }

    ajax.open(httpMethod, httpUrl, true);
    ajax.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
    ajax.onreadystatechange = callback;
    ajax.send(httpMethod === "POST" ? httpParams : null);
}
