
import UIKit
import SnapKit

class CustomCollectionViewCell: UICollectionViewCell {
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        return label
    }()
    
    static let reuseId = String(describing: CustomCollectionViewCell.self)
    
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
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(catedory: Category) {
        
        titleLabel.text = catedory.title

    }
}
