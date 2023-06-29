import UIKit

enum passButton {
    static var eye = UIImage(systemName: "eye", withConfiguration: UIImage.SymbolConfiguration(scale: .small))
    static var slashEye = UIImage(systemName: "eye.slash", withConfiguration: UIImage.SymbolConfiguration(scale: .small))
}

class LoginViewController: UIViewController {
    
    private var passSecure = true
    private var confirmPassSecure = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    @IBOutlet weak var confirmPasswordEyeButtonOutlet: UIButton!
    @IBOutlet weak var passwordEyeButtonOutlet: UIButton!
    @IBOutlet weak var doneButtonOutlet: UIButton!
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextFieldOutlet: UITextField!
    @IBOutlet weak var confirmPasswordTextFieldOutlet: UITextField!
    
    @IBOutlet weak var passLengthIndicator: UILabel!
    @IBOutlet weak var capitalLetterIndicator: UILabel!
    @IBOutlet weak var lowerCaseIndicator: UILabel!
    @IBOutlet weak var digitIndicator: UILabel!
    
    @IBAction func passwordEyeButtonAction(_ sender: Any) {
        if passSecure == true {
            passwordTextFieldOutlet.isSecureTextEntry = false
            passwordEyeButtonOutlet.setImage(passButton.eye, for: .normal)
            passSecure = false
        } else {
            passwordTextFieldOutlet.isSecureTextEntry = true
            passwordEyeButtonOutlet.setImage(passButton.slashEye, for: .normal)
            passSecure = true
        }
    }
    
    @IBAction func confirmPasswordEyeButton(_ sender: Any) {
        if confirmPassSecure == true {
            confirmPasswordTextFieldOutlet.isSecureTextEntry = false
            confirmPasswordEyeButtonOutlet.setImage(passButton.eye, for: .normal)
            confirmPassSecure = false
        } else {
            confirmPasswordTextFieldOutlet.isSecureTextEntry = true
            confirmPasswordEyeButtonOutlet.setImage(passButton.slashEye, for: .normal)
            confirmPassSecure = true
        }
    }
    
    @IBAction func doneButtonAction(_ sender: Any) {
        guard let login = loginTextField.text else { return }
        guard let password = passwordTextFieldOutlet.text else { return }
        guard let confirmPassword = confirmPasswordTextFieldOutlet.text else { return }
        if login.isEmpty {
            alertView(alertText: "Login is empty")
        } else if password.isEmpty {
            alertView(alertText: "Password is empty")
        } else if confirmPassword != password {
            alertView(alertText: "Confirm password not match")
        } else {
            alertView(alertText: "All done!!!")
        }
    }
    
    @IBAction func passwordTextFieldChanged(_ sender: Any) {
        guard let pass = passwordTextFieldOutlet.text else { return }
        
        if stringLength(string: pass) {
            passLengthIndicator.textColor = .green
        } else {
            passLengthIndicator.textColor = .red
        }
        if containCapitalize(string: pass) {
            capitalLetterIndicator.textColor = .green
        } else {
            capitalLetterIndicator.textColor = .red
        }
        if containLowerCased(string: pass) {
            lowerCaseIndicator.textColor = .green
        } else {
            lowerCaseIndicator.textColor = .red
        }
        if containDigit(string: pass) {
            digitIndicator.textColor = .green
        } else {
            digitIndicator.textColor = .red
        }
        if stringLength(string: pass) && containCapitalize(string: pass) && containLowerCased(string: pass) && containDigit(string: pass) {
            confirmPasswordTextFieldOutlet.isEnabled = true
        }
    }
    
    private func setupUI() {
        title = "Login"
        confirmPasswordTextFieldOutlet.isEnabled = false
        doneButtonOutlet.layer.borderColor = UIColor.tintColor.cgColor
        doneButtonOutlet.layer.borderWidth = 1
        doneButtonOutlet.layer.cornerRadius = 5
    }
    
    private func alertView(alertText: String) {
        let alert = UIAlertController(title: "Alert", message: alertText, preferredStyle: .alert)
        present(alert, animated: true)
        alert.addAction(UIAlertAction(title: "Ok", style: .default))
    }
    
    private func stringLength(string: String) -> Bool {
        if string.count >= 4 {
            return true
        } else {
            return false
        }
    }
    
    private func containCapitalize(string: String) -> Bool {
        var res: Bool = false
        let capitalLetterRegEx  = ".*[A-Z].*"
        let texttest = NSPredicate(format:"SELF MATCHES %@", capitalLetterRegEx)
        res = texttest.evaluate(with: string)
        return res
    }
    
    private func containLowerCased(string: String) -> Bool {
        var res: Bool = false
        let lowerCasedRegEx  = ".*[a-z].*"
        let texttest = NSPredicate(format:"SELF MATCHES %@", lowerCasedRegEx)
        res = texttest.evaluate(with: string)
        return res
    }
    
    private func containDigit(string: String) -> Bool {
        var res: Bool = false
        let digitsRegEx  = ".*[0-9].*"
        let texttest = NSPredicate(format:"SELF MATCHES %@", digitsRegEx)
        res = texttest.evaluate(with: string)
        return res
    }
}

