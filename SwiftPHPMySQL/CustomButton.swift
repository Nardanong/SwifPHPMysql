//
//  CustomButton.swift
//  SwiftPHPMySQL
//
//  Created by TST-APP-02 on 17/5/2562 BE.
//  Copyright © 2562 Hitachi. All rights reserved.
//

import Foundation
import UIKit

class CustomButton: UIButton {
    
    var imageLeft: UIImageView {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }
    
    var  imageRight: UIImageView {
        let  view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpView()
    }//awakeFromNib
    
    func setUpView() {
        let margin = frame.height / 4
        let  size = frame.height / 2
        
        layer.cornerRadius = size
        layer.masksToBounds = true
        
        titleLabel?.translatesAutoresizingMaskIntoConstraints = false
        titleLabel?.textAlignment = .center
        titleLabel?.numberOfLines = 1
        titleLabel?.lineBreakMode = .byTruncatingTail
        
        addSubview(imageLeft)
        addSubview(imageRight)
        
//      imageLeft Addcinstraint
        imageLeft.leftAnchor.constraint(equalTo: leftAnchor, constant: margin).isActive = true
        imageLeft.rightAnchor.constraint(equalTo: titleLabel!.leftAnchor, constant: -margin).isActive = true
        imageLeft.topAnchor.constraint(equalTo: topAnchor, constant: margin).isActive = true
        imageLeft.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -margin).isActive = true
        imageLeft.heightAnchor.constraint(equalToConstant: size).isActive = true
        imageLeft.widthAnchor.constraint(equalToConstant: size).isActive = true
        
//      TitleLabel AddConStraint
        titleLabel?.rightAnchor.constraint(equalTo: imageRight.leftAnchor, constant: -margin).isActive = true
        titleLabel?.topAnchor.constraint(equalTo: topAnchor, constant: 0).isActive = true
        titleLabel?.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0).isActive = true
        
//      imageRight AddConstraint
        imageRight.rightAnchor.constraint(equalTo: rightAnchor, constant: -margin).isActive = true
        imageRight.topAnchor.constraint(equalTo: topAnchor, constant: margin).isActive = true
        imageRight.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -margin).isActive = true
        imageRight.heightAnchor.constraint(equalToConstant: size).isActive = true
        imageRight.widthAnchor.constraint(equalToConstant: size).isActive = true
    }
}//CustomButton
