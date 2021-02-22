//
//  TextInput.swift
//  Prueba conocimientos Francisco
//
//  Created by Francisco Guerrero Escamilla on 21/02/21.
//

import UIKit

class TextInput: UIView {

    //MARK: - Properties
    
    var placeHolder: String
    let leadingImageView = UIImageView(image: nil, contentMode: .scaleAspectFit)
    let trailingButton = UIButton(image: UIImage(systemName: "eye")!, tintColor: .darkGray, target: self, action: #selector(verContrasena))
    var inputTextField = UITextField()
    
    var isTrailingButtonVisible: Bool! {
        didSet {
            if isTrailingButtonVisible {
                trailingButton.isHidden = false
            } else {
                trailingButton.isHidden = true
            }
        }
    }
    
    let placeHolderAttributes = [NSAttributedString.Key.foregroundColor : #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1),
                                 NSAttributedString.Key.font : UIFont.systemFont(ofSize: 14)] as [NSAttributedString.Key : Any]
    
    var isPlaceHolderVisible: Bool! {
        didSet {
            if isPlaceHolderVisible {
                if placeHolder == "" {
                    inputTextField.attributedPlaceholder = NSAttributedString(string: placeHolder, attributes: placeHolderAttributes)
                }else{
                    inputTextField.attributedPlaceholder = NSAttributedString(string: placeHolder, attributes: placeHolderAttributes)
                }
                
            } else {
                inputTextField.placeholder = nil
            }
        }
    }
    
    //MARK: - Init
    
    init(placeHolder: String, keyboardType: UIKeyboardType = .default, isSecureTextEntry: Bool = false, backgroundColor: UIColor = .white) {
        self.placeHolder = placeHolder
        super.init(frame: .zero)
        leadingImageView.tintColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        self.inputTextField.attributedPlaceholder = NSAttributedString(string: placeHolder, attributes: placeHolderAttributes)
        self.inputTextField.textColor = .black
        self.inputTextField.keyboardType = keyboardType
        self.inputTextField.isSecureTextEntry = isSecureTextEntry
        self.backgroundColor = backgroundColor
        setupViewComponents()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    //MARK: - Helpers
    
    private func setupViewComponents() {
        layer.cornerRadius = 8
        
        hstack(leadingImageView.withWidth(40), inputTextField, trailingButton.withWidth(40),
               spacing: 4).withMargins(.allSides(6))
    }
    
    //MARK: - Selectors
    
    @objc fileprivate func verContrasena() {
        self.inputTextField.isSecureTextEntry.toggle()
    }

}
