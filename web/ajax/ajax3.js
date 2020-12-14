// class 방식으로 한번

class Ajax {
    constructor() {
        this.xhr = new Xhr();
    }
}

class Xhr {
    constructor() {
        this.Request = new Request();
    }
}

class Request {
    constructor(url, params, callback, method) {
        this.url = url;
        this.params = params;
        this.callback = callback;
        this.method = method;
        this.send();
    }

    getXmlHttpRequest() {
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
    }

    send() {
        this.req = this.getXmlHttpRequest();

        let httpMethod = this.method ? this.method : "GET";
        if (httpMethod !== "GET" && httpMethod !== "POST") {
            httpMethod = "GET";
        }

        const httpParams = (this.params === null || this.params === '')
            ? null
            : this.params;

        let httpUrl = this.url;

        if (httpMethod === 'GET' && httpParams !== null) {
            httpUrl = httpUrl + "?" + httpParams;
        }

        this.req.open(httpMethod, httpUrl, true);
        this.req.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");

        const request = this;
        this.req.onreadystatechange = function() {
            request.onStateChange.call(request);
        }

        this.req.send(httpMethod === "POST" ? httpParams : null);
    }

    onStateChange() {
        this.callback(this.req);
    }
}