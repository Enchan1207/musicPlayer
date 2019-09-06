//
//  PlayList.swift
//  MusicPlayListEx
//
//  Created by EnchantCode on 2019/09/05.
//  Copyright © 2019 EnchantCode. All rights reserved.
//

import Foundation

//--プレイリスト管理クラス
class PlayList{
    private var playlist: [Music] = []
    private var current: Int = 0; //今何曲目?
    private var loop: Bool = false
    
    //--リストに追加
    //先頭に追加(次に再生)
    func addFirst(content: Music){
        playlist = [content] + playlist
    }
    //末尾に追加(初期化時)
    func addList(content: Music){
        playlist += [content]
    }
    
    //--ループモード
    func setLoopStat(stat: Bool){
        loop = stat
    }
    func getLoopStat() -> Bool{
        return loop
    }
    
    //--現在の曲のパスを返す
    func getCurrent() -> Music{
        return playlist[current]
    }
    
    //--次の曲(範囲外なら-1を返す)
    func next(){
        if(current != -1){
            current += 1
            if(current == (playlist.count)){
                //リストの最後に達した時、ループがオンなら最初に戻る　オフならnil
                if(!loop){
                    current = -1
                }else{
                    current = 0;
                }
            }
        }
    }
    
    //--前の曲(範囲外なら-1を返す)
    func previous(){
        if(current > 0){
            current -= 1
        }else if(loop){
            current = playlist.count - 1
        }else{
            current = -1
        }
    }
    
    //--next/previousで要求されたcurrentが範囲外かを返す
    func isoutofRange() -> Bool{
        return current == -1
    }
    
    //--リストをシャッフル
    func shuffle(){
        var isUsed: [Bool] = [Bool](repeating: false, count: playlist.count)
        var tmplist: [Music] = [];
        
        var index = 0;
        
        for i in 0..<(playlist.count) {
            //--一度使った文字列は使わない
            repeat{
                index = Int.random(in: 0..<(playlist.count))
            }while(isUsed[index] == true && i != 0);
            tmplist += [playlist[index]]
            isUsed[index] = true
        }
        playlist = tmplist
    }
}
