//
//  File.swift
//  DirListEx
//
//  Created by EnchantCode on 2019/09/05.
//  Copyright © 2019 EnchantCode. All rights reserved.
//

import Foundation

//--FileManagerを少し楽にする
class File{
    private var path: String
    private let manager: FileManager = FileManager.default
    private var regex: Regex = Regex()
    
    //--
    init(filepath:String){
        path = filepath
    }
    
    //--パスを取得
    func getPath() -> String{
        return path
    }
    
    //--ファイル名を取得
    func getName() -> String{
        regex.setPattern(regex: "^.*?/([^/]*)$")
        let matches = regex.matchRegex(target: path)
        if matches.count > 0 {
            return (path as NSString).substring(with: matches[0].range(at: 1))
        }
        return ""
    }
    
    //--拡張子を取得
    func getSuffix() -> String{
        regex.setPattern(regex: "^[^./]*\\.([^./]*)$")
        let matches = regex.matchRegex(target: path)
        if matches.count > 0 {
            return (path as NSString).substring(with: matches[0].range(at: 1))
        }
        return ""
    }
    
    //--存在するか
    func isExists() -> Bool{
        return manager.fileExists(atPath: path)
    }
    
    //--ディレクトリか
    func isDirectory() -> Bool{
        var isDir: ObjCBool = false
        if(manager.fileExists(atPath: path, isDirectory: &isDir)){
            if(isDir.boolValue){
                return true
            }
        }
        return false
    }
    
    //--ディレクトリ以下のリストを取得
    func listFiles() -> [File]?{
        var files: [File] = []
        guard let filelist = try? manager.contentsOfDirectory(atPath: path) else {
            return nil
        }
        filelist.forEach { (file) in
            let tmp = File(filepath: path + "/" + file)
            files += [tmp]
        }
        return files
    }
    //正規表現フィルタ付き
    func listFiles(filter: String) -> [File]?{
        let reg: Regex = Regex(initpattern: filter)
        var tmplist: [File] = []
        listFiles()?.forEach({ (file) in
            if(reg.test(target: file.getName())){
                tmplist += [file]
            }
        })
        return tmplist
    }
    
    //--ディレクトリを作成して移動
    func mkDir(maketo: String) -> Bool{
        do {
            try manager.createDirectory(atPath: path + "/" + maketo, withIntermediateDirectories: true, attributes: nil)
        } catch {
            return false
        }
        return true
    }
    
    //--指定相対パスに移動
    func chDir(goto: String){
        path = path + "/" + goto
    }
    
    //--パスが示すファイルを削除
    func remove() -> Bool{
        do {
            try manager.removeItem( atPath: path )
        } catch {
            return false
        }
        return true
    }
    
    //--親ディレクトリへ
    func parentDir() -> Bool{
        regex.setPattern(regex: "^[^./]*\\.([^./]*)$")
        let matches = regex.matchRegex(target: path)
        if matches.count > 0 {
            path = (path as NSString).substring(with: matches[0].range(at: 1))
            return true
        }
        return false
    }
}
