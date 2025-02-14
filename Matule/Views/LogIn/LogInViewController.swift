//
//  LogInViewController.swift
//  Matule
//
//  Created by  MacBook Air on 10.12.2024.
//

import UIKit

//MARK: View
class LogInViewController: UIViewController {
    
    var iconClick: Bool = false
    
    lazy var mainView: UIView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIView())
    
    lazy var greetingLabel: UILabel = Label(labelText: "Привет!", labelFont: .systemFont(ofSize: 32, weight: .regular), labelColor: .appText)
    lazy var descriptionLabel: UILabel = Label(labelText: "Заполните Свои данные или продолжите через социальные медиа", labelColor: .appSubTextDark)
    lazy var emailLabel: UILabel = Label(labelText: "Email", labelAlignment: .left, labelColor: .appText)
    lazy var passwordLabel: UILabel = Label(labelText: "Пароль", labelAlignment: .left, labelColor: .appText)
    lazy var recoveryButton: UILabel = Label(labelText: "Востановить", labelAlignment: .right, labelFont: .systemFont(ofSize: 12, weight: .regular), labelColor: .appSubTextDark)
    lazy var invalidLabel: UILabel = Label(labelText: "", labelAlignment: .left, labelFont: .systemFont(ofSize: 12, weight: .regular), labelColor: .appRed)
    lazy var registerLabel: UILabel = Label(labelText: "Вы впервые?", labelAlignment: .right, labelFont: .systemFont(ofSize: 16, weight: .medium), labelColor: .appHint)
    
    
    lazy var emailTextField: UITextField = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.placeholder = "xyz@gmail.com"
        $0.font = .systemFont(ofSize: 14, weight: .regular)
        $0.autocapitalizationType = .none
        $0.textColor = .appHint
        $0.backgroundColor = .appBackground
        $0.layer.cornerRadius = 15
        $0.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 14, height: 48))
        $0.leftViewMode = .always
        $0.rightView = UIView(frame: CGRect(x: 0, y: 0, width: 14, height: 48))
        $0.rightViewMode = .always
        return $0
    }(UITextField())
    
    lazy var passwordView: UIView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = .appBackground
        $0.layer.cornerRadius = 15
        return $0
    }(UIView())
    
    lazy var passwordTextField: UITextField = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.placeholder = "••••••••"
        $0.font = .systemFont(ofSize: 14, weight: .regular)
        $0.textColor = .appHint
        $0.backgroundColor = .appBackground
        $0.layer.cornerRadius = 15
        $0.isSecureTextEntry = true
        return $0
    }(UITextField())
    
    lazy var eyeButton: UIButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setImage(.eyeClose, for: .normal)
        $0.tintColor = .appHint
        $0.addTarget(self, action: #selector(togglePasswordVisibility), for: .touchUpInside)
        return $0
    }(UIButton())
    
    lazy var enterButton: UIButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setTitle("Войти", for: .normal)
        $0.setTitleColor(.appBackground, for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 14, weight: .regular)
        $0.layer.cornerRadius = 14
        $0.backgroundColor = .appAccent
        $0.addTarget(self, action: #selector(enter), for: .touchUpInside)
        return $0
    }(UIButton())
    
    lazy var bottomView: UIView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIView())
    
    lazy var registerButton: UIButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setTitle("Создать пользователя", for: .normal)
        $0.setTitleColor(.appText, for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        return $0
    }(UIButton())
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .appBlock
        
        view.addSubviews(mainView, bottomView)
        mainView.addSubviews(greetingLabel, descriptionLabel, emailLabel, emailTextField, passwordLabel, passwordView, invalidLabel, recoveryButton, enterButton)
        passwordView.addSubviews(passwordTextField, eyeButton)
        bottomView.addSubviews(registerLabel, registerButton)
        
        setupConstraints()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    
    
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            mainView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            mainView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            mainView.topAnchor.constraint(equalTo: view.topAnchor, constant: 121),
            
            greetingLabel.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 10),
            greetingLabel.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -10),
            greetingLabel.topAnchor.constraint(equalTo: mainView.topAnchor),
            greetingLabel.heightAnchor.constraint(equalToConstant: 33),
            
            descriptionLabel.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 10),
            descriptionLabel.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -10),
            descriptionLabel.topAnchor.constraint(equalTo: greetingLabel.bottomAnchor, constant: 8),
            descriptionLabel.heightAnchor.constraint(equalToConstant: 48),
            
            emailLabel.leadingAnchor.constraint(equalTo: mainView.leadingAnchor),
            emailLabel.trailingAnchor.constraint(equalTo: mainView.trailingAnchor),
            emailLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 35),
            emailLabel.heightAnchor.constraint(equalToConstant: 20),
            
            emailTextField.leadingAnchor.constraint(equalTo: mainView.leadingAnchor),
            emailTextField.trailingAnchor.constraint(equalTo: mainView.trailingAnchor),
            emailTextField.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 12),
            emailTextField.heightAnchor.constraint(equalToConstant: 48),
            
            passwordLabel.leadingAnchor.constraint(equalTo: mainView.leadingAnchor),
            passwordLabel.trailingAnchor.constraint(equalTo: mainView.trailingAnchor),
            passwordLabel.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 26),
            passwordLabel.heightAnchor.constraint(equalToConstant: 20),
            
            passwordView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor),
            passwordView.trailingAnchor.constraint(equalTo: mainView.trailingAnchor),
            passwordView.topAnchor.constraint(equalTo: passwordLabel.bottomAnchor, constant: 12),
            passwordView.heightAnchor.constraint(equalToConstant: 48),
            
            invalidLabel.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 14),
            invalidLabel.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -14),
            invalidLabel.topAnchor.constraint(equalTo: passwordView.bottomAnchor, constant: 8),
            
            passwordTextField.leadingAnchor.constraint(equalTo: passwordView.leadingAnchor, constant: 14),
            passwordTextField.trailingAnchor.constraint(equalTo: eyeButton.leadingAnchor, constant: -16),
            passwordTextField.topAnchor.constraint(equalTo: passwordView.topAnchor),
            passwordTextField.bottomAnchor.constraint(equalTo: passwordView.bottomAnchor),
            
            eyeButton.trailingAnchor.constraint(equalTo: passwordView.trailingAnchor, constant: -16),
            eyeButton.topAnchor.constraint(equalTo: passwordView.topAnchor, constant: 14),
            eyeButton.widthAnchor.constraint(equalToConstant: 18),
            eyeButton.heightAnchor.constraint(equalToConstant: 18),
            
            recoveryButton.trailingAnchor.constraint(equalTo: mainView.trailingAnchor),
            recoveryButton.topAnchor.constraint(equalTo: invalidLabel.bottomAnchor, constant: 16),
            recoveryButton.widthAnchor.constraint(equalToConstant: 82),
            recoveryButton.heightAnchor.constraint(equalToConstant: 16),
            
            enterButton.leadingAnchor.constraint(equalTo: mainView.leadingAnchor),
            enterButton.trailingAnchor.constraint(equalTo: mainView.trailingAnchor),
            enterButton.topAnchor.constraint(equalTo: recoveryButton.bottomAnchor, constant: 24),
            enterButton.bottomAnchor.constraint(equalTo: mainView.bottomAnchor),
            enterButton.heightAnchor.constraint(equalToConstant: 50),
            
            bottomView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50),
            bottomView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            bottomView.heightAnchor.constraint(equalToConstant: 16),
            
            registerButton.leadingAnchor.constraint(equalTo: registerLabel.trailingAnchor, constant: 3),
            registerButton.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor),
            registerButton.bottomAnchor.constraint(equalTo: bottomView.bottomAnchor),
            registerButton.heightAnchor.constraint(equalToConstant: 16),
            
            registerLabel.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor),
            registerLabel.bottomAnchor.constraint(equalTo: bottomView.bottomAnchor),
            registerLabel.heightAnchor.constraint(equalToConstant: 16),
        ])
    }
    
    
}

//MARK: Controller
extension LogInViewController {
    //Возможность отображения пароля
    @objc private func togglePasswordVisibility() {
        iconClick.toggle()
        passwordTextField.isSecureTextEntry.toggle()
        
        eyeButton.setImage(iconClick ? .eyeOpen : .eyeClose, for: .normal)
    }
    
    //Скрытие клавиатуры
    @objc private func hideKeyboard() {
        view.endEditing(true)
    }
    
    @objc private func enter() {
        //Валидация на пустоту строк
        guard let email = emailTextField.text, !email.isEmpty,
              let password = passwordTextField.text, !password.isEmpty else {
            invalidLabel.text = "• Заполните все поля"
            return
        }
        
        //Валидация email
        guard isValidEmail(email) else {
            invalidLabel.text = "• Некорректный email"
            return
        }
        
        //Валидация пароля
        guard let password = passwordTextField.text, password.count >= 6 else {
            invalidLabel.text = "• Пароль может содержать минимум 6 символов"
            return
        }
        
        //Переход на экрна Home
        invalidLabel.text = ""
        let sceneDelegate = (UIApplication.shared.connectedScenes.first as? UIWindowScene)!.delegate as! SceneDelegate
        sceneDelegate.window?.rootViewController = TabBarController()
        sceneDelegate.window?.makeKeyAndVisible()
    }
    
    // Функция для проверки email
    private func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "^[a-z0-9._%+-]+@[a-z0-9.-]+\\.[a-z]{2,}$"
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: email)
    }
}
