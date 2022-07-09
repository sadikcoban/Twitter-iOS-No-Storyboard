//
//  LoginController.swift
//  Twitter-iOS-No-Storyboard
//
//  Created by Sadık Çoban on 8.07.2022.
//

import UIKit
import Firebase
class RegistrationController: UIViewController {
    
    // MARK: - Properties
    private let imagePickder = UIImagePickerController ()
    private var profileImage: UIImage?
    
    private lazy var plusPhotoButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "plus_photo"), for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(didTapAddPhoto), for: .touchUpInside)
        button.layer.cornerRadius = 75
        button.layer.masksToBounds = true
        button.layer.borderColor = UIColor.white.cgColor
        return button
    }()
    
    private lazy var emailView: AuthInputView = {
        let view = AuthInputView(image: UIImage(named: "mail")!,
                                 tintColor: .white,
                                 hintText: "Email",
                                 keyboard: .emailAddress,
                                 returnKey: .next,
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
                                 returnKey: .next,
                                 delegate: self
        )
        
        return view
    }()
    
    private lazy var fullNameView: AuthInputView = {
        let view = AuthInputView(image: UIImage(named: "ic_person_outline_white_2x")!,
                                 tintColor: .white,
                                 hintText: "Full Name",
                                 keyboard: .default,
                                 returnKey: .next,
                                 delegate: self
        )
        
        return view
    }()
    
    private lazy var userNameView: AuthInputView = {
        let view = AuthInputView(image: UIImage(named:"ic_person_outline_white_2x")!,
                                 tintColor: .white,
                                 hintText: "Username",
                                 keyboard: .default,
                                 returnKey: .go,
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
        button.addTarget(self, action: #selector(didTapSignUp), for: .touchUpInside)
        
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
                                    selector: #selector(didTapLogin)
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
        present(imagePickder, animated: true, completion: nil)
    }
    
    @objc func didTapSignUp(){
        guard let email = emailView.textField.text, email != "" else { return }
        guard let password = passwordView.textField.text, password != "" else { return }
        guard let fullname = fullNameView.textField.text, fullname != "" else { return }
        guard let username = userNameView.textField.text, username != "" else { return }
        guard let profileImage = profileImage else { return }
        
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                print("DEBUG ERROR IS: \(error.localizedDescription)")
                return
            }
            guard let result = result else { return }
            let uid = result.user.uid
            
            let values = ["email": email, "username": username, "fullname": fullname]
            let ref = Database.database().reference().child("users").child(uid)
            ref.updateChildValues(values) { error, reference in
                print("successfully registered")
            }
            
        }
    }
    
    @objc func didTapLogin(){
        navigationController?.popViewController(animated: true)
    }
    
    
    // MARK: - Helpers
    
    func configureUI(){
        view.backgroundColor = .twitterBlue
        navigationController?.navigationBar.isHidden = true
        
        imagePickder.delegate = self
        imagePickder.allowsEditing = true
        
        signUpButton.snp.makeConstraints { make in
            make.height.equalTo(50)
        }
        view.addSubview(plusPhotoButton)
        plusPhotoButton.snp.makeConstraints { make in
            make.width.height.equalTo(150)
            make.top.equalTo(view.safeAreaInsets).offset(50)
            make.centerX.equalToSuperview()
        }
        
        let stack = UIStackView(arrangedSubviews: [emailView,passwordView, fullNameView,userNameView, signUpButton])
        stack.axis = .vertical
        stack.spacing = 32
        
        view.addSubview(stack)
        
        stack.snp.makeConstraints { make in
            make.top.equalTo(plusPhotoButton.snp.bottom).offset(20)
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
    
    private func switchToNextTextField(_ textField: UITextField) {
        
        switch textField {
        case self.emailView.textField:
            passwordView.textField.becomeFirstResponder()
        case self.passwordView.textField:
            fullNameView.textField.becomeFirstResponder()
        case self.fullNameView.textField:
            userNameView.textField.becomeFirstResponder()
        default:
            userNameView.textField.resignFirstResponder()
        }
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.switchToNextTextField(textField)
        
        return true
    }
    
}

extension RegistrationController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let profileImage = info[.editedImage] as? UIImage else { return }
        self.plusPhotoButton.setImage(profileImage.withRenderingMode(.alwaysOriginal), for: .normal)
        self.plusPhotoButton.layer.borderWidth = 1
        self.profileImage = profileImage
        dismiss(animated: true)
    }
}
