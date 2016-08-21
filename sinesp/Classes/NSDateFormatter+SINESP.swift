import Foundation

extension NSDateFormatter {
    static func sinespResponseDateFormatter() -> NSDateFormatter {
        return dateFormatter("dd/MM/yyyy 'às' HH:mm:ss")
    }
    
    private static func dateFormatter(format: String) -> NSDateFormatter {
        let formatter = NSDateFormatter()
        formatter.dateFormat = format
        return formatter
    }
}
