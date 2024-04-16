
import UIKit
import SnapKit

protocol EmailDelegate {
    
    func getEmail(email: String, password: String)

}

class EmailViewController: UIViewController {
    
    private let emailView = EmailView(frame: .zero)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        emailView.delegate = self
    }
    
    private func setup() {
        view.addSubview(emailView)
        emailView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func goTo() {
        let vc = CustomTabBarController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}


extension EmailViewController: EmailDelegate {
    func getEmail(email: String, password: String) {
        AuthService.shared.signIn(with: email, password: password) { result in
            DispatchQueue.main.async {
                switch result {
                case .success():
                    self.goTo()
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    
}
