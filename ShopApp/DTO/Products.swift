
import Foundation

struct Categorys: Codable {
    
    let categories: [Category]
    
}

struct Category: Codable {
    
    let strCategory: String
    
}

struct Products: Codable {
    
    let meals: [Product]

}

struct Product: Codable {
    
    let strMeal: String
    let strMealThumb: String
    let idMeal: String
    
}



