
//  Created by Roman Vakulenko on 03.06.2022.
// 

import UIKit

class MyFriendsController: UIViewController {
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    let fromFriendListToGallarySegue = "fromFriendsListToGallary"
    
    
    
//8.для работы searchBar нам нужно 2 массива: 1-ый исходный, 2ой-с отфильтрованными данными согласнно введенным символам
    //var sourceFriends = [Friend]() //пусть это будет исходный массив, 1ч51м - убрали, не нужен, т.к. есть Сторадж (удобно, но не безопасно)
    var myFriends = [Friend]() //пусть это будет отфильтрованный
    let customTableViewCellReuseIdentifier = "customTableViewCellReuseIdentifier"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myFriends = Storage.shared.friends //8.3.storage 1h51m fillData() заменили на те же самые френды
        //sourceFriends = myFriends //8.3.storage там же где заполняем массив myFriends, там же и заполняем sourceFriends 1ч51м - убрали, не нужен, т.к. есть Сторадж
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
            myFriends = Storage.shared.friends //8.3.storage если текст searchBar пустой/все стерли, то массивы должны быть равны, заменили на тех же френдов из Стораджа
        }
        else {
            myFriends = Storage.shared.friends.filter ({ friendItem in //8.3.storage  заменили на тех же френдов из Стораджа
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
           let fotoArrayIndex = sender as? Int { //указывая sender as? мы убираем опционал; и если фото это массив из строк, тогда можем добраться до свойства destinationController (св-во fotoAlbum прописали в GallaryViewController), 8L1h21m поставили MyFoto вместо String - это передача, а прием в GallaryViewController - там тоже изменим на MyFoto;8.3.storage  В связи со Сторадж заменили фотос на аррейИндекс и типа Инт
            
            destinationController.fotoAlbumIndex = fotoArrayIndex //8.3.storage в связи со сторокой выше
        }
    }
    //чтобы передать фотольбом при клике на конкретного друга, нам надо передать фотольбом
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //let fotos = myFriends[indexPath.row].fotoAlbum //придет индекс той ячейки,на кот.нажали и из массива мы можем достать данные - достаем фотоальбом, Убрали в связи со Стораджем
        performSegue(withIdentifier: fromFriendListToGallarySegue, sender: indexPath.row) //8.3.storage  соответственно sender это фотос, 1ч53мСо стораджем давайте теперь передадим не fotoAlbum, а просто индекс
    }
}

//        NotificationCenter.default.addObserver(self, selector: #selector(catchMessage(_:)), name: NSNotification.Name("sendMeaasageFromAllGroups"), object: nil)

    
//    @objc func catchMessage (_ notification: Notification) {
//        if let text = notification.object as? String {
//            receiverLabel.text = text
//        }
//    }
 
