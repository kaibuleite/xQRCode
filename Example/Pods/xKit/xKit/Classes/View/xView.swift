//
//  xView.swift
//  xSDK
//
//  Created by Mac on 2020/9/17.
//

import UIKit

open class xView: UIView {
    
    // MARK: - IBInspectable Property
    /// 填充色
    @IBInspectable public var fillColor : UIColor = .clear {
        willSet { self.backgroundColor = newValue }
    }
    /// 边框线
    @IBInspectable public var borderWidth : CGFloat = 0 {
        willSet { self.layer.borderWidth = newValue }
    }
    /// 边框颜色
    @IBInspectable public var borderColor : UIColor = .clear {
        willSet { self.layer.borderColor = newValue.cgColor}
    }
    
    // MARK: - Open Override Func
    open override func awakeFromNib() {
        super.awakeFromNib()
        self.initCompleted()
    }
    required public init?(coder aDecoder: NSCoder) {
        // 没有指定构造器时，需要实现NSCoding的指定构造器
        super.init(coder: aDecoder)
        /*
         如果没有实现awakeFromNib，则会调用该方法
         如过是通过xib或storeboard实现的控件一定要用awakeFromNib
         */
        self.initCompleted()
    }
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.initCompleted()
    }
    /// 初始化完成
    func initCompleted()
    {
        self.backgroundColor = self.fillColor
        if self.borderWidth > 0 {
            self.layer.borderWidth = self.borderWidth
            self.layer.borderColor = self.borderColor.cgColor
        }
        
        DispatchQueue.main.async {
            self.viewDidAppear()
        }
    }

    // MARK: - Open Func 
    /// 视图已显示（GCD调用）
    open func viewDidAppear() {
        // 子类实现
    }
}
