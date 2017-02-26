import CoreLocation
import AEXML
import Regex_swift

private struct System {
    static var version: String {
        #if os(OSX)
            return "9.1"
        #else
            return UIDevice.current.systemVersion
        #endif
    }
}

public struct ProxyConfiguration {
    let url: String
    let port: Int

    public init(url: String, port: Int) {
        self.url = url
        self.port = port
    }
}

public struct SinespClient {

    public init(proxyConfiguraion: ProxyConfiguration? = nil) {
        requester = Requester(proxyConfiguration: proxyConfiguraion)
    }

    fileprivate var requester: Requester

    public typealias PlateCompletion = (PlateInformation?) -> Void
    public func information(for plate: Plate,
                     at location: CLLocation = .random,
                        completion: @escaping PlateCompletion) {

        let endpoint =  "mobile/consultar-placa"
        let headers = ["Host": "sinespcidadao.sinesp.gov.br",
                       "User-Agent": "SinespCidadao/4.0.7 CFNetwork/808 Darwin/16.0.0",
                       "Accept": "*/*"]

        let latitude  = String(format: "%0.7f", location.coordinate.latitude)
        let longitude = String(format: "%0.7f", location.coordinate.longitude)

        let formatter = DateFormatter.requestDateFormatter()

        let uuid = UUID().uuidString.lowercased()
        let date = formatter.string(from: Date())

        let soapRequest = AEXMLDocument()
        let attributes = ["xmlns:soap": "http://schemas.xmlsoap.org/soap/envelope/",
                          "xmlns:xsi": "http://www.w3.org/2001/XMLSchema-instance",
                          "xmlns:xsd": "http://www.w3.org/2001/XMLSchema"]
        let envelope = soapRequest.addChild(name: "soap:Envelope", attributes: attributes)
        let header = envelope.addChild(name: "soap:Header")
        header.addChild(name: "b", value: "iPhone")
        header.addChild(name: "c", value: "ANDROID") //Oh, the irony
        header.addChild(name: "d", value: System.version)
        header.addChild(name: "i", value: latitude)
        header.addChild(name: "e", value: "SinespCidadao")
        header.addChild(name: "f", value: "10.0.0.1")
        header.addChild(name: "g", value: plate.token)
        header.addChild(name: "k", value: uuid)
        header.addChild(name: "h", value: longitude)
        header.addChild(name: "l", value: date)
        header.addChild(name: "m", value: "8797e74f0d6eb7b1ff3dc114d4aa12d3")
        let body = envelope.addChild(name: "soap:Body")
        let getStatus = body.addChild(name: "webs:getStatus",
                                      attributes: ["xmlns:webs": "http://soap.ws.placa.service.sinesp.serpro.gov.br/"])
        getStatus.addChild(name: "a", value: plate.plate)

        captchaCookie { (cookie) in
            guard let cookie = cookie else {
                completion(nil)
                return
            }

            var headersWithCookie = headers
            headersWithCookie["Cookie"] = cookie

            self.requester.sendRequest(method: .post, endpoint: endpoint, headers: headersWithCookie, body: soapRequest.xml) {
                (data, response, error) in
                guard let data = data,
                    let xml = String(data: data, encoding: .isoLatin1),
                    let xmlResponse = try? AEXMLDocument(xml: xml) else {
                    completion(nil)
                    return
                }

                let element = xmlResponse.root["soap:Body"]["ns2:getStatusResponse"]["return"]
                let plateInformation = PlateInformation(element: element)

                completion(plateInformation)
            }
        }
    }

    private func captchaCookie(completion: @escaping (String?) -> Void) {
        let endpoint =  "captchaMobile.png"
        requester.sendRequest(method: .get, endpoint: endpoint, body: "") { (_, response, _) in
            guard let response = response as? HTTPURLResponse else {
                completion(nil)
                return
            }

            guard let cookie = response.allHeaderFields["Set-Cookie"] as? String else {
                completion(nil)
                return
            }

            let regex = Regex(pattern: "(JSESSIONID=[^;]*);?")
            let sessionIDCookie = regex?.matches(cookie).first?.captureGroups.first

            completion(sessionIDCookie)
        }

    }
}
