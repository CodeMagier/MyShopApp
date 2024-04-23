
import UIKit

class SMSCodeViewController: UIViewController {
    
    private let smsCodeTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Enter Code"
        tf.layer.cornerRadius = 18
        tf.backgroundColor = UIColor(hex: "#EDEDED")
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 8, height: 5))
        tf.leftView = view
        tf.leftViewMode = .always
        return tf
    }()
    
    private let nextButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sign Up", for: .normal)
        button.tintColor = .white
        button.backgroundColor = UIColor(hex: "#FF8B5B")
        button.layer.cornerRadius = 18
        return button
    }()
    
    @objc
    private func goToMeinViewController() {
        let vc = CustomTabBarController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        nextButton.addTarget(self, action: #selector(goToMeinViewController), for: .touchUpInside)
        setup()
    }
    
    private func setup() {
        view.addSubview(smsCodeTextField)
        smsCodeTextField.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(30)
            make.height.equalTo(40)
            make.horizontalEdges.equalToSuperview().inset(16)
        }
        
        view.addSubview(nextButton)
        nextButton.snp.makeConstraints { make in
            make.top.equalTo(smsCodeTextField.snp.bottom).offset(15)
            make.horizontalEdges.equalTo(smsCodeTextField)
            make.height.equalTo(40)
        }
    }
}
