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
    @IBOutlet weak var playButton: UIButton!
    
    
    //--
    let player:Player = Player()

    override func viewDidLoad() {
        super.viewDidLoad()
        player.delegate = self
        
        //--プレイリストを作成
        let playlist: PlayList = PlayList()
        playlist.setLoopStat(stat: false)
        
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
        playlist.shuffle()
        player.setPlayList(playlist: playlist)
        player.setCurrent(music: player.getCurrent())
        while(!player.isPrepared()){
            print("ファイルの再生を準備しています…")
        }
        self.currentLabel.text = player.getCurrent().getName()
        player.play()
    }
    
    func didFinishplaying(next: Music) {
        self.currentLabel.text = player.getCurrent().getName()
    }
    
    @IBAction func onTapPlay(_ sender: Any) {
        if(player.isPlaying()){
            player.pause()
            self.playButton.setTitle("Play", for: .normal)
        }else{
            player.play()
            self.playButton.setTitle("Pause", for: .normal)
        }
    }
    
    @IBAction func onTapNext(_ sender: Any) {
        player.next()
    }
    @IBAction func onTapPrevious(_ sender: Any) {
        player.previous()
    }
    
}
