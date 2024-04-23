
import UIKit

class CompassViewController: UIViewController {
    
    private lazy var menuTableView: UITableView = {
        let view = UITableView()
        view.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 18, right: 0)
        view.dataSource = self
        view.delegate = self
        view.register(CustomTableViewCell.self,
                      forCellReuseIdentifier: CustomTableViewCell.reuseId)
        return view
    }()
    
    private let activityIndicator: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView()
        view.hidesWhenStopped = true
        view.style = .large
        return view
    }()
    
    private var paginations: [Pagination] = []
    
    private let netWorkLayer = NetworkLayer()
    
    private var page = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupConstreints()
        fetchProducts()
    }
    
    private func setupConstreints() {
        
        view.addSubview(menuTableView)
        menuTableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(10)
            make.horizontalEdges.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().offset(-10)
        }
        
        view.addSubview(activityIndicator)
        activityIndicator.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(40)
        }
    }
    
    private func fetchProducts() {
        isLoaging = true
        netWorkLayer.fetchProductsPagination(with: page, limit: 10) { [ weak self ] result in
            guard let self else { return }
            isLoaging = false
            switch result {
            case .success(let paginations):
                DispatchQueue.main.async {
                    sleep(UInt32(1.5))
                    self.paginations = paginations
                    self.menuTableView.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private var isLoaging = false {
        didSet {
            DispatchQueue.main.async {
                _ = self.isLoaging
                ? self.activityIndicator.startAnimating()
                : self.activityIndicator.stopAnimating()
            }
        }
    }
}

extension CompassViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        paginations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CustomTableViewCell.reuseId,
                                                 for: indexPath) as! CustomTableViewCell
        let item = paginations[indexPath.row]
        cell.fill(with: item)
        return cell
    }
}

extension CompassViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView,
                   heightForRowAt indexPath: IndexPath) -> CGFloat {
        let cellHeight = 89
        let topPadding = 8
        let bottomPadding = 8
        return CGFloat(cellHeight + topPadding + bottomPadding)
    }
    
    func tableView(_ tableView: UITableView, 
                   willDisplay cell: UITableViewCell,
                   forRowAt indexPath: IndexPath) {
        if indexPath.row == paginations.count - 1 {
            page += 1
            fetchProducts()
        }
    }
}

