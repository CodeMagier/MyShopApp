
import UIKit
import SnapKit

class InfoCollectionViewCell: UICollectionViewCell {
    
    private let titleView: UIView = {
        let view = UIView()
        view.backgroundColor = .none
        view.layer.cornerRadius = 18
        view.layer.borderColor = UIColor.cyan.cgColor
        view.layer.borderWidth = 1.5
        //view.backgroundColor = .cyan
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .label
        label.font = .systemFont(ofSize: 16, weight: .medium)
        return label
    }()
    
    private let recordImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        //image.backgroundColor = .cyan
        return image
    }()
    
    static let reuseId = String(describing: InfoCollectionViewCell.self)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func fill(with item: String, imageName: String) {
        titleLabel.text = item
        recordImageView.image = UIImage(named: imageName)
    }
    
    private func setupConstraints() {
        
        addSubview(titleView)
        titleView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.horizontalEdges.equalToSuperview().inset(16 )
            make.height.equalTo(50)
        }
        
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(titleView.snp.leading).offset(8)
            
        }
        
        addSubview(recordImageView)
        recordImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalTo(titleView.snp.trailing).offset(-8)
        }
    }
}
