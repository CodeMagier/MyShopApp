
import UIKit
import SnapKit

class MainViewController: UIViewController {
    
    private lazy var horizontalCollectionView: UICollectionView = {
        var layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 90, height: 32)
        layout.minimumLineSpacing = 15
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        
        var collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.register(CustomCollectionViewCell.self, forCellWithReuseIdentifier: CustomCollectionViewCell.CellID)
        collection.dataSource = self
        collection.delegate = self
        return collection
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Кофе"
        label.textColor = .label
        label.font = .systemFont(ofSize: 24, weight: .light)
        return label
    }()
    
    private lazy var menuTableView: UITableView = {
        let view = UITableView()
        view.register(CustomTableViewCell.self, forCellReuseIdentifier: CustomTableViewCell.SetupID)
        view.contentInset = UIEdgeInsets(top: 18, left: 0, bottom: 18, right: 0)
        view.dataSource = self
        view.delegate = self
        return view
    }()
    
    private let typeOfFood = [
        Cellitem(type: "Кофе"),
        Cellitem(type: "Десерты"),
        Cellitem(type: "Выпечка"),
        Cellitem(type: "Коктейли"),
        Cellitem(type: "Напитки"),
        Cellitem(type: "Еда"),
        Cellitem(type: "Марожное")
    ]
    
    private var products: [ProductModel] = []
    
    private var selectedIndex: IndexPath? {
        didSet {
            horizontalCollectionView.reloadData()
        }
    }
    
    private var selectedCategoryInadex = 0
    
    private let productsType: [Int: [Product]] = [
        0: [
            Product(image: "1", title: "Капучино", drink: "Кофейный напиток", preis: "130c"),
            Product(image: "2", title: "Латте", drink: "Кофейный напиток", preis: "145c"),
            Product(image: "3", title: "Американо", drink: "Кофейный напиток", preis: "150c"),
            Product(image: "4", title: "Раф", drink: "Кофейный напиток", preis: "170c"),
            Product(image: "5", title: "Эспрессо", drink: "Кофейный напиток", preis: "200c"),
            Product(image: "макко", title: "Макко", drink: "Кофейный напиток", preis: "220с")
        ],
        1:  [
            Product(image: "Рубиновое Шоколадное Мастерство", title: "Рубиновое Шоколадное Мастерство", drink: "Кондитерское изделие", preis: "320c"),
            Product(image: "Полуночный Бархат", title: "Полуночный Бархат", drink: "Кондитерское изделие", preis: "400c"),
            Product(image: "Королевский Панна Котта", title: "Королевский Панна Котта", drink: "Кондитерское изделие", preis: "250c"),
            Product(image: "Императорская Шафрановая Симфония", title: "Императорская Шафрановая Симфония", drink: "Кофейный напиток", preis: "490c"),
            Product(image: "Изумрудная Мятная Мечта", title: "Изумрудная Мятная Мечта", drink: "Кондитерское изделие", preis: "500c"),
            Product(image: "Золотое Угощение с Ягодами", title: "Золотое Угощение с Ягодами", drink: "Кондитерское изделие", preis: "220с")
        ]
    ]

    private let betailList = [
        information(image: "капучино", title: "Капучино", price: "140c", description: "Капучино — самый известный кофейный напиток на основе эспрессо. В нём сохраняется баланс: чувствуется вкус эспрессо, но он не преобладает над вкусом молока. Это золотая середина между латте и флэт Уайтом и хороший вариант для первого знакомства с кофе."), information(image: "латте", title: "Латте", price: "140c", description: "Латте — кофейный напиток на основе молока, представляющий собой трёхслойную смесь из молочной пены, молока и кофе эспрессо. Для придания дополнительных вкусовых ощущений пенку латте часто посыпают добавками: корицей, шоколадом или ореховой крошкой. Также можно добавить сироп амаретто."), information(image: "американо", title: "Американо", price: "100c", description: "Американо — это эспрессо с добавлением горячей воды. Допускается разбавление эспрессо водой в соотношении 1:1, 1:2 или 1:4. Классическая пропорция — 1:1, но вы можете приготовить американо так, как вам нравится. Чем больше воды, тем менее концентрированным получится напиток."), information(image: "раф", title: "Раф", price: "170c", description: "кофейный напиток, готовится путём добавления нагретых паром сливок с небольшим количеством пены (0,5 см) в одиночную порцию эспрессо. Часто подаётся с сиропом. Раф популярен в России и странах бывшего СССР. Принципиально похож на латте, но отличается — добавлением ванильного сахара и сливок вместо молока. Появился в конце 1990-х годов."), information(image: "эспрессо", title: "Экспрессо", price: "140c", description: "Эспре́ссо (от итал. espresso) — метод приготовления кофе путём прохождения горячей воды (около 90 °C) под давлением (около 9 бар) через фильтр с молотым кофе. Эспрессо пользуется большой популярностью во всём мире и, прежде всего, на юге Европы — в Италии, Испании и Португалии. Традиционно подается с одним кубиком сахара, без ложки. В процессе приема сахар растворяется не изменяя вкус кофе."), information(image: "раф", title: "Макко", price: "220с", description: "Он включает в себя несколько основных ингредиентов: эспрессо, горячий шоколад или какао и взбитое молоко. Это классический вариант, но некоторые рецепты могут включать дополнительные ингредиенты. Обычно это сахар, ваниль, карамель и различные вкусовые добавки.")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupConstreints()
        fetchProducts()
        selectedIndex = IndexPath(item: 0, section: 0)
        
    }
    
    private func fetchProducts() {
        let parser = JSONParser()
        if let url = Bundle.main.url(
            forResource: "Products",
            withExtension: "json"
        ),
           let data = try? Data(contentsOf: url) {
            parser.decode(with: data) { [weak self] (result: Result<[ProductModel],
                                                     Error>) in
                guard let self else { return }
                switch result {
                case .success(let products):
                    DispatchQueue.main.async {
                        self.products = products
                        self.menuTableView.reloadData()
                    }
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
    
    private func setupConstreints() {
        
        view.addSubview(horizontalCollectionView)
        horizontalCollectionView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(32)
        }
        
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(horizontalCollectionView.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(16)
        }
        
        view.addSubview(menuTableView)
        menuTableView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(16)
            make.horizontalEdges.equalToSuperview().inset(16)
            make.bottom.equalToSuperview()
        }
    }
}

extension MainViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return typeOfFood.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomCollectionViewCell.CellID,
                                                      for: indexPath) as! CustomCollectionViewCell
        cell.setTitle(label: typeOfFood[indexPath.row])
        cell.backgroundColor = indexPath == selectedIndex ? .purple : .clear
        cell.layer.cornerRadius = 16
        return cell
    }
}

extension MainViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        if let selectedIndex {
            if collectionView.cellForItem(at: selectedIndex) is CustomCollectionViewCell {
                
            }
        }
        
        if let cell = collectionView.cellForItem(at: indexPath) as? CustomCollectionViewCell {
            cell.updateAppearance(isSelected: true)
        }
        selectedCategoryInadex = indexPath.row
        menuTableView.reloadData()
        selectedIndex = indexPath
        
    }
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? CustomCollectionViewCell {
            cell.updateAppearance(isSelected: false)
        }
    }
}

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return productsType[selectedCategoryInadex]?.count ?? .zero
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = betailList[indexPath.row]
        let detailVC = DetailslViewController()
        detailVC.descriptionImageName = item.image
        detailVC.titleText = item.title
        detailVC.priceText = item.price
        detailVC.descriptionText = item.description
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CustomTableViewCell.SetupID,
                                                 for: indexPath) as? CustomTableViewCell
        guard let product = productsType[selectedCategoryInadex]?[indexPath.row] else { fatalError()}
        cell?.setup(product: product)
        
        //        let model = products[indexPath.row]
        //        cell?.fill(with: model)
        return cell!
    }
}

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView,
                   heightForRowAt indexPath: IndexPath) -> CGFloat {
        let cellHeight = 89
        let topPadding = 8
        let bottomPadding = 8
        return CGFloat(cellHeight + topPadding + bottomPadding)
    }
}


