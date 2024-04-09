
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
    
    private let netWorkLayer = NetworkLayer()
    
    var idMeal: String?

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        setupConstraints()
        loadMealDetails(idMeal: "")
        
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func loadMealDetails(idMeal: String) {
        netWorkLayer.fetchMealDetails(by: idMeal) { [weak self] result in
            switch result {
            case .success(let mealDetails):
                DispatchQueue.main.async {
                    
                    self?.updateUIWith(meal: mealDetails)
                }
            case .failure(let error):
                print("Ошибка: \(error)")
            }
        }
    }
    
    func loadImage(from urlString: String) {
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data, error == nil, let image = UIImage(data: data) else { return }
            DispatchQueue.main.async {
                self?.descriptionImage.image = image
            }
        }.resume()
    }
    
    func updateUIWith(meal: Meal) {
        titleLabel.text = meal.strMeal
        areaLabel.text = meal.strArea
        categoryLabel.text = meal.strCategory
        descriptionLabel.text = meal.strInstructions
        loadImage(from: meal.strMealThumb)
    }
 
    private func setupConstraints() {
        
        addSubview(scrollView)
        
        scrollView.addSubview(contentView)
        
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
      
            
            contentView.snp.makeConstraints { make in
                make.top.bottom.equalTo(scrollView)
                make.left.right.equalTo(self)
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
            make.bottom.equalTo(contentView).offset(-10)
        }
    }
}
