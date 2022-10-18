//
//  ViewControllerFactory.swift
//  Documents
//
//  Created by Artur Skaliy on 16.10.2022.
//


import UIKit

class ViewControllerFactory: UIViewController, UITableViewDataSource, UITableViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    let fileManagerService = FileManagerService()
    var rootURL: URL //URL для которого отображаем View
    var files: [URL] = [] //пустой массив URLов, в который мы потом записываем содержимое rootURL
    var viewTitle: String //заголовок rootURL
    
    
    
    init(rootURL: URL, viewTitle: String) {
        self.rootURL = rootURL
        self.viewTitle = viewTitle
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let table: UITableView = {
        let table = UITableView.init(frame: .zero, style: .grouped)
        table.register(UITableViewCell.self, forCellReuseIdentifier: "TableViewCell")
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    let picker: UIImagePickerController = {
        let picker = UIImagePickerController()
        return picker
    }()
        
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return files.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) 
        cell.textLabel?.textColor = .black
        cell.textLabel?.text = "\(self.files[indexPath.row].lastPathComponent)"
        do {
            //Получаем тип файлов, и если он равен директории (папке) - ставим disclosureIndicator
            let fileType = try FileManager.default.attributesOfItem(atPath: "\(self.files[indexPath.row].path)")[FileAttributeKey.type]
            if fileType as! FileAttributeType == FileAttributeType.typeDirectory{
                cell.accessoryType = .disclosureIndicator
            } else {
                cell.accessoryType = .none
            }
        } catch {
            print(error.localizedDescription)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        do {
            let fileType = try FileManager.default.attributesOfItem(atPath: "\(self.files[indexPath.row].path)")[FileAttributeKey.type]
            if fileType as! FileAttributeType == FileAttributeType.typeDirectory {
          // проверка на опционал + кодирование URL, если символы, например, русские
                guard let path = self.files[indexPath.row].path.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed), let pathURL = URL(string: path) else {
                    print("Некорректный URL")
                    return
                }
                // по клику на ячейку открываем View, передавая в качестве rootURL - URL выбранной ячейки
                let view = ViewControllerFactory(rootURL: pathURL as URL, viewTitle: pathURL.lastPathComponent)
                navigationController?.pushViewController(view, animated: true)
            } else {
                print("Это не папка")
            }
        } catch {
            print(error.localizedDescription)
        }
        
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let url = files[indexPath.row]
            files.remove(at: indexPath.row)
            fileManagerService.removeContent(currentDirectory: rootURL, toDelete: url)
            table.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    func setupTable() {
        view.addSubview(table)
        table.dataSource = self
        table.delegate = self
        picker.delegate = self
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
        let addDirectory = UIBarButtonItem(image: UIImage(systemName: "folder.badge.plus"), style: .plain, target: self, action: #selector(createDirectory))
        let addFile = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(createFile))
        navigationItem.rightBarButtonItems = [addFile, addDirectory]
        self.title = viewTitle

        setupTable()
        files = fileManagerService.contentsOfDirectory(currentDirectory: rootURL)
    }
    
    @objc func createDirectory() {
        let alert = UIAlertController(title: "Create new folder", message: nil, preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.placeholder = "Folder name"
        }
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        alert.addAction(UIAlertAction(title: "Create", style: .default, handler: { [self] _ in
            guard let textField = alert.textFields?[0].text else {return}
            fileManagerService.createDirectory(currentDirectory: rootURL, newDirectoryName: textField)
            files = fileManagerService.contentsOfDirectory(currentDirectory: rootURL)
            self.table.reloadData()
        }))
        self.present(alert, animated: true, completion: nil)
        
    }
    @objc func createFile() {
        present(picker, animated: true)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.imageURL] as! URL
        self.dismiss(animated: true, completion: nil)
        fileManagerService.createFile(currentDirectory: rootURL, newFile: image)
        files = fileManagerService.contentsOfDirectory(currentDirectory: rootURL)
        self.table.reloadData()
    }
}




