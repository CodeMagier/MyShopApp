
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



