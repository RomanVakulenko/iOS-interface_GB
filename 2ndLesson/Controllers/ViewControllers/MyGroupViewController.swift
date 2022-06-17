//
//  MyGroupViewController.swift
//  2ndLesson
//
//  Created by Roman Vakulenko on 15.06.2022.
//

import UIKit

class MyGroupViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var groups = [Group]() //создали массив из групп и инициализируем его сразу - во viewDidLoad вызовем fillData и передадим в groups
    let customTableViewCellReuse = "customTableViewCellReuse"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "CustomTableViewCell", bundle: nil), forCellReuseIdentifier: customTableViewCellReuse)
        tableView.dataSource = self
        tableView.delegate = self
        
        // а тут мы подпишемся на нотификейшн
        NotificationCenter.default.addObserver(self, selector: #selector(didPressToGroup(_:)), name: Notification.Name("pressToGroup"), object: nil)//обозревателем указываем этотКласс, селектор - это функция,кот. будет обрабатывать, нейм - на какое событие мы подписываемся, объект мы лучше поймаем в функции, чтобы применить какую-либо логику;
    }
    @objc func didPressToGroup(_ notification: Notification) {
        // ловим нотификейшен
        guard let group = notification.object as? Group else {return} //берем из Нотификейшн объект, как параметр в функции-обработчике, безопасно его кастим до группы
        
        if !groups.contains(where: {groupItem in
            groupItem.name == group.name //проверяем содержится ли группа, которая была передана, в текущем массиве; содержится ли она
        }) {
            groups.append(group) // и если не содержится, то добавляем группу и
            tableView.reloadData()// перезагружаем ячейки
        }
    }
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
    
extension MyGroupViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return groups.count
    }
    
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: customTableViewCellReuse, for: indexPath) as? CustomTableViewCell else { return UITableViewCell() }
        
        cell.configure(self.groups[indexPath.row])
        return cell
    }
}

extension MyGroupViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
//  вместо Сеги как в MyFriendViewController используем другой способ - через нотификейшн
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
     
    }
}
