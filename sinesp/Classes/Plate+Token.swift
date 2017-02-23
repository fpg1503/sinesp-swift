import Arcane

private struct Key {
    fileprivate static let secret = "7lYS859X6fhB5Ow"
}

extension Plate {
    var token: String? {
        let plateAndSecret = plate + Key.secret
        return HMAC.SHA1(plate, key: plateAndSecret)
    }
}
