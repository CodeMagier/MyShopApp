
import UIKit
import SnapKit

class CustomTableViewCell: UITableViewCell {
 
    private lazy var coffeeImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.tintColor = .label
        image.layer.cornerRadius = 24
        image.clipsToBounds = true
        return image
    }()
    
    private let stackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 5
        view.alignment = .leading
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    
    private lazy var drinkLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .light)
        return label
    }()
    
    private lazy var preisLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    static let SetupID = "note_cell"
  
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(product: Product) {
        
        coffeeImage.image = UIImage(named: product.image)
        titleLabel.text = product.title
        drinkLabel.text = product.drink
        preisLabel.text = product.preis
        
    }
    
    private func setupConstraints() {
        
        addSubview(coffeeImage)
        coffeeImage.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(0)
            make.height.width.equalTo(89)
        }
        
        addSubview(stackView)
        
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(drinkLabel)
        stackView.addArrangedSubview(preisLabel)
        
        stackView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(coffeeImage.snp.trailing).offset(16)
            make.trailing.equalToSuperview()
        }
    }
    
    func fill(with model: ProductModel) {
        
        coffeeImage.image = UIImage(named: model.productImage)
        titleLabel.text = model.productName
        drinkLabel.text = model.productDescription
        preisLabel.text = model.productPrice
    }
    
}