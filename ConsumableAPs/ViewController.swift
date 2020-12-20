//
//  ViewController.swift
//  ConsumableAPs
//
//  Created by Ngo Dang tan on 20/12/2020.
//

import UIKit

class ViewController: UIViewController {

    private let tableView: UITableView = {
       let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()
    private var models = [Model]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        models.append(Model(title: "500 Dimonds", handler: {
            IAPManager.shared.purchase(product: .diamond_500, completion: { [weak self] count in
                DispatchQueue.main.async {
                    let currentCount = self?.myDiamondsCount ?? 0
                    let newCount = currentCount + count
                    UserDefaults.standard.setValue(newCount, forKey: "diamond_count")
                    self?.setupHeaders()
                }
                
                
            })
        }))
        models.append(Model(title: "1000 Dimonds", handler: {
            IAPManager.shared.purchase(product: .diamond_1000,completion: { [weak self] count in
                DispatchQueue.main.async {
                    let currentCount = self?.myDiamondsCount ?? 0
                    let newCount = currentCount + count
                    UserDefaults.standard.setValue(newCount, forKey: "diamond_count")
                    self?.setupHeaders()
                }
                
            })
        }))
        models.append(Model(title: "2500 Dimonds", handler: {
            IAPManager.shared.purchase(product: .diamond_2500,completion: { [weak self] count in
                DispatchQueue.main.async {
                    let currentCount = self?.myDiamondsCount ?? 0
                    let newCount = currentCount + count
                    UserDefaults.standard.setValue(newCount, forKey: "diamond_count")
                    self?.setupHeaders()
                }
                
            })
        }))
        models.append(Model(title: "5000 Dimonds", handler: {
            IAPManager.shared.purchase(product: .diamond_5000,completion: { [weak self] count in
                DispatchQueue.main.async {
                    let currentCount = self?.myDiamondsCount ?? 0
                    let newCount = currentCount + count
                    UserDefaults.standard.setValue(newCount, forKey: "diamond_count")
                    self?.setupHeaders()
                }
                
            })
        }))
        
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.frame = view.bounds
        setupHeaders()
    }


}

extension ViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = models[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = model.title
        cell.imageView?.image = UIImage(systemName: "suit.diamond.fill")
        cell.imageView?.tintColor = .systemBlue
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let model = models[indexPath.row]
        model.handler()
    }
    
    var myDiamondsCount: Int{
        return UserDefaults.standard.integer(forKey: "diamond_count")
    }
    
    func setupHeaders(){
        let header = UIView(frame: CGRect(x: 0, y: 0,
                                          width: view.frame.size.width,
                                          height: view.frame.size.width))
        let imageView = UIImageView(image: UIImage(systemName: "suit.diamond.fill"))
        imageView.frame = CGRect(x: (view.frame.size.width - 100)/2,
                                 y: 10, width: 100, height: 100)
        imageView.tintColor = .systemBlue
        header.addSubview(imageView)
        let label = UILabel(frame: CGRect(x: 10, y: 120, width: view.frame.size.width-20, height: 100))
        header.addSubview(label)
        label.font = .systemFont(ofSize: 25, weight:.bold)
        label.textAlignment = .center
        label.text = "\(myDiamondsCount) Diamonds"
        tableView.tableHeaderView = header
    }
}

