
import UIKit
import SnapKit

class DetailslViewController: UIViewController {
        
   private let detailsView = DetailsView(frame: .zero)
    
    var idMeal: String!
    
    private let netWorkLayer = NetworkLayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        loadMealDetails(idMeal: idMeal)
        setup()
        
    }
 
    private func setup() {
        
        view.addSubview(detailsView)
        detailsView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        detailsView.didOrderTapped = { [ weak self ] in
            guard let self else { return }
            navigationController?.popToRootViewController(animated: true)
        }
    }
    
    func loadMealDetails(idMeal: String) {
        netWorkLayer.fetchMealDetails(by: idMeal) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let mealDetails):
                DispatchQueue.main.async {
                    self.detailsView.fill(with: mealDetails)
                }
            case .failure(let error):
                print("Ошибка: \(error)")
            }
        }
    }
}
