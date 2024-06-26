
import UIKit

final class PlusButton: UIButton {
    
    var didGrcodeTapped: (() -> Void)?
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.cornerRadius = frame.width / 2
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
       // setImage(UIImage(resource: .qr), for: .normal)
        setImage(UIImage(systemName: "qrcode"), for: .normal)
        tintColor = .white
        backgroundColor = .purple
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.3
        layer.shadowOffset = CGSize(width: 0,
                                    height: 5)
        translatesAutoresizingMaskIntoConstraints = false
        addTarget(self, action: #selector(goToProfileVC), for: .touchUpInside)
    }
    
    @objc 
    func goToProfileVC() {
        didGrcodeTapped?()
    }
}
