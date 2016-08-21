import CoreLocation

struct SinespClient {

    typealias PlateCompletion = (PlateInformation?) -> Void
    func information(for plate: Plate,
                     at location: CLLocation = .random,
                        completion: PlateCompletion) {

        let endpoint =  "ConsultaPlacaNovo02102014"
        let headers = ["Content-Type": "text/xml; charset=utf-8",
                       "Accept-Encoding": "gzip, deflate",
                       "Host": "sinespcidadao.sinesp.gov.br",
                       "Content-Length": "634",
                       "Accept": "*/*"]

        let body = ""
        Requester.sendRequest(.POST, endpoint: endpoint, headers: headers, body: body) {
            (data, response, error) in

            print(data)
        }
    }
}
