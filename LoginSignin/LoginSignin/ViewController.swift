//
//  ViewController.swift
//  LoginSignin
//
//  Created by d182_sofia_d on 20/04/18.
//  Copyright © 2018 d182_sofia_d. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var userTextField: UITextField!
    @IBOutlet weak var passwdTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userTextField.text = "admin@example.com"
        passwdTextField.text = "tacocat1234"
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func loginBtn(_ sender: UIButton) {
        let user = userTextField.text!
        let pswd = passwdTextField.text!
        if !user.isEmpty && !pswd.isEmpty{
            makeLogin(user: user, pswd: pswd)
        }
    }
    
    func makeLogin(user: String, pswd: String){
        let body : [String:String] = ["email":user, "password":pswd]
        var components = URLComponents()
        components.scheme = "https"
        components.host = "ioslab.herokuapp.com"
        components.path = "/auth"
        
        var request = URLRequest(url: components.url!)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONEncoder().encode(body)
        
        
        let task = URLSession.shared.dataTask(with: request){(data, response, error) in
            if let error = error{
                print("Error en el request: ",error)
                return
            }
            if let data = data, let response = response as? HTTPURLResponse{
                switch response.statusCode{
                case 200:
                    do {
                        let json_ = try JSONSerialization.jsonObject(with: data, options: [])
                        if let  json = json_ as? [String:Any]{
                            let token = json["token"]
                            print(token)
                        }
                    }catch(let err){
                        print(err)
                    }
                default:
                    print("default",response)
                }
            }else{
                print("no hay internet")
            }
            
        }
        task.resume()
    }

}

