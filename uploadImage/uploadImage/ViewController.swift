//
//  ViewController.swift
//  uploadImage
//
//  Created by d182_sofia_d on 12/05/18.
//  Copyright © 2018 d182_sofia_d. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseStorage

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    var storageImage = UIImage()
    var ref: DatabaseReference!
    
    let uploadImage : UIButton = {
       let b = UIButton()
       b.setImage(#imageLiteral(resourceName: "Snoopy"), for: .normal)
       b.translatesAutoresizingMaskIntoConstraints = false
       b.addTarget(self, action: #selector(selectImage), for: .touchUpInside)
       return b
    }()
    let uploadButton : UIButton = {
        let b = UIButton()
        b.backgroundColor = UIColor.red
        b.setTitle("Subir imagen", for: .normal)
        b.translatesAutoresizingMaskIntoConstraints = false
         b.addTarget(self, action: #selector(saveImage), for: .touchUpInside)
        return b
    }()
    let myActivityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.gray)
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        paintViews()
        ref = Database.database().reference()
        // Do any additional setup after loading the view, typically from a nib.
    }
    func paintViews(){
        view.addSubview(uploadImage)
        view.addSubview(uploadButton)
        view.addSubview(myActivityIndicator)
        
        uploadImage.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        uploadImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 150).isActive = true
        uploadImage.heightAnchor.constraint(equalToConstant: 150).isActive = true
        uploadImage.widthAnchor.constraint(equalToConstant: 150).isActive = true
        
        uploadButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        uploadButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        uploadButton.widthAnchor.constraint(equalToConstant: 300).isActive = true
        uploadButton.heightAnchor.constraint(equalToConstant: 50)
        
        myActivityIndicator.translatesAutoresizingMaskIntoConstraints = false
        myActivityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        myActivityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -100).isActive = true
        
    }
    @objc func selectImage(){
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        self.present(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let imagen = info["UIImagePickerControllerOriginalImage"] as? UIImage{
                self.uploadImage.setImage(imagen, for: .normal)
                storageImage = imagen
                dismiss(animated: true, completion: nil)
        }
    }
    
    @objc func saveImage(){
        let id = ref.childByAutoId().key
        self.myActivityIndicator.startAnimating()
        let storage = Storage.storage().reference()
        let nombreImagen = UUID()
        let directorio = storage.child("imagenes/\(nombreImagen)")
        let metadata = StorageMetadata()
        metadata.contentType = "image/png"
        directorio.putData(UIImagePNGRepresentation(storageImage)!, metadata: metadata){
            (data, error) in
            if error != nil{
                print(error?.localizedDescription)
                return
            }
            print("Se subio la imagen")
            self.myActivityIndicator.stopAnimating()
        }
        let values = ["nombre": String(describing: directorio)]
        ref.child("imagenes").child(id).setValue(values)
        
    }
    

}

