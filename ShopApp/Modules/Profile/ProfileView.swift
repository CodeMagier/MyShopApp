
import UIKit
import SnapKit

class ProfileView: UIView {
    
    private let scrollView: UIScrollView = {
        let view = UIScrollView()
        view.backgroundColor = .clear
        return view
    }()
    
    private let contentView: UIView = {
        let view = UIView()
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Your account"
        label.font = .systemFont(ofSize: 30, weight: .medium)
        label.textColor = .label
        return label
    }()
    
    private let ordersButton: UIButton = {
        var configuration = UIButton.Configuration.plain()
        configuration.attributedTitle = "my orders"
        configuration.image = UIImage(systemName: "chevron.right")
        configuration.imagePlacement = .trailing
        configuration.imagePadding = 210
        let view = UIButton(configuration: configuration)
        view.backgroundColor = .systemGray6
        view.layer.cornerRadius = 16
        return view
    }()
    
    private let informationButton: UIButton = {
        var configuration = UIButton.Configuration.plain()
        configuration.attributedTitle = "my information"
        configuration.image = UIImage(systemName: "chevron.right")
        configuration.imagePlacement = .trailing
        configuration.imagePadding = 175
        let view = UIButton(configuration: configuration)
        view.backgroundColor = .systemGray6
        view.layer.cornerRadius = 16
        return view
    }()
    
    private let addressButton: UIButton = {
        var configuration = UIButton.Configuration.plain()
        configuration.attributedTitle = "saved addresses"
        configuration.image = UIImage(systemName: "chevron.right")
        configuration.imagePlacement = .trailing
        configuration.imagePadding = 175
        let view = UIButton(configuration: configuration)
        view.backgroundColor = .systemGray6
        view.layer.cornerRadius = 16
        return view
    }()
    
    private let settingsLabel: UILabel = {
        let label = UILabel()
        label.text = "Settings"
        label.font = .systemFont(ofSize: 30, weight: .medium)
        label.textColor = .label
        return label
    }()
    
    private let languageButton: UIButton = {
        var configuration = UIButton.Configuration.plain()
        configuration.attributedTitle = "Change language"
        configuration.image = UIImage(systemName: "chevron.right")
        configuration.imagePlacement = .trailing
        configuration.imagePadding = 175
        let view = UIButton(configuration: configuration)
        view.backgroundColor = .systemGray6
        view.layer.cornerRadius = 16
        return view
    }()
    
    
    private let notificationsButton: UIButton = {
        var configuration = UIButton.Configuration.plain()
        configuration.attributedTitle = "notifications"
        configuration.image = UIImage(systemName: "chevron.right")
        configuration.imagePlacement = .trailing
        configuration.imagePadding = 175
        let view = UIButton(configuration: configuration)
        view.backgroundColor = .systemGray6
        view.layer.cornerRadius = 16
        return view
    }()
    
    private let informationLabel: UILabel = {
        let label = UILabel()
        label.text = "Information"
        label.font = .systemFont(ofSize: 30, weight: .medium)
        label.textColor = .label
        return label
    }()
    
    
    private let questionsButton: UIButton = {
        var configuration = UIButton.Configuration.plain()
        configuration.attributedTitle = "аrequent questions"
        configuration.image = UIImage(systemName: "chevron.right")
        configuration.imagePlacement = .trailing
        configuration.imagePadding = 175
        let view = UIButton(configuration: configuration)
        view.backgroundColor = .systemGray6
        view.layer.cornerRadius = 16
        return view
    }()
    
    private let frequentQuestionsButton: UIButton = {
        var configuration = UIButton.Configuration.plain()
        configuration.attributedTitle = "how the system works"
        configuration.image = UIImage(systemName: "chevron.right")
        configuration.imagePlacement = .trailing
        configuration.imagePadding = 175
        let view = UIButton(configuration: configuration)
        view.backgroundColor = .systemGray6
        view.layer.cornerRadius = 16
        return view
    }()
    
    private let agreementsButton: UIButton = {
        var configuration = UIButton.Configuration.plain()
        configuration.attributedTitle = "user agreements"
        configuration.image = UIImage(systemName: "chevron.right")
        configuration.imagePlacement = .trailing
        configuration.imagePadding = 175
        let view = UIButton(configuration: configuration)
        view.backgroundColor = .systemGray6
        view.layer.cornerRadius = 16
        return view
    }()
    
    private let confidentialityButton: UIButton = {
        var configuration = UIButton.Configuration.plain()
        configuration.attributedTitle = "privacy policy"
        configuration.image = UIImage(systemName: "chevron.right")
        configuration.imagePadding = 175
        configuration.imagePlacement = .trailing
        configuration.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 50, bottom: 10, trailing: 50)
        let view = UIButton(configuration: configuration)
        view.backgroundColor = .systemGray6
        view.layer.cornerRadius = 16
        return view
    }()
   
    private lazy var exitButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("log out of your account", for: .normal)
        button.layer.cornerRadius = 16
        button.backgroundColor = .systemGray6
        button.tintColor = .red
        return button
    }()
    
    private let versionLabel: UILabel = {
        let label = UILabel()
        label.text = "version 2.40.11"
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textColor = .cyan
        return label
    }()
    
    var didTapped: (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        exitButton.addTarget(self, action: #selector(goTo), for: .touchUpInside)
        backgroundColor = .systemBackground
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc
    private func goTo() {
        didTapped?()
    }
    
    private func setupConstraints() {
        
        addSubview(scrollView)
        
        scrollView.addSubview(contentView)
        
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        contentView.snp.makeConstraints { make in
            make.top.bottom.equalTo(scrollView)
            make.left.right.equalTo(scrollView)
            make.width.equalTo(scrollView)
            
        }
        
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView.safeAreaLayoutGuide).offset(20)
            make.leading.equalTo(contentView).offset(16)
        }
        
        contentView.addSubview(ordersButton)
        ordersButton.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(15)
            make.horizontalEdges.equalTo(contentView).inset(16)
            make.height.equalTo(50)
        }
        
        contentView.addSubview(informationButton)
        informationButton.snp.makeConstraints { make in
            make.top.equalTo(ordersButton.snp.bottom).offset(10)
            make.horizontalEdges.equalTo(ordersButton)
            make.height.equalTo(ordersButton)
        }
        
        contentView.addSubview(addressButton)
        addressButton.snp.makeConstraints { make in
            make.top.equalTo(informationButton.snp.bottom).offset(10)
            make.horizontalEdges.equalTo(ordersButton)
            make.height.equalTo(ordersButton)
        }
        
        contentView.addSubview(settingsLabel)
        settingsLabel.snp.makeConstraints { make in
            make.top.equalTo(addressButton.snp.bottom).offset(20)
            make.leading.equalTo(titleLabel)
        }
        
        contentView.addSubview(languageButton)
        languageButton.snp.makeConstraints { make in
            make.top.equalTo(settingsLabel.snp.bottom).offset(15)
            make.horizontalEdges.equalTo(ordersButton)
            make.height.equalTo(ordersButton)
        }
       
        contentView.addSubview(notificationsButton)
        notificationsButton.snp.makeConstraints { make in
            make.top.equalTo(languageButton.snp.bottom).offset(10)
            make.horizontalEdges.equalTo(ordersButton)
            make.height.equalTo(ordersButton)
        }
        
        contentView.addSubview(informationLabel)
        informationLabel.snp.makeConstraints { make in
            make.top.equalTo(notificationsButton.snp.bottom).offset(15)
            make.leading.equalTo(titleLabel)
        }
        
        contentView.addSubview(questionsButton)
        questionsButton.snp.makeConstraints { make in
            make.top.equalTo(informationLabel.snp.bottom).offset(10)
            make.horizontalEdges.equalTo(ordersButton)
            make.height.equalTo(ordersButton)
        }
        
        contentView.addSubview(frequentQuestionsButton)
        frequentQuestionsButton.snp.makeConstraints { make in
            make.top.equalTo(questionsButton.snp.bottom).offset(10)
            make.horizontalEdges.equalTo(ordersButton)
            make.height.equalTo(ordersButton)
            
        }
        
        contentView.addSubview(agreementsButton)
        agreementsButton.snp.makeConstraints { make in
            make.top.equalTo(frequentQuestionsButton.snp.bottom).offset(10)
            make.horizontalEdges.equalTo(ordersButton)
            make.height.equalTo(ordersButton)
        }
        
        contentView.addSubview(confidentialityButton)
        confidentialityButton.snp.makeConstraints { make in
            make.top.equalTo(agreementsButton.snp.bottom).offset(10)
            make.horizontalEdges.equalTo(ordersButton)
            make.height.equalTo(ordersButton)
         
        }
        
        contentView.addSubview(exitButton)
        exitButton.snp.makeConstraints { make in
            make.top.equalTo(confidentialityButton.snp.bottom).offset(30)
            make.horizontalEdges.equalTo(ordersButton)
            make.height.equalTo(42)
        }
        
        contentView.addSubview(versionLabel)
        versionLabel.snp.makeConstraints { make in
            make.top.equalTo(exitButton.snp.bottom).offset(15)
            make.centerX.equalTo(contentView.snp.centerX)
            make.bottom.equalTo(contentView).offset(-40)
        }
    }
}
