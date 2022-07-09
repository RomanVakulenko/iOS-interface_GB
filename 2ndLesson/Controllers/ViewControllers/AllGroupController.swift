//
//  AllGroupController.swift
//  2ndLesson
//
//  Created by Roman Vakulenko on 03.06.2022.
//

import UIKit

class AllGroupController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    func fillData() -> [Group] {
        let group1 = Group(name: "Cats lovers", description: "MSK", avatar: "1")
        let group2 = Group(name: "Dogs lovers", description: "LPK", avatar: "22")
        let group3 = Group(name: "Apple lovers", description: "LA", avatar: "3")
        var groups = [Group]() // инициализируем переменную и в нее запишем массив типа группа
        groups.append(group1)
        groups.append(group2)
        groups.append(group3)
        return groups
    }
    var groups = [Group]() //создали массив из групп и инициализируем его сразу - во viewDidLoad вызовем fillData и передадим в groups
    let customTableViewCellReuse = "customTableViewCellReuse"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        groups = fillData()
        tableView.register(UINib(nibName: "CustomTableViewCell", bundle: nil), forCellReuseIdentifier: customTableViewCellReuse)
        tableView.dataSource = self
        tableView.delegate = self
    }
}


extension AllGroupController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return groups.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: customTableViewCellReuse, for: indexPath) as? CustomTableViewCell else { return UITableViewCell() }
        
        cell.configure(self.groups[indexPath.row])
        
        return cell
    }
}

// отсюда будем распространять нотификейшены
extension AllGroupController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    // 5L 2.11m вместо Сеги как в MyFriendViewController используем другой способ - через нотификейшн.Отсюда и будем распространять
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {//нажали на картинку и пришла к нам группа
        let group = groups[indexPath.item]
        NotificationCenter.default.post(name: Notification.Name("pressToGroup"), object: group)
    }
}



// С урока №3 про Notification
//    @IBAction func pressSendButton(_ sender: Any) {
//        if let text =   messageTextField.text {
//            NotificationCenter.default.post(name: NSNotification.Name("sendMeaasageFromAllGroups"), object: text)
//        }
//    }
//
//}
