
import UIKit
import SnapKit

class DetailslViewController: UIViewController {
    
    var configureDetails: (() -> Void)?
    
    let detailsView = DetailsView(frame: .zero)

    override func viewDidLoad() {
        super.viewDidLoad()
        configureDetails?()
        setup()

    }
    
    private func setup() {
        view.addSubview(detailsView)
        detailsView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
 }

