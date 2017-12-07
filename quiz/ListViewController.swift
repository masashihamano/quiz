//
//  ListViewController.swift
//  quiz
//
//  Created by 濱野将士 on 2017/11/17.
//  Copyright © 2017年 Masashi Hamano. All rights reserved.
//

import UIKit
import AVFoundation

//プロトコルの設定
class ListViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {

    
    //プロパティリストから読み込んだデータを格納する配列
    var GodList:[NSDictionary] = []
     //選択されたエリア名を保存するメンバ変数
    var godName = ""
    
    //前の画面から受け取るためのプロパティ
    var getlistname = ""
    
    //タップ音の変数
    var cellAudioPlayer: AVAudioPlayer! = nil
    
    
    @IBOutlet weak var listTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //セルをタップした時の音
        cellSound()
        
        //ファイルパスを取得(エリア名が格納されているプロパティリスト)
        let filePath = Bundle.main.path(forResource:"GodList", ofType:"plist")
        // プロパティリストからデータを取得（Dictionary型）
        let dic = NSDictionary(contentsOfFile: filePath!)
        // TableViewで扱いやすい配列（エリア名の入ってる配列）を作成
        for(key,data) in dic!{
            print(data)
            print(key)
//        var godinfo:NSDictionary = ["name":key]
        var goddic:NSDictionary = data as! NSDictionary
        var godinfo:NSDictionary = ["name":key,"image":goddic["image"]]
            
            GodList.append(godinfo)
        }
    
    }
    
    //行数の決定 /// セルの個数を指定するデリゲートメソッド（必須）
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return GodList.count
    }
    
    //表示する文字列を決定 /// セルに値を設定するデータソースメソッド（必須）
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
    //文字列を表示するセルの取得  // セルを取得
        let cell:CustomTableViewCell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CustomTableViewCell
        
        //表示したい文字・画像の設定
                var godinfo = GodList[indexPath.row] as! NSDictionary
                print(godinfo["name"] as! String)
                print(godinfo["image"] as! String)
        
        //画像を表示
        cell.listImageView.image = UIImage(named:godinfo["image"] as! String)
        //文字を表示
        cell.listLabel.text = godinfo["name"] as? String
        //文字色、矢印
        cell.listLabel.textColor = UIColor.orange
        cell.accessoryType = .disclosureIndicator
        

        return cell

        
    }
    
    //セルがタップされたとき
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
            cellAudioPlayer.play()
            
            //タップされた行のエリア名を保存
            var godinfo = GodList[indexPath.row] as! NSDictionary
            
            godName = godinfo["name"]  as! String
    
            //セグエのidentifierを指定して、画面移動
            performSegue(withIdentifier: "showDetail",sender: nil)
        }
    
    // Segueで画面遷移する時
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        //次の画面のインスタンスを取得
        let secondinfo = segue.destination as!
        DetailViewController
        
        // 次の画面のプロパティに選択されたエリア名を設定
        secondinfo.getGodName = godName

    }
    
    
    func cellSound() {
        // サウンドファイルのパスを生成
        let soundFile = Bundle.main.path(forResource: "cell", ofType: "wav")! as NSString
        let soundClear = URL(fileURLWithPath: soundFile as String)
        //AVAudioPlayerのインスタンス化
        do {
            cellAudioPlayer = try AVAudioPlayer(contentsOf: soundClear as URL, fileTypeHint:nil)
        }catch{
            print("AVAudioPlayerインスタンス作成失敗")
        }
//        restartAudioPlayer.volume = 0.1
        cellAudioPlayer.prepareToPlay()
    }
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

    
//    cell.imageView!.image = UIImage(named:godinfo["image"] as! String)
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
