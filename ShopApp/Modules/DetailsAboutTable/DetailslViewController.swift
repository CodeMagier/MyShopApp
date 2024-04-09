
import UIKit
import SnapKit

class DetailslViewController: UIViewController {
        
    let detailsView = DetailsView(frame: .zero)
    
    var idMeal: String? {
           didSet {
               if let idMeal = idMeal {
                   detailsView.loadMealDetails(idMeal: idMeal)
               }
           }
       }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setup()
        
    }
   
    private func setup() {
        
        view.addSubview(detailsView)
        detailsView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        detailsView.didOrderTapped = { [ weak self ] in
            guard let self else { return }
            let vc = MainViewController()
            navigationController?.popToRootViewController(animated: true)
        }
    }
}
