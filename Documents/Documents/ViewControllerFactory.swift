//
//  ViewControllerFactory.swift
//  Documents
//
//  Created by Artur Skaliy on 16.10.2022.
//


import UIKit

protocol ReloadDataDelegate {
    func currentDirectorySort()
}


class ViewControllerFactory: UIViewController, UITableViewDataSource, UITableViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, ReloadDataDelegate {
    
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
    
    let tableList: UITableView = {
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
        
        do {
            //Получаем тип файлов, и если он равен директории (папке) - ставим disclosureIndicator
            let fileType = try FileManager.default.attributesOfItem(atPath: "\(self.files[indexPath.row].path)")[FileAttributeKey.type]
            let fileSize = try FileManager.default.attributesOfItem(atPath: "\(self.files[indexPath.row].path)")[FileAttributeKey.size] as? UInt64 ?? UInt64(0)
            if fileType as! FileAttributeType == FileAttributeType.typeDirectory{
                cell.accessoryType = .disclosureIndicator
                cell.textLabel?.text = "\(self.files[indexPath.row].lastPathComponent)"
            } else {
                cell.accessoryType = .none
                let showSize = UserDefaults.standard.object(forKey: "size") as? Bool ?? true
                if showSize == true {
                    cell.textLabel?.text = "\(ByteCountFormatter.string(fromByteCount: Int64(fileSize), countStyle: .file)) \(self.files[indexPath.row].lastPathComponent)"
                } else {
                    cell.textLabel?.text = "\(self.files[indexPath.row].lastPathComponent)"
                }
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
//                let view = ViewControllerFactory(rootURL: pathURL as URL, viewTitle: pathURL.lastPathComponent)
                navigationController?.pushViewController(ViewControllerFactory(rootURL: pathURL as URL, viewTitle: pathURL.lastPathComponent), animated: true)
                
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
            tableList.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    func setupTable() {
        view.addSubview(tableList)
        tableList.dataSource = self
        tableList.delegate = self
        picker.delegate = self
        NSLayoutConstraint.activate([
            tableList.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableList.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableList.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableList.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.delegate = self
        let addDirectory = UIBarButtonItem(image: UIImage(systemName: "folder.badge.plus"), style: .plain, target: self, action: #selector(createDirectory))
        let addFile = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(createFile))
        navigationItem.rightBarButtonItems = [addFile, addDirectory]
        setupTable()
        self.title = viewTitle
        currentDirectorySort()
        
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
            currentDirectorySort()
        }))
        self.present(alert, animated: true, completion: nil)
        
    }
    @objc func createFile() {
        present(picker, animated: true)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let imageURL = info[.imageURL] as! URL
        let originalImage = info[.originalImage] as! UIImage
        self.dismiss(animated: true) { [self] in
        fileManagerService.createFile(currentDirectory: rootURL, newFile: imageURL, image: originalImage)
        currentDirectorySort()
        }
        
    }
    
    func currentDirectorySort() {
        let isSorted = UserDefaults.standard.object(forKey: "sort") as? Bool ?? true
        if isSorted == true {
            files = fileManagerService.contentsOfDirectory(currentDirectory: rootURL).sorted(by: { (URL1: URL, URL2: URL) -> Bool in
                return URL1.pathComponents.last! < URL2.pathComponents.last!
            })
        } else {
            files = fileManagerService.contentsOfDirectory(currentDirectory: rootURL).sorted(by: { (URL1: URL, URL2: URL) -> Bool in
                return URL1.pathComponents.last! > URL2.pathComponents.last!
            })
        }
        tableList.reloadData()
    }
    
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        currentDirectorySort()
    }
}





