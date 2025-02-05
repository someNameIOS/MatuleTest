//
//  LogInViewController.swift
//  Matule
//
//  Created by  MacBook Air on 10.12.2024.
//

import UIKit

//MARK: View
final class LogInViewController: UIViewController {
    
    var iconClick: Bool = false
    
    lazy var mainView: UIView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = .appBlock
        return $0
    }(UIView())
    
    lazy var greetingLabel: Label = Label(labelColor: .appText, labelFont: UIFont(name: "PlaywriteVN-Regular", size: 32) ?? .systemFont(ofSize: 32, weight: .regular), labelAlignment: .center, labelText: "Hello!")
    
    lazy var descriptionLabel: Label = Label(labelColor: .appSubTextDark, labelFont: .systemFont(ofSize: 16, weight: .regular), labelAlignment: .center, labelText: "Заполните Свои данные или \n продолжите через социальные медиа")
    
    lazy var emailLabel: Label = Label(labelColor: .appText, labelFont: .systemFont(ofSize: 16, weight: .regular), labelAlignment: .left, labelText: "Email")
    
    lazy var emailTextField: UITextField = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.font = .systemFont(ofSize: 14, weight: .regular)
        $0.backgroundColor = .appBackground
        $0.placeholder = "xyz@gmail.com"
        $0.textColor = .appHint
        $0.layer.cornerRadius = 12
        $0.autocapitalizationType = .none
        $0.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 14, height: 48))
        $0.leftViewMode = .always
        $0.rightView = UIView(frame: CGRect(x: 0, y: 0, width: 14, height: 48))
        $0.rightViewMode = .always
        return $0
    }(UITextField())
    
    lazy var passwordLabel: Label = Label(labelColor: .appText, labelFont: .systemFont(ofSize: 16, weight: .regular), labelAlignment: .left, labelText: "Пароль")
    
    lazy var passwordView: UIView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = .appBackground
        $0.layer.cornerRadius = 12
        return $0
    }(UIView())
    
    lazy var passwordTextField: UITextField = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.font = .systemFont(ofSize: 14, weight: .regular)
        $0.backgroundColor = .appBackground
        $0.placeholder = "••••••••"
        $0.textColor = .appHint
        $0.layer.cornerRadius = 12
        $0.isSecureTextEntry = true
        return $0
    }(UITextField())
    
    lazy var eyeButton: UIButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setImage(UIImage(named: "EyeClose"), for: .normal)
        $0.tintColor = .appHint
        $0.addTarget(self, action: #selector(togglePasswordVisibility), for: .touchUpInside)
        return $0
    }(UIButton())
    
    lazy var recoveryButton: UIButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setTitle("Восстановить", for: .normal)
        $0.setTitleColor(.appSubTextDark, for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 12, weight: .regular)
        $0.sizeToFit()
        return $0
    }(UIButton())
    
    lazy var enterButton: UIButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setTitle("Войти", for: .normal)
        $0.setTitleColor(.appBackground, for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 14, weight: .regular)
        $0.backgroundColor = .appAccent
        $0.layer.cornerRadius = 14
        $0.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        return $0
    }(UIButton())
    
    lazy var bottomView: UIView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = .appBlock
        return $0
    }(UIView())
    
    lazy var registerLabel: Label = Label(labelColor: .appHint, labelFont: .systemFont(ofSize: 16, weight: .regular), labelAlignment: .left, labelText: "Вы впервые?")
    
    lazy var registerButton: UIButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setTitle("Создать пользователя", for: .normal)
        $0.setTitleColor(.appText, for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 16, weight: .regular)
        $0.sizeToFit()
        return $0
    }(UIButton())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .appBlock
        view.addSubviews(mainView, bottomView)
        bottomView.addSubviews(registerLabel, registerButton)
        mainView.addSubviews(greetingLabel, descriptionLabel, emailLabel, emailTextField, passwordLabel, recoveryButton, passwordView, enterButton)
        passwordView.addSubviews(passwordTextField, eyeButton)

        setupConstraints()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
            view.addGestureRecognizer(tapGesture)
        
        }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            mainView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            mainView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            mainView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            greetingLabel.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 0),
            greetingLabel.centerXAnchor.constraint(equalTo: mainView.centerXAnchor),
            
            descriptionLabel.topAnchor.constraint(equalTo: greetingLabel.bottomAnchor, constant: 8),
            descriptionLabel.centerXAnchor.constraint(equalTo: mainView.centerXAnchor),
            
            emailLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 35),
            emailLabel.leadingAnchor.constraint(equalTo: mainView.leadingAnchor),
            emailLabel.trailingAnchor.constraint(equalTo: mainView.trailingAnchor),
            
            emailTextField.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 12),
            emailTextField.leadingAnchor.constraint(equalTo: mainView.leadingAnchor),
            emailTextField.trailingAnchor.constraint(equalTo: mainView.trailingAnchor),
            emailTextField.heightAnchor.constraint(equalToConstant: 48),
            
            passwordLabel.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 26),
            passwordLabel.leadingAnchor.constraint(equalTo: mainView.leadingAnchor),
            passwordLabel.trailingAnchor.constraint(equalTo: mainView.trailingAnchor),
            
            passwordView.topAnchor.constraint(equalTo: passwordLabel.bottomAnchor, constant: 12),
            passwordView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor),
            passwordView.trailingAnchor.constraint(equalTo: mainView.trailingAnchor),
            passwordView.heightAnchor.constraint(equalToConstant: 48),

            passwordTextField.topAnchor.constraint(equalTo: passwordView.topAnchor),
            passwordTextField.leadingAnchor.constraint(equalTo: passwordView.leadingAnchor, constant: 14),
            passwordTextField.trailingAnchor.constraint(equalTo: eyeButton.leadingAnchor, constant: -14),
            passwordTextField.heightAnchor.constraint(equalTo: passwordView.heightAnchor),
            
            eyeButton.topAnchor.constraint(equalTo: passwordView.topAnchor, constant: 12),
            eyeButton.trailingAnchor.constraint(equalTo: passwordView.trailingAnchor, constant: -14),
            eyeButton.bottomAnchor.constraint(equalTo: passwordView.bottomAnchor, constant: -12),
            eyeButton.widthAnchor.constraint(equalToConstant: 24),
            
            recoveryButton.topAnchor.constraint(equalTo: eyeButton.bottomAnchor, constant: 16),
            recoveryButton.trailingAnchor.constraint(equalTo: mainView.trailingAnchor),
            
            enterButton.topAnchor.constraint(equalTo: recoveryButton.bottomAnchor, constant: 24),
            enterButton.leadingAnchor.constraint(equalTo: mainView.leadingAnchor),
            enterButton.trailingAnchor.constraint(equalTo: mainView.trailingAnchor),
            enterButton.bottomAnchor.constraint(equalTo: mainView.bottomAnchor),
            enterButton.heightAnchor.constraint(equalToConstant: 50),
            
            bottomView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50),
            bottomView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            bottomView.leadingAnchor.constraint(equalTo: registerLabel.leadingAnchor),
            bottomView.trailingAnchor.constraint(equalTo: registerButton.trailingAnchor),
            bottomView.heightAnchor.constraint(equalToConstant: 16),
            
            registerLabel.topAnchor.constraint(equalTo: bottomView.topAnchor),
            registerLabel.bottomAnchor.constraint(equalTo: bottomView.bottomAnchor),
            registerLabel.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor),
            
            registerButton.topAnchor.constraint(equalTo: bottomView.topAnchor),
            registerButton.bottomAnchor.constraint(equalTo: bottomView.bottomAnchor),
            registerButton.leadingAnchor.constraint(equalTo: registerLabel.trailingAnchor, constant: 2),

        ])
    }
    
}

//MARK: Controller
extension LogInViewController {
    
    @objc private func hideKeyboard() {
        view.endEditing(true) // Скрыть клавиатуру для всех текстовых полей
    }
    
    @objc private func togglePasswordVisibility() {
        iconClick.toggle()
        passwordTextField.isSecureTextEntry.toggle()
        
        // Меняем изображение на кнопке
        let imageName = iconClick ? "EyeOpen" : "EyeClose"
        eyeButton.setImage(UIImage(named: imageName), for: .normal)
    }
    
    @objc private func loginButtonTapped() {
        let nextVC = TabBarController()
        if let sceneDelegate = self.view.window?.windowScene?.delegate as? SceneDelegate,
           let window = sceneDelegate.window {
            window.rootViewController = UINavigationController(rootViewController: nextVC)
            UIView.transition(with: window, duration: 0.1, options: .autoreverse, animations: nil)
        }
    }
    
}
