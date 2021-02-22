//
//  OptionsHomeCell.swift
//  Prueba conocimientos Francisco
//
//  Created by Francisco Guerrero Escamilla on 21/02/21.
//

import UIKit

class OptionsHomeCell: UICollectionViewCell {
    
    //MARK: - Properties
    
    let backgroundImageView = UIImageView(image: nil, contentMode: .scaleAspectFill)
    let textLabel = UILabel(text: "", font: .boldSystemFont(ofSize: 18), textColor: .white)
    
    //MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViewComponents()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Helpers
    
    func setupViewComponents() {
        backgroundColor = .blue
        
        addSubview(backgroundImageView)
        addSubview(textLabel)
        
        backgroundImageView.fillSuperview()
        textLabel.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: nil, padding: .init(top: 0, left: 12, bottom: 12, right: 0))
        
    }

}
