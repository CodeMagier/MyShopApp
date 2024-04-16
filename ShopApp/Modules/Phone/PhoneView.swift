
import UIKit

class PhoneView: UIView {
    
    private let geeksImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.image = UIImage(resource: .geeks)
        return image
    }()
    
    private let enterlabel: UILabel = {
        let label = UILabel()
        label.text = "create an account"
        label.textColor = .label
        label.font = .systemFont(ofSize: 34, weight: .light)
        return label
    }()
    
    private let phoneTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "+996 777 777 777"
        tf.layer.cornerRadius = 18
        tf.backgroundColor = UIColor(hex: "#EDEDED")
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        let image = UIImageView(frame: CGRect(x: 12.5, y: 12.5, width: 25, height: 25))
        image.image = UIImage(systemName: "phone")
        view.addSubview(image)
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
    
    private let accountStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 5
        return stack
    }()
    
    private let accountLabel: UILabel = {
        let label = UILabel()
        label.text = "already have an account ?"
        label.textColor = .label
        return label
    }()
    
    private let logInButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Log in", for: .normal)
        button.tintColor = UIColor(hex: "#FF8B5B")
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
    
    private let emailButton: UIButton = {
        var config = UIButton.Configuration.plain()
        config.title = "continue with email"
        //config.image = UIImage(resource: .google)
        config.image = UIImage(systemName: "envelope.badge")
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
        button.backgroundColor = .white
        button.layer.borderWidth = 0.5
        button.frame.size = CGSizeMake(40, 40)
        button.layer.cornerRadius = 18
        return button
    }()
    
    var delegate: PhoneDelegate?
    
    var didLogInTapped: (() -> Void)?
    
    var didEmailTapped: (() -> Void)?

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .systemBackground
        entranceButton.addTarget(self, action: #selector(goToMainViewController), for: .touchUpInside)
        logInButton.addTarget(self, action: #selector(goToLogIn), for: .touchUpInside)
        emailButton.addTarget(self, action: #selector(goToEmail), for: .touchUpInside)
        setupConsteints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConsteints() {
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
        
        addSubview(phoneTextField)
        phoneTextField.snp.makeConstraints { make in
            make.top.equalTo(enterlabel.snp.bottom).offset(30)
            make.horizontalEdges.equalToSuperview().inset(16)
            make.height.equalTo(50)
        }
        
        addSubview(entranceButton)
        entranceButton.snp.makeConstraints { make in
            make.top.equalTo(phoneTextField.snp.bottom).offset(10)
            make.horizontalEdges.equalTo(phoneTextField)
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
        
        addSubview(emailButton)
        emailButton.snp.makeConstraints { make in
            make.top.equalTo(orLabel.snp.bottom).offset(20)
            make.horizontalEdges.equalTo(entranceButton)
            make.height.equalTo(entranceButton)
        }
        
        addSubview(appleButton)
        appleButton.snp.makeConstraints { make in
            make.top.equalTo(emailButton.snp.bottom).offset(10)
            make.horizontalEdges.equalTo(entranceButton)
            make.height.equalTo(entranceButton)
        }
    }
    
    @objc
    private func goToMainViewController() {
    
        delegate?.getPhone(phone: phoneTextField.text ?? "" )
    }
    
    @objc
    private func goToLogIn() {
        didLogInTapped?()
    }
    
    @objc
    private func goToEmail() {
        didEmailTapped?()
    }

}
