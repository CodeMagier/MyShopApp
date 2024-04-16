
import UIKit
import FirebaseAuth

protocol PhoneDelegate {
    func getPhone(phone: String)
}
class PhoneViewController: UIViewController {
    
    private let phoneView = PhoneView(frame: .zero)
    
    private let authService = AuthService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setup()
        phoneView.delegate = self
    }
    
    private func setup() {
        view.addSubview(phoneView)
        phoneView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        phoneView.didLogInTapped = { [ weak self ] in
            guard let self else { return }
            let vc = SignInViewController()
            navigationController?.pushViewController(vc, animated: true)
        }
        
        phoneView.didEmailTapped = { [ weak self ] in
            guard let self else { return }
            let vc = EmailViewController()
            navigationController?.pushViewController(vc, animated: true)
        }
        
    }
    
    private func showSMSCodeViewController() {
        let vc = SMSCodeViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension PhoneViewController: PhoneDelegate {
    
    func getPhone(phone: String) {
        authService.sendSmsCode(with: phone) { result in
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
}
