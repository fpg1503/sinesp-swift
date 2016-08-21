import Foundation

private extension String {
    var wholeRange: NSRange {
        return NSRange(location: 0, length: characters.count)
    }
    
    //TODO: Use ObjectiveCBridgeable or wait until NSRegularExpression has a swifty API
    var _ns: NSString {
        return self as NSString
    }
    
    func substringWithRange(range: NSRange) -> String {
        return self._ns.substringWithRange(range)
    }
}

private extension NSTextCheckingResult {
    var ranges: [NSRange] {
        var ranges = [NSRange]()
        for i in 0 ..< numberOfRanges {
            ranges.append(rangeAtIndex(i))
        }
        return ranges
    }
}

public struct Match {
    public let matchedString: String
    public let captureGroups: [String]
    
    public init(baseString string: String, checkingResult: NSTextCheckingResult) {
        matchedString = string.substringWithRange(checkingResult.range)
        captureGroups = checkingResult.ranges.dropFirst().map {
            string.substringWithRange($0)
        }
    }
}

public struct Regex {
    public let pattern: String
    public let options: NSRegularExpressionOptions
    
    private let matcher: NSRegularExpression
    
    public init?(pattern: String, options: NSRegularExpressionOptions = []) {
        guard let matcher = try? NSRegularExpression(pattern: pattern, options: options) else {
            return nil
        }
        
        self.matcher = matcher
        self.pattern = pattern
        self.options = options
    }
    
    public func match(string: String, options: NSMatchingOptions = [], range: NSRange? = .None) -> Bool {
        let range = range ?? string.wholeRange
        
        return matcher.numberOfMatchesInString(string, options: options, range: range) != 0
    }
    
    public func matches(string: String, options: NSMatchingOptions = [], range: NSRange? = .None) -> [Match] {
        let range = range ?? string.wholeRange
        
        return matcher.matchesInString(string, options: options, range: range).map { Match(baseString: string, checkingResult: $0)
        }
    }
}