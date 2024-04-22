
import Foundation

enum ListSection {

    case info(String, [ListItem])
    case footer(FooterModel)
    
    var items: [ListItem] {
        switch self {
        case
            .info(_, let items):
            return items
        case .footer:
            return[]
        }
    }
    
    var count: Int {
        items.count
    }
    
    var title: String {
        switch self {
        case .info(let hederTitle, _ ):
            return hederTitle
        case .footer:
            return ""
        }
    }
    
    struct FooterModel {
        
        let version: String
        
    }
    
    struct ListItem {
        
        let title: String
        let image: String
        
    }
}
