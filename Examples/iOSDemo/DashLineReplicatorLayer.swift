//
//  DashLineReplicatorLayer.swift
//
//
//  Created by EZen on 2022/02/18.
//
//  Copyright (c) 2021 EZen <shenyanjie123@foxmail.com>
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

import Foundation
import QuartzCore
import UIKit

public enum Direction {
    case horizontal
    case vertical
}

open class DashLineReplicatorLayer: CAReplicatorLayer {
    
    private(set) var direction: Direction = .horizontal
    private(set) var horizontalSize: CGFloat = 2
    private(set) var verticalSize: CGFloat = 2
    private(set) var lineColor: UIColor = .black
    private(set) var startPosition: CGPoint = .zero
    private(set) var count: Int = 0
    
    public init(direction: Direction = .horizontal,
                horizontalSize: CGFloat = 2,
                verticalSize: CGFloat = 2,
                lineColor: UIColor = .black,
                startPosition: CGPoint = .zero,
                count: Int = 0) {
        super.init()
        self.direction = direction
        self.horizontalSize = horizontalSize
        self.verticalSize = verticalSize
        self.lineColor = lineColor
        self.startPosition = startPosition
        self.count = count
        _setupSublayers()
    }
    
    private override init() {
        super.init()
        _setupSublayers()
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        _setupSublayers()
    }
}

fileprivate extension DashLineReplicatorLayer {
    
    func _setupSublayers() {
        
        position = .zero
        let subLayer = CALayer()
        subLayer.bounds = CGRect(x: 0, y: 0, width: horizontalSize, height: verticalSize)
        subLayer.backgroundColor = lineColor.cgColor
        subLayer.position = startPosition
        switch direction {
        case .horizontal:
            instanceTransform = CATransform3DMakeTranslation(horizontalSize * 1.5, 0, 0)
        case .vertical:
            instanceTransform = CATransform3DMakeTranslation(0, verticalSize * 1.5, 0)
        }
        instanceCount = count
        addSublayer(subLayer)
    }
}
