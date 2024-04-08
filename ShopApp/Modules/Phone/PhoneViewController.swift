
import UIKit

class PhoneViewController: UIViewController {
    
    private let phoneView = PhoneView(frame: .zero)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setup()
    }
    
    private func setup() {
        view.addSubview(phoneView)
        phoneView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        phoneView.didLoginTapped = { [ weak self ] in
            guard let self else { return }
            let vc = MainViewController()
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}


