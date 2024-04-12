
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
            guard let self else { return }
            let vc = SMSCodeViewController()
            navigationController?.pushViewController(vc, animated: true)
            singIn()
        }
    }
    
    private func sendSms() {
        authService.sendSmsCode(with: "+996703928927") { result in
            if case.success = result {
                print("success")
                
            }
        }
    }
    
    private func singIn() {
        guard let text  = phoneView.phoneNumber else { return }
        authService.singIn(with: text) { result in
            switch result {
            case .success(let success):
                print(success)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}



