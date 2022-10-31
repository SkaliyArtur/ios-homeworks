//
//  SettingsViewController.swift
//  Documents
//
//  Created by Artur Skaliy on 27.10.2022.
//

import UIKit

class SettingsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var delegate: ReloadDataDelegate?
    
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
        switchView.setOn(true, animated: true)
        switchView.tag = indexPath.row // for detect which row switch Changed
        switchView.addTarget(self, action: #selector(self.switchChanged(_:)), for: .valueChanged)
        switch indexPath.row {
        case 0:
            cell.accessoryView = switchView
            cell.textLabel?.text = "Сортировка по алфавиту"
            return cell
        case 1:
            cell.accessoryView = switchView
            cell.textLabel?.text = "Показывать размер фотографии"
            return cell
        default:
            cell.textLabel?.text = "Поменять пароль"
            return cell
        }
    }
    @objc func switchChanged(_ sender : UISwitch!){
        switch sender.tag {
        case 0:
            sender.isOn ? UserDefaults.standard.set(true, forKey: "sort") : UserDefaults.standard.set(false, forKey: "sort")
        case 1:
          print("table row switch Changed \(sender.tag)")
          print("The switch is \(sender.isOn ? "ON" : "OFF")")
        default:
            print("print")
        }
        delegate?.reload()
    }
}
