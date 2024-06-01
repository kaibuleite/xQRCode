//
//  xImageView.swift
//  Alamofire
//
//  Created by Mac on 2020/9/15.
//

import UIKit
import xExtension

open class xImageView: UIImageView {
    
    // MARK: - IBInspectable Property
    /// 边框线
    @IBInspectable public var borderWidth : CGFloat = 0 {
        willSet { self.layer.borderWidth = newValue }
    }
    /// 边框颜色
    @IBInspectable public var borderColor : UIColor = .clear {
        willSet { self.layer.borderColor = newValue.cgColor}
    }
    /// 是否为圆形图片(优先级高于圆角)
    @IBInspectable public var isCircle : Bool = false
    /// 圆角
    @IBInspectable public var cornerRadius : CGFloat = 0
    /// 左上圆角
    @IBInspectable public var tlRadius : CGFloat = 0
    /// 右上圆角
    @IBInspectable public var trRadius : CGFloat = 0
    /// 左下圆角
    @IBInspectable public var blRadius : CGFloat = 0
    /// 右下圆角
    @IBInspectable public var brRadius : CGFloat = 0
    
    // MARK: - Private Property
    /// 遮罩(考虑到性能问题，这边使用遮罩来实现圆角
    let maskLayer = CAShapeLayer()
    
    // MARK: - Open Override Func
    open override func awakeFromNib() {
        super.awakeFromNib()
        self.initCompleted()
    }
    required public init?(coder aDecoder: NSCoder) {
        // 没有指定构造器时，需要实现NSCoding的指定构造器
        super.init(coder: aDecoder)
        // 参考xView说明
        self.initCompleted()
    }
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.initCompleted()
    }
    /// 设置内容UI
    func initCompleted()
    {
        self.backgroundColor = .clear
        // 填充色
        let size = self.bounds.size
        self.image = UIColor.xNewRandom(alpha: 0.3).xToImage(size: size)
        // 边框
        if self.borderWidth > 0 {
            self.layer.borderWidth = self.borderWidth
            self.layer.borderColor = self.borderColor.cgColor
        }
        // 圆角遮罩
        self.layer.masksToBounds = true
        self.maskLayer.backgroundColor = UIColor.clear.cgColor
        self.maskLayer.fillColor = UIColor.red.cgColor
        self.maskLayer.lineWidth = 1
        self.maskLayer.lineCap = .round
        self.maskLayer.lineJoin = .round
        if self.isCircle {
            self.cornerRadius = self.bounds.width / 2
        }
        self.clip(cornerRadius: self.cornerRadius)
        
        DispatchQueue.main.async {
            self.viewDidAppear()
            guard self.cornerRadius == 0 else { return }
            self.clip(tlRadius: self.tlRadius,
                      trRadius: self.trRadius,
                      blRadius: self.blRadius,
                      brRadius: self.brRadius)
        }
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        self.maskLayer.frame = self.bounds
    }
    
    // MARK: - Open Func
    /// 视图已显示（GCD调用）
    open func viewDidAppear() {
        
    }
    
    // MARK: - Public Func
    /// 规则圆角
    public func clip(cornerRadius : CGFloat)
    {
        self.layer.mask = nil
        self.layer.cornerRadius = cornerRadius
    }
    /// 不规则圆角
    public func clip(tlRadius : CGFloat,
                     trRadius : CGFloat,
                     blRadius : CGFloat,
                     brRadius : CGFloat)
    {
        guard tlRadius >= 0, trRadius >= 0, blRadius >= 0, brRadius >= 0 else { return }
        // 声明计算参数
        self.layoutIfNeeded()
        let frame = self.bounds
        // 开始绘制
        let path = UIBezierPath.xNew(rect: frame,
                                     tlRadius: tlRadius,
                                     trRadius: trRadius,
                                     blRadius: blRadius,
                                     brRadius: brRadius)
        // 添加遮罩(限制显示区域)
        self.maskLayer.frame = frame
        self.maskLayer.path = path.cgPath
        self.layer.mask = self.maskLayer
        self.layer.cornerRadius = 0
    }
    
}
