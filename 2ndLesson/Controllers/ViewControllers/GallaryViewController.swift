//
//  GallaryViewController.swift
//  2ndLesson
//
//  Created by Roman Vakulenko on 15.06.2022.
//

import UIKit

class GallaryViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    
    let fotoCollectionViewReuseIdentifier = "fotoCollectionViewReuseIdentifier"
    var fotoAlbum = [MyFoto] ()//инициализировали фотольбом  
    //1ч52м Со Строраджем мы можем передавать не фотоальбом, а только индекс
    var fotoAlbumIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(UINib(nibName: fotoCollectionViewCell, bundle: nil), forCellWithReuseIdentifier: fotoCollectionViewReuseIdentifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        fotoAlbum = Storage.shared.friends[fotoAlbumIndex].fotoAlbum //1ч55 в связи со Сторадж
    }
    
    override func viewWillAppear(_ animated: Bool) { //перед показом, чтобы обновилась инфа
        super.viewWillAppear(animated)
        collectionView.reloadData()
    }
}
