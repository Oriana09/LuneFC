//
//  ColorManager.swift
//  LuneFcClothes
//
//  Created by Oriana Costancio on 21/02/2024.
//

import Foundation
import UIKit

@propertyWrapper
struct Theme {
    let light: UIColor
    let dark: UIColor

    var wrappedValue: UIColor {
        return UIColor { (traitCollection: UITraitCollection) -> UIColor in

            let currentStyle = UITraitCollection.current.userInterfaceStyle
            return currentStyle == .dark ? self.dark : self.light
        }
    }
}
public final class ColorManager {
    
    // GRAY Light
    let light_neutral_0 = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1.0)
    let light_neutral_1 = UIColor(red: 254/255, green: 254/255, blue: 254/255, alpha: 1.0)
    let light_neutral_50 = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1.0)
    let light_neutral_100 = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1.0)
    let light_neutral_200 = UIColor(red: 204/255, green: 204/255, blue: 204/255, alpha: 1.0)
    let light_neutral_300 = UIColor(red: 179/255, green: 179/255, blue: 179/255, alpha: 1.0)
    let light_neutral_400 = UIColor(red: 153/255, green: 153/255, blue: 153/255, alpha: 1.0)
    let light_neutral_500 = UIColor(red: 128/255, green: 128/255, blue: 128/255, alpha: 1.0)
    let light_neutral_600 = UIColor(red: 102/255, green: 102/255, blue: 102/255, alpha: 1.0)
    let light_neutral_700 = UIColor(red: 77/255, green: 77/255, blue: 77/255, alpha: 1.0)
    let light_neutral_800 = UIColor(red: 51/255, green: 51/255, blue: 51/255, alpha: 1.0)
    let light_neutral_900 = UIColor(red: 26/255, green: 26/255, blue: 26/255, alpha: 1.0)
    let light_neutral_950 = UIColor(red: 13/255, green: 13/255, blue: 13/255, alpha: 1.0)
    let light_neutral_999 = UIColor(red: 1/255, green: 1/255, blue: 1/255, alpha: 1.0)
    let light_neutral_1000 = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1.0)

    // GRAY Dark
    let dark_neutral_0 = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1.0)
    let dark_neutral_1 = UIColor(red: 1/255, green: 1/255, blue: 1/255, alpha: 1.0)
    let dark_neutral_50 = UIColor(red: 13/255, green: 13/255, blue: 13/255, alpha: 1.0)
    let dark_neutral_100 = UIColor(red: 26/255, green: 26/255, blue: 26/255, alpha: 1.0)
    let dark_neutral_200 = UIColor(red: 51/255, green: 51/255, blue: 51/255, alpha: 1.0)
    let dark_neutral_300 = UIColor(red: 77/255, green: 77/255, blue: 77/255, alpha: 1.0)
    let dark_neutral_400 = UIColor(red: 102/255, green: 102/255, blue: 102/255, alpha: 1.0)
    let dark_neutral_500 = UIColor(red: 128/255, green: 128/255, blue: 128/255, alpha: 1.0)
    let dark_neutral_600 = UIColor(red: 153/255, green: 153/255, blue: 153/255, alpha: 1.0)
    let dark_neutral_700 = UIColor(red: 179/255, green: 179/255, blue: 179/255, alpha: 1.0)
    let dark_neutral_800 = UIColor(red: 204/255, green: 204/255, blue: 204/255, alpha: 1.0)
    let dark_neutral_900 = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1.0)
    let dark_neutral_950 = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1.0)
    let dark_neutral_999 = UIColor(red: 254/255, green: 254/255, blue: 254/255, alpha: 1.0)
    let dark_neutral_1000 = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1.0)
    
    
    @Theme(light: ColorManager.sharedInstance.light_neutral_1000,
           dark: ColorManager.sharedInstance.dark_neutral_1000)
    static var light_neutral_1000_dark_neutral_1000: UIColor
    
    
    static let sharedInstance = ColorManager()
}
