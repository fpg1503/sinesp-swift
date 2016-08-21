struct Requester {

    static let baseURL = "http://sinespcidadao.sinesp.gov.br/sinesp-cidadao/"

    enum Method: String {
        case POST = "POST"
    }

    static func sendRequest(method: Method,
                     endpoint: String,
                     headers: [String: String] = [:],
                     body: String,
                     completionHandler: (NSData?, NSURLResponse?, NSError?) -> Void) {

        let sessionConfig = NSURLSessionConfiguration.defaultSessionConfiguration()
        let session = NSURLSession(configuration: sessionConfig)

        guard var URL = NSURL(string: baseURL + endpoint) else { return }
        let request = NSMutableURLRequest(URL: URL)

        request.HTTPMethod = method.rawValue
        request.allHTTPHeaderFields = headers
        request.HTTPBody = body.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: true)

        let task = session.dataTaskWithRequest(request, completionHandler: completionHandler)
        task.resume()

        session.finishTasksAndInvalidate()
    }
}

