//
//  SFFit.swift
//  SwiftyFileBrowser
//
//  Created by Hansen on 2021/12/6.
//

import Foundation
import UIKit

/// 尺寸适配相关
public class SFFit {
    
    /// 屏幕宽度
    public static let width = UIScreen.main.bounds.width
    
    /// 屏幕高度
    public static let height = UIScreen.main.bounds.height
    
    /// 是否是iPhone
    public static let isiPhone = UIDevice.current.userInterfaceIdiom == .phone
    
    /// 是否是竖屏
//    public static let isPortrait = UIApplication.shared.statusBarOrientation == .portrait || UIApplication.shared.statusBarOrientation == .portraitUpsideDown
    public static let isPortrait = UIApplication.shared.windows.first?.windowScene?.interfaceOrientation.isPortrait ?? false
    
    /// 判断设备是不是异形屏
    public class var isHetero : Bool {
        return self.isiPhone && self.height >= 812.0
    }
    
    /// TabBar距底部区域高度
    public class var tabSafeBottom: CGFloat {
        return isHetero ? 34.0 : 0.0
    }
    
    /// navBar距顶部区域安全高度
    public class var navBarSafeHeight: CGFloat {
        return isHetero ? 24.0 : 0.0
    }
    
    /// 状态栏的高度
    public class var statusBarHeight : CGFloat {
        return isHetero ? 44.0 : 20.0
    }
    
    /// 导航栏的高度
    public class var navBarHeight: CGFloat {
        return 44.0
    }
    
    /// 导航栏和状态栏的总高度
    public class var navWithStatusBarHeight : CGFloat {
        return isHetero ? 88.0 : 64.0
    }
    
    /// 标签栏高度
    public class var tabBarHeight: CGFloat {
        return 49.0
    }
    /// 标签栏和安全高度总高度
    public class var tabWithSafeBottomHeight: CGFloat {
        return isHetero ? 83.0 : 49.0
    }
    
    /// 按宽度适配
    /// - Parameter width: 需要适配的宽度
    /// - Returns: 适配后的宽度
    public class func scaleWidth(_ width: CGFloat) -> CGFloat {
        return (self.width / 375.0) * width
    }
    
    /// 按高度适配
    /// - Parameter height: 需要适配的高度
    /// - Returns: 适配后的高度
    public class func scaleHeight(_ height: CGFloat) -> CGFloat {
        return (self.height / 667.0) * height
    }
    
    /// 适配
    /// - Parameter value: 需要适配的值
    /// - Returns: 适配后的值
    public class func scale(_ value: CGFloat) -> CGFloat {
        return scaleWidth(value)
    }
}

// MARK: - 对常用数字扩展适配属性
public extension CGFloat {
    var scale: CGFloat {
        return SFFit.scale(self)
    }
}

public extension Int {
    var scale: CGFloat {
        return SFFit.scale(CGFloat(self))
    }
}

public extension Double {
    var scale: CGFloat {
        return SFFit.scale(CGFloat(self))
    }
}

public extension Float {
    var scale: CGFloat {
        return SFFit.scale(CGFloat(self))
    }
}
