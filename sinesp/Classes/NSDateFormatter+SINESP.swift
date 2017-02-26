import Foundation

extension DateFormatter {
    static func sinespResponseDateFormatter() -> DateFormatter {
        return dateFormatter("dd/MM/yyyy 'às' HH:mm:ss")
    }

    static func requestDateFormatter() -> DateFormatter {
        return dateFormatter("yyyy-MM-dd HH:mm:ss")
    }
    
    private static func dateFormatter(_ format: String) -> DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter
    }
}
