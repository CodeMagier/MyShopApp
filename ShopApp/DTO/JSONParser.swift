
import Foundation

struct JSONParser {
    
    let decoder = JSONDecoder()
    
    let encoder = JSONEncoder()
    
    func decode<T: Codable>(with data: Data, completion: (Result<T,Error>) -> Void) {
        do {
            let product = try decoder.decode(T.self, from: data)
            completion(.success(product))
        } catch {
            completion(.failure(error))
        }
    }
}
