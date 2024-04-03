
import UIKit

class MajorViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupNavigationItem()
    }
    
    private func setupNavigationItem() {
        navigationItem.title = "Меню"
        navigationItem.hidesBackButton = true
        let rigtButton = UIBarButtonItem(image: UIImage(systemName: "bell"), style: .plain, target: self, action: #selector(settingsButtonTapped))
        navigationItem.rightBarButtonItem = rigtButton
        
    }
    @objc func settingsButtonTapped() {
    
    }
}
