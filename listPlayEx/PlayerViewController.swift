//
//  PlayerViewController.swift
//  listPlayEx
//
//  Created by EnchantCode on 2019/09/06.
//  Copyright © 2019 EnchantCode. All rights reserved.
//

//プレイリストから再生してみるよ

import UIKit
import AVFoundation

class PlayerViewController: UIViewController,PlayerDelegate{
    
    //--
    @IBOutlet weak var currentLabel: UILabel!
    
    
    //--
    let player:Player = Player()

    override func viewDidLoad() {
        super.viewDidLoad()
        player.delegate = self
        
        //--プレイリストを作成
        let playlist: PlayList = PlayList()
        playlist.setLoopStat(stat: true)
        
        //--バンドルされたファイルを取得(bundlePathはどこを指してるんだろう?)
        let bundle: File = File(filepath: Bundle.main.bundlePath)
        let filelist: [File]? = bundle.listFiles(filter: "(wav|mp3|aif|m4a)$")
        if(filelist == nil){
            print("music file not found")
            return
        }
        print("\(filelist!.count) file found");
        
        //--ファイルリストからMusicクラスのインスタンスを生成し、プレイリストに追加
        filelist!.forEach { (file) in
            let music: Music = Music(name: file.getName(), path: file.getPath())
            playlist.addList(content: music)
        }
        
        //--完成したプレイリストをPlayerに渡して再生開始
//        playlist.shuffle()
        player.setPlayList(playlist: playlist)
        player.setCurrent(music: player.getCurrent())
        while(!player.isPrepared()){
            print("preparing file...")
        }
        self.currentLabel.text = player.getCurrent().getName()
        player.playSound()
        
    }
    
    func didFinishplaying(next: Music) {
        self.currentLabel.text = player.getCurrent().getName()
    }
}
