//
//  xTwoSideImageView.swift
//  xSDK
//
//  Created by Mac on 2020/12/1.
//

import UIKit

public class xTwoSideImageView: xView {

    // MARK: - Enum
    /// 面向枚举
    public enum SideEnum {
        /// 正面
        case front
        /// 背面
        case back
    }
    
    // MARK: - Public Property
    /// 当前朝向
    public var currentSide = SideEnum.front
    
    // MARK: - Private Property
    /// 正面图
    let frontIcon = UIImageView()
    /// 背面图
    let backIcon = UIImageView()
    /// 是否正在翻转中
    var isFlipping = false
    
    // MARK: - Public Override Func
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.addSubview(self.frontIcon)
        self.addSubview(self.backIcon)
    }
    public override func viewDidAppear() {
        super.viewDidAppear()
        let frame = self.bounds
        self.frontIcon.frame = frame
        self.backIcon.frame = frame
    }
    
    // MARK: - Public Func
    /// 设置图片
    /// - Parameters:
    ///   - frontImage: 正面图片
    ///   - backImage: 反面图片
    ///   - side: 朝向
    public func set(frontImage : UIImage?,
                    backImage : UIImage?,
                    side : SideEnum = .front)
    {
        self.frontIcon.image = frontImage
        self.backIcon.image = backImage
        switch side {
        case .front:
            self.frontIcon.isHidden = false
            self.backIcon.isHidden = true
        case .back:
            self.frontIcon.isHidden = true
            self.backIcon.isHidden = false
        }
    }
    
    /// 翻转图片
    /// - Parameters:
    ///   - duration: 动画时长
    public func flip(duration : TimeInterval = 0.5)
    {
        switch self.currentSide {
        case .front:    self.flip(to: .back, duration: duration)
        case .back:     self.flip(to: .front, duration: duration)
        }
    }
    
    /// 翻转图片
    /// - Parameters:
    ///   - side: 朝向
    ///   - duration: 动画时长
    public func flip(to side : SideEnum,
                     duration : TimeInterval = 0.5)
    {
        guard self.isFlipping == false else { return }
        guard self.currentSide != side else { return }
        
        self.isFlipping = true
        self.currentSide = side
        
        UIView.animate(withDuration: duration) {
            self.layer.transform = CATransform3DMakeRotation(CGFloat.pi / 2, 0, 1, 0)
        } completion: {
            (finish) in
            switch side {
            case .front:
                self.frontIcon.isHidden = false
                self.backIcon.isHidden = true
            case .back:
                self.frontIcon.isHidden = true
                self.backIcon.isHidden = false
            }
            UIView.animate(withDuration: duration) {
                self.layer.transform = CATransform3DMakeRotation(CGFloat.pi, 0, 1, 0)
            } completion: {
                (finish) in
                self.isFlipping = false
            }
        }
    }
    
    // MARK: - Private Func
}
