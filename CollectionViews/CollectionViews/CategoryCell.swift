//
//  CategoryCell.swift
//  CollectionViews
//
//  Created by d182_sofia_d on 21/04/18.
//  Copyright © 2018 d182_sofia_d. All rights reserved.
//

import UIKit

class CategoryCell: UICollectionViewCell, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource{
    
    let albumCellId = "albumCell"
    var albumCategories : [Category]?
    
    var albumCategory: Category? {
        didSet{
            if let name = albumCategory?.name{
                categoryLabel.text = name
            }
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let AlbumCollectionView : UICollectionView = {
       let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
       let collectionview = UICollectionView(frame: .zero, collectionViewLayout: layout)
       collectionview.backgroundColor = UIColor.white
       collectionview.translatesAutoresizingMaskIntoConstraints = false
        return collectionview
    }()
    let categoryLabel : UILabel = {
        let label = UILabel()
        label.text = "Category Label"
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = .lightGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
   
    //: Pone el display de lo que queremos hacer
    func setupLayout(){
        //backgroundColor = UIColor.red
        addSubview(AlbumCollectionView) //Agregar al collection view
        addSubview(categoryLabel)
        AlbumCollectionView.dataSource = self
        AlbumCollectionView.delegate = self
        AlbumCollectionView.register(AlbumCell.self, forCellWithReuseIdentifier: albumCellId)
        
        
        
        //va a permitir ponelre contraints a un conjunto de elemntos
        //1.- lo quiero con un formato visual con opciones de formato y vistas para el album collection
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-10-[v0]-10-|", options: NSLayoutFormatOptions(), metrics: nil, views:  ["v0":categoryLabel]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-14-[v1]-14-|", options: NSLayoutFormatOptions(), metrics: nil, views:  ["v1":AlbumCollectionView]))
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[v0][v1]|", options: NSLayoutFormatOptions(), metrics: nil, views:  ["v0":categoryLabel, "v1":AlbumCollectionView]))
    }
     func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    
     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: albumCellId, for: indexPath)
        cell.backgroundColor = UIColor.white
        //cell.album = albumCategory?.albums![indexPath.item]
        // Configure the cell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: frame.height)
        
        
        
    }
}
