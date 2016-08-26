import CoreLocation
import AEXML

private struct System {
    static var version: String {
        #if os(OSX)
            return "9.1"
        #else
            return UIDevice.currentDevice().systemVersion
        #endif
    }
}

public struct ProxyConfiguration {
    let url: String
    let port: Int
}

public struct SinespClient {

    public init(proxyConfiguraion: ProxyConfiguration? = nil) {
        requester = Requester(proxyConfiguration: proxyConfiguraion)
    }

    private var requester: Requester

    public typealias PlateCompletion = (PlateInformation?) -> Void
    public func information(for plate: Plate,
                     at location: CLLocation = .random,
                        completion: PlateCompletion) {

        let endpoint =  "ConsultaPlacaNovo02102014"
        let headers = ["Content-Type": "text/xml; charset=utf-8",
                       "Accept-Encoding": "gzip, deflate",
                       "Host": "sinespcidadao.sinesp.gov.br",
                       "User-Agent": "SinespCidadao/4.0.7 CFNetwork/808 Darwin/16.0.0",
                       "Accept": "*/*"]

        let latitude  = String(format: "%0.7f", location.coordinate.latitude)
        let longitude = String(format: "%0.7f", location.coordinate.longitude)

        let soapRequest = AEXMLDocument()
        let attributes = ["xmlns:soap": "http://schemas.xmlsoap.org/soap/envelope/",
                          "xmlns:xsi": "http://www.w3.org/2001/XMLSchema-instance",
                          "xmlns:xsd": "http://www.w3.org/2001/XMLSchema"]
        let envelope = soapRequest.addChild(name: "soap:Envelope", attributes: attributes)
        let header = envelope.addChild(name: "soap:Header")
        header.addChild(name: "b", value: "iPhone")
        header.addChild(name: "j")
        header.addChild(name: "i", value: latitude)
        header.addChild(name: "c", value: "iPhone OS")
        header.addChild(name: "e", value: "SinespCidadao")
        header.addChild(name: "f", value: "10.0.0.1")
        header.addChild(name: "g", value: plate.token)
        header.addChild(name: "d", value: System.version)
        header.addChild(name: "h", value: longitude)
        let body = envelope.addChild(name: "soap:Body")
        let getStatus = body.addChild(name: "webs:getStatus",
                                      attributes: ["xmlns:webs": "http://soap.ws.placa.service.sinesp.serpro.gov.br/"])
        getStatus.addChild(name: "a", value: plate.plate)

        requester.sendRequest(.POST, endpoint: endpoint, headers: headers, body: soapRequest.xmlString) {
            (data, response, error) in
            guard let data = data,
                      xmlResponse = try? AEXMLDocument(xmlData: data) else {
                completion(nil)
                return
            }

            let element = xmlResponse.root["soap:Body"]["ns2:getStatusResponse"]["return"]
            let plateInformation = PlateInformation(element: element)

            completion(plateInformation)
        }
    }
}
