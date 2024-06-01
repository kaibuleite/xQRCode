//
//  xNavigationView.swift
//  Alamofire
//
//  Created by Mac on 2020/9/16.
//

import UIKit
import xExtension

public class xNavigationView: xNibView {
    
    // MARK: - Handler
    /// 返回按钮点击回调
    public typealias HandkerClickBackBtn = (UIButton) -> Void
    
    // MARK: - IBInspectable Property
    /// 是否返回root（默认false）
    @IBInspectable public var isPopRootViewController : Bool = false
    /// 是否显示返回按钮
    @IBInspectable public var isShowBackBtn: Bool = true {
        willSet { self.backBtn?.isHidden = !newValue }
    }
    /// 标题
    @IBInspectable public var title : String = "" {
        willSet { self.titleLbl?.text = newValue }
    }
    /// 标题颜色
    @IBInspectable public var titleColor: UIColor = .darkText {
        willSet {
            self.titleLbl?.textColor = newValue
            self.backBtn?.tintColor = newValue
        }
    }
    /// 导航栏颜色
    @IBInspectable public var barColor : UIColor = UIColor.xNew(hex: "F7F6F6") {
        willSet { self.barColorView?.backgroundColor = newValue }
    }
    /// 分割线颜色
    @IBInspectable public var lineColor: UIColor = UIColor.lightGray {
        willSet { self.lineView?.lineColor = newValue }
    }
    
    // MARK: - IBOutlet Property
    /// 渐变背景色
    @IBOutlet public weak var barColorView: xGradientColorView?
    /// 返回按钮
    @IBOutlet weak var backBtn: UIButton?
    /// 标题标签
    @IBOutlet weak var titleLbl: UILabel?
    /// 分割线
    @IBOutlet weak var lineView: xLineView?
    
    // MARK: - Private Property
    /// 返回按钮点击回调
    var backHandler : HandkerClickBackBtn?
    
    // MARK: - 内存释放
    deinit {
        self.backHandler = nil
    }
    
    // MARK: - Public Override Func
    public override func awakeFromNib() {
        super.awakeFromNib()
        self.backBtn?.isHidden = !self.isShowBackBtn
        self.titleLbl?.text = self.title
        self.titleLbl?.textColor = self.titleColor
        self.backBtn?.tintColor = self.titleColor
        self.barColorView?.backgroundColor = self.barColor
        self.lineView?.lineColor = self.lineColor
    }
    public override func viewDidAppear() {
        super.viewDidAppear()
    }
    
    // MARK: - Public Func
    /// 添加返回按钮回调
    public func addBackBtnClick(handler : @escaping HandkerClickBackBtn)
    {
        self.backHandler = handler
    }
    
    // MARK: - IBAction Func
    /// 返回
    @IBAction func backBtnClick(_ sender: UIButton)
    {
        if let vc = self.xContainerViewController {
            vc.view.endEditing(true)
        }
        if let handler = self.backHandler {
            handler(sender)
            return
        }
        // 尝试模态退出
        guard let nvc = self.vc?.navigationController else {
            self.vc?.dismiss(animated: true, completion: nil)
            return
        }
        if self.isPopRootViewController {
            nvc.popToRootViewController(animated: true)
        } else {
            nvc.popViewController(animated: true)
        }
    }

}
