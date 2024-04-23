
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
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 14, weight: .light)
        return label
    }()
    
    private lazy var preisLabel: UILabel = {
        let label = UILabel()
        label.textColor = .orange
        return label
    }()
    
    private lazy var addToCartButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "cart.badge.plus"), for: .normal)
        button.tintColor = .label
        return button
    }()
    
    static let reuseId = String(describing: CustomTableViewCell.self)
    
    var idMeal: String?
    
    var didCartTapped: ((CGPoint) -> Void)?
    
    weak var parentTableView: UITableView?
    
    var counterItem = 0
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addToCartButton.addTarget(self, action: #selector(handleAddToCart), for: .touchUpInside)
        setupConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with product: Product, tableView: UITableView) {
        fill(with: product)
        self.parentTableView = tableView
    }
    
    @objc
    private func handleAddToCart(_ sender: UIButton) {
        if let tableView = parentTableView {
            let buttonPosition: CGPoint = sender.convert(sender.bounds.origin, to: tableView)
            
            let indexPath = tableView.indexPathForRow(at: buttonPosition)!
            
            let cell = tableView.cellForRow(at: indexPath) as! CustomTableViewCell
            
            let imageViewPosition: CGPoint = cell.productImage.convert(cell.productImage.bounds.origin, to: self.contentView)
            
            let imgViewTemp = UIImageView(frame: CGRect(x: imageViewPosition.x, y: imageViewPosition.y, width: cell.productImage.frame.size.width, height: cell.productImage.frame.size.height))
            
            imgViewTemp.image = cell.productImage.image
            animation(tempView: imgViewTemp)
            
            didCartTapped?(buttonPosition)
        }
    }
    
    func animation(tempView : UIView)  {
        self.contentView.addSubview(tempView)
        UIView.animate(withDuration: 1.0,
                       animations: {
            tempView.animationZoom(scaleX: 1.1, y: 1.1)
        }, completion: { _ in
            
            UIView.animate(withDuration: 1.2, animations: {
                
                tempView.animationZoom(scaleX: 0.2, y: 0.2)
                tempView.animationRoted(angle: CGFloat(Double.pi))
                
                tempView.frame.origin.x = UIScreen.main.bounds.width / 2 - 22
                tempView.frame.origin.y = UIScreen.main.bounds.height - 120
                
            }, completion: { _ in
                tempView.removeFromSuperview()
                self.animatTitleLabel()
            })
        })
    }
    
    private func animatTitleLabel() {
        UIView.animate(withDuration: 1.0) {
            self.counterItem += 1
            self.titleLabel.text = "\(self.counterItem)"
            self.addToCartButton.animationZoom(scaleX: 1.4, y: 1.4)
        } completion: {_ in
            self.addToCartButton.animationZoom(scaleX: 1.0, y: 1.0)
        }
    }
    
    func fill(with item: Product) {
        titleLabel.text = item.strMeal
        self.idMeal = item.idMeal
        ImageDownloader.shared.loadImage(from: item.strMealThumb) { result in
            if case .success(let image) = result {
                DispatchQueue.main.async {
                    self.productImage.image = image
                }
            }
        }
    }
    
    func fill(with item: Pagination) {
        titleLabel.text = item.title
        descriptionLabel.text = item.brand
        preisLabel.text = String("\(item.price)$")
        ImageDownloader.shared.loadImage(from: item.thumbnail) { result in
            if case .success(let image) = result {
                DispatchQueue.main.async {
                    self.productImage.image = image
                }
            }
        }
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
        stackView.addArrangedSubview(descriptionLabel)
        stackView.addArrangedSubview(preisLabel)
        
        stackView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(productImage.snp.trailing).offset(16)
            make.trailing.equalToSuperview()
        }
        
        contentView.addSubview(addToCartButton)
        addToCartButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(0)
            make.trailing.equalToSuperview().offset(-5)
        }
    }
}

extension UIView{
    func animationZoom(scaleX: CGFloat, y: CGFloat) {
        self.transform = CGAffineTransform(scaleX: scaleX, y: y)
    }
    
    func animationRoted(angle : CGFloat) {
        self.transform = self.transform.rotated(by: angle)
    }
}
