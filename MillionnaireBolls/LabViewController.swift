//
//  LabViewController.swift
//  MillionnaireBolls
//
//  Created by wuxi on 2018/12/30.
//  Copyright © 2018 wuxi. All rights reserved.
//

import UIKit

class LabViewController: UIViewController {

    
    @IBOutlet weak var segment: UISegmentedControl!
    
    @IBOutlet weak var contentLb: UILabel!
    
    @IBOutlet weak var timesStrLb: UILabel!
    @IBOutlet weak var timesTf: UITextField!
    var manager = RandomBollsManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }


    @IBAction func segmentChanged(_ sender: Any) {
        manager.type = segment.selectedSegmentIndex
    }
    
    @IBAction func startPlay(_ sender: Any) {
        contentLb.text = "正在模拟中..."
        if timesTf.text?.count ?? 0 == 0 {
            return
        }
        guard let times = Int(timesTf.text!) else {
            return
        }
        manager.startLab(times: times) { [weak self] (t, resultStr) in
            let timestr = "正在模拟第\(t)次实验"
            self?.timesStrLb.text = timestr
            if resultStr != nil {
                self?.contentLb.text = resultStr
            }
        }
    }
    
    @IBAction func back(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

    
}
