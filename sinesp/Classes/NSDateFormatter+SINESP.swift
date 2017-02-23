import Foundation

extension DateFormatter {
    static func sinespResponseDateFormatter() -> DateFormatter {
        return dateFormatter("dd/MM/yyyy 'às' HH:mm:ss")
    }
    
    fileprivate static func dateFormatter(_ format: String) -> DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter
    }
}
