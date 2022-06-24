//
//  MyFriendsController.swift
//  2ndLesson
//
//  Created by Roman Vakulenko on 03.06.2022.
//

import UIKit

class MyFriendsController: UIViewController {
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    let fromFriendListToGallarySegue = "fromFriendsListToGallary"
    
    func fillData() -> [Friend] {
        let myPhoto = MyFoto(url: "roman1") //8L1h19 изменяем в соответствии со структурой Foto и тогда в этой структуре мы сможем сохранять все лайки
        let friend1 = Friend(name: "Ivan", age: "34", avatar: "roman1", fotoAlbum: [myPhoto])
        let friend2 = Friend(name: "Roman", age: "27", avatar: "roman2", fotoAlbum: [myPhoto, myPhoto, myPhoto, myPhoto, myPhoto])
        let friend3 = Friend(name: "Petr", age: "23", avatar: "roman3", fotoAlbum: [myPhoto])
        let friend4 = Friend(name: "Egor", age: "14", avatar: "roman1", fotoAlbum: [myPhoto])
        let friend5 = Friend(name: "Alexey", age: "27", avatar: "roman2", fotoAlbum: [myPhoto,myPhoto,myPhoto])
        let friend6 = Friend(name: "Ignat", age: "23", avatar: "roman3", fotoAlbum: [myPhoto])
        var friendsArray = [Friend]()
        friendsArray.append(friend1)
        friendsArray.append(friend2)
        friendsArray.append(friend3)
        friendsArray.append(friend4)
        friendsArray.append(friend5)
        friendsArray.append(friend6)
        //8L57m добавим 30 друзей, чтобы проверить не перезаписываются ли лайки друзей scroll'oм
        for _ in 0...30 {
            friendsArray[1].fotoAlbum.append(myPhoto)
        }
        return friendsArray
    }
    
//8.для работы searchBar нам нужно 2 массива: 1-ый исходный, 2ой-с отфильтрованными данными согласнно введенным символам
    var sourceFriends = [Friend]() //пусть это будет исходный массив
    var myFriends = [Friend]() //пусть это будет отфильтрованный
    let customTableViewCellReuseIdentifier = "customTableViewCellReuseIdentifier"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myFriends = fillData()
        sourceFriends = myFriends //8.там же где заполняем массив myFriends, там же и заполняем sourceFriends
        tableView.register(UINib(nibName: "CustomTableViewCell", bundle: nil), forCellReuseIdentifier: customTableViewCellReuseIdentifier)
        tableView.dataSource = self
        tableView.delegate = self
        searchBar.delegate = self //8L25m чтобы searchBar знал в какой класс он будет отдавать делегаты
    }
}

//8. после заполнения массивов мы фильтруем в sourceFriends и обновляем myFriends массив - табличку
extension MyFriendsController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            myFriends = sourceFriends //если текст searchBar пустой/все стерли, то массивы должны быть равны
        }
        else {
            myFriends = sourceFriends.filter ({ friendItem in
                friendItem.name.lowercased().contains(searchText.lowercased()) //будет проверять содержится ли в нем searchText, если да, то этот элемент попадет в myFriends, .lowercased() - приводим сравнение текстов к нижнему регистру(больше ни на что не влияет)
            })
        }
        tableView.reloadData()
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
           let fotos = sender as? [MyFoto] { //указывая sender as? мы убираем опционал; и если фото это массив из строк, тогда можем добраться до свойства destinationController (св-во fotoAlbum прописали в GallaryViewController), 8L1h21m поставили MyFoto вместо String - это передача, а прием в GallaryViewController - там тоже изменим на MyFoto
            
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
 
