import CoreLocation

private struct Constant {
    fileprivate static let LatitudeOffset  = 38.5290245
    fileprivate static let LongitudeOffset = 3.7506985
}

private extension Double {
    static var randomDouble: Double {
        return Double(Float(arc4random()) / Float(UINT32_MAX))
    }
    static var π: Double { return .pi }
}

private extension CLLocationDegrees {
    static var randomDegrees: CLLocationDegrees {
        get {
            let radius: Double = 2000

            let seed = (radius/111000 * sqrt(randomDouble))
                        * sin(2 * π * randomDouble)
            return seed
        }
    }
}

extension CLLocation {
    static var random: CLLocation {
        get {
            let latitude  = CLLocationDegrees.randomDegrees - Constant.LatitudeOffset
            let longitude = CLLocationDegrees.randomDegrees - Constant.LongitudeOffset
            let location  = CLLocation(latitude: latitude, longitude: longitude)
            return location
        }
    }
}
