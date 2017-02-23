struct Requester {

    init(proxyConfiguration: ProxyConfiguration? = nil) {

        let sessionConfiguration = URLSessionConfiguration.default

        if let proxyConfiguration = proxyConfiguration {
            sessionConfiguration.connectionProxyDictionary = [
                kCFNetworkProxiesHTTPEnable as AnyHashable: true,
                kCFNetworkProxiesHTTPPort as AnyHashable: proxyConfiguration.port,
                kCFNetworkProxiesHTTPProxy as AnyHashable: proxyConfiguration.url
            ]
        }
        session = URLSession(configuration: sessionConfiguration)
    }

    let baseURL = "http://sinespcidadao.sinesp.gov.br/sinesp-cidadao/"

    enum Method: String {
        case POST = "POST"
    }

    let session: URLSession
    
    func sendRequest(method: Method,
                     endpoint: String,
                     headers: [String: String] = [:],
                     body: String,
                     completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) {
        
        guard let URL = URL(string: baseURL + endpoint) else { return }
        let request = NSMutableURLRequest(url: URL as URL)
    
        request.httpMethod = method.rawValue
        request.allHTTPHeaderFields = headers
        request.httpBody = body.data(using: String.Encoding.utf8, allowLossyConversion: true)
        
        let task = session.dataTask(with: request as URLRequest, completionHandler: completionHandler)
        task.resume()
    }
}

