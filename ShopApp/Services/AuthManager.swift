
import Foundation
import FirebaseAuth

class AuthManager {
    
    static let shared = AuthManager()
    
    private let auth = Auth.auth()
    
    private var verificationID: String?
    
    private func startAuth(phoneNumber: String, completion: @escaping (Bool) -> Void) {
        PhoneAuthProvider.provider().verifyPhoneNumber(phoneNumber, uiDelegate: nil) { [ weak self ] verificationID, error in
            guard let verificationID = verificationID, error == nil else {
                completion(false)
                return
            }
            self?.verificationID = verificationID
            completion(true)
        }
    }
    
    private func verifyCode(smsCode: String, completion: @escaping (Bool) -> Void) {
        guard let verificationID = verificationID else {
            completion(false)
            return
        }
        
        let credenrial = PhoneAuthProvider.provider().credential(
            withVerificationID: verificationID,
            verificationCode: smsCode
        )
        
        auth.signIn(with: credenrial) { result, error in
            guard result != nil, error == nil else {
                completion(false)
                return
            }
            completion(true)
        }
    }
    
}





