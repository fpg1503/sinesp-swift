import Arcane

private struct Key {
    fileprivate static let secret = "TRwf1iBwvCoSboSscGne"
}

extension Plate {
    var token: String? {
        let plateAndSecret = plate + Key.secret
        return HMAC.SHA1(plate, key: plateAndSecret)
    }
}
