
import UIKit
import SnapKit

class ButtonsFooterCell: UICollectionViewCell {
    
    private lazy var exitButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("log out of your account", for: .normal)
        button.layer.cornerRadius = 16
        button.backgroundColor = .systemGray6
        button.tintColor = .red
        return button
    }()
    
    private let versionLabel: UILabel = {
        let label = UILabel()
        label.text = "version 2.40.11"
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textColor = .cyan
        return label
    }()
    
    static let reuseId = String(describing: ButtonsFooterCell.self)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .none
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func fill(with item: ListSection.FooterModel) {
        versionLabel.text = item.version
    }
    
    private func setupConstraints() {
       
        addSubview(exitButton)
        addSubview(versionLabel)
        
        exitButton.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.horizontalEdges.equalToSuperview().inset(16)
            make.height.equalTo(50)
        }
    
        versionLabel.snp.makeConstraints { make in
            make.top.equalTo(exitButton.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
}
