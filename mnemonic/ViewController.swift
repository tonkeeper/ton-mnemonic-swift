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
    
    private let words = "source solution nurse sauce that often wheat top penalty picture sense finish engine parent such surge retire aware produce caught chronic extra bomb sport"

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
        do {
            let mnemonic = try Mnemonic.generateMnemonic(wordsCount: 24, password: "")
            print("Mnemonic: \(mnemonic)")
        } catch {
            print("Generate mnemonic error \(error.localizedDescription)")
            logError(error: error)
        }
    }
    
    @objc private func validateMnemonic() {
        do {
//            try Mnemonic.validate(mnemonic: words)
            print("Mnemonic validated")
        } catch {
            print("Validate mnemonic error \(error.localizedDescription)")
            logError(error: error)
        }
    }
    
    private func logError(error: Error) {
        if let error = error as? MnemonicError {
            print(error)
        }
    }

}
