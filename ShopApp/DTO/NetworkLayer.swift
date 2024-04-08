
import Foundation

struct NetworkLayer {
    
    private let decoder = JSONDecoder()
    
    private let encoder = JSONEncoder()
    
    func fetchCategorys(
        completion: @escaping (Result<[Category],
                               Error>) -> Void) {
        let reguest = URLRequest(url: Constants.categoryURL)
        URLSession.shared.dataTask(with: reguest) { data,
                                                    response,
                                                    error in
            if let error {
                completion(.failure(error))
            }
            
            if let data {
                do {
                    let model = try decoder.decode(Categorys.self,
                                                   from: data)
                    completion(.success(model.categories))
                } catch {
                    completion(.failure(error))
                }
            }
        }.resume()
    }
    
    func fetchProducts(
        completion: @escaping (Result<[Product],
                               Error>) -> Void) {
        let reguest = URLRequest(url: Constants.baseURL)
        URLSession.shared.dataTask(with: reguest) { data,
                                                    response,
                                                    error in
            if let error {
                completion(.failure(error))
            }
            
            if let data {
                do {
                    let model = try decoder.decode(Products.self, 
                                                   from: data)
                    completion(.success(model.meals))
                } catch {
                    completion(.failure(error))
                }
            }
        }.resume()
    }
}
