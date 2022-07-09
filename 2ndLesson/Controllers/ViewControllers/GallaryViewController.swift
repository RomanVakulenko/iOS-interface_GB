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

    var fotoAlbum = [MyFoto] ()//5L 1.41m инициализировали фотольбом //8L1h22m вместо String вставили MyFoto
//    var fotoAlbumIndex = 0 //8L1h53m можем передавать не фотоальбом, а индекс
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(UINib(nibName: fotoCollectionViewCell, bundle: nil), forCellWithReuseIdentifier: fotoCollectionViewReuseIdentifier)
        collectionView.dataSource = self
        collectionView.delegate = self
//        fotoAlbum = Storage.shared.friends[fotoAlbumIndex].fotoAlbum //8L1h55m
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        collectionView.reloadData() //перед показом, чтобы обновилась инфа
    }
}


extension GallaryViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    { return self.fotoAlbum.count }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: fotoCollectionViewReuseIdentifier, for: indexPath) as? FotoCollectionViewCell else {return UICollectionViewCell()}
         
//        let localFotoAlbumIndex = fotoAlbumIndex
//        let currentFotoAlbum = Storage.shared.friends[localFotoAlbumIndex].fotoAlbum //8.3.SavingLikesBySingleton
        
        let image = UIImage(named: self.fotoAlbum[indexPath.item].url) //8L 1.21m рисует не просто Петра какого-то, а чтото из фотоальбома; то, откуда он возьмет имя файла, в котором будут лежать фотос 8.3.SavingLikesBySingleton  - вставили
        
        cell.configure(image: image, isLiked: true, likeCounter: 3, onlikeClosure: { isLikePressed, currentCounter in //8L1h38m конфигурируем дополнительно клоужер; в клоужер прилетает 2 параметра нажата/нет и числоНажатий; 8.3.SavingLikesBySingleton 8L2h00 с использованием Storage мы должны в конфигураторе не просто лайкКаунтер , а должны считать его например из фотольбома
            print("counter \(currentCounter)") //выведем в консоль - посмотрим как отрабатывает делегат
            print(isLikePressed ? "true" : "false") //если likeState будет истина, то напишет тру, иначе фолс
            
            //8.3.SavingLikesBySingleton 8L1h57m можем в клоужере поменять наш singleton:
//            Storage.shared.friends[self?.fotoAlbumIndex ?? 0].fotoAlbum[indexPath.item].isLiked = isLikePressed
//            Storage.shared.friends[self?.fotoAlbumIndex ?? 0].fotoAlbum[indexPath.item].likeCounter = currentCounter
        })
        return cell
    }
}


extension GallaryViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.item)
        
//9.1 9м. как сделать фото друга во весь экран
        let fullScreenView = UIView(frame: self.view.bounds) //создаем fullScreenView программно,bounds тк внутри
        let fullScreenImageView = UIImageView(frame: fullScreenView.frame) //создадим ImageView
        fullScreenView.addSubview(fullScreenImageView)// добавляем ImageView на fullScreenView

//закоментил, чтобы уйти от прошлого синглтона(мы в него друзей засунули)
//        let imageFullScreen = Storage.shared.friends[fotoAlbumIndex].fotoAlbum[indexPath.item].url //возьмем из Сторадж, добавили url,чтобы в строке ниже named было действиетльно строка
        let imageFullScreen = self.fotoAlbum[indexPath.item].url //пытался достать фото для галереи
        
        
        
        fullScreenImageView.image = UIImage(named: imageFullScreen) // берем картинку (можно взять по имени, можно взять системную картинку systemName, можно взять из url)
        self.view.addSubview(fullScreenView) // 14m добавляем fullScreenView на нашу абсолютно отдельную Вью (типо вызываем) (это не увеличенная ячейка)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(onTap(_:))) // создадим tap
        fullScreenView.addGestureRecognizer(tap)// 20m добавляем tap на Вью
    }
    
    //нам нужны будут параметры(UITapGestureRecognizer), чтобы выцепить из него Вьюшку
    @objc func onTap(_ recognizer: UITapGestureRecognizer) { //параметром будет приходить наш рекогнайзер
        guard let targetView = recognizer.view else {return} //берем из нашего рекогнайзера и выдираем Вьюшку, к которой он приделан; тк recognizer.view опционал, то его надо прикрыть гуардом
        targetView.removeFromSuperview()
    }
}//2ой способ как сделать фото друга во весь экран:создать вьюконтроллер,куда при помощи сеги прокинем один элемент url




// 5L 1h25m если нужно, чтобы в строке было всегда фиксированное число ячеек и большее переходило на новую строку, то:
extension GallaryViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = collectionView.bounds.width
        let whiteSpaces: CGFloat = 32
        let cellWidth = width/3 - whiteSpaces
        
        return CGSize(width: cellWidth, height: cellWidth)
    }
}
