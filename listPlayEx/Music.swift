//
//  Music.swift
//  MusicPlayListEx
//
//  Created by EnchantCode on 2019/09/05.
//  Copyright © 2019 EnchantCode. All rights reserved.
//

import Foundation

//--音声ファイル管理クラス
class Music{
    private let title: String //曲名
    private let filepath: String //ファイル名s
    
    //--
    init(name: String, path: String){
        title = name
        filepath = path
    }
    
    //--
    func getName() -> String{
        return title
    }
    func getPath() -> String{
        return filepath
    }
    
}
