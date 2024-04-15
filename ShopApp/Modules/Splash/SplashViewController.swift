
import UIKit

class SplashViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let currentTime = Date()
        if let sessionDate = UserDefaults.standard.object(forKey: "session") as? Date, sessionDate >= currentTime {
            showTabBar()
        } else {
            showPhoneNumber()
        }
    }
    
    private func showPhoneNumber() {
        let startViewController = StartViewController()
        let navVc = UINavigationController(rootViewController: startViewController)
        navVc.modalPresentationStyle = .fullScreen
        navigationController?.present(navVc, animated: false)
    }
    
    private func showTabBar() {
        let tabBarController = CustomTabBarController()
        let navVc = UINavigationController(rootViewController: tabBarController)
        navVc.modalPresentationStyle = .fullScreen
        navigationController?.present(navVc, animated: false)
    }
}
