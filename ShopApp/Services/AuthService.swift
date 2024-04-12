
import Foundation
import FirebaseAuth

struct AuthService {
    
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
                completion(.success(autchResult))
            }
        }
    }
}
