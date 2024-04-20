
import Foundation

struct MockData {
    
    static let shared = MockData()
    
    private let record: ListSection = {
        ListSection.info( "User account",
        [
            ListSection.ListItem(title: "My orders", image: "стрелка"),
            ListSection.ListItem(title: "My information", image: "стрелка"),
            ListSection.ListItem(title: "Saved addresses", image: "стрелка")])
    }()
    
    private let settings: ListSection = {
        ListSection.info( "Settings",
        [
            ListSection.ListItem(title: "Arequent questions", image: "стрелка"),
            ListSection.ListItem(title: "How the system works", image: "стрелка")])
    }()
    
    private let info: ListSection = {
        ListSection.info( "Information",
        [
            ListSection.ListItem(title: "Arequent questions", image: "стрелка"),
            ListSection.ListItem(title: "How the system works", image: "стрелка"),
            ListSection.ListItem(title: "User agreements", image: "стрелка"),
            ListSection.ListItem(title: "Privacy policy", image: "стрелка")])
    }()
    
    private let footerModel = ListSection.footer(
        ListSection.FooterModel(version: "5.0.0")
    )
    
    var pageData: [ListSection] {
        [record, settings, info, footerModel]
    }
}
