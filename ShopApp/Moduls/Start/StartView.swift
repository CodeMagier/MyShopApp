
import UIKit
import SnapKit

class StartView: UIView {

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
        
        return button
    }()
    
    var didLoginTapped: (() -> Void)?

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .systemBackground
        entranceButton.addTarget(self, action: #selector(goToPhoneControllerView), for: .touchUpInside)
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
        
        addSubview(entranceButton)
        entranceButton.snp.makeConstraints { make in
            make.top.equalTo(geeksImage.snp.bottom).offset(90)
            make.horizontalEdges.equalToSuperview().inset(16)
            make.height.equalTo(50)
        }
    }
    
    @objc
    private func goToPhoneControllerView() {
        didLoginTapped?()
    }
}
