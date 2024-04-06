
import UIKit
import SnapKit

class DetailslViewController: UIViewController {
    
    var descriptionImageName: String?
    var titleText: String?
    var priceText: String?
    var descriptionText: String?
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureView()
        setupConstraints()
        
    }
    
    private func configureView() {
        if let imageName = descriptionImageName, let image = UIImage(named: imageName) {
            descriptionImage.image = image
        }
        titleLabel.text = titleText
        priceLabel.text = priceText
        descriptionLabel.text = descriptionText
    }
    
    private func setupConstraints() {
        view.addSubview(descriptionImage)
        descriptionImage.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(10)
            make.horizontalEdges.equalToSuperview().inset(0)
            make.height.equalTo(225)
        }
        
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(descriptionImage.snp.bottom).offset(15)
            make.leading.equalToSuperview().offset(16)
        }
        
        view.addSubview(priceLabel)
        priceLabel.snp.makeConstraints { make in
            make.top.equalTo(descriptionImage.snp.bottom).offset(15)
            make.trailing.equalToSuperview().offset(-16)
        }
        
        view.addSubview(descriptionLabel)
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.horizontalEdges.equalToSuperview().inset(16)
        }
    }
}
