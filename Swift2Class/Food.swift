//
//  Food.swift
//  Swift2Class
//
//  Created by mac on 16/10/28.
//  Copyright © 2016年 team. All rights reserved.
//

import Foundation
import UIKit

class Food: NSObject, NSCoding {
    var foodImg: UIImage?
    var foodName: String
    var foodDetail: String?
    var foodStar: String?
    
    // 获取Document的url，最后为url格式
    static let urls = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let url = urls.appendingPathComponent("data.plist")
    
    // 获取Document的url，最后为string格式
    static let paths = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)).first! as String
    static let path = paths.appending("/photoData.plist")

    init(name foodName: String, detail foodDetail: String?, star foodStar: String?, photo foodImage: UIImage?) {
        self.foodName = foodName
        self.foodDetail = foodDetail
        self.foodStar = foodStar
        self.foodImg = foodImage
    }
    
    required init(coder aDecoder: NSCoder) {
        self.foodName = aDecoder.decodeObject(forKey: "foodName") as! String
        self.foodDetail = aDecoder.decodeObject(forKey: "foodDetail") as! String?
        self.foodStar = aDecoder.decodeObject(forKey: "foodStar") as! String?
        self.foodImg = aDecoder.decodeObject(forKey: "foodImage") as! UIImage?
        super.init()
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.foodName, forKey: "foodName")
        aCoder.encode(self.foodDetail, forKey: "foodDetail")
        aCoder.encode(self.foodStar, forKey: "foodStar")
        aCoder.encode(self.foodImg, forKey: "foodImage")
    }
}
