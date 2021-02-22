//
//  LogInController.swift
//  Prueba conocimientos Francisco
//
//  Created by Francisco Guerrero Escamilla on 21/02/21.
//

import UIKit
import JGProgressHUD

class LogInController: UIViewController {

    //MARK: - Properties
    
    let loginImage = UIImageView(image: UIImage(named: ImageName.rookmotionImage), contentMode: .scaleAspectFit)
    
    let welcomeLabel = UILabel(text: "¡Bienvenido a RookMotion!", font: .boldSystemFont(ofSize: 26), textColor: .red, textAlignment: .center)
    
    let userTextInput = TextInput(placeHolder: "Correo", keyboardType: .emailAddress, isSecureTextEntry: false, backgroundColor: #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1))
    let passwordTextInput = TextInput(placeHolder: "Contraseña", keyboardType: .emailAddress, isSecureTextEntry: true, backgroundColor: #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1))
    
    lazy var loginButton = UIButton(title: "Iniciar", titleColor: .red, font: .boldSystemFont(ofSize: 16), backgroundColor: .white, target: self, action: #selector(loginTapped))
    lazy var siginButton = UIButton(title: "Únete", titleColor: .gray, font: .boldSystemFont(ofSize: 16), backgroundColor: .white, target: self, action: #selector(siginTapped))
    
    //MARK: - Init
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    //MARK: - Helpers
    
    private func setupView() {
        view.backgroundColor = .white
        userTextInput.isTrailingButtonVisible = false
        userTextInput.leadingImageView.image = UIImage(systemName: ImageName.emailImage)
        passwordTextInput.leadingImageView.image = UIImage(systemName: ImageName.passwordImage)
        
        loginButton.roundedButton(cornerRadius: 25, color: .red)
        siginButton.roundedButton(cornerRadius: 25, color: .gray)
        
        view.addSubview(loginImage)
        view.addSubview(welcomeLabel)
        view.addSubview(userTextInput)
        view.addSubview(passwordTextInput)
        view.addSubview(loginButton)
        view.addSubview(siginButton)
        
        loginImage.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: nil, bottom: nil, trailing: nil, padding: .init(top: 32, left: 0, bottom: 0, right: 0), size: .init(width: view.frame.width - 64, height: 250))
        loginImage.centerXToSuperview()
        
        welcomeLabel.anchor(top: loginImage.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 12, left: 12, bottom: 0, right: 12))
        
        userTextInput.anchor(top: welcomeLabel.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 28, left: 12, bottom: 0, right: 12))
        userTextInput.withHeight(50)
        
        passwordTextInput.anchor(top: userTextInput.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 16, left: 12, bottom: 0, right: 12))
        passwordTextInput.withHeight(50)
        
        loginButton.anchor(top: passwordTextInput.bottomAnchor, leading: nil, bottom: nil, trailing: nil, padding: .init(top: 32, left: 0, bottom: 0, right: 0), size: .init(width: 200, height: 50))
        loginButton.centerXToSuperview()
        
        siginButton.anchor(top: loginButton.bottomAnchor, leading: nil, bottom: nil, trailing: nil, padding: .init(top: 18, left: 0, bottom: 0, right: 0), size: .init(width: 200, height: 50))
        siginButton.centerXToSuperview()
    }
    
    //MARK: - Selectors
    
    @objc private func loginTapped() {
        let hud = JGProgressHUD(style: .dark)
        hud.show(in: view)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [unowned self] in
            hud.dismiss()
            let window = UIApplication.shared.windows.filter { $0.isKeyWindow }.first!
            window.rootViewController = UINavigationController(rootViewController: HomeController())
        }
    }
    
    @objc private func siginTapped() {
    }
}
