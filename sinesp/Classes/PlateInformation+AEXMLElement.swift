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
                  _returnMessage      = values["mensagemRetorno"] ?? nil,
                  _statusCodeValue    = values["codigoSituacao"]  ?? nil,
                  _statusMessage      = values["situacao"]        ?? nil,
                  _chassis            = values["chassi"]          ?? nil,
                  _model              = values["modelo"]          ?? nil,
                  _brand              = values["marca"]           ?? nil,
                  _color              = values["cor"]             ?? nil,
                  _yearValue          = values["ano"]             ?? nil,
                  _modelYearValue     = values["anoModelo"]       ?? nil,
                  _plateValue         = values["placa"]           ?? nil,
                  _dateValue          = values["data"]            ?? nil,
                  _city               = values["municipio"]       ?? nil,
                  _state              = values["uf"]              ?? nil else { return nil }

        let formatter = NSDateFormatter.sinespResponseDateFormatter()

        guard let _returnCode         = Int(_returnCodeValue),
                  _statusCode         = Int(_statusCodeValue),
                  _year               = Int(_yearValue),
                  _modelYear          = Int(_modelYearValue),
                  _plate              = Plate(plate: _plateValue),
                  _date               = formatter.dateFromString(_dateValue) else { return nil }

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