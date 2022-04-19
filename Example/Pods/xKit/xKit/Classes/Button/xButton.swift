//
//  xButton.swift
//  Pods-xSDK_Example
//
//  Created by Mac on 2020/9/14.
//

import UIKit

open class xButton: UIButton {
    
    // MARK: - IBInspectable Property
    /// 圆角
    @IBInspectable public var cornerRadius : CGFloat = 0
    /// 边框线
    @IBInspectable public var borderWidth : CGFloat = 0
    /// 边框颜色
    @IBInspectable public var borderColor : UIColor = .clear
    
    // MARK: - Open Override Func
    open override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = self.cornerRadius
        self.layer.borderWidth = self.borderWidth
        self.layer.borderColor = self.borderColor.cgColor
    }
}

