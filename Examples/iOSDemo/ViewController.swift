//
//  ViewController.swift
//  iOSDemo
//
//  Created by EZen on 2021/10/24.
//

import UIKit
import DashLine

class ViewController: UIViewController {
    
    fileprivate lazy var line: DashLine = {
        let line = DashLine()
        ///  frame
        line.frame = CGRect(x: 20,
                            y: 100,
                            width: UIScreen.main.bounds.width - 40,
                            height: 4)
        line.animate = true
        line.lineWidth = 4
        line.lineDashPattern = [4, 4]
        return line
    }()
    
    fileprivate lazy var layerLine: DashLineReplicatorLayer = {
        let layer = DashLineReplicatorLayer(direction: .vertical,
                                            startPosition: CGPoint(x: 10, y: 20),
                                            count: 1000)
        return layer
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .white

        /// 设置动画
        view.addSubview(line)
        line.updateLine()
        
        // layer 虚线
        view.layer.addSublayer(layerLine)
    }
    
}

