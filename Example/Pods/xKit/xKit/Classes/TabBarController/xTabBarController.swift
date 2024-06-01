//
//  xTabBarController.swift
//  Alamofire
//
//  Created by Mac on 2020/9/15.
//

import UIKit
import xExtension

open class xTabBarController: UITabBarController {
    
    // MARK: - Public Property
    /// 用于内存释放提示(可快速定位被释放的对象)
    open var typeEmoji : String { return "🚄" }
    
    // MARK: - 内存释放
    deinit {
        let info = self.xClassInfoStruct
        let space = info.space
        let name = info.name
        print("\(self.typeEmoji)【\(space).\(name)】")
    }
    
    // MARK: - Open Override Func
    open override func viewDidLoad() {
        super.viewDidLoad()
        // 模态全屏
        self.modalPresentationStyle = .fullScreen
        // 强制白天模式
        if #available(iOS 13.0, *) {
            self.overrideUserInterfaceStyle = .light
        } else {
            // Fallback on earlier versions
        }
        // 主线程初始化UI
        DispatchQueue.main.async {
            self.addKit()
            self.addChildren()
            self.requestData()
        }
    }
    
}
