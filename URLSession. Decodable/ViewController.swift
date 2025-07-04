//
//  ViewController.swift
//  URLSession. Decodable
//
//  Created by Авазбек Надырбек уулу on 23.06.25.
//

import UIKit

class ViewController: UIViewController {
    
    private let networkService = NetworkLayerRikiandMorty()
    private var persons = [RikandMortyModel.Character]() {
        didSet {
            DispatchQueue.main.async { [weak self] in // обновление UI на главном потоке
                self?.tableView.reloadData()
            }
        }
    }
    private lazy var tableView: UITableView = {
        $0.dataSource = self
        $0.delegate = self
        $0.backgroundColor = .white
        $0.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return $0
    }(UITableView(frame: view.frame, style: .insetGrouped))
    //
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(tableView)
        tableView.frame = view.bounds

        networkService.sendRequest { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let model):
                print("Pages:", model.info.pages)

                DispatchQueue.main.async {
                    self.persons = model.results
                }

            case .failure(let error):
                print("Error:", error)
            }
        }
        
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(persons[indexPath.row])
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        persons.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let person = persons[indexPath.row]

        var config = cell.defaultContentConfiguration()
        config.text = person.name                                // крупный текст
        config.secondaryText = "ID: \(person.id)"               // мелкий подзаголовок (пример)
        config.image = UIImage(systemName: "person.circle")     // иконка слева
        config.imageProperties.cornerRadius = 22                // скругление картинки
        config.textProperties.font = .systemFont(ofSize: 18, weight: .semibold)

        cell.contentConfiguration = config                      // применяем
        return cell
    }
}
