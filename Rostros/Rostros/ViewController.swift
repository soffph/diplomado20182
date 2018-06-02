//
//  ViewController.swift
//  Rostros
//
//  Created by d182_sofia_d on 02/06/18.
//  Copyright © 2018 d182_sofia_d. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    var selectedImage:UIImage!
    
    let faceImage: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "alien.png")
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleToFill
        iv.layer.cornerRadius = 5
        iv.layer.masksToBounds = true
        return iv
    }()
    let boton : UIButton = {
        let bt = UIButton(type: .system)
        bt.setTitle("Detectar rostros", for: .normal)
        bt.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
        bt.backgroundColor = #colorLiteral(red: 0.9745214581, green: 0.3607123494, blue: 0.3209956884, alpha: 1)
        bt.translatesAutoresizingMaskIntoConstraints = false
        bt.addTarget(self, action: #selector(detectFace), for: .touchUpInside)
        bt.layer.cornerRadius = 10
        bt.layer.masksToBounds = true
        return bt
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(selectImage))
        setupLayout()
    }
    func setupLayout(){
        view.addSubview(boton)
        view.addSubview(faceImage)
        faceImage.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        faceImage.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        faceImage.widthAnchor.constraint(equalToConstant: 300).isActive = true
        faceImage.heightAnchor.constraint(equalToConstant: 300).isActive = true
        
        boton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        boton.topAnchor.constraint(equalTo: faceImage.bottomAnchor,constant: 20).isActive = true
        boton.widthAnchor.constraint(equalTo: view.widthAnchor,constant:-100).isActive = true
        boton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
    }
    
    @objc func detectFace()  {
        let detectFaceView = DetectFaceViewController()
        detectFaceView.selectedImage = selectedImage
        navigationController?.pushViewController(detectFaceView, animated: true)
    }
    @objc func selectImage()  {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        present(picker,animated: true,completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let imagen = info["UIImagePickerControllerOriginalImage"] as? UIImage{
            faceImage.image = imagen
            selectedImage = imagen
            dismiss(animated: true, completion: nil)
        }
    }

}

