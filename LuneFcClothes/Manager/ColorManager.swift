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
    
    //Button Color
    let button_primary_blue_light = UIColor(red: 40.0 / 255.0, green: 127.0 / 255.0, blue: 255.0 / 255.0, alpha: 1)
    let button_prmary_blue_dark =  UIColor(red: 12.0 / 255.0, green: 90.0 / 255.0, blue: 204.0 / 255.0, alpha: 1)
    
    //Houses Color
    let light_blue_house = UIColor(red: 28.0 / 255.0, green: 112.0 / 255.0, blue: 188.0 / 255.0, alpha: 1)
    let dark_blue_house = UIColor(red: 40.0 / 255.0, green: 227.0 / 255.0, blue: 253.0 / 255.0, alpha: 1)
    let light_snow_house = UIColor(red: 108.0 / 255.0, green: 131.0 / 255.0, blue: 140.0 / 255.0, alpha: 1)
    let dark_snow_house = UIColor(red: 149.0 / 255.0, green: 177.0 / 255.0, blue: 160.0 / 255.0, alpha: 1)
    let light_hotel_house = UIColor(red: 119.0 / 255.0, green: 76.0 / 255.0, blue: 131.0 / 255.0, alpha: 1)
    let dark_hotel_house = UIColor(red: 177.0 / 255.0, green: 119.0 / 255.0, blue: 218.0 / 255.0, alpha: 1)
    
    //Texfield Border brackground
    let light_textfield_border = UIColor(red: 227.0 / 255.0, green: 230.0 / 255.0, blue: 245.0 / 255.0, alpha: 1)
    let dark_textfield_border = UIColor(red: 20.0 / 255.0, green: 56.0 / 255.0, blue: 109.0 / 255.0, alpha: 1)
    
    //Container Gradiente
    let violet_gradient = UIColor(red: 0.0 / 255.0, green: 147.0 / 255.0, blue: 255.0 / 255.0, alpha: 0.4)
    let blue_gradient =  UIColor(red: 26.0 / 255.0, green: 0.0 / 255.0, blue: 200.0 / 255.0, alpha: 0.4)
    
    @Theme(light: ColorManager.sharedInstance.light_neutral_1000,
           dark: ColorManager.sharedInstance.dark_neutral_1000)
    static var light_neutral_1000_dark_neutral_1000: UIColor
    
    @Theme(light: ColorManager.sharedInstance.light_neutral_50,
           dark: ColorManager.sharedInstance.dark_neutral_100)
    static var light_neutral_50_dark_neutral_100: UIColor
    
    @Theme(light: ColorManager.sharedInstance.button_primary_blue_light,
           dark: ColorManager.sharedInstance.button_prmary_blue_dark)
    static var button_primary_blue_light_button_prmary_blue_dark: UIColor
    
    @Theme(light: ColorManager.sharedInstance.light_blue_house,
           dark: ColorManager.sharedInstance.dark_blue_house)
    static var light_blue_house_dark_blue_house: UIColor
    
    @Theme(light: ColorManager.sharedInstance.light_snow_house,
           dark: ColorManager.sharedInstance.dark_snow_house)
    static var light_snow_house_dark_snow_house: UIColor
    
    @Theme(light: ColorManager.sharedInstance.light_hotel_house,
           dark: ColorManager.sharedInstance.dark_hotel_house)
    static var light_hotel_house_dark_hotel_house: UIColor
    
//    @Theme(light: ColorManager.sharedInstance.light_background,
//           dark: ColorManager.sharedInstance.dark_background)
//    static var light_background_dark_background: UIColor
//    
    @Theme(light: ColorManager.sharedInstance.light_textfield_border,
           dark: ColorManager.sharedInstance.dark_textfield_border)
    static var light_textfield_border_dark_textfield_borde
    
    @Theme(light: ColorManager.sharedInstance.light_neutral_500,
           dark: ColorManager.sharedInstance.dark_neutral_600)
    static var light_neutral_500_dark_neutral_600
    
    @Theme(light: ColorManager.sharedInstance.light_neutral_0,
           dark: ColorManager.sharedInstance.dark_neutral_1000)
    static var light_neutral_0_dark_neutral_1000
    
    @Theme(light: ColorManager.sharedInstance.violet_gradient,
           dark: ColorManager.sharedInstance.violet_gradient)
    static var dark_violet_gradient_light_violet_gradient
    
    @Theme(light: ColorManager.sharedInstance.blue_gradient,
           dark: ColorManager.sharedInstance.blue_gradient)
    static var dark_blue_gradient_light_blue_gradient
    
    static let sharedInstance = ColorManager()
}
