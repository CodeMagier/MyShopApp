
import Foundation

struct MockData {
    
    static let shared = MockData()
    
    private let record: ListSection = {
        .record([.init(title: "My orders", image: "стрелка"),
                 .init(title: "My information", image: "стрелка"),
                 .init(title: "Saved addresses", image: "стрелка")])
    }()
    
    private let settings: ListSection = {
        .settings([.init(title: "Change language", image: "стрелка"),
                   .init(title: "Notifications", image: "стрелка")])
    }()
    
    private let info: ListSection = {
        .info([.init(title: "Arequent questions", image: "стрелка"),
               .init(title: "How the system works", image: "стрелка"),
               .init(title: "User agreements", image: "стрелка"),
               .init(title: "Privacy policy", image: "стрелка")])
    }()
    
    var pageData: [ListSection] {
        [record, settings, info]
    }
}
