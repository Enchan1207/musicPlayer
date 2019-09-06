//
//  Regex.swift
//  fetchtoFileEx
//
//  Created by EnchantCode on 2019/09/05.
//  Copyright © 2019 EnchantCode. All rights reserved.
//

import Foundation

class Regex{
    private var pattern: String = ""
    private var content: String = ""
    
    //--
    init(){}
    init(initpattern:String){
        pattern = initpattern
    }
    
    //--
    func setPattern(regex: String){
        pattern = regex
    }
    func getPattern() -> String{
        return pattern
    }
    
    //--
    func matchRegex(target: String) -> [NSTextCheckingResult]{
        content = target
        let regex = try! NSRegularExpression(pattern: pattern, options: [])
        let matches = regex.matches(in: target, options: [], range: NSMakeRange(0, target.count))
        return matches
    }
    
    //--マッチした部分を抜き出す
    func getFragment(result: [NSTextCheckingResult], index:Int) -> String{
        if result.count > 0 {
            return (content as NSString).substring(with: result[0].range(at: index))
        }
        return ""
    }
    
    //--マッチしているかどうかのみ取得
    func test(target: String) -> Bool{
        content = target
        let regex = try! NSRegularExpression(pattern: pattern, options: [])
        let matches = regex.matches(in: target, options: [], range: NSMakeRange(0, target.count))
        if(matches.count > 0){
            return true
        }
        return false
    }
}
