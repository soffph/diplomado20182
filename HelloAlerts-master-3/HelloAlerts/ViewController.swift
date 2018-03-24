//
//  ViewController.swift
//  HelloAlerts
//
//  Created by Luis Ezcurdia on 3/23/18.
//  Copyright © 2018 Luis Ezcurdia. All rights reserved. chacaleado por mi 
//

import UIKit

class ViewController: UIViewController {
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    private let titleLabel: UILabel = {
        let lbl =  UILabel()
        lbl.text = "Hello Alerts"
        lbl.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        lbl.textColor = .white
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    let simpleBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Simple alert", for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        btn.tintColor = .white
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addTarget(self, action: #selector(tapOkAlert), for: .touchUpInside)
        return btn
    }()
    var prof = ProfileView()
    override func viewDidLoad() {
        super.viewDidLoad()
        //------------ modificados **
        self.view.backgroundColor = UIColor.tangerine
        setupView()
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    func setupView(){
//        let titleLabel =  UILabel()
//        titleLabel.text = "Hello Alerts"
//        titleLabel.font = UIFont.systemFont(ofSize: 22, weight: .bold)
//        titleLabel.textColor = .white
//        titleLabel.translatesAutoresizingMaskIntoConstraints = false  //tome en consideración el autolayout
//        self.view.addSubview(titleLabel)
//        titleLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
//        titleLabel.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor).isActive = true
//        titleLabel.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor).isActive = true
//        titleLabel.heightAnchor.constraint(equalToConstant: 45)
        //let titleLabel = UIView()
//        titleLabel.backgroundColor = .yankeesBlue
//        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(titleLabel)
        NSLayoutConstraint.activate([
        titleLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
        titleLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10),
       // titleLabel.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
        titleLabel.heightAnchor.constraint(equalToConstant: 45)
        ])
        
        self.view.addSubview(simpleBtn)
        NSLayoutConstraint.activate([
            simpleBtn.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            simpleBtn.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10),
            // titleLabel.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            simpleBtn.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            simpleBtn.heightAnchor.constraint(equalToConstant: 45)
            ])
        
        self.view.addSubview(prof)
        prof.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            prof.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            prof.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            prof.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier :0.7),
            prof.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.7)
            ])
    }

    let lipsum = "Lorem ipsum dolor quet sit amet"

    func tapSimpleAlert(_ sender: Any) {
        print("Simple Alert")
        let alert = UIAlertController(title: "Simple Alert", message: lipsum, preferredStyle: .actionSheet)
        self.present(alert, animated: true, completion: nil)
    }

    @objc func tapOkAlert(_ sender: Any) {
        print("Ok Alert")
        let alert = UIAlertController(title: "Ok Alert", message: lipsum, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default) { action in
            debugPrint(action)
        }
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }

    func tapOkCancelAlert(_ sender: Any) {
        print("Ok Cancel Alert")
        let alert = UIAlertController(title: "Ok Cancel Alert", message: lipsum, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default) { action in
            debugPrint(action)
        }
        alert.addAction(okAction)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { action in
            debugPrint(action)
        }
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
    }

}
