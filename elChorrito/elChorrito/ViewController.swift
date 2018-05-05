//
//  ViewController.swift
//  elChorrito
//
//  Created by d182_sofia_d on 05/05/18.
//  Copyright © 2018 d182_sofia_d. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class ViewController: UIViewController {
    var ref: DatabaseReference! = nil
    
    let formContainerView: UIView = { //vista que va a ir en medio
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 25
        view.layer.masksToBounds = true
        return view
    }()
    let registerButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.backgroundColor = UIColor(red: 232/255, green: 173/255, blue: 72/255, alpha: 0.5)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.setTitle("Registro", for: .normal)
        btn.layer.cornerRadius = 15
        btn.layer.masksToBounds = true
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 30)
        
        btn.addTarget(self, action: #selector(loginRegister) , for: .touchUpInside)
        
        return btn
    }()
    let emailTextField : UITextField = {
       let tf = UITextField()
       tf.placeholder = "email@it.com"
       tf.translatesAutoresizingMaskIntoConstraints = false
        
       return tf
    }()
    let passwordTextField : UITextField = {
        let tf = UITextField()
        tf.placeholder = "password"
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.isSecureTextEntry = true
        return tf
    }()
    
    let formSegmentedControll : UISegmentedControl = {
       let sg = UISegmentedControl(items: ["Login","Register"])
       sg.translatesAutoresizingMaskIntoConstraints = false
       sg.layer.cornerRadius = 15
       sg.layer.masksToBounds = true
       sg.selectedSegmentIndex = 1
       sg.tintColor = UIColor.white
       sg.addTarget(self, action: #selector(segmentedChange) , for: .valueChanged)
       return sg
    }()
    
    @objc func segmentedChange(){
        let title = formSegmentedControll.titleForSegment(at: formSegmentedControll.selectedSegmentIndex)
        registerButton.setTitle(title, for: .normal)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 1, green: 0.8191497922, blue: 0.7091891766, alpha: 1)
       // #colorLiteral(red: 1, green: 0.5560173988, blue: 0, alpha: 1)
        setupLayout()
        
        ref = Database.database().reference()
    }

    func setupLayout(){
        view.addSubview(formContainerView)
        view.addSubview(registerButton)
        formContainerView.addSubview(emailTextField)
        formContainerView.addSubview(passwordTextField)
        view.addSubview(formSegmentedControll)
        
        //: vista blanca
        formContainerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive=true
        formContainerView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive=true
        formContainerView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -20).isActive = true
        formContainerView.heightAnchor.constraint(equalToConstant: 120).isActive=true
        
        //: agregar al boton
        registerButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        registerButton.topAnchor.constraint(equalTo: formContainerView.bottomAnchor,constant: 5).isActive = true
        registerButton.widthAnchor.constraint(equalTo: formContainerView.widthAnchor).isActive = true
        registerButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        //: los textfields email y password
        emailTextField.leftAnchor.constraint(equalTo: formContainerView.leftAnchor, constant: 5).isActive = true
        emailTextField.topAnchor.constraint(equalTo: formContainerView.topAnchor).isActive = true
        emailTextField.widthAnchor.constraint(equalTo: formContainerView.widthAnchor).isActive = true
        emailTextField.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        //: password
        passwordTextField.leftAnchor.constraint(equalTo: formContainerView.leftAnchor, constant: 5).isActive = true
        passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor).isActive = true
        passwordTextField.widthAnchor.constraint(equalTo: formContainerView.widthAnchor).isActive = true
        passwordTextField.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        //SegmentedControll
        
        formSegmentedControll.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        formSegmentedControll.bottomAnchor.constraint(equalTo: formContainerView.topAnchor, constant: -15 ).isActive = true
        formSegmentedControll.widthAnchor.constraint(equalTo: formContainerView.widthAnchor).isActive = true
        
        formSegmentedControll.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
    }
    
    @objc func loginRegister(){
        if formSegmentedControll.selectedSegmentIndex == 0{
            loginUser()
        }else{
            registerUser()
        }
    }
    
    func loginUser(){
        if let email = emailTextField.text, let pswd = passwordTextField.text{
            Auth.auth().signIn(withEmail: email, password: pswd) { (user, error) in
                if user != nil {
                    print("Usuario autenticado")
                    let lc = LoginUIViewController()
                    self.navigationController?.pushViewController(lc, animated: true)
                    
                }else{
                    if let error = error?.localizedDescription{
                        print("Error inicio secion firebase",error)
                    }else{
                        print("Tu eres error en sesion")
                    }
                }
            }
        }
    }
    func registerUser(){
        if let email = emailTextField.text, let pswd = passwordTextField.text{
            Auth.auth().createUser(withEmail: email, password: pswd) { (user, error) in
                if user != nil {
                    print("Se creo el usuario")
                    
                    let values = ["name": email]
                    self.ref.updateChildValues(values, withCompletionBlock: { (error, ref) in
                        if error != nil{
                            print("ERror al insertar datos")
                            return
                        }else{
                            print("Datos guardados en la bd",ref)
                        }
                    })
                }else{
                        if let error = error?.localizedDescription{
                            print(error)
                        }else{
                            print("tu eres el error")
                        }
                }
            }
        }
    }

}

