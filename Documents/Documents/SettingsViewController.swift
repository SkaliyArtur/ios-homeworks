//
//  SettingsViewController.swift
//  Documents
//
//  Created by Artur Skaliy on 27.10.2022.
//

import UIKit

class SettingsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var delegate: ReloadDataDelegate?
    let passwordKeychainService = PasswordKeychainSevice()
    
    let table: UITableView = {
        let table = UITableView.init(frame: .zero, style: .grouped)
        table.register(UITableViewCell.self, forCellReuseIdentifier: "TableViewCell")
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    func setupTable() {
        view.addSubview(table)
        table.dataSource = self
        table.delegate = self
        NSLayoutConstraint.activate([
            table.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            table.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            table.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            table.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationController?.navigationBar.prefersLargeTitles = true
        self.title = "Настройки"
        setupTable()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath)
        cell.textLabel?.textColor = .black
        let switchView = UISwitch(frame: .zero)
        switchView.tag = indexPath.row
        switchView.addTarget(self, action: #selector(self.switchChanged(_:)), for: .valueChanged)
        let isSorted = UserDefaults.standard.object(forKey: "sort") as? Bool ?? true
        let showSize = UserDefaults.standard.object(forKey: "size") as? Bool ?? true
        switch indexPath.row {
        case 0:
            cell.accessoryView = switchView
            if isSorted == true {
                cell.textLabel?.text = "Сортировка от А до Я"
                switchView.setOn(true, animated: true)
            } else {
                cell.textLabel?.text = "Сортировка от Я до А"
                switchView.setOn(false, animated: true)
            }
            return cell
        case 1:
            cell.accessoryView = switchView
            cell.textLabel?.text = "Показывать размер фотографии"
            if showSize == true {
                switchView.setOn(true, animated: true)
            } else {
                switchView.setOn(false, animated: true)
            }
            return cell
        default:
            cell.textLabel?.text = "Поменять пароль"
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 2 {
            let passwordVC = PasswordViewController(toUpdatePassword: true)
            passwordVC.modalPresentationStyle = .automatic
            present(passwordVC, animated: true, completion: nil)
        }
    }
    
    
    @objc func switchChanged(_ sender : UISwitch!){
        switch sender.tag {
        case 0:
            sender.isOn ? UserDefaults.standard.set(true, forKey: "sort") : UserDefaults.standard.set(false, forKey: "sort")
        case 1:
            sender.isOn ? UserDefaults.standard.set(true, forKey: "size") : UserDefaults.standard.set(false, forKey: "size")
        default:
            print("print")
        }
        self.table.reloadData()
        self.delegate?.currentDirectorySort()
    }
}
