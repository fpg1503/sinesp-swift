import Regex_swift

private extension String {
    var stringByRemovingWhitespaces: String {
        let components = componentsSeparatedByCharactersInSet(.whitespaceCharacterSet())
        return components.joinWithSeparator("")
    }
}

public struct Plate {
    public init?(plate: String) {
        guard let regex = Regex(pattern: "^(\\w{3})-?(\\d{4})$") else { return nil }
        let cleanPlate = plate.uppercaseString.stringByRemovingWhitespaces

        guard let captureGroups = regex.matches(cleanPlate).first?.captureGroups
            where captureGroups.count == 2 else { return nil }

        let lettersString = captureGroups[0]
        let numbersString = captureGroups[1]

        letters = lettersString.characters.map { $0 as Character }
        numbers = numbersString.characters.map { $0 as Character }.map { String($0) }.map{ Int($0) }.flatMap { $0 }

        self.plate = lettersString + numbersString
    }

    public let letters: [Character]
    public let numbers: [Int]

    public let plate: String
}