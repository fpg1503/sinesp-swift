struct Requester {

    init(proxyConfiguration: ProxyConfiguration? = nil) {

        let sessionConfiguration = NSURLSessionConfiguration.defaultSessionConfiguration()

        if let proxyConfiguration = proxyConfiguration {
            sessionConfiguration.connectionProxyDictionary = [
                kCFNetworkProxiesHTTPEnable: true,
                kCFNetworkProxiesHTTPPort: proxyConfiguration.port,
                kCFNetworkProxiesHTTPProxy: proxyConfiguration.url
            ]
        }
        session = NSURLSession(configuration: sessionConfiguration)
    }

    let baseURL = "http://sinespcidadao.sinesp.gov.br/sinesp-cidadao/mobile/"

    enum Method: String {
        case POST = "POST"
    }

    let session: NSURLSession

    func sendRequest(method: Method,
                     endpoint: String,
                     headers: [String: String] = [:],
                     body: String,
                     completionHandler: (NSData?, NSURLResponse?, NSError?) -> Void) {

        guard let URL = NSURL(string: baseURL + endpoint) else { return }
        let request = NSMutableURLRequest(URL: URL)

        request.HTTPMethod = method.rawValue
        request.allHTTPHeaderFields = headers
        request.HTTPBody = body.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: true)

        let task = session.dataTaskWithRequest(request, completionHandler: completionHandler)
        task.resume()
    }
}

