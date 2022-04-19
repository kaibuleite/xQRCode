//
//  xCountDownButton.swift
//  Pods-xSDK_Example
//
//  Created by Mac on 2020/9/14.
//

import UIKit

open class xCountDownButton: xButton {
    
    // MARK: - IBInspectable Property
    /// 默认标题
    @IBInspectable public var defaultTitle : String = "获取验证码"
    /// 普通时标题颜色
    @IBInspectable public var titleNormalColor : UIColor = .darkText
    /// 倒计时标题颜色
    @IBInspectable public var titleCountdownColor : UIColor = .lightGray
    /// 普通时背景颜色
    @IBInspectable public var backgroundNormalColor : UIColor = .darkText
    /// 倒计时背景颜色
    @IBInspectable public var backgroundCountdownColor : UIColor = .lightGray
    
    /// 倒计时边框颜色
    @IBInspectable public var borderCountdownColor : UIColor = .lightGray
    
    // MARK: - Private Property
    /// 总时长(默认60s)
    private var duration = Int(60)
    /// 定时器
    private var timer : Timer?
    
    // MARK: - 内存释放
    deinit {
        self.closeTimer()
    }
    
    // MARK: - Open Override Func
    open override func awakeFromNib() {
        super.awakeFromNib()
        self.tag = 0
        self.setTitle(" \(self.defaultTitle) ", for: .normal)
        self.setTitleColor(titleNormalColor, for: .normal)
        self.backgroundColor = self.backgroundNormalColor
        self.layer.borderWidth = self.borderWidth
        self.layer.borderColor = self.borderColor.cgColor
    }
    
    // MARK: - Public Func
    /// 开始倒计时
    /// - Parameters:
    ///   - totalTime: 倒计时时间(默认60s)
    public func startCountDown(duration : Int = 60)
    {
        self.duration = duration
        self.openTimer()
    }
    
    // MARK: - Private Func
    /// 开启定时器
    private func openTimer()
    {
        self.closeTimer()
        self.tag = self.duration
        self.setTitle(" \(self.tag)s ",
                      for: .normal)
        self.setTitleColor(self.titleCountdownColor,
                           for: .normal)
        self.backgroundColor = self.backgroundCountdownColor
        if self.borderWidth > 0 {
            self.layer.borderColor = self.borderCountdownColor.cgColor
        }
        self.isUserInteractionEnabled = false
        
        let timer = Timer.xNew(timeInterval: 1, repeats: true) {
            [weak self] (timer) in
            guard let self = self else { return }
            self.tag -= 1
            self.setTitle(" \(self.tag)s ",
                          for: .normal)
            guard self.tag <= 0 else { return }
            self.closeTimer()
            self.setTitle("\(self.defaultTitle) ",
                          for: .normal)
            self.setTitleColor(self.titleNormalColor,
                               for: .normal)
            self.backgroundColor = self.backgroundNormalColor
            if self.borderWidth > 0 {
                self.layer.borderColor = self.borderColor.cgColor
            }
            self.isUserInteractionEnabled = true
        }
        RunLoop.main.add(timer,
                         forMode: .common)
        self.timer = timer
    }
    /// 关闭定时器
    private func closeTimer()
    {
        self.timer?.invalidate()
        self.timer = nil
    }
}
