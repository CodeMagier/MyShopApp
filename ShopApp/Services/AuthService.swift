
import Foundation
import FirebaseAuth

final class AuthService {
    
    static let shared = AuthService()
    
    func sendSmsCode(with phoneNumber: String, completion: @escaping (Result<Void, Error>) -> Void)
    
    {
        PhoneAuthProvider.provider()
            .verifyPhoneNumber(phoneNumber, uiDelegate: nil) { verificationID, error in
                if let error = error {
                    completion(.failure(error))
                }
                if let verificationID {
                    UserDefaults.standard.set(verificationID, forKey: "authVerificationID")
                    completion(.success(()))
                }
            }
    }
    
    func singIn(with verificationCode: String, completion: @escaping (Result<AuthDataResult, Error>) -> Void) {
        let verificationID = UserDefaults.standard.string(forKey: "authVerificationID") ?? ""
        let credential = PhoneAuthProvider.provider().credential(
            withVerificationID: verificationID,
            verificationCode: verificationCode
        )
        
        Auth.auth().signIn(with: credential) { autchResult, error in
            if let error = error {
                completion(.failure(error))
            }
            if let autchResult {
                let currentDate = Date()
               guard let oneMinLater = Calendar.current.date(byAdding: .second,
                                                        value: 30,
                                                        to: currentDate
               ) else { return }
                UserDefaults.standard.set(oneMinLater, forKey: "session")
                completion(.success(autchResult))
            }
        }
    }
}
