
import UIKit
import SnapKit

class SignInView: UIView {
    
    private let SignLabel: UILabel = {
        let label = UILabel()
        label.text = "Sign in with"
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textColor = .black
        return label
    }()
    
    private let PhoneButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(resource: .phone), for: .normal)
      //  button.setImage(UIImage(systemName: "phone.circle"), for: .normal)
        button.tintColor = .label
        button.sizeToFit()
        return button
    }()
    
    private let AppleButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(resource: .галочка), for: .normal)
      //  button.setImage(UIImage(systemName: "phone.circle"), for: .normal)
        button.tintColor = .label
        return button
    }()
    
    private let GoogleButton: UIButton = {
        let button = UIButton(type: .system)
      //  button.setImage(UIImage(resource: .google), for: .normal)
        button.setImage(UIImage(systemName: "phone.circle"), for: .normal)
        button.tintColor = .label
        return button
    }()
    
    private let EmailButton: UIButton = {
        let button = UIButton(type: .system)
       // button.setImage(UIImage(resource: .email), for: .normal)
        button.setImage(UIImage(systemName: "phone.circle"), for: .normal)
        button.tintColor = .label
        return button
    }()
    private lazy var trashButton: UIButton = {
        var configuration = UIButton.Configuration.plain()
        configuration.image = UIImage(resource: .apple)
        let view = UIButton(configuration: configuration)
        
        view.tintColor = .black
        return view
    }()
    
    private let stackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.spacing = 5
        view.alignment = .center
        return view
    }()
    
    var didButtonTapped: (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        setupView()
        PhoneButton.addTarget(self, action: #selector(goTo), for: .touchUpInside)
        AppleButton.addTarget(self, action: #selector(goTo), for: .touchUpInside)
        GoogleButton.addTarget(self, action: #selector(goTo), for: .touchUpInside)
        EmailButton.addTarget(self, action: #selector(goTo), for: .touchUpInside)
    }
    

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        addSubview(SignLabel)
        SignLabel.snp.makeConstraints { make in
         //   make.top.equalTo(self.safeAreaInsets).offset(90)
            make.centerY.equalToSuperview()
            make.centerX.equalToSuperview()
        }
        
        addSubview(trashButton)
        trashButton.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide).offset(30)
            make.centerY.equalToSuperview()
        }
        
        addSubview(stackView)
        
       // stackView.addArrangedSubview(PhoneButton)
       // stackView.addArrangedSubview(AppleButton)
        stackView.addArrangedSubview(GoogleButton)
        stackView.addArrangedSubview(EmailButton)
        
        stackView.snp.makeConstraints { make in
            make.bottom.equalTo(self.safeAreaLayoutGuide).offset(-20)
            make.horizontalEdges.equalToSuperview().inset(16)
            make.height.equalTo(50)
        }
        
    }
        
    @objc
    private func goTo() {
        didButtonTapped?()
    }
}
