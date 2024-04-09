
import UIKit
import SnapKit

class CustomTableViewCell: UITableViewCell {
 
    private lazy var productImage: UIImageView = {
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
    
    private lazy var price: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(hex: "FF8B5B")
        return label
    }()
    
    static let SetupID = "note_cell"
    
    var idMeal: String?
  
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func loadImage(from urlString: String) {
        guard let url = URL(string: urlString) else { return }

        URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data, error == nil, let image = UIImage(data: data) else { return }
            DispatchQueue.main.async {
                self?.productImage.image = image
            }
        }.resume()
    }
    
    func setup(product: Product) {

        titleLabel.text = product.strMeal
        loadImage(from: product.strMealThumb)
        self.idMeal = product.idMeal
        
    }

    private func setupConstraints() {
        
        addSubview(productImage)
        productImage.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(0)
            make.height.width.equalTo(89)
        }
        
        addSubview(stackView)
        
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(drinkLabel)
        stackView.addArrangedSubview(price)
        
        stackView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(productImage.snp.trailing).offset(16)
            make.trailing.equalToSuperview()
        }
    }

}
