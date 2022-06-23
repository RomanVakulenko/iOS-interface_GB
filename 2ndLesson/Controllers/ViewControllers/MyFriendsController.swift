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
    
    //var sourceFriends = [Friend]()// а это будет исходный массив для сёрч поиска. 8L1h51mУбрали,тк Storage(singleton)его заместил - в нем теперь хранится
    var myFriends = [Friend]() //для сёрч поиска это пусть будет отфильтрованный массив
    let customTableViewCellReuseIdentifier = "customTableViewCellReuseIdentifier"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myFriends = Storage.shared.friends
        //sourceFriends = myFriends //8урок. Убрали,тк Storage(singleton)его заместил - в нем теперь хранится
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
            myFriends = Storage.shared.friends //8L1h51m sourceFriends убрали,тк Storage(singleton)его заместил - в нем теперь хранится
        }
        else { //когда в сёрч поле есть что-то
            myFriends = Storage.shared.friends.filter ({friendItem in
                friendItem.name.lowercased().contains(searchText.lowercased()) //если запрос содержится в searchText, тогда он попадет в myFriends;lowercased - сравнение в нижнем регистре
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
//           let fotos = sender as? [MyFoto] { //указывая sender as? мы убираем опционал; и если фото это массив из строк, тогда можем добраться до свойства destinationController (св-во fotoAlbum прописали в GallaryViewController), 8L1h22m вместо String вставили MyFoto (передаем делегатом нажатие и счетчик)
            
            let fotoArrayIndex = sender as? Int { //8L1h54m
            destinationController.fotoAlbumIndex = fotoArrayIndex //8L1h54m 
        }
    }
}

/*    //чтобы передать фотольбом при клике на конкретного друга, нам надо передать фотольбом
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let fotos = myFriends[indexPath.row].fotoAlbum //придет индекс той ячейки,на кот.нажали и из массива мы можем достать данные - достаем фотоальбом. 8L1h53m давайте передадим не фотольбом, а индекс
        performSegue(withIdentifier: fromFriendListToGallarySegue, sender: indexPath.row) // соответственно sender это фотос. 8L1h53m давайте передадим не фотольбом, а индекс (вместо fotos)
    } //закомментили, тк мы сами обрабатываем нажатие (в самой ячейке добавили прозрачную кнопку на ImageView и прокинули IBAction, написав в completion блоке переход по Segue)
}*/


/*        NotificationCenter.default.addObserver(self, selector: #selector(catchMessage(_:)), name: NSNotification.Name("sendMeaasageFromAllGroups"), object: nil)

    @objc func catchMessage (_ notification: Notification) {
        if let text = notification.object as? String {
            receiverLabel.text = text
        }
    }
*/
