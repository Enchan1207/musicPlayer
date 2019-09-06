//
//  Player.swift
//  listPlayEx
//
//  Created by EnchantCode on 2019/09/06.
//  Copyright © 2019 EnchantCode. All rights reserved.
//

import AVFoundation

protocol  PlayerDelegate{
    func didFinishplaying(next: Music)
}

class Player: NSObject, AVAudioPlayerDelegate{
    private var audioPlayer: AVAudioPlayer! = AVAudioPlayer()
    private var prepared: Bool = false
    private var list: PlayList = PlayList()
    
    var delegate: PlayerDelegate!
    
    //--playerの準備はできているか?
    func isPrepared() -> Bool{
        return prepared
    }
    
    //--プレイリストを適用
    func setPlayList(playlist:PlayList){
        list = playlist
    }
    
    //--現在再生中のMusicインスタンスを取得
    func getCurrent() -> Music{
        return list.getCurrent()
    }
    
    //--再生するMusicインスタンスを設定してロード
    func setCurrent(music: Music) -> Bool{
        return loadFile(path: music.getPath())
    }
    
    //--ファイル読み込み
    private func loadFile(path: String) -> Bool{
        do {
            prepared = false
            audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
            audioPlayer.delegate = self
            prepared = true
            return true
        } catch {
            print("prepare error")
            return false
        }
    }
    
    //-- 再生
    func playSound() {
        if(isPrepared()) {
            audioPlayer.play()
        }else{
            print("sound preparing...");
        }
    }
    
    //-- 一時停止
    func stopSound(){
        if(isPrepared()) {
            audioPlayer.pause()
        }else{
            print("sound preparing...");
        }
    }
    
    //--次の曲
    func next(){
        list.next()
    }
    
    //--前の曲
    func previous(){
        list.previous()
    }
    
    //--再生終了時、次の曲へ自動遷移
    func audioPlayerDidFinishPlaying(_ avplayer: AVAudioPlayer, successfully flag: Bool) {
        //--再生終了時、次の曲へ自動遷移
        print("finished.play next file.")
        next()
        setCurrent(music: getCurrent())
        playSound()
        
        delegate.didFinishplaying(next: getCurrent()) //デリゲートメソッドを呼び出す
    }
}
