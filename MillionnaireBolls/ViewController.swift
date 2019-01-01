//
//  ViewController.swift
//  MillionnaireBolls
//
//  Created by wuxi on 2018/12/28.
//  Copyright © 2018 wuxi. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    @IBOutlet weak var segment: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    var manager = RandomBollsManager()
    
    ///大乐透
    var data1: [[Int]] = []
    ///双色球
    var data2: [[Int]] = []
    
    var data: [[Int]] {
        get {
            return segment.selectedSegmentIndex == 0 ? data1 : data2
        }
        set {
            if segment.selectedSegmentIndex == 0 {
                data1 = newValue
            } else {
                data2 = newValue
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = 60
    }

    @IBAction func segmentChanged(_ sender: Any) {
        manager.type = segment.selectedSegmentIndex
        data.removeAll()
        manager.setupBolls()
        tableView.reloadData()
    }
    
    @IBAction func tapReset(_ sender: Any) {
        data.removeAll()
        manager.setupBolls()
        tableView.reloadData()
    }
    
    @IBAction func tapGenerateBalls(_ sender: Any) {
        data.append(manager.generateGroup())
        tableView.reloadData()
    }
    
    @IBAction func tapLab(_ sender: Any) {
        
        let vc = LabViewController()
        present(vc, animated: true, completion: nil)
    }
    
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = BallCell()
        let model = data[indexPath.row]
        cell.bindCell(data: model, type: segment.selectedSegmentIndex)
        return cell
    }
    
//    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//        cell.transform = CGAffineTransform.init(scaleX: 0.5, y: 0.5)
//        UIView.animate(withDuration: 0.4) {
//            cell.transform = CGAffineTransform.identity
//        }
//    }
}

