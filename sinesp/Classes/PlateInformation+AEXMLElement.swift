import AEXML

protocol AEXMLElementDecodable {
    init?(element: AEXMLElement)
}

private extension Dictionary {
    init(elements:[(Key, Value)]) {
        self.init()
        for (key, value) in elements {
            updateValue(value, forKey: key)
        }
    }
}

extension AEXMLElement {
    var values: [String: String?] {
        let elements = children.map { (element) -> (String, String?) in
            return (element.name, element.value)
        }

        return Dictionary(elements: elements)
    }
}

extension PlateInformation: AEXMLElementDecodable {
    init?(element: AEXMLElement) {
        let values = element.values

        guard let _returnCodeValue    = values["codigoRetorno"]   ?? nil,
                  let _returnMessage      = values["mensagemRetorno"] ?? nil,
                  let _statusCodeValue    = values["codigoSituacao"]  ?? nil,
                  let _statusMessage      = values["situacao"]        ?? nil,
                  let _chassis            = values["chassi"]          ?? nil,
                  let _model              = values["modelo"]          ?? nil,
                  let _brand              = values["marca"]           ?? nil,
                  let _color              = values["cor"]             ?? nil,
                  let _yearValue          = values["ano"]             ?? nil,
                  let _modelYearValue     = values["anoModelo"]       ?? nil,
                  let _plateValue         = values["placa"]           ?? nil,
                  let _dateValue          = values["data"]            ?? nil,
                  let _city               = values["municipio"]       ?? nil,
                  let _stateValue         = values["uf"]              ?? nil else { return nil }

        let formatter = DateFormatter.sinespResponseDateFormatter()

        guard let _returnCode         = Int(_returnCodeValue),
                  let _statusCode         = Int(_statusCodeValue),
                  let _year               = Int(_yearValue),
                  let _modelYear          = Int(_modelYearValue),
                  let _plate              = Plate(plate: _plateValue),
                  let _date               = formatter.date(from: _dateValue),
                  let _state              = State(rawValue: _stateValue) else { return nil }

        returnCode                    = _returnCode
        returnMessage                 = _returnMessage
        statusCode                    = _statusCode
        statusMessage                 = _statusMessage
        chassis                       = _chassis
        model                         = _model
        brand                         = _brand
        color                         = _color
        year                          = _year
        modelYear                     = _modelYear
        plate                         = _plate
        date                          = _date
        city                          = _city
        state                         = _state
    }
}
