
import Foundation

struct ListItem {
    
    let title: String
    let image: String
    
}

enum ListSection {
    
    case record([ListItem])
    case settings([ListItem])
    case info([ListItem])
    
    var items: [ListItem] {
        switch self {
        case .record(let items),
            .settings(let items),
            .info(let items):
            return items
        }
    }
    
    var count: Int {
        items.count
    }
    
    var title: String {
        switch self {
        case .record(_):
            return "User account"
        case .settings(_):
            return "Settings"
        case .info(_):
            return "Information"
        }
    }
}
