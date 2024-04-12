
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setup()
    }
    
    private func setup() {
        view.addSubview(smsCodeTextField)
        smsCodeTextField.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(30)
            make.height.equalTo(40)
            make.horizontalEdges.equalToSuperview().inset(16)
        }
    }
}
