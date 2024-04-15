
import UIKit

class StartViewController: UIViewController {
    
    private let startView = StartView(frame: .zero)
        
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        
    }
    
    private func setup() {
        view.addSubview(startView)
        startView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        startView.didSignUpTapped = { [weak self] in
            guard let self else { return }
            let vc = PhoneViewController()
            navigationController?.pushViewController(vc, animated: true)
        }
        
        startView.didLogInButton = { [weak self] in
            guard let self else { return }
            let vc = SignInViewController()
            navigationController?.pushViewController(vc, animated: true)
        }
    }

}
