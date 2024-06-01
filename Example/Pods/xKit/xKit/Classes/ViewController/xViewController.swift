//
//  xViewController.swift
//  Pods-xSDK_Example
//
//  Created by Mac on 2020/9/15.
//

import UIKit
import xExtension

open class xViewController: UIViewController {
    
    // MARK: - IBOutlet Property
    /// 自定义导航栏
    @IBOutlet open weak var topNaviBar: xNavigationView?
    /// 安全区域
    @IBOutlet open weak var safeView: xSafeView?
    /// 子控制器容器
    @IBOutlet open weak var childContainer: xContainerView?
    
    // MARK: - Override Property
    open override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
    
    // MARK: - Public Property
    /// 用于内存释放提示(可快速定位被释放的对象)
    open var typeEmoji : String { return "♻️" }
    /// 是否显示中
    public var isAppear = false
    /// 是否完成数据加载(默认已完成)
    public var isRequestDataCompleted = true
    /// 子控制器Key
    public var childViewControllerKeys = [String]()
    
    // MARK: - 内存释放
    deinit {
        let info = self.xClassInfoStruct
        let space = info.space
        let name = info.name
        print("\(self.typeEmoji)【\(space).\(name)】")
    }
    
    // MARK: - Open Override Func
    open override class func xDefaultViewController() -> Self {
        let vc = self.xNewStoryboard()
        return vc
    }
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
        // 子控制器的Key
        self.childViewControllerKeys = ["Child", "child"]
        // 主线程初始化UI
        DispatchQueue.main.async {
            self.addKit()
            self.addChildren()
            self.requestData()
        }
    }
    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.requestDataWhenViewWillAppear()
    }
    open override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.requestDataWhenViewDidAppear()
        self.isAppear = true
    }
    open override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.requestDataWhenViewWillDisappear()
    }
    open override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.requestDataWhenViewDidDisappear()
        self.isAppear = false
    }
    open override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        guard let ident = segue.identifier else { return }
        for key in self.childViewControllerKeys {
            guard key == ident else { continue }
            self.addChild(segue.destination)   // 绑定父控制器
            break
        }
    }
    
}
