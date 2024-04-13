
import UIKit

final class CustomTabBarController: UITabBarController {
    
    private let customTabBar = CustomTabBar()
    
    private let plusButton = PlusButton(frame: .zero)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setValue(customTabBar, forKey: "tabBar")
        setupNavigtionItem()
        setupTabItem()
        setupPlusButtonAction()
     
    }
    
     func setupNavigtionItem() {
        navigationItem.title = "Меню"
        let rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "bell"),
                                                 style: .plain,
                                                 target: self,
                                                 action: .none)
        navigationItem.rightBarButtonItem = rightBarButtonItem
        navigationController?.navigationBar.tintColor = .black
    }
    
    private func setupTabItem() {
        
        let majorVC = MainViewController()
        majorVC.tabBarItem.image = UIImage(systemName: "house")
        
        var bagVC = BagViewController()
        bagVC.tabBarItem.image = UIImage(systemName: "bag")
        
        let compassVC = CompassViewController()
        compassVC.tabBarItem.image = UIImage(systemName: "location")
        //compassVC.tabBarItem.image = UIImage(resource: .kompas)
        
        let profileVC = ProfileViewController()
        profileVC.tabBarItem.image = UIImage(systemName: "person")
        
        setViewControllers([majorVC, bagVC, compassVC, profileVC], animated: false)
    }
    
    private func setupPlusButtonAction() {
        plusButton.didGrcodeTapped = { [ weak self ] in
            guard let self else { return }
            let vc = BagViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
