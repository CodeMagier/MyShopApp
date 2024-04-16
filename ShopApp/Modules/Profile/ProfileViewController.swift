 
import UIKit

class ProfileViewController: UIViewController {
    
    private let profileView = ProfileView(frame: .zero)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Профиль"
        setup()
    }
    
    private func setup() {
        view.addSubview(profileView)
        profileView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        profileView.didTapped = { [ weak self ] in
            guard let self else { return }
            navigationController?.popToRootViewController(animated: true)
        }
    }
}
