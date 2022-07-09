//
//  MyFriendsController.swift
//  2ndLesson
//
//  Created by Roman Vakulenko on 03.06.2022.
//

import UIKit

class MyFriendsController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    let fromFriendListToGallarySegue = "fromFriendsListToGallary"
    
    func fillData() -> [Friend] {
        let myPhoto = MyFoto(url: "44")
        
        let friend1 = Friend(name: "Ivana", age: "34", avatar: "1", fotoAlbum: [myPhoto])
        let friend2 = Friend(name: "Victoria", age: "27", avatar: "2", fotoAlbum: [myPhoto,myPhoto,myPhoto,myPhoto])
        let friend3 = Friend(name: "Petr", age: "23", avatar: "11", fotoAlbum: [myPhoto])
        let friend4 = Friend(name: "Roman", age: "14", avatar: "22", fotoAlbum: [myPhoto])
        let friend5 = Friend(name: "Alexa", age: "27", avatar: "3", fotoAlbum: [myPhoto])
        let friend6 = Friend(name: "Sam", age: "23", avatar: "33", fotoAlbum: [myPhoto])
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
    
    var sourceFriends = [Friend]()//исходный массив для сёрч поиска. 8L1h51mУбрали,тк Storage(singleton)его заместил - в нем теперь хранится
    var myFriends = [Friend]() //для сёрч поиска - отфильтрованный массив
    let customTableViewCellReuseIdentifier = "customTableViewCellReuseIdentifier"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myFriends = fillData()
        sourceFriends = myFriends //8урок. Убрали,тк Storage(singleton)его заместил - в нем теперь хранится
        tableView.register(UINib(nibName: "CustomTableViewCell", bundle: nil), forCellReuseIdentifier: customTableViewCellReuseIdentifier)
        tableView.dataSource = self
        tableView.delegate = self
        searchBar.delegate = self //8урок_так searchBar знает в какой классе будут реализованы методы делегата и будет их вызывать
    }
}
//8урок когда загружается MyFriendsController оба массива имеют одинаковое наполнение, дальше мы фильтруем из sourceFriends, формируя myFriends и обновляя табличку
extension MyFriendsController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String){
        if searchText.isEmpty {
            myFriends = sourceFriends //8L1h51m sourceFriends убрали,тк Storage(singleton)его заместил - в нем теперь хранится
        }
        else { //когда в сёрч поле есть что-то
            myFriends = sourceFriends.filter ({friendItem in
                friendItem.name.lowercased().contains(searchText.lowercased()) //если запрос содержится в searchText, тогда он попадет в myFriends;lowercased - сравнение в нижнем регистре
            })
        }
        tableView.reloadData()
    }
}


extension MyFriendsController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myFriends.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: customTableViewCellReuseIdentifier, for: indexPath) as? CustomTableViewCell else {return UITableViewCell()}
        
        let friend = myFriends[indexPath.row] //выбор друга по индексу из массива друзей
        cell.configure(image: UIImage(named: friend.avatar ?? ""), name: friend.name, description: friend.age, closure: { [weak self] in
            guard let self = self else {return}
            self.performSegue(withIdentifier: self.fromFriendListToGallarySegue, sender: indexPath.row)
        }) //8L.2.32m сама ячейка будет считывать нажатия и по окончанию анимации в комплишн мы дернем переход
        return cell
    }
}


extension MyFriendsController: UITableViewDelegate {
    
// перед тем как отработает Сега мы подготовимся/ У Сеги есть название (identifier), source - тот контроллер с кот. мы переходим и destination - тот контроллер, на кот. переходим
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender) //если оверрайд, то всегда используем суперметод
        if segue.identifier == fromFriendListToGallarySegue,   //если id совпадает, то проверяем дальше
           let destinationController = segue.destination as? GallaryViewController,//если целевой контроллер нужного класса(т.е. нужный контроллер)
           let fotos = sender as? [MyFoto] { //указывая sender as? мы убираем опционал; и тк мы знаем что цлевой VC - это GallaryViewController. тогда можем добраться до его свойства: destinationController (св-во fotoAlbum прописали в GallaryViewController) //8L1h22m вместо String вставили MyFoto (передаем делегатом нажатие и счетчик)
            destinationController.fotoAlbum = fotos //8L1h54m
            //            let fotoArrayIndex = sender as? Int { //8L1h54m
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}

/*    //чтобы передать фотольбом при клике на конкретного друга, нам надо передать фотольбом
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let fotos = myFriends[indexPath.row].fotoAlbum //5L 1.35m придет индекс той ячейки,на кот.нажали и из массива мы можем достать данные - достаем фотоальбом. 8L1h53m давайте передадим не фотольбом, а индекс
        performSegue(withIdentifier: fromFriendListToGallarySegue, sender: fotos) // соответственно sender это фотос. 8L1h53m давайте передадим не фотольбом, а индекс (вместо fotos)
    } //2ч21м закомментили, тк мы сами обрабатываем нажатие (в самой ячейке добавили прозрачную кнопку на ImageView и прокинули IBAction, написав в completion блоке переход по Segue)
}//8L 2.32m таблица никак не будет участвовать в процессе обработки нажатия, а будет участвовать сама наша ячейка
*/


/*        NotificationCenter.default.addObserver(self, selector: #selector(catchMessage(_:)), name: NSNotification.Name("sendMeaasageFromAllGroups"), object: nil)
 
 @objc func catchMessage (_ notification: Notification) {
 if let text = notification.object as? String {
 receiverLabel.text = text
 }
 }
 */




