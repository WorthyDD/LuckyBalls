//
//  RandomBollsManager.swift
//  MillionnaireBolls
//
//  Created by wuxi on 2018/12/28.
//  Copyright © 2018 wuxi. All rights reserved.
//

import UIKit

/// 随机球
class RandomBollsManager: NSObject {

    var redBolls: [Int] = []
    var blueBolls: [Int] = []
    /// 0 - 大乐透  1 - 双色球
    var type: Int = 0
    var redBallsCount: Int {
        get {
            return type == 0 ? 35 : 33
        }
    }
    var blueBallsCount: Int {
        get {
            return type == 0 ? 12 : 16
        }
    }
    var redBallLimit: Int {
        get {
            return type == 0 ? 5 : 6
        }
    }
    var blueBallLimit: Int {
        get {
            return type == 0 ? 2 : 1
        }
    }

    override init() {
        super.init()
        setupBolls()
    }
    
    ///初始化球
    func setupBolls() {
        blueBolls.removeAll()
        redBolls.removeAll()
        for i in 1...redBallsCount {
            redBolls.append(i)
        }
        for i in 1...blueBallsCount {
            blueBolls.append(i)
        }
    }
    
    ///生成一组彩票 5+2 | 6+1
    func generateGroup() -> [Int] {
        if redBolls.count < redBallLimit || blueBolls.count < blueBallLimit {
            return []
        }
        var results: [Int] = []
        var r1: [Int] = []
        var r2: [Int] = []
        for _ in 0..<redBallLimit {
            let n = Int(arc4random()) % redBolls.count
            r1.append(redBolls[n])
            redBolls.remove(at: n)
        }
        results.append(contentsOf: r1.sorted())
        for _ in 0..<blueBallLimit {
            let n = Int(arc4random()) % blueBolls.count
            r2.append(blueBolls[n])
            blueBolls.remove(at: n)
        }
        results.append(contentsOf: r2.sorted())
        return results
    }
    
    
    ///模拟中奖模式
    ///
    /// - Parameters:
    ///   - times: 总次数
    ///   - shotDown: 次数 中奖结果
    func startLab(times: Int, shotDown: ((Int, String?) -> Void)?) {
        setupBolls()
        let bingoBalls = generateGroup()
        var i = 0
        // 等级: (次数, 最近第几次)
        var resultDic: [Int: (Int, Int)] = [:]
        while i < times {
            setupBolls()
            let n = generateGroup()
            let result = compareAward(data1: bingoBalls, data2: n)
            print(">>>>>>\(result)")
            if result > 0 {
                if let m = resultDic[result] {
                    resultDic[result] = (m.0 + 1, i)
                } else {
                    resultDic[result] = (1, i)
                }
                //转换字符串
                let str = transToStr(resultDic: resultDic)
                shotDown?(i, str)
            }
            i = i + 1
            shotDown?(i, nil)
        }
    }
    
    ///计算中奖否? 0-未中 1 一等奖
    func compareAward(data1: [Int], data2: [Int]) -> Int {
        var reds = 0
        var blues = 0
        for (i, v) in data2.enumerated() {
            if i < redBallLimit {
                if data1[0..<redBallLimit].contains(v) {
                    reds = reds + 1
                }
            } else {
                if data1[redBallLimit..<data1.count].contains(v) {
                    blues = blues + 1
                }
            }
        }
        if type == 0 {
            //比较结果
            if reds == redBallLimit && blues == blueBallLimit {
                return 1
            } else if reds == redBallLimit && blues == 1 {
                return 2
            } else if (reds == redBallLimit) || (reds == 4 && blues == 2) {
                return 3
            } else if (reds == 4 && blues == 1) || (reds == 3 && blues == 2) {
                return 4
            } else if (reds == 4 && blues == 0) || (reds == 3 && blues == 1) || (reds == 2 && blues == 2) {
                return 5
            } else if (reds == 1 && blues == 2) || (reds == 2 && blues == 1) || (reds == 0 && blues == 2) {
                return 6
            }
            return 0
        } else {
            //双色球
            //比较结果
            if reds == redBallLimit && blues == blueBallLimit {
                return 1
            } else if reds == redBallLimit {
                return 2
            } else if (reds == 5 && blues == 1) {
                return 3
            } else if (reds == 5 && blues == 0) || (reds == 4 && blues == 1) {
                return 4
            } else if (reds == 4 && blues == 0) || (reds == 3 && blues == 1) {
                return 5
            } else if blues == 1 {
                return 6
            }
            return 0
        }
    }
    
    func transToStr(resultDic: [Int: (Int, Int)]) -> String {
        var r = ""
        for (_, v) in resultDic.enumerated() {
            r = "\(r)\n第\(v.value.1)次: \(v.key)等奖: 中奖\(v.value.0)次\n"
        }
        return r
    }
}
