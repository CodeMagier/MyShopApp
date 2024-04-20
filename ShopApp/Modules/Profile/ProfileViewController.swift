
import UIKit

class ProfileViewController: UIViewController {
    
    private lazy var profileCollectionView: UICollectionView = {
        let layout = UICollectionViewLayout()
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.backgroundColor = .none
        view.delegate = self
        view.dataSource = self       
        view.register(InfoCollectionViewCell.self,
                      forCellWithReuseIdentifier: InfoCollectionViewCell.reuseId)
        view.register(ButtonsFooterCell.self, 
                      forCellWithReuseIdentifier: ButtonsFooterCell.reuseId)
        view.register(HeaderSupplementaryView.self,
                      forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                      withReuseIdentifier: HeaderSupplementaryView.reuseId)
        view.collectionViewLayout = createLayout()
        return view
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
            case .info:
                return self.createInfoSection()
            case .footer:
                return self.createFooterSection()
            }
        }
    }
    
    private func createInfoSection() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1),
                                                            heightDimension: .fractionalHeight(1)))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1),
                                                                         heightDimension: .fractionalHeight(0.1)), subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 0
        section.boundarySupplementaryItems = [supplementaryHeadeerItem()]
        section.contentInsets = .init(top: 5, leading: 0, bottom: 5, trailing: 0)
        return section
    }
    
    private func createFooterSection() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1),
                                                            heightDimension: .fractionalHeight(1)))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1),
                                                                         heightDimension: .fractionalHeight(0.1)), subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 0
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
        switch sections[section] {
        case .info(_, let items):
            return items.count
        case.footer:
            return 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let section = sections[indexPath.section]
        switch section {
       
        case .info(_, let info):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: InfoCollectionViewCell.reuseId,
                                                                for: indexPath) as? InfoCollectionViewCell
            else {
                return UICollectionViewCell()
            }
            cell.fill(with: info[indexPath.row].title,
                      imageName: info[indexPath.row].image)
            return cell
            
        case .footer(let model):
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ButtonsFooterCell.reuseId,
                                                          for: indexPath) as! ButtonsFooterCell
            cell.fill(with: model)
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                         withReuseIdentifier: HeaderSupplementaryView.reuseId,
                                                                         for: indexPath) as! HeaderSupplementaryView
            header.fill(with: sections[indexPath.section].title)
            return header
        default:
            return UICollectionReusableView()
        }
    }
}



