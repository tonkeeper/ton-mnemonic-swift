import UIKit

final class ViewController: UIViewController {
    
    private let generatePrivateKeyButton: UIButton = {
        let button = UIButton()
        button.setTitle("Generate keys", for: .normal)
        button.setTitleColor(.black, for: .normal)
        
        return button
    }()
    
    private let generateMnemonicButton: UIButton = {
        let button = UIButton()
        button.setTitle("Generate mnemonic", for: .normal)
        button.setTitleColor(.black, for: .normal)
        
        return button
    }()
    
    private let validateMnemonicButton: UIButton = {
        let button = UIButton()
        button.setTitle("Validate mnemonic", for: .normal)
        button.setTitleColor(.black, for: .normal)
        
        return button
    }()
    
    private let rootStack: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.axis = .vertical
        stackView.spacing = 16.0
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    private var mnemonic = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        view.addSubview(rootStack)
        
        rootStack.addArrangedSubview(generatePrivateKeyButton)
        rootStack.addArrangedSubview(generateMnemonicButton)
        rootStack.addArrangedSubview(validateMnemonicButton)
        
        generateMnemonicButton.addTarget(self, action: #selector(generateMnemonic), for: .touchUpInside)
        validateMnemonicButton.addTarget(self, action: #selector(validateMnemonic), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            rootStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            rootStack.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    @objc private func generateMnemonic() {
        let mnemonic =  Mnemonic.mnemonicNew(wordsCount: 24, password: "")
        self.mnemonic = mnemonic
        print("Mnemonic: \(mnemonic)")
    }
    
    @objc private func validateMnemonic() {
        let valid = Mnemonic.mnemonicValidate(mnemonicArray: mnemonic.components(separatedBy: " "), password: "")
        print("Mnemonic validated:", valid)
    }

}
