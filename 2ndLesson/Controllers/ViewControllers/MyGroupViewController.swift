//
//  MyGroupViewController.swift
//  2ndLesson
//
//  Created by Roman Vakulenko on 15.06.2022.
//

import UIKit

class MyGroupViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var plusButtonToAllGroups: UIBarButtonItem! //10
    
    override func viewDidLoad() {//вью ViewController’a созданa, и вы можете быть уверены, что все Outlets на месте
        
        super.viewDidLoad()
        tableView.register(UINib(nibName: "CustomTableViewCell", bundle: nil), forCellReuseIdentifier: customTableViewCellReuse)
        tableView.dataSource = self
        tableView.delegate = self
        
        //5L 2.13m а тут мы подпишемся на нотификейшн
        NotificationCenter.default.addObserver(self, selector: #selector(didPressToGroup(_:)), name: Notification.Name("pressToGroup"), object: nil)//обозревателем указываем этотКласс, селектор - это функция,кот. будет обрабатывать, нейм - на какое событие мы подписываемся, объект мы лучше поймаем в функции, чтобы применить какую-либо логику;
        self.navigationController?.delegate = self //указываем navigationControllerу брать всю анимацию из 
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
    deinit {//важно отписаться от нотификейшн - тк в нотификейшнСентер мы закидываем ссылку на наш файл self'ом в 22 строке и ссылка там будет висеть - мусор. Отписываться надо обычно во ВьюДидАнлоалд( но можно и тут)
        NotificationCenter.default.removeObserver(self)
    }

    
//с этой строки и до 58 - это ДЗ для 10урока (по заданию 9ого урока№1)
    override func viewDidAppear(_ animated: Bool) { //вызывается после того, как ViewController появляется на экране
        super.viewDidAppear(animated)
    }
    override func viewWillDisappear(_ animated: Bool) {//вызывается до того, как произойдет переход к следующему View Controller’у и исходный ViewController будет удален с экрана
        super.viewWillDisappear(animated)// чтобы при переходе назад вернулось обратно
    }
}

//xcode вначале Предлагал пофиксить и подписать MyGroupViewController на класс UINavigationControllerDelegate -лучше сделаем extension:
extension MyGroupViewController: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return Animator()
    }
}


var groups = [Group]() //создали массив из групп и инициализируем его сразу - во viewDidLoad вызовем fillData и передадим в groups
let customTableViewCellReuse = "customTableViewCellReuse"

extension MyGroupViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return groups.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: customTableViewCellReuse, for: indexPath) as? CustomTableViewCell else { return UITableViewCell() }
        
        cell.configure(groups[indexPath.row])
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
