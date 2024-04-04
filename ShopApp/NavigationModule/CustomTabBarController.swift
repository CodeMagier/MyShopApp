
import UIKit

final class CustomTabBarController: UITabBarController {
    
    private let customTabBar = CustomTabBar()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setValue(customTabBar, forKey: "tabBar")
        setupTabItem()
        setupNavigtionItem()
    }
    
    private func setupNavigtionItem() {
            navigationItem.title = "Меню"
            let rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "bell"),
                                                     style: .plain,
                                                     target: self,
                                                     action: .none)
            navigationItem.rightBarButtonItem = rightBarButtonItem
            navigationController?.navigationBar.tintColor = .black
        }
    
    private func setupTabItem() {
        
        let firstVC = MajorViewController()
        firstVC.tabBarItem.title = "Like"
        firstVC.tabBarItem.image = UIImage(systemName: "person")
        
        let secondVC = BagVC()
        secondVC.tabBarItem.title = "Subscrin"
        secondVC.tabBarItem.image = UIImage(systemName: "house.fill")
        
        let seconddVC = ProfileVC()
        seconddVC.tabBarItem.title = "Subscrin"
        seconddVC.tabBarItem.image = UIImage(systemName: "house.fill")
        
        let secondddVC = CompasVC()
        secondddVC.tabBarItem.title = "Subscrin"
        secondddVC.tabBarItem.image = UIImage(systemName: "house.fill")
        
        
        setViewControllers([firstVC, secondVC, seconddVC,secondddVC], animated: false)
    }
    
}
