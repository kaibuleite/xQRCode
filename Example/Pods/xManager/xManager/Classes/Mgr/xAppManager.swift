//
//  xAppManager.swift
//  Pods-xSDK_Example
//
//  Created by Mac on 2020/9/14.
//

import UIKit
import xExtension

public class xAppManager: NSObject {

    // MARK: - Enum
    /// App运行模式
    public enum AppRunMode {
        case debug
        case release
    }
    
    // MARK: - 应用配置
    /// 运行环境
    //public let xAppRunMode = AppRunMode.debug
    public static var runMode = xAppManager.AppRunMode.release
    
    // MARK: - 常用参数
    /// 主题色
    public static var themeColor = UIColor.xNew(hex: "#487FFC")
    /// TableView背景色
    public static var tableViewBackgroundColor = UIColor.groupTableViewBackground
    /// 导航栏背景色
    public static var navigationBarColor = UIColor.xNew(hex: "F7F6F6")
    /// 导航栏背阴影线条景色
    public static var navigationBarShadowColor = UIColor.lightGray
    /// 占位色
    public static var placeholderColor = UIColor.xNew(hex: "F5F5F5")
    /// 占位图_默认
    public static var placeholderImage = UIColor.xNew(hex: "F5F5F5").xToImage(size: .init(width: 5, height: 5))
    /// 占位图_头像
    public static var placeholderImage_avatar = UIColor.xNew(hex: "F5F5F5").xToImage(size: .init(width: 5, height: 5))
    /// 占位图_横幅
    public static var placeholderImage_banner = UIColor.xNew(hex: "F5F5F5").xToImage(size: .init(width: 5, height: 5))
    
    // MARK: - 应用信息
    /// 名称
    public static var appBundleName : String {
        let name = Bundle.main.object(forInfoDictionaryKey: "CFBundleName")
        let ret = name as? String ?? ""
        return ret
    }
    /// ID
    public static var appBundleID : String {
        let name = Bundle.main.object(forInfoDictionaryKey: "CFBundleIdentifier")
        let ret = name as? String ?? ""
        return ret
    }
    /// 版本号
    public static var appVersion : String {
        let name = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString")
        let ret = name as? String ?? ""
        return ret
    }
    /// 编译信息
    public static var appBuildVersion : String {
        let name = Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion")
        let ret = name as? String ?? ""
        return ret
    }
    
}
