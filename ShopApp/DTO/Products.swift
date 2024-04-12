
import Foundation

struct categories: Codable {
    
    let categories: [Category]
}

struct Category: Codable, Equatable {
    
    let title: String
    
    enum CodingKeys: String, CodingKey {
        case title = "strCategory"
    }
    
    static func ==(lhs: Category, rhs: Category) -> Bool {
        return lhs.title == rhs.title
    }
}

//----------------------------------

struct Products: Codable {
    
    let meals: [Product]
}

struct Product: Codable {
    
    let strMeal: String
    let strMealThumb: String
    let idMeal: String
}

//----------------------------------

struct Meals: Codable {
    
    let meals: [Meal]
}

struct Meal: Codable {
    
    let idMeal: String
    let strMeal: String
    let strCategory: String
    let strArea: String
    let strInstructions: String
    let strMealThumb: String
}

//----------------------------------

struct Searchs: Codable {
    
    let searchs: [Search]
}

struct Search: Codable {
    
    let idMeal: String
    let strMeal: String
    
}
