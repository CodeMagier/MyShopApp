
import UIKit
import SnapKit

class CustomCollectionViewCell: UICollectionViewCell {
    
    static let CellID = "cell"
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLabel()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        updateAppearance(isSelected: false)
    }

    private func setupLabel() {
        contentView.addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
    }
    
    func updateAppearance(isSelected: Bool) {
        
        }
    
    func setTitle(label: Cellitem) {
        titleLabel.text = label.type
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
