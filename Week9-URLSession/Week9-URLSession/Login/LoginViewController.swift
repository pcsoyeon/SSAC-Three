//
//  LoginViewController.swift
//  Week9-URLSession
//
//  Created by 소연 on 2022/09/01.
//

import UIKit

final class LoginViewController: UIViewController {

    // MARK: - UI Property
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!

    @IBOutlet weak var button: UIButton!
    
    // MARK: - Property
    
    private var viewModel = LoginViewModel()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        viewModel.name.bind { text in
//            self.nameTextField.text = text
//        }
//
//        viewModel.password.bind { text in
//            self.passwordTextField.text = text
//        }
//
//        viewModel.email.bind { text in
//            self.emailTextField.text = text
//        }
        
        viewModel.isValid.bind { isValid in
            self.button.isEnabled = isValid
            self.button.backgroundColor = isValid ? .systemPink : .lightGray
        }
    }
    
    @IBAction func touchUpNameTextField(_ sender: UITextField) {
        guard let text = nameTextField.text else { return }
        viewModel.loginData.value.name = text
        
        viewModel.checkValidation()
    }
    
    @IBAction func touchUpPasswordTextField(_ sender: Any) {
        guard let text = passwordTextField.text else { return }
        viewModel.loginData.value.password = text
        
        viewModel.checkValidation()
    }
    
    @IBAction func touchUpEmailTextField(_ sender: UITextField) {
        guard let text = emailTextField.text else { return }
        viewModel.loginData.value.email = text
        
        viewModel.checkValidation()
    }
    
    @IBAction func touchUpButton(_ sender: UIButton) {
        viewModel.signIn {
            // 화면 전환
        }
    }
}
