//
//  ProfileView.swift
//  HelloAlerts
//
//  Created by d182_sofia_d on 23/03/18.
//  Copyright © 2018 Luis Ezcurdia. All rights reserved.
//

import UIKit

class ProfileView: UIView {
    let titleLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Nombre Persona"
        lbl.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        lbl.textAlignment = .center
        lbl.textColor = .white
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    private let textView: UITextView = {
        let tv = UITextView()
        tv.text = "Lorem ipsum dolor ... coas asi de la vida lol"
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    
    @objc func tapOkAlert(){
        
    }
    let ImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "dog")
        iv.contentMode = .scaleAspectFill
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    override init (frame: CGRect){
        super.init(frame: frame)
        self.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        setupLayout()
    }
    required init?(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)
        setupLayout()
    }
    func setupLayout(){
        
        self.addSubview(ImageView)
        NSLayoutConstraint.activate([
            ImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
            ImageView.heightAnchor.constraint(equalToConstant: 200),
            ImageView.widthAnchor.constraint(equalToConstant: 200),
            ImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor)
            
            ])
        
        self.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: self.ImageView.bottomAnchor, constant:20),
            titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor)
            ])

        self.addSubview(textView)
        NSLayoutConstraint.activate([
            textView.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant:5),
            textView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier : 0.4),
            textView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier : 0.8),
            textView.centerXAnchor.constraint(equalTo: self.centerXAnchor)
   
            ])
        

    }
}
