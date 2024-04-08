
import UIKit
import SnapKit

class DetailsView: UIView {
    
    private let descriptionImage: UIImageView = {
        let view = UIImageView()
        view.image = UIImage()
        view.contentMode = .scaleAspectFill
        view.layer.cornerRadius = 18
        view.clipsToBounds = true
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = .systemFont(ofSize: 22, weight: .medium)
        return label
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = .systemFont(ofSize: 20, weight: .medium)
        label.textColor = UIColor(hex: "#FF8B5B")
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = .systemFont(ofSize: 16, weight: .light)
        label.numberOfLines = 0
        return label
    }()
    
    var descriptionImageName: String?
    var titleText: String?
    var priceText: String?
    var descriptionText: String?

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        configureView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
     func configureView() {
        if let imageName = descriptionImageName,
           let image = UIImage(named: imageName) {
            descriptionImage.image = image
        }
         
        titleLabel.text = titleText
        priceLabel.text = priceText
        descriptionLabel.text = descriptionText
    }
    
    private func setupConstraints() {
        addSubview(descriptionImage)
        descriptionImage.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide).offset(10)
            make.horizontalEdges.equalToSuperview().inset(0)
            make.height.equalTo(225)
        }
        
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(descriptionImage.snp.bottom).offset(15)
            make.leading.equalToSuperview().offset(16)
        }
        
        addSubview(priceLabel)
        priceLabel.snp.makeConstraints { make in
            make.top.equalTo(descriptionImage.snp.bottom).offset(15)
            make.trailing.equalToSuperview().offset(-16)
        }
        
        addSubview(descriptionLabel)
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.horizontalEdges.equalToSuperview().inset(16)
        }
    }
}
