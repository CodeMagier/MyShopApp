
import UIKit
import SnapKit

class SignInViewController: UIViewController {
    
    private let singInView = SignInView(frame: .zero)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        
    }
    private func setup() {
        view.addSubview(singInView)
        singInView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
