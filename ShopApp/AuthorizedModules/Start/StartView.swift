
import UIKit
import SnapKit

class StartView: UIView {

    private let geeksImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.image = UIImage(resource: .geeks)
        return image
    }()
        
    private let SignUpButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sign Up", for: .normal)
        button.tintColor = .white
        button.backgroundColor = UIColor(hex: "#FF8B5B")
        button.layer.cornerRadius = 18
        return button
    }()
    
    private let logInbutton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Log In", for: .normal)
        button.tintColor = .white
        button.backgroundColor = .black
        button.layer.cornerRadius = 18
        return button
    }()
    
    var didSignUpTapped: (() -> Void)?
    
    var didLogInButton: (() -> Void)?

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .systemBackground
        SignUpButton.addTarget(self, action: #selector(goToPhoneControllerView), for: .touchUpInside)
        logInbutton.addTarget(self, action: #selector(goTo), for: .touchUpInside)
        setupConstreints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstreints() {
        addSubview(geeksImage)
        geeksImage.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide).offset(180)
            make.centerX.equalToSuperview()
        }
        
        addSubview(logInbutton)
        logInbutton.snp.makeConstraints { make in
            make.bottom.equalTo(self.safeAreaLayoutGuide).offset(-90)
            make.horizontalEdges.equalToSuperview().inset(16)
            make.height.equalTo(50)
           
        }
        
        addSubview(SignUpButton)
        SignUpButton.snp.makeConstraints { make in
            make.bottom.equalTo(logInbutton.snp.top).offset(-10)
            make.horizontalEdges.equalToSuperview().inset(16)
            make.height.equalTo(50)
          
        }
     
    }
    
    @objc
    private func goToPhoneControllerView() {
        didSignUpTapped?()
    }
    
    @objc
    private func goTo() {
        didLogInButton?()
    }
}
