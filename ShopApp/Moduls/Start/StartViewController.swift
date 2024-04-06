
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
        
        startView.didLoginTapped = { [weak self] in
            guard let self else { return }
            let vc = PhoneViewController()
            navigationController?.pushViewController(vc, animated: true)
        }
    }

}
