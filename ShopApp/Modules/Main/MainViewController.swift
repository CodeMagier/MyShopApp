
import UIKit
import SnapKit

class MainViewController: UIViewController {
    
    private let noteSearchBar: UISearchBar = {
        let bar = UISearchBar()
        bar.placeholder = "Search"
        bar.backgroundImage = UIImage()
        return bar
    }()
    
    private lazy var horizontalCollectionView: UICollectionView = {
        var layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 90, height: 32)
        layout.minimumLineSpacing = 15
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        
        var collection = UICollectionView(frame: .zero, 
                                          collectionViewLayout: layout)
        collection.register(CustomCollectionViewCell.self,
                            forCellWithReuseIdentifier: CustomCollectionViewCell.CellID)
        collection.dataSource = self
        collection.delegate = self
        return collection
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Beef"
        label.textColor = .label
        label.font = .systemFont(ofSize: 24, weight: .light)
        return label
    }()
    
    private lazy var menuTableView: UITableView = {
        let view = UITableView()
        view.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 18, right: 0)
        view.dataSource = self
        view.delegate = self
        view.register(CustomTableViewCell.self, 
                      forCellReuseIdentifier: CustomTableViewCell.SetupID)
        return view
    }()
    
    private var categorys: [Category] = []

    private var products: [Product] = []
    
    private var meals: [Meal] = []
    
    private let netWorkLayer = NetworkLayer()
    
    private var selectedIndex: IndexPath? {
        didSet {
            horizontalCollectionView.reloadData()
        }
    }
    
    private var selectedCategoryInadex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupConstreints()
        fetchCategorys()
        fetchProducts()
        selectedIndex = IndexPath(item: 0, section: 0)
        
    }
    
    private func fetchCategorys() {
        netWorkLayer.fetchCategorys { result in
            switch result {
            case .success(let categorys):
                DispatchQueue.main.async {
                    self.categorys = categorys
                    self.horizontalCollectionView.reloadData()
                }
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
 
    private func fetchProducts() {
        netWorkLayer.fetchProducts { result in
            switch result {
            case .success(let products):
                DispatchQueue.main.async {
                    self.products = products
                    self.menuTableView.reloadData()
                }
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }

    private func setupConstreints() {
        
        view.addSubview(noteSearchBar)
        noteSearchBar.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.horizontalEdges.equalToSuperview().inset(0)
            make.height.equalTo(40)
        }
        
        view.addSubview(horizontalCollectionView)
        horizontalCollectionView.snp.makeConstraints { make in
            make.top.equalTo(noteSearchBar.snp.bottom).offset(15)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(32)
        }
        
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(horizontalCollectionView.snp.bottom).offset(15)
            make.leading.equalToSuperview().offset(16)
        }
        
        view.addSubview(menuTableView)
        menuTableView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(0)
            make.horizontalEdges.equalToSuperview().inset(16)
            make.bottom.equalToSuperview()
        }
    }
}

extension MainViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return categorys.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomCollectionViewCell.CellID,
            for: indexPath) as! CustomCollectionViewCell
        cell.backgroundColor = indexPath == selectedIndex ? .purple : .clear
        cell.layer.cornerRadius = 16
        let category = categorys[indexPath.row]
        cell.setup(catedory: category)
        return cell
    }
}

extension MainViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {

        selectedCategoryInadex = indexPath.row
        menuTableView.reloadData()
        selectedIndex = indexPath
        
    }
    func collectionView(_ collectionView: UICollectionView,
                        didDeselectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? CustomCollectionViewCell {
            cell.updateAppearance(isSelected: false)
        }
    }
}

extension MainViewController: UITableViewDataSource {
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard indexPath.row < products.count else { return }
        let product = products[indexPath.row]
        let detailVC = DetailslViewController()
        //detailVC.loadMealDetails(idMeal: product.idMeal)
        detailVC.idMeal = product.idMeal
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CustomTableViewCell.SetupID,
                                                 for: indexPath) as? CustomTableViewCell
        let product = products[indexPath.row]
        cell?.setup(product: product)
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


