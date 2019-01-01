//
//  BallCell.swift
//  MillionnaireBolls
//
//  Created by wuxi on 2018/12/30.
//  Copyright © 2018 wuxi. All rights reserved.
//

import UIKit

class BallCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func bindCell(data: [Int], type: Int) {
        self.selectionStyle = .none
        var separLine = type == 0 ? 5 : 6
        let l: CGFloat = 20
        let len: CGFloat = 36
        for (i, value) in data.enumerated() {
            let x = l + CGFloat(i) * (len + 10)
            let y: CGFloat = 8
            let lb = UILabel(frame: CGRect(x: x, y: y, width: len, height: len))
            lb.font = UIFont.systemFont(ofSize: 15, weight: UIFont.Weight.medium)
            lb.textColor = .white
            lb.layer.cornerRadius = len / 2
            lb.clipsToBounds = true
            lb.textAlignment = .center
            if i < separLine {
                lb.backgroundColor = UIColor.red
            } else {
                lb.backgroundColor = UIColor(displayP3Red: 30/2550, green: 144/255.0, blue: 255/255.0, alpha: 0.8)
            }
            lb.text = "\(value)"
            let dot = UIView(frame: CGRect(x: len - 10.0, y: 10, width: 4, height: 4))
            dot.layer.cornerRadius = 2
            dot.clipsToBounds = true
            dot.backgroundColor = UIColor.white
            lb.addSubview(dot)
            self.addSubview(lb)
        }
    }

}
