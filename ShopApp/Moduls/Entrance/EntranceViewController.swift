
import UIKit
import SnapKit

class EntranceViewController: UIViewController {
    
    private let geeksImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.image = UIImage(resource: .geeks)
        return image
    }()
        
    private let entranceButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Войти", for: .normal)
        button.tintColor = .white
        button.backgroundColor = UIColor(hex: "#FF8B5B")
        button.layer.cornerRadius = 18
        button.addTarget(EntranceViewController.self, action: #selector(goToPhoneControllerView), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupConstreints()
    }
    
    private func setupConstreints() {
        view.addSubview(geeksImage)
        geeksImage.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(180)
            make.centerX.equalToSuperview()
        }
        
        view.addSubview(entranceButton)
        entranceButton.snp.makeConstraints { make in
            make.top.equalTo(geeksImage.snp.bottom).offset(90)
            make.horizontalEdges.equalToSuperview().inset(16)
            make.height.equalTo(50)
        }
    
    }
    
    @objc 
    private func goToPhoneControllerView() {
        let vc = PhoneViewController()
        navigationController?.pushViewController(vc, animated: true)
    }

}

