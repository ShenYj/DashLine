//
//  DashLine.swift
//
//
//  Created by ShenYj on 2021/10/24.
//
//  Copyright (c) 2021 ShenYj <shenyanjie123@foxmail.com>
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

import UIKit
import Foundation

open class DashLine: UIView {
    
    /// 是否需要动画
    public var animate: Bool = false
    /// 虚线颜色
    public var color: UIColor = UIColor.gray
    /// 虚线宽
    public var lineWidth: CGFloat = 1
    /// 虚线效果
    public var lineDashPattern: [NSNumber] = [2, 2]
    
    fileprivate lazy var shapeLayer = CAShapeLayer()
    
    public override var frame: CGRect {
        didSet {
            guard oldValue != frame else { return }
            bounds = CGRect(x: 0, y: 0, width: frame.width, height: frame.height)
            _update()
        }
    }
    public override var bounds: CGRect {
        didSet {
            guard oldValue != bounds else { return }
            _update()
        }
    }
    
    required public init() {
        super.init(frame: .zero)
        _setupUI()
    }
    
    required public init?(coder: NSCoder) {
        super.init(frame: .zero)
        _setupUI()
    }
}


public extension DashLine {
    
    /// 修改属性后更新
    func updateLine() { _update() }
}


fileprivate extension DashLine {
    
    func _setupUI() {
        _setupProperties()
        layer.addSublayer(shapeLayer)
    }
    
    func _update() {
        _setupProperties()
        _updatePath()
        if animate { _animate() }
        setNeedsDisplay()
    }
    
    // MARK: -
    
    func _setupProperties() {
        shapeLayer.strokeColor = color.cgColor
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.lineWidth = lineWidth
        shapeLayer.lineDashPattern = lineDashPattern
    }
    func _updatePath() {
        let path = CGMutablePath()
        path.addLines(between: [CGPoint.zero, CGPoint(x: bounds.width, y: 0)])
        shapeLayer.path = path
    }
    func _animate() {
        let lineDashAnimation = CABasicAnimation(keyPath: "lineDashPhase")
        lineDashAnimation.fromValue = 0
        lineDashAnimation.toValue = shapeLayer.lineDashPattern?.reduce(0) { $0 + $1.intValue }
        lineDashAnimation.duration = 1
        lineDashAnimation.repeatCount = Float.greatestFiniteMagnitude
        shapeLayer.add(lineDashAnimation, forKey: nil)
    }
}
