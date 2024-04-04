
import UIKit

class MajorViewController: UIViewController {
    
    private var coffee: [Coffee] = [Coffee(image: "1", title: "Капучино", drink: "Кофейный напиток", preis: "130c"),
                                    Coffee(image: "2", title: "Латте", drink: "Кофейный напиток", preis: "145c"),
                                    Coffee(image: "3", title: "Американо", drink: "Кофейный напиток", preis: "150c"),
                                    Coffee(image: "4", title: "Раф", drink: "Кофейный напиток", preis: "170c"),
                                    Coffee(image: "5", title: "Эспрессо", drink: "Кофейный напиток", preis: "200c")]
    
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
        
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(80)
            make.leading.equalToSuperview().offset(16)
        }
        
        view.addSubview(menuTableView)
        menuTableView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(16)
            make.horizontalEdges.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().offset(-0)
        }
    }
}

extension MajorViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return coffee.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CustomTableViewCell.SetupID, for: indexPath) as? CustomTableViewCell
        cell?.setup(coffee: coffee[indexPath.row])
        return cell!
    }
    
}

extension MajorViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let cellHeight = 89
        let topPadding = 8
        let bottomPadding = 8
        return CGFloat(cellHeight + topPadding + bottomPadding) // Высота ячейки с отступами
    }
}
