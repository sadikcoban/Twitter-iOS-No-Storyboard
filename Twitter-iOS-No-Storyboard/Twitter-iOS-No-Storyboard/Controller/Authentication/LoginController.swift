//
//  LoginController.swift
//  Twitter-iOS-No-Storyboard
//
//  Created by Sadık Çoban on 8.07.2022.
//

import UIKit

class LoginController: UIViewController {
    
    // MARK: - Properties
    private lazy var logoImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.clipsToBounds = true
        view.image = UIImage(named: "TwitterLogo")
        
        return view
    }()
    
    private lazy var emailView: AuthInputView = {
        let view = AuthInputView(image: UIImage(named: "mail")!,
                                 tintColor: .white,
                                 hintText: "Email",
                                 keyboard: .emailAddress,
                                 returnKey: .continue,
                                 delegate: self
        )
        
        return view
    }()
    
    private lazy var passwordView: AuthInputView = {
        let view = AuthInputView(image: UIImage(named:"ic_lock_outline_white_2x")!,
                                 tintColor: .white,
                                 hintText: "Password",
                                 isSecure: true,
                                 keyboard: .default,
                                 returnKey: .done,
                                 delegate: self
        )
        
        return view
    }()
    
    private lazy var loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Log In", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 20)
        button.setTitleColor(.twitterBlue, for: .normal)
        button.backgroundColor = .white
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(didTapLogin), for: .touchUpInside)
        
        return button
    }()
    
    
    

    private lazy var bottomTextButton: AuthBottomButton = {
        let firstStr = "Don't have an account? "
        let secondStr = "Sign Up"
        let view = AuthBottomButton(firstPartString: firstStr,
                                    secondPartString: secondStr,
                                    textColor: .white,
                                    bgColor: .clear,
                                    target: self,
                                    selector: #selector(didTapSignUp)
        )
        return view
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        configureUI()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.emailView.textField.text = ""
        self.passwordView.textField.text = ""
    }
    
    // MARK: - Selectors

    @objc func didTapLogin(){
        guard let email = emailView.textField.text, email != "" else { return }
        guard let password = passwordView.textField.text, password != "" else { return }
        AuthService.shared.login(withEmail: email, password: password) {[weak self] result, error in
            if let error = error {
                print("DEFDEFDE")
                // TODO: Handle error during login
                return
            }
            guard let window = UIApplication.shared.windows.first(where: { $0.isKeyWindow }) else { return }
            guard let controller = window.rootViewController as? MainTabController else { return }
            controller.authenticateUserAndConfigureUI()
            self?.dismiss(animated: true)

        }
    }
    
    @objc func didTapSignUp(){
        let controller = RegistrationController()
        navigationController?.pushViewController(controller, animated: true)
    }
    
    // MARK: - Helpers
    
    func configureUI(){
        view.backgroundColor = .twitterBlue
        
        view.addSubview(logoImageView)
        logoImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaInsets.top).offset(70)
            make.width.height.equalTo(150)
        }
        loginButton.snp.makeConstraints { make in
            make.height.equalTo(50)
        }
        
        let stack = UIStackView(arrangedSubviews: [emailView,passwordView, loginButton])
        stack.axis = .vertical
        stack.spacing = 32
        
        view.addSubview(stack)

        stack.snp.makeConstraints { make in
            make.top.equalTo(logoImageView.snp.bottom).offset(50)
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-24)
        }
        view.addSubview(bottomTextButton)
        bottomTextButton.snp.makeConstraints { make in
            make.height.equalTo(30)
            make.bottom.equalTo(view.safeAreaInsets).offset(-48)
            make.centerX.equalToSuperview()
        }
    }
}

extension LoginController: UITextFieldDelegate {
    
    private func switchToNextTextField(_ textField: UITextField) {

        switch textField {
        case self.emailView.textField:
            passwordView.textField.becomeFirstResponder()
        default:
            passwordView.textField.resignFirstResponder()
        }
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.switchToNextTextField(textField)

        return true
    }
}
