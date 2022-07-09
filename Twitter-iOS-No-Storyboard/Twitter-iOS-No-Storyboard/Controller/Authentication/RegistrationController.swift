//
//  LoginController.swift
//  Twitter-iOS-No-Storyboard
//
//  Created by Sadık Çoban on 8.07.2022.
//

import UIKit

class RegistrationController: UIViewController {
    
    // MARK: - Properties
    
    private lazy var plusPhotoButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "plus_photo"), for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(didTapAddPhoto), for: .touchUpInside)
        return button
    }()
    
    private lazy var emailView: AuthInputView = {
        let view = AuthInputView(image: UIImage(named: "mail")!,
                                 tintColor: .white,
                                 hintText: "Email",
                                 keyboard: .emailAddress,
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
                                 delegate: self
        )
        
        return view
    }()
    
    private lazy var fullNameView: AuthInputView = {
        let view = AuthInputView(image: UIImage(named: "ic_person_outline_white_2x")!,
                                 tintColor: .white,
                                 hintText: "Full Name",
                                 keyboard: .default,
                                 delegate: self
        )
        
        return view
    }()
    
    private lazy var userNameView: AuthInputView = {
        let view = AuthInputView(image: UIImage(named:"ic_person_outline_white_2x")!,
                                 tintColor: .white,
                                 hintText: "Username",
                                 keyboard: .default,
                                 delegate: self
        )
        
        return view
    }()
    
    private lazy var signUpButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sign Up", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 20)
        button.setTitleColor(.twitterBlue, for: .normal)
        button.backgroundColor = .white
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(didTapLogin), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var bottomTextButton: AuthBottomButton = {
        let firstStr = "Already have an account? "
        let secondStr = "Log In"
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
    
    // MARK: - Selectors
    @objc func didTapAddPhoto(){
        
    }
    
    @objc func didTapSignUp(){
        
    }
    
    @objc func didTapLogin(){
        navigationController?.popViewController(animated: true)
    }
    
    
    // MARK: - Helpers
    
    func configureUI(){
        view.backgroundColor = .twitterBlue
        navigationController?.navigationBar.isHidden = true
        
        signUpButton.snp.makeConstraints { make in
            make.height.equalTo(50)
        }
        
        let stack = UIStackView(arrangedSubviews: [plusPhotoButton, emailView,passwordView, fullNameView,userNameView, signUpButton])
        stack.axis = .vertical
        stack.spacing = 32
        
        view.addSubview(stack)

        stack.snp.makeConstraints { make in
            make.top.equalTo(view.snp.top).offset(50)
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
extension RegistrationController: UITextFieldDelegate {
    
}
