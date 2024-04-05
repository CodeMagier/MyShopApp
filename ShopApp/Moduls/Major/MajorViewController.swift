
import UIKit
import SnapKit

class MajorViewController: UIViewController {
    
    private let typeOfFood = [Cellitem(type: "Кофе"),
                              Cellitem(type: "Десерты"),
                              Cellitem(type: "Выпечка"),
                              Cellitem(type: "Коктейли"),
                              Cellitem(type: "Напитки"),
                              Cellitem(type: "Еда"),
                              Cellitem(type: "Марожное")
    ]
    
    private let coffee = [Coffee(image: "1", title: "Капучино", drink: "Кофейный напиток", preis: "130c"),
                          Coffee(image: "2", title: "Латте", drink: "Кофейный напиток", preis: "145c"),
                          Coffee(image: "3", title: "Американо", drink: "Кофейный напиток", preis: "150c"),
                          Coffee(image: "4", title: "Раф", drink: "Кофейный напиток", preis: "170c"),
                          Coffee(image: "5", title: "Эспрессо", drink: "Кофейный напиток", preis: "200c"),Coffee(image: "макко", title: "Макко", drink: "Кофейный напиток", preis: "220с")
    ]
    
    let betailList = [information(image: "капучино", title: "Капучино", price: "140c", description: "Капучино — самый известный кофейный напиток на основе эспрессо. В нём сохраняется баланс: чувствуется вкус эспрессо, но он не преобладает над вкусом молока. Это золотая середина между латте и флэт Уайтом и хороший вариант для первого знакомства с кофе."), information(image: "латте", title: "Латте", price: "140c", description: "Латте — кофейный напиток на основе молока, представляющий собой трёхслойную смесь из молочной пены, молока и кофе эспрессо. Для придания дополнительных вкусовых ощущений пенку латте часто посыпают добавками: корицей, шоколадом или ореховой крошкой. Также можно добавить сироп амаретто."), information(image: "американо", title: "Американо", price: "100c", description: "Американо — это эспрессо с добавлением горячей воды. Допускается разбавление эспрессо водой в соотношении 1:1, 1:2 или 1:4. Классическая пропорция — 1:1, но вы можете приготовить американо так, как вам нравится. Чем больше воды, тем менее концентрированным получится напиток."), information(image: "раф", title: "Раф", price: "170c", description: "кофейный напиток, готовится путём добавления нагретых паром сливок с небольшим количеством пены (0,5 см) в одиночную порцию эспрессо. Часто подаётся с сиропом. Раф популярен в России и странах бывшего СССР. Принципиально похож на латте, но отличается — добавлением ванильного сахара и сливок вместо молока. Появился в конце 1990-х годов."), information(image: "эспрессо", title: "Экспрессо", price: "140c", description: "Эспре́ссо (от итал. espresso) — метод приготовления кофе путём прохождения горячей воды (около 90 °C) под давлением (около 9 бар) через фильтр с молотым кофе. Эспрессо пользуется большой популярностью во всём мире и, прежде всего, на юге Европы — в Италии, Испании и Португалии. Традиционно подается с одним кубиком сахара, без ложки. В процессе приема сахар растворяется не изменяя вкус кофе."), information(image: "раф", title: "Макко", price: "220с", description: "Он включает в себя несколько основных ингредиентов: эспрессо, горячий шоколад или какао и взбитое молоко. Это классический вариант, но некоторые рецепты могут включать дополнительные ингредиенты. Обычно это сахар, ваниль, карамель и различные вкусовые добавки.")]
    
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
    
    private var selectedIndex: IndexPath? {
        didSet {
            horizontalCollectionView.reloadData()
        }
    }
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Кофе"
        label.textColor = .label
        label.font = .systemFont(ofSize: 24, weight: .light)
        return label
    }()
    
    private lazy var  menuTableView: UITableView = {
        let view = UITableView()
        view.register(CustomTableViewCell.self, forCellReuseIdentifier: CustomTableViewCell.SetupID)
        view.contentInset = UIEdgeInsets(top: 18, left: 0, bottom: 18, right: 0)
        view.dataSource = self
        view.delegate = self
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupConstreints()
        
        selectedIndex = IndexPath(item: 0, section: 0)
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

extension MajorViewController: UICollectionViewDataSource {
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

extension MajorViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let selectedIndex = selectedIndex {
            if let cell = collectionView.cellForItem(at: selectedIndex) as? CustomCollectionViewCell {
                
            }
        
        }
        
        if let cell = collectionView.cellForItem(at: indexPath) as? CustomCollectionViewCell {
            cell.updateAppearance(isSelected: true)
        }
        
        selectedIndex = indexPath
        
    }
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? CustomCollectionViewCell {
            cell.updateAppearance(isSelected: false)
        }
    }
}

extension MajorViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return coffee.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = betailList[indexPath.row]
        let detailVC = ВetailView()
        detailVC.descriptionImageName = item.image
        detailVC.titleText = item.title
        detailVC.priceText = item.price
        detailVC.descriptionText = item.description
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CustomTableViewCell.SetupID,
                                                 for: indexPath) as? CustomTableViewCell
        cell?.setup(coffee: coffee[indexPath.row])
        return cell!
    }
}

extension MajorViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView,
                   heightForRowAt indexPath: IndexPath) -> CGFloat {
        let cellHeight = 89
        let topPadding = 8
        let bottomPadding = 8
        return CGFloat(cellHeight + topPadding + bottomPadding)
    }
}


