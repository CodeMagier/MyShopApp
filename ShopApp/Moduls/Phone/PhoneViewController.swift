
import UIKit

class PhoneViewController: UIViewController {
    
    private let geeksImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.image = UIImage(resource: .geeks)
        return image
    }()
    
    private let enterlabel: UILabel = {
        let label = UILabel()
        label.text = "Вход"
        label.textColor = .label
        label.font = .systemFont(ofSize: 34, weight: .light)
        return label
    }()
    
    private let phoneTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "+996 777 777 777"
        tf.layer.cornerRadius = 18
        tf.backgroundColor = UIColor(hex: "#EDEDED")
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 8, height: 5))
        tf.leftView = view
        tf.leftViewMode = .always
        return tf
    }()
    
    private let entranceButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Войти", for: .normal)
        button.tintColor = .white
        button.backgroundColor = UIColor(hex: "#FF8B5B")
        button.layer.cornerRadius = 18
        button.addTarget(PhoneViewController.self, action: #selector(goToMajorViewController), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupConsteints()
    }
    
    private func setupConsteints() {
        view.addSubview(geeksImage)
        geeksImage.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(100)
            make.centerX.equalToSuperview()
        }
        
        view.addSubview(enterlabel)
        enterlabel.snp.makeConstraints { make in
            make.top.equalTo(geeksImage.snp.bottom).offset(60)
            make.leading.equalToSuperview().offset(16)
        }
        
        view.addSubview(phoneTextField)
        phoneTextField.snp.makeConstraints { make in
            make.top.equalTo(enterlabel.snp.bottom).offset(30)
            make.horizontalEdges.equalToSuperview().inset(16)
            make.height.equalTo(50)
        }
        
        view.addSubview(entranceButton)
        entranceButton.snp.makeConstraints { make in
            make.top.equalTo(phoneTextField.snp.bottom).offset(20)
            make.horizontalEdges.equalTo(phoneTextField)
            make.height.equalTo(50)
        }
    }
    
    @objc
    private func goToMajorViewController() {
        let vc = MainViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}
