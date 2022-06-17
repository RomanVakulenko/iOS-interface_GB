//
//  MFC+dataSource.swift
//  2ndLesson
//
//  Created by Roman Vakulenko on 15.06.2022.
//

import UIKit

extension MyFriendsController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myFriends.count
        }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: customTableViewCellReuseIdentifier, for: indexPath) as? CustomTableViewCell else {return UITableViewCell()}
            
        let friend = myFriends[indexPath.row]
        cell.configure(image: UIImage(named: friend.avatar ?? ""), name: friend.name, description: friend.age)
        return cell
        }
    }
