
import UIKit
import SnapKit

class SignInView: UIView {
    
    private let geeksImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.image = UIImage(resource: .geeks)
        return image
    }()
    
    private let enterlabel: UILabel = {
        let label = UILabel()
        label.text = "Welcome back"
        label.textColor = .label
        label.font = .systemFont(ofSize: 34, weight: .light)
        return label
    }()

    private let emailTextField = UITextField ()
    
    private let emailLabel = UILabel ()
    
    private let entranceButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Continue", for: .normal)
        button.tintColor = .label
        button.backgroundColor = .systemMint
        button.layer.cornerRadius = 18
        return button
    }()
    
    private let accountStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 5
        return stack
    }()
    
    private let accountLabel: UILabel = {
        let label = UILabel()
        label.text = "no account ?"
        label.textColor = .label
        return label
    }()
    
    private let logInButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sign up", for: .normal)
        button.tintColor = .systemMint
        return button
    }()
    
    private let orLabel: UILabel = {
        let label = UILabel()
        label.text = "or"
        label.textColor = .label
        return label
    }()
    
    private let lineUIView: UIView = {
        let view = UIView()
        view.backgroundColor = .label
        return view
    }()
    
    private let secondlineUIView: UIView = {
        let view = UIView()
        view.backgroundColor = .label
        return view
    }()
    
    private let phoneButton: UIButton = {
        var config = UIButton.Configuration.plain()
        config.title = "continue with phone number"
        config.image = UIImage(systemName: "phone")
        config.imagePlacement = .leading
        config.imagePadding = 15
        let button = UIButton(configuration: config, primaryAction: nil)
        //button.tintColor = .label
        button.backgroundColor = .white
        button.layer.borderWidth = 0.5
        button.frame.size = CGSizeMake(40, 40)
        button.layer.cornerRadius = 18
        return button
    }()
    
    private let appleButton: UIButton = {
        var config = UIButton.Configuration.plain()
        config.title = "continue with Apple"
        config.image = UIImage(systemName: "applelogo")
        config.imagePlacement = .leading
        config.imagePadding = 15
        let button = UIButton(configuration: config, primaryAction: nil)
        //button.tintColor = .label
        button.backgroundColor = .white
        button.layer.borderWidth = 0.5
        button.frame.size = CGSizeMake(40, 40)
        button.layer.cornerRadius = 18
        return button
    }()
    
    var delegate: PhoneDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .systemBackground
        entranceButton.addTarget(self, action: #selector(goToMainViewController), for: .touchUpInside)
        setupConsteints()
        configureEmailTextField()
        configureEmailLabel()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConsteints() {
        addSubview(emailLabel)
        addSubview(geeksImage)
        geeksImage.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide).offset(60)
            make.centerX.equalToSuperview()
        }
        
        addSubview(enterlabel)
        enterlabel.snp.makeConstraints { make in
            make.top.equalTo(geeksImage.snp.bottom).offset(30)
            make.leading.equalToSuperview().offset(16)
        }
        
        addSubview(emailTextField)
        emailTextField.snp.makeConstraints { make in
            make.top.equalTo(enterlabel.snp.bottom).offset(30)
            make.horizontalEdges.equalToSuperview().inset(16)
            make.height.equalTo(50)
        }
        addSubview(emailLabel)
        emailLabel.snp.makeConstraints { make in
            make.centerY.equalTo(emailTextField.snp.centerY)
            make.leading.equalTo(emailTextField.snp.leading).offset(37)
            
        }
        
        addSubview(entranceButton)
        entranceButton.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).offset(10)
            make.horizontalEdges.equalToSuperview().inset(16)
            make.height.equalTo(50)
        }
        
        addSubview(accountStack)
        
        accountStack.addArrangedSubview(accountLabel)
        accountStack.addArrangedSubview(logInButton)
        
        accountStack.snp.makeConstraints { make in
            make.top.equalTo(entranceButton.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
            make.height.equalTo(20)
        }
        
        addSubview(orLabel)
        orLabel.snp.makeConstraints { make in
            make.top.equalTo(accountStack.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
        }
        
        addSubview(lineUIView)
        lineUIView.snp.makeConstraints { make in
            make.top.equalTo(accountStack.snp.bottom).offset(31.5)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalTo(orLabel.snp.leading).offset(-10)
            make.height.equalTo(0.5)

        }
        
        addSubview(secondlineUIView)
        secondlineUIView.snp.makeConstraints { make in
            make.top.equalTo(accountStack.snp.bottom).offset(31.5)
            make.leading.equalTo(orLabel.snp.trailing).offset(10)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(0.5)
        }
        
        addSubview(phoneButton)
        phoneButton.snp.makeConstraints { make in
            make.top.equalTo(orLabel.snp.bottom).offset(20)
            make.horizontalEdges.equalTo(entranceButton)
            make.height.equalTo(entranceButton)
        }
        
        addSubview(appleButton)
        appleButton.snp.makeConstraints { make in
            make.top.equalTo(phoneButton.snp.bottom).offset(10)
            make.horizontalEdges.equalTo(entranceButton)
            make.height.equalTo(entranceButton)
        }
    }
    
    @objc
    private func goToMainViewController() {
    
        delegate?.getPhone(phone: emailTextField.text ?? "" )
    }

}

private extension SignInView {
    
    func configureEmailTextField() {
        emailTextField.layer.cornerRadius = 18
        emailTextField.layer.borderWidth = 0.5
        emailTextField.layer.borderColor = UIColor.systemGray.cgColor
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        let image = UIImageView(frame: CGRect(x: 12.5, y: 12.5, width: 25, height: 25))
        image.image = UIImage(systemName: "envelope.badge")
        view.addSubview(image)
        emailTextField.leftView = view
        emailTextField.leftViewMode = .always
        emailTextField.returnKeyType = .done
        emailTextField.delegate = self
        addSubview(emailTextField)
        
    }
    
    func configureEmailLabel() {
    
        emailLabel.text = " email address "
        emailLabel.textColor = .systemGray2
        emailLabel.backgroundColor = .white
        emailLabel.font =  UIFont(name: "Arial", size: 20)
        addSubview(emailLabel)
        
    }
}

extension SignInView: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        emailLabel.layer.anchorPoint = CGPoint(x: 0.8, y: 0.6)
        UIView.animate(withDuration: 0.1) {
            self.emailLabel.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
            self.emailLabel.frame.origin = CGPoint(x: self.emailTextField.frame.origin.x + 45,
                                                   y: self.emailTextField.frame.minY - self.emailLabel.frame.height / 2)
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        UIView.animate(withDuration: 0.1) { [self] in
            self.emailLabel.transform = .identity
            self.emailLabel.snp.makeConstraints { make in
                make.centerY.equalTo(emailTextField.snp.centerY)
                make.leading.equalTo(emailTextField.snp.leading).offset(37)
            }
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}
