
import UIKit
import SnapKit

class EmailView: UIView {
    
    private let emailTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "email address"
        tf.layer.cornerRadius = 18
        tf.backgroundColor = UIColor(hex: "#EDEDED")
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        let image = UIImageView(frame: CGRect(x: 12.5, y: 12.5, width: 25, height: 25))
        image.image = UIImage(systemName: "envelope.badge")
        view.addSubview(image)
        tf.leftView = view
        tf.leftViewMode = .always
        return tf
    }()
    
    private let passwordTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "your password"
        tf.layer.cornerRadius = 18
        tf.backgroundColor = UIColor(hex: "#EDEDED")
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 8, height: 5))
        tf.leftView = view
        tf.leftViewMode = .always
        return tf
    }()
    
    private let entranceButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sign up", for: .normal)
        button.tintColor = .label
        button.backgroundColor = UIColor(hex: "#FF8B5B")
        button.layer.cornerRadius = 18
        return button
    }()
    
    var didButtonTapped: (() -> Void)?
    
    var delegate: EmailDelegate?
     
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        entranceButton.addTarget(self, action: #selector(goTo), for: .touchUpInside)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraints() {
        
        addSubview(emailTextField)
        emailTextField.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide).offset(20)
            make.horizontalEdges.equalToSuperview().inset(16)
            make.height.equalTo(50)
        }
        
        addSubview(passwordTextField)
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).offset(15)
            make.horizontalEdges.equalTo(emailTextField)
            make.height.equalTo(emailTextField)
        
        }
        
        addSubview(entranceButton)
        entranceButton.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(15)
            make.horizontalEdges.equalTo(emailTextField)
            make.height.equalTo(emailTextField)
        }
    }
    
    @objc
    private func goTo() {
        delegate?.getEmail(email: emailTextField.text ?? "", password: passwordTextField.text ?? "")
    }
    
}
