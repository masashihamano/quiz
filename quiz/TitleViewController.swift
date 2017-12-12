//
//  ViewController.swift
//  quiz
//
//  Created by 濱野将士 on 2017/11/12.
//  Copyright © 2017年 Masashi Hamano. All rights reserved.
//

import UIKit
import AVFoundation

//UIButtonのカスタムクラス
@IBDesignable
class Button_Custom: UIButton {
    @IBInspectable var textColor: UIColor?
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
        }
    }
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    @IBInspectable var borderColor: UIColor = UIColor() {
        didSet {
            layer.borderColor = borderColor.cgColor
        }
    }
}


class TitleViewController: UIViewController {
   
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var myImageView: UIImageView!
    @IBOutlet weak var titleImageView: UIImageView!
    
    
    //プロパティリストから読み込んだデータを格納する配列、問題の内容を入れておくメンバ変数
    var GodList:[NSDictionary] = []
    //選択された名前を保存するメンバ変数
    var godName = ""
    
    
    //スタート音の変数
    var startAudioPlayer: AVAudioPlayer! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
     //ボタン押した時の音
        startSound()
        
    //背景イメージ画像
        myImageView.image = UIImage(named: "background.jpg")
        myImageView.alpha = 0.1
    //タイトル画面イメージ
        RandomQuestions()
//        titleImageView.image = UIImage(named: "title.jpg")
        titleImageView.layer.borderColor = UIColor.white.cgColor
        titleImageView.layer.borderWidth = 2
        titleImageView.layer.cornerRadius = 10.0
        titleImageView.layer.masksToBounds = true
    //タイトル文字
        titleLabel.layer.borderColor = UIColor.white.cgColor
        titleLabel.layer.borderWidth = 2
        titleLabel.layer.cornerRadius = 10.0
        titleLabel.layer.masksToBounds = true
        titleLabel.font = UIFont.boldSystemFont(ofSize: 46)
        
        //表示可能最大行数を指定
        titleLabel.numberOfLines = 2
        //contentsのサイズに合わせてobujectのサイズを変える
        titleLabel.sizeToFit()

    
        
    }
 
    
    @IBAction func startBtn(_ sender: Any) {
//       performSegue(withIdentifier: "showQuestion", sender: nil)
        startAudioPlayer.play()
    }
    
    
    func startSound() {
        // サウンドファイルのパスを生成
        let soundFile = Bundle.main.path(forResource: "start", ofType: "mp3")! as NSString
        let soundClear = URL(fileURLWithPath: soundFile as String)
        //AVAudioPlayerのインスタンス化
        do {
            startAudioPlayer = try AVAudioPlayer(contentsOf: soundClear as URL, fileTypeHint:nil)
        }catch{
            print("AVAudioPlayerインスタンス作成失敗")
        }
            startAudioPlayer.prepareToPlay()
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func RandomQuestions(){
        var RandomNumber:Int = Int(arc4random() % 35)
        RandomNumber += 1
        
        //ファイルパスを取得(神様が格納されているプロパティリスト)
        let filePath = Bundle.main.path(forResource:"GodList", ofType:"plist")
        // プロパティリストからデータを取得（Dictionary型）
        let dic = NSDictionary(contentsOfFile: filePath!)
    
        //画像ファイル名を格納する配列を作成
        for(key,data) in dic!{
            print(data)
            print(key)
            
            let goddic:NSDictionary = data as! NSDictionary
            let godinfo:NSDictionary = ["name":key,"image":goddic["image"]!]
            
            GodList.append(godinfo)
        }
        
        //今画面に表示したいデータの取得
        var detailInfo = GodList[RandomNumber]
        
        //Dictionaryからキー指定で取り出すと必ずAny型になるのでダウンキャスト変換が必要
        print(detailInfo["image"] as! String)
        print(detailInfo["name"] as! String)
        
        for(key,data) in dic!{
            print(data)
            print(key)
            
            var _:NSDictionary = data as! NSDictionary
        }
        
        titleImageView.image = UIImage(named:detailInfo["image"] as! String)
        
    }

}

