//
//  xContainerView.swift
//  xSDK
//
//  Created by Mac on 2020/9/16.
//

import UIKit

public class xContainerView: xView {
    
    // MARK: - IBInspectable Property
    /// 填充色
    @IBInspectable open var fillColor : UIColor = .clear {
        willSet { self.backgroundColor = newValue }
    }
    
    // MARK: - Public Override Func
    public override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = self.fillColor
    }
}
