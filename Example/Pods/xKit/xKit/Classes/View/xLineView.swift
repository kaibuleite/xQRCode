//
//  xLineView.swift
//  Alamofire
//
//  Created by Mac on 2020/9/15.
//

import UIKit

public class xLineView: xView {
    
    // MARK: - IBInspectable Property
    /// 线条颜色
    @IBInspectable public var lineColor : UIColor = .groupTableViewBackground {
        willSet { self.backgroundColor = newValue }
    }
    /// 是否展示虚线
    @IBInspectable public var isDashLine : Bool = false
    /// 是否是垂直虚线
    @IBInspectable public var isVerticalDashLine : Bool = false
    /// 虚线绘制宽度
    @IBInspectable public var dashDrawWidth : Float = 5
    /// 虚线跳过宽度
    @IBInspectable public var dashSkipWidth : Float = 5
    
    // MARK: - Public Override Func
    public override func awakeFromNib() {
        super.awakeFromNib()
        self.clipsToBounds = true
        self.layer.masksToBounds = true
        self.isUserInteractionEnabled = false
        self.backgroundColor = self.lineColor
    }
    public override func viewDidAppear() {
        super.viewDidAppear()
        guard self.isDashLine else { return }
        self.drawDashLine()
    }
    
    // MARK: - Public Func
    /// 绘制虚线
    public func drawDashLine()
    {
        self.layer.sublayers?.forEach({
            (layer) in
            layer.removeFromSuperlayer()
        })
        self.backgroundColor = .clear
        self.layoutIfNeeded()
        let frame = self.bounds
        
        let layer = CAShapeLayer()
        layer.frame = frame
        layer.fillColor = UIColor.clear.cgColor
        layer.strokeColor = self.lineColor.cgColor
        layer.lineWidth = frame.height
        layer.lineJoin = .round
        layer.lineDashPhase = 0
        layer.lineDashPattern = [NSNumber(value: self.dashDrawWidth),
                                 NSNumber(value: self.dashSkipWidth)]
        
        let path = UIBezierPath()
        // 根据方向绘制虚线
        if self.isVerticalDashLine {
            path.move(to: CGPoint.init(x: frame.width / 2, y: 0))
            path.addLine(to: CGPoint(x: frame.width / 2, y: frame.height))
        }
        else {
            path.move(to: CGPoint.init(x: 0, y: frame.height / 2))
            path.addLine(to: CGPoint(x: frame.width, y: frame.height / 2))
        }
        layer.path = path.cgPath
        self.layer.addSublayer(layer)
    }
}
