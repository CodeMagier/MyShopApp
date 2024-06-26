
import UIKit
import SnapKit

class DetailsView: UIView {
    
    private let scrollView: UIScrollView = {
        let view = UIScrollView()
        view.backgroundColor = .clear
        return view
    }()
    
    private let contentView: UIView = {
        let view = UIView()
        return view
    }()
    
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
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 22, weight: .medium)
        return label
    }()
    
    private let areaLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = .systemFont(ofSize: 20, weight: .medium)
        label.textColor = UIColor(hex: "#FF8B5B")
        return label
    }()
    
    private let categoryLabel: UILabel = {
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
    
    private let buyButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("To order", for: .normal)
        button.backgroundColor = UIColor(hex: "#FF8B5B")
        button.tintColor = .label
        button.layer.cornerRadius = 18
        
        return button
    }()
    
    var idMeal: String?
    
    var didOrderTapped: (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        setupConstraints()
        buyButton.addTarget(self, action: #selector(goTo), for: .touchUpInside)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func fill(with item: Meal) {
        titleLabel.text = item.strMeal
        areaLabel.text = item.strArea
        categoryLabel.text = item.strCategory
        descriptionLabel.text = item.strInstructions
        ImageDownloader.shared.loadImage(from: item.strMealThumb) { result in
            if case .success(let image) = result {
                DispatchQueue.main.async {
                    self.descriptionImage.image = image
                }
            }
        }
    }
    
    private func setupConstraints() {
        
        addSubview(scrollView)
        
        scrollView.addSubview(contentView)
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        contentView.snp.makeConstraints { make in
            make.top.bottom.equalTo(scrollView)
            make.left.right.equalTo(scrollView)
            make.width.equalTo(scrollView)
            
        }
        
        contentView.addSubview(descriptionImage)
        descriptionImage.snp.makeConstraints { make in
            make.top.equalTo(contentView.safeAreaLayoutGuide).offset(10)
            make.horizontalEdges.equalTo(contentView)
            make.height.equalTo(225)
        }
        
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(descriptionImage.snp.bottom).offset(15)
            make.horizontalEdges.equalTo(contentView).inset(16)
        }
        
        contentView.addSubview(areaLabel)
        areaLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.leading.equalTo(contentView).offset(16)
        }
        
        contentView.addSubview(categoryLabel)
        categoryLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.trailing.equalTo(contentView).offset(-16)
            
        }
        
        contentView.addSubview(descriptionLabel)
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(areaLabel.snp.bottom).offset(10)
            make.horizontalEdges.equalTo(contentView).inset(16)
        }
        
        contentView.addSubview(buyButton)
        buyButton.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(20)
            make.horizontalEdges.equalTo(contentView).inset(16)
            make.bottom.equalTo(contentView).offset(-10)
            make.height.equalTo(50)
        }
    }
    
    @objc
    private func goTo() {
        didOrderTapped?()
    }
}
