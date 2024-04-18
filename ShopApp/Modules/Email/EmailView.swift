
import UIKit
import SnapKit

protocol EmailDelegate {
    
    func getEmail(email: String, password: String)

}

class EmailView: UIView {
    
    private let emailTextField: UITextField = {
        let tf = UITextField()
        tf.layer.cornerRadius = 18
        tf.layer.borderWidth = 0.5
        tf.layer.borderColor = UIColor.systemGray.cgColor
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        let image = UIImageView(frame: CGRect(x: 12.5, y: 12.5, width: 25, height: 25))
        image.image = UIImage(systemName: "envelope.badge")
        view.addSubview(image)
        tf.leftView = view
        tf.leftViewMode = .always
        return tf
    }()
    
    private let emailLabel: UILabel = {
        let label = UILabel()
        label.text = " your email address "
        label.textColor = .systemGray2
        label.backgroundColor = .white
        label.font = UIFont(name: "Arial", size: 20)
        return label
    }()
    
    private let passwordTextField: UITextField = {
        let tf = UITextField()
        tf.layer.borderWidth = 0.5
        tf.layer.borderColor = UIColor.systemGray.cgColor
        tf.layer.cornerRadius = 18
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 8, height: 5))
        tf.leftView = view
        tf.leftViewMode = .always
        return tf
    }()
    
    private let passwordLabel: UILabel = {
        let label = UILabel()
        label.text = " your password "
        label.textColor = .systemGray2
        label.backgroundColor = .white
        label.font = UIFont(name: "Arial", size: 20)
        return label
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
        emailTextField.delegate = self
        passwordTextField.delegate = self
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
        
        addSubview(emailLabel)
        emailLabel.snp.makeConstraints { make in
            make.centerY.equalTo(emailTextField.snp.centerY)
            make.leading.equalTo(emailTextField.snp.leading).offset(37)
        }
        
        addSubview(passwordTextField)
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).offset(15)
            make.horizontalEdges.equalTo(emailTextField)
            make.height.equalTo(emailTextField)
        
        }
        
        addSubview(passwordLabel)
        passwordLabel.snp.makeConstraints { make in
            make.centerY.equalTo(passwordTextField.snp.centerY)
            make.leading.equalTo(passwordTextField.snp.leading).offset(5)
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


extension EmailView: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == emailTextField {
            emailLabel.layer.anchorPoint = CGPoint(x: 0.8, y: 0.6)
            UIView.animate(withDuration: 0.1) {
                
                self.emailLabel.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
                self.emailLabel.frame.origin = CGPoint(x: self.emailTextField.frame.origin.x + 50,
                                                       y: self.emailTextField.frame.minY - self.emailLabel.frame.height / 2)
               }
            } else if textField == passwordTextField {
                emailLabel.layer.anchorPoint = CGPoint(x: 0.8, y: 0.6)
                UIView.animate(withDuration: 0.1) {
                    self.passwordLabel.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
                    self.passwordLabel.frame.origin = CGPoint(x: self.passwordTextField.frame.origin.x + 20,
                                                              y: self.passwordTextField.frame.minY - self.passwordLabel.frame.height / 2)
                }
            }
        }
    }

