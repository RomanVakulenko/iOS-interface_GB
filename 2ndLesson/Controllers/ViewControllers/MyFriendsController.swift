//
//  MyFriendsController.swift
//  2ndLesson
//
//  Created by Roman Vakulenko on 03.06.2022.
//

import UIKit

class MyFriendsController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    let fromFriendListToGallarySegue = "fromFriendsListToGallary"
    
    func fillData() -> [Friend] {
        let friend1 = Friend(name: "Roman", age: "27", avatar: "roman1", fotoAlbum: ["roman1"])
        let friend2 = Friend(name: "Roman", age: "27", avatar: "roman2", fotoAlbum: ["roman1","roman2","roman3"])
        let friend3 = Friend(name: "Roman", age: "27", avatar: "roman3", fotoAlbum: ["roman3"])
        var friendsArray = [Friend]()
        friendsArray.append(friend1)
        friendsArray.append(friend2)
        friendsArray.append(friend3)
        return friendsArray
    }
    
    var myFriends = [Friend]()
    let customTableViewCellReuseIdentifier = "customTableViewCellReuseIdentifier"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myFriends = fillData()
        tableView.register(UINib(nibName: "CustomTableViewCell", bundle: nil), forCellReuseIdentifier: customTableViewCellReuseIdentifier)
        tableView.dataSource = self
        tableView.delegate = self
               
    }
}

extension MyFriendsController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
// перед тем как отработает Сега мы подготовимся/ У Сеги есть название - Identifier, source - тот контроллер с кот. мы переходим и destination - тот контроллер, на кот. переходим
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender) //если оверрайд, то всегда используем суперметод
        if segue.identifier == fromFriendListToGallarySegue,   //если АйДи совпадает, то проверяем дальше
           let destinationController = segue.destination as? GallaryViewController,//если целевой контроллер нужного класса(т.е. нужный контроллер)
           let fotos = sender as? [String] { //указывая sender as? мы убираем опционал; и если фото это массив из строк, тогда можем добраться до свойства destinationController (св-во fotoAlbum прописали в GallaryViewController)
            
            destinationController.fotoAlbum = fotos
        }
    }
    //чтобы передать фотольбом при клике на конкретного друга, нам надо передать фотольбом
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let fotos = myFriends[indexPath.row].fotoAlbum //придет индекс той ячейки,на кот.нажали и из массива мы можем достать данные - достаем фотоальбом
        performSegue(withIdentifier: fromFriendListToGallarySegue, sender: fotos) // соответственно sender это фотос
    }
}

//        NotificationCenter.default.addObserver(self, selector: #selector(catchMessage(_:)), name: NSNotification.Name("sendMeaasageFromAllGroups"), object: nil)

    
//    @objc func catchMessage (_ notification: Notification) {
//        if let text = notification.object as? String {
//            receiverLabel.text = text
//        }
//    }
 
