
import UIKit

class ProfileViewController: UIViewController {
    
    private lazy var profileCollectionView: UICollectionView = {
        let layout = UICollectionViewLayout()
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.backgroundColor = .none
        view.delegate = self
        view.dataSource = self
        view.register(RecordCollectionViewCell.self,
                      forCellWithReuseIdentifier: RecordCollectionViewCell.reuseId)
        view.register(SettingsCollectionViewCell.self,
                      forCellWithReuseIdentifier: SettingsCollectionViewCell.reuseId)
        view.register(InfoCollectionViewCell.self,
                      forCellWithReuseIdentifier: InfoCollectionViewCell.reuseId)
        view.register(HeaderSupplementaryView.self,
                      forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                      withReuseIdentifier: HeaderSupplementaryView.CellID)
        view.collectionViewLayout = createLayout()
        return view
    }()
    
    private lazy var exitButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("log out of your account", for: .normal)
        button.layer.cornerRadius = 16
        button.backgroundColor = .systemGray6
        button.tintColor = .red
        return button
    }()
    
    private let versionLabel: UILabel = {
        let label = UILabel()
        label.text = "version 2.40.11"
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textColor = .cyan
        return label
    }()
    
    private let sections = MockData.shared.pageData
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupConstraints()
    }
    
    private func setupConstraints() {
        
        view.addSubview(profileCollectionView)
        profileCollectionView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(10)
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
}

extension ProfileViewController {
    
    private func createLayout() -> UICollectionViewCompositionalLayout {
        
        UICollectionViewCompositionalLayout { [weak self] sectionIndex, _ in
            guard let self = self else { return nil }
            let section = self.sections[sectionIndex]
            switch section {
            case .record(_):
                return self.createRecordSection()
            case .settings(_):
                return self.createSettingsSection()
            case .info(_):
                return self.createInfoSection()
            }
        }
    }
    
    private func createRecordSection() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1),
                                                            heightDimension: .fractionalHeight(1)))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1),
                                                                         heightDimension: .fractionalHeight(0.1)), subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 5
        section.boundarySupplementaryItems = [supplementaryHeadeerItem()]
        // section.supplementariesFollowContentInsets = false
        section.contentInsets = .init(top: 5, leading: 0, bottom: 5, trailing: 0)
        return section
    }
    
    private func createSettingsSection() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1),
                                                            heightDimension: .fractionalHeight(1)))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1),
                                                                         heightDimension: .fractionalHeight(0.1)), subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 5
        section.boundarySupplementaryItems = [supplementaryHeadeerItem()]
        section.contentInsets = .init(top: 5, leading: 0, bottom: 5, trailing: 0)
        return section
    }
    
    private func createInfoSection() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1),
                                                            heightDimension: .fractionalHeight(1)))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1),
                                                                         heightDimension: .fractionalHeight(0.1)), subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 5
        section.boundarySupplementaryItems = [supplementaryHeadeerItem()]
        section.contentInsets = .init(top: 5, leading: 0, bottom: 5, trailing: 0)
        return section
    }
    
    private func supplementaryHeadeerItem() -> NSCollectionLayoutBoundarySupplementaryItem {
        .init(layoutSize: .init(widthDimension: .fractionalWidth(1),
                                heightDimension: .estimated(50)),
              elementKind: UICollectionView.elementKindSectionHeader,
              alignment: .top)
    }
}

extension ProfileViewController: UICollectionViewDelegate {
    
}

extension ProfileViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        sections[section].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let section = sections[indexPath.section]
        switch section {
        case .record(let records):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecordCollectionViewCell.reuseId,
                                                                for: indexPath) as? RecordCollectionViewCell
            else {
                return UICollectionViewCell()
            }
            cell.fill(with: records[indexPath.row].title, imageName: records[indexPath.row].image)
            return cell
            
        case .settings(let settings):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SettingsCollectionViewCell.reuseId,
                                                                for: indexPath) as? SettingsCollectionViewCell
            else {
                return UICollectionViewCell()
            }
            cell.fill(with: settings[indexPath.row].title, imageName: settings[indexPath.row].image)
            return cell
            
        case .info(let infos):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: InfoCollectionViewCell.reuseId,
                                                                for: indexPath) as? InfoCollectionViewCell
            else {
                return UICollectionViewCell()
            }
            cell.fill(with: infos[indexPath.row].title, imageName: infos[indexPath.row].image)
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                         withReuseIdentifier: HeaderSupplementaryView.CellID,
                                                                         for: indexPath) as! HeaderSupplementaryView
            header.fill(with: sections[indexPath.section].title)
            return header
        default:
            return UICollectionReusableView()
        }
    }
}



