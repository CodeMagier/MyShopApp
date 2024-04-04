
import UIKit

class MajorViewController: UIViewController {
    
    private let typeOfFood: [Cellitem] = [Cellitem(type: "Кофе"),
                                          Cellitem(type: "Десерты"),
                                          Cellitem(type: "Выпечка"),
                                          Cellitem(type: "Коктейли"),
                                          Cellitem(type: "Напитки"),
                                          Cellitem(type: "Еда"),
                                          Cellitem(type: "Марожное")]
    
    private var coffee: [Coffee] = [Coffee(image: "1", title: "Капучино", drink: "Кофейный напиток", preis: "130c"),
                                    Coffee(image: "2", title: "Латте", drink: "Кофейный напиток", preis: "145c"),
                                    Coffee(image: "3", title: "Американо", drink: "Кофейный напиток", preis: "150c"),
                                    Coffee(image: "4", title: "Раф", drink: "Кофейный напиток", preis: "170c"),
                                    Coffee(image: "5", title: "Эспрессо", drink: "Кофейный напиток", preis: "200c")]
    
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
        setupNavigationItem()
        setupConstreints()
        
        selectedIndex = IndexPath(item: 0, section: 0)
    }
    
    private func setupNavigationItem() {
        navigationItem.title = "Меню"
        navigationItem.hidesBackButton = true
        let rigtButton = UIBarButtonItem(image: UIImage(systemName: "bell"), style: .plain, target: self, action: #selector(settingsButtonTapped))
        navigationItem.rightBarButtonItem = rigtButton
        
    }
    
    @objc func settingsButtonTapped() {
        
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
                cell.updateAppearance(isSelected: false)
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
