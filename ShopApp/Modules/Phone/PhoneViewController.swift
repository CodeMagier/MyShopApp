
import UIKit
import FirebaseAuth

class PhoneViewController: UIViewController {
    
    private let phoneView = PhoneView(frame: .zero)
    
    private let authService = AuthService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setup()
        sendSms()
    }
    
    private func setup() {
        view.addSubview(phoneView)
        phoneView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        phoneView.didLoginTapped = { [ weak self ] in
            self?.sendSms()
            
        }
    }
    
    private func sendSms() {
        guard let phoneNumber = phoneView.phoneNumber else {
            print("No phone number")
            return
            
        }
        
        authService.sendSmsCode(with: phoneNumber) { result in
            DispatchQueue.main.async {
                switch result {
                case .success:
                    self.showSMSCodeViewController()
                case .failure(let error):
                    print("Failed to send SMS: \(error.localizedDescription)")
                }
            }
        }
    }
    
    private func showSMSCodeViewController() {
        let vc = SMSCodeViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}
