
import UIKit
import SnapKit

class HeaderSupplementaryView: UICollectionReusableView {
    
    private let headerLabel: UILabel = {
        let label = UILabel()
        label.text = "header"
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 28)
        label.textColor = .label
        return label
    }()
    
    static let CellID = "HeaderSupplementaryView"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .none
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func fill(with item: String) {
        headerLabel.text = item
    }
    
    private func setupConstraints() {
        
        addSubview(headerLabel)
        headerLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(16)
        }
    }
}
