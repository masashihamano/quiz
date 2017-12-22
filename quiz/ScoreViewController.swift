//
//  ScoreViewController.swift
//  quiz
//
//  Created by 濱野将士 on 2017/11/23.
//  Copyright © 2017年 Masashi Hamano. All rights reserved.
//

import UIKit
import AVFoundation

class ScoreViewController: UIViewController {

    
    @IBOutlet weak var scoreTitleLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var rankLabel: UILabel!
    @IBOutlet weak var myImageView: UIImageView!
   
    @IBOutlet weak var godImageView: UIImageView!
    
    
//    var scoregodname = ""
    
    //プロパティリストから読み込んだデータを格納する配列
    var GodList:[NSDictionary] = []

    //QuizControllerより引き渡される値を格納する
    var correctProblemNumber: Int!
    
    //リスタート音の変数
    var restartAudioPlayer: AVAudioPlayer! = nil

    //0-100点のBGM
    var score0AudioPlayer: AVAudioPlayer! = nil
    var score10AudioPlayer: AVAudioPlayer! = nil
    var score20AudioPlayer: AVAudioPlayer! = nil
    var score30AudioPlayer: AVAudioPlayer! = nil
    var score40AudioPlayer: AVAudioPlayer! = nil
    var score50AudioPlayer: AVAudioPlayer! = nil
    var score60AudioPlayer: AVAudioPlayer! = nil
    var score70AudioPlayer: AVAudioPlayer! = nil
    var score80AudioPlayer: AVAudioPlayer! = nil
    var score90AudioPlayer: AVAudioPlayer! = nil
    var score100AudioPlayer: AVAudioPlayer! = nil
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    
        //ボタン押した時の音
        restartSound()
        
        //0-100点のBGM
        score0Sound()
        score10Sound()
        score20Sound()
        score30Sound()
        score40Sound()
        score50Sound()
        score60Sound()
        score70Sound()
        score80Sound()
        score90Sound()
        score100Sound()
        
        //背景画像
        myImageView.image = UIImage(named: "background.jpg")
        myImageView.alpha = 0.1
        
        //点数表示
        scoreLabel.text = String(correctProblemNumber*10)
        showRank(num: correctProblemNumber*10)
        scoreLabel.font = UIFont.boldSystemFont(ofSize: 80)
        
        //テキスト文字の枠線
        scoreTitleLabel.layer.borderColor = UIColor.white.cgColor
        scoreTitleLabel.layer.borderWidth = 2
        scoreTitleLabel.layer.cornerRadius = 10.0
        scoreTitleLabel.layer.masksToBounds = true
        scoreTitleLabel.font = UIFont.boldSystemFont(ofSize: 62)
        
        //表示画像
        godImageView.layer.borderColor = UIColor.white.cgColor
        godImageView.layer.borderWidth = 2
        godImageView.layer.cornerRadius = 10.0
        godImageView.layer.masksToBounds = true
        
    }
    
    
    @IBAction func restartBtn(_ sender: UIButton) {
        restartAudioPlayer.play()
    }
    
    func restartSound() {
        // サウンドファイルのパスを生成
        let soundFile = Bundle.main.path(forResource: "restart", ofType: "wav")! as NSString
        let soundClear = URL(fileURLWithPath: soundFile as String)
        //AVAudioPlayerのインスタンス化
        do {
            restartAudioPlayer = try AVAudioPlayer(contentsOf: soundClear as URL, fileTypeHint:nil)
        }catch{
            print("AVAudioPlayerインスタンス作成失敗")
        }
        restartAudioPlayer.volume = 0.05
        restartAudioPlayer.prepareToPlay()
    }
    
    func score0Sound() {
        // サウンドファイルのパスを生成
        let soundFile = Bundle.main.path(forResource: "score0", ofType: "mp3")! as NSString
        let soundClear = URL(fileURLWithPath: soundFile as String)
        //AVAudioPlayerのインスタンス化
        do {
            score0AudioPlayer = try AVAudioPlayer(contentsOf: soundClear as URL, fileTypeHint:nil)
        }catch{
            print("AVAudioPlayerインスタンス作成失敗")
        }
        score0AudioPlayer.volume = 0.2
        score0AudioPlayer.prepareToPlay()
    }
    
    func score10Sound() {
        // サウンドファイルのパスを生成
        let soundFile = Bundle.main.path(forResource: "score10", ofType: "wav")! as NSString
        let soundClear = URL(fileURLWithPath: soundFile as String)
        //AVAudioPlayerのインスタンス化
        do {
            score10AudioPlayer = try AVAudioPlayer(contentsOf: soundClear as URL, fileTypeHint:nil)
        }catch{
            print("AVAudioPlayerインスタンス作成失敗")
        }
        score10AudioPlayer.volume = 0.1
        score10AudioPlayer.prepareToPlay()
    }
    
    func score20Sound() {
        // サウンドファイルのパスを生成
        let soundFile = Bundle.main.path(forResource: "score20", ofType: "wav")! as NSString
        let soundClear = URL(fileURLWithPath: soundFile as String)
        //AVAudioPlayerのインスタンス化
        do {
            score20AudioPlayer = try AVAudioPlayer(contentsOf: soundClear as URL, fileTypeHint:nil)
        }catch{
            print("AVAudioPlayerインスタンス作成失敗")
        }
        score20AudioPlayer.volume = 0.1
        score20AudioPlayer.prepareToPlay()
    }
    
    func score30Sound() {
        // サウンドファイルのパスを生成
        let soundFile = Bundle.main.path(forResource: "score30", ofType: "mp3")! as NSString
        let soundClear = URL(fileURLWithPath: soundFile as String)
        //AVAudioPlayerのインスタンス化
        do {
            score30AudioPlayer = try AVAudioPlayer(contentsOf: soundClear as URL, fileTypeHint:nil)
        }catch{
            print("AVAudioPlayerインスタンス作成失敗")
        }
        score30AudioPlayer.volume = 0.1
        score30AudioPlayer.prepareToPlay()
    }
    
    func score40Sound() {
        // サウンドファイルのパスを生成
        let soundFile = Bundle.main.path(forResource: "score40", ofType: "mp3")! as NSString
        let soundClear = URL(fileURLWithPath: soundFile as String)
        //AVAudioPlayerのインスタンス化
        do {
            score40AudioPlayer = try AVAudioPlayer(contentsOf: soundClear as URL, fileTypeHint:nil)
        }catch{
            print("AVAudioPlayerインスタンス作成失敗")
        }
        score40AudioPlayer.volume = 0.1
        score40AudioPlayer.prepareToPlay()
    }
    
    func score50Sound() {
        // サウンドファイルのパスを生成
        let soundFile = Bundle.main.path(forResource: "score50", ofType: "mp3")! as NSString
        let soundClear = URL(fileURLWithPath: soundFile as String)
        //AVAudioPlayerのインスタンス化
        do {
            score50AudioPlayer = try AVAudioPlayer(contentsOf: soundClear as URL, fileTypeHint:nil)
        }catch{
            print("AVAudioPlayerインスタンス作成失敗")
        }
        score50AudioPlayer.volume = 0.1
        score50AudioPlayer.prepareToPlay()
    }
    
    func score60Sound() {
        // サウンドファイルのパスを生成
        let soundFile = Bundle.main.path(forResource: "score60", ofType: "wav")! as NSString
        let soundClear = URL(fileURLWithPath: soundFile as String)
        //AVAudioPlayerのインスタンス化
        do {
            score60AudioPlayer = try AVAudioPlayer(contentsOf: soundClear as URL, fileTypeHint:nil)
        }catch{
            print("AVAudioPlayerインスタンス作成失敗")
        }
        score60AudioPlayer.volume = 0.1
        score60AudioPlayer.prepareToPlay()
    }
    
    func score70Sound() {
        // サウンドファイルのパスを生成
        let soundFile = Bundle.main.path(forResource: "score70", ofType: "mp3")! as NSString
        let soundClear = URL(fileURLWithPath: soundFile as String)
        //AVAudioPlayerのインスタンス化
        do {
            score70AudioPlayer = try AVAudioPlayer(contentsOf: soundClear as URL, fileTypeHint:nil)
        }catch{
            print("AVAudioPlayerインスタンス作成失敗")
        }
        score70AudioPlayer.volume = 0.1
        score70AudioPlayer.prepareToPlay()
    }
    
    func score80Sound() {
        // サウンドファイルのパスを生成
        let soundFile = Bundle.main.path(forResource: "score80", ofType: "mp3")! as NSString
        let soundClear = URL(fileURLWithPath: soundFile as String)
        //AVAudioPlayerのインスタンス化
        do {
            score80AudioPlayer = try AVAudioPlayer(contentsOf: soundClear as URL, fileTypeHint:nil)
        }catch{
            print("AVAudioPlayerインスタンス作成失敗")
        }
        score80AudioPlayer.volume = 0.1
        score80AudioPlayer.prepareToPlay()
    }
    
    func score90Sound() {
        // サウンドファイルのパスを生成
        let soundFile = Bundle.main.path(forResource: "score90", ofType: "mp3")! as NSString
        let soundClear = URL(fileURLWithPath: soundFile as String)
        //AVAudioPlayerのインスタンス化
        do {
            score90AudioPlayer = try AVAudioPlayer(contentsOf: soundClear as URL, fileTypeHint:nil)
        }catch{
            print("AVAudioPlayerインスタンス作成失敗")
        }
        score90AudioPlayer.volume = 0.1
        score90AudioPlayer.prepareToPlay()
    }
    
    func score100Sound() {
        // サウンドファイルのパスを生成
        let soundFile = Bundle.main.path(forResource: "score100", ofType: "wav")! as NSString
        let soundClear = URL(fileURLWithPath: soundFile as String)
        //AVAudioPlayerのインスタンス化
        do {
            score100AudioPlayer = try AVAudioPlayer(contentsOf: soundClear as URL, fileTypeHint:nil)
        }catch{
            print("AVAudioPlayerインスタンス作成失敗")
        }
            score100AudioPlayer.volume = 0.1
            score100AudioPlayer.prepareToPlay()
    }
    
    
    func rankDisplay(num: Int){

        //ファイルパスを取得(神様が格納されているプロパティリスト)
        let filePath = Bundle.main.path(forResource:"GodList", ofType:"plist")
        // プロパティリストからデータを取得（Dictionary型）
        let dic = NSDictionary(contentsOfFile: filePath!)

        //画像ファイル名を格納する配列を作成
        for(key,data) in dic!{
            print(data)
            print(key)

            let goddic:NSDictionary = data as! NSDictionary
            let scoreinfo:NSDictionary = ["name":key,"score":goddic["score"],"image":goddic["image"]!]

            GodList.append(data as! NSDictionary)

        }

        //スコアの点数専用の配列を用意と表示する画像を
        var s0arr:Array<Any> = []
        var s10arr:Array<Any> = []
        var s20arr:Array<Any> = []
        var s30arr:Array<Any> = []
        var s40arr:Array<Any> = []
        var s50arr:Array<Any> = []
        var s60arr:Array<Any> = []
        var s70arr:Array<Any> = []
        var s80arr:Array<Any> = []
        var s90arr:Array<Any> = []
        var s100arr:Array<Any> = []
        
        //リストと画像を一致させる。
        for god in GodList {
            
            let scoreGodDisplay = Int(arc4random()) % GodList.count
            let score = GodList[scoreGodDisplay]
            
//          s0専用の配列を用意し、s0のデータだけを格納する
            
            //スコアのデータを格納
            if (god["score"] as! String) == "s0" {
                s0arr.append(god)
            }else if (god["score"] as! String) == "s10" {
                s10arr.append(god)
            }else if (god["score"] as! String) == "s20" {
                s20arr.append(god)
            }else if (god["score"] as! String) == "s30" {
                s30arr.append(god)
            }else if (god["score"] as! String) == "s40" {
                s40arr.append(god)
            }else if (god["score"] as! String) == "s50" {
                s50arr.append(god)
            }else if (god["score"] as! String) == "s60" {
                s60arr.append(god)
            }else if (god["score"] as! String) == "s70" {
                s70arr.append(god)
            }else if (god["score"] as! String) == "s80" {
                s80arr.append(god)
            }else if (god["score"] as! String) == "s90" {
                s90arr.append(god)
            }else if (god["score"] as! String) == "s100" {
                s100arr.append(god)
            }else{
            }
        }
        
    
        if num == 0 {
            let scoreGodDisplay = Int(arc4random()) % s0arr.count
            let displaygod:NSDictionary = s0arr[scoreGodDisplay] as! NSDictionary
            godImageView.image = UIImage(named:displaygod["image"] as! String)
        }else if num == 10 {
            let scoreGodDisplay = Int(arc4random()) % s10arr.count
            let displaygod:NSDictionary = s10arr[scoreGodDisplay] as! NSDictionary
            godImageView.image = UIImage(named:displaygod["image"] as! String)
        }else if num == 20 {
            let scoreGodDisplay = Int(arc4random()) % s20arr.count
            let displaygod:NSDictionary = s20arr[scoreGodDisplay] as! NSDictionary
            godImageView.image = UIImage(named:displaygod["image"] as! String)
        }else if num == 30 {
            let scoreGodDisplay = Int(arc4random()) % s30arr.count
            let displaygod:NSDictionary = s30arr[scoreGodDisplay] as! NSDictionary
            godImageView.image = UIImage(named:displaygod["image"] as! String)
        }else if num == 40 {
            let scoreGodDisplay = Int(arc4random()) % s40arr.count
            let displaygod:NSDictionary = s40arr[scoreGodDisplay] as! NSDictionary
            godImageView.image = UIImage(named:displaygod["image"] as! String)
        }else if num == 50 {
            let scoreGodDisplay = Int(arc4random()) % s50arr.count
            let displaygod:NSDictionary = s50arr[scoreGodDisplay] as! NSDictionary
            godImageView.image = UIImage(named:displaygod["image"] as! String)
        }else if num == 60 {
            let scoreGodDisplay = Int(arc4random()) % s60arr.count
            let displaygod:NSDictionary = s60arr[scoreGodDisplay] as! NSDictionary
            godImageView.image = UIImage(named:displaygod["image"] as! String)
        }else if num == 70 {
            let scoreGodDisplay = Int(arc4random()) % s70arr.count
            let displaygod:NSDictionary = s70arr[scoreGodDisplay] as! NSDictionary
            godImageView.image = UIImage(named:displaygod["image"] as! String)
        }else if num == 80 {
            let scoreGodDisplay = Int(arc4random()) % s80arr.count
            let displaygod:NSDictionary = s80arr[scoreGodDisplay] as! NSDictionary
            godImageView.image = UIImage(named:displaygod["image"] as! String)
        }else if num == 90 {
            let scoreGodDisplay = Int(arc4random()) % s90arr.count
            let displaygod:NSDictionary = s90arr[scoreGodDisplay] as! NSDictionary
            godImageView.image = UIImage(named:displaygod["image"] as! String)
        }else if num == 100 {
            let scoreGodDisplay = Int(arc4random()) % s100arr.count
            let displaygod:NSDictionary = s100arr[scoreGodDisplay] as! NSDictionary
            godImageView.image = UIImage(named:displaygod["image"] as! String)
        }else{
            
        }
        

        for(key,data) in dic!{
            print(data)
            print(key)

            var _:NSDictionary = data as! NSDictionary
        }

    }
    
    //ランクを表示するメソッド
    func showRank(num: Int) {
        var text: String
        switch num {
        case 0:
            rankLabel.text = NSLocalizedString("commentZero", comment: "")
            rankDisplay(num:num)
            score0AudioPlayer.play()
        case 10:
            rankLabel.text = NSLocalizedString("commentFirst", comment: "")
            rankDisplay(num:num)
            score10AudioPlayer.play()
        case 20:
            rankLabel.text = NSLocalizedString("commentSecond", comment: "")
            rankDisplay(num:num)
            score20AudioPlayer.play()
        case 30:
            rankLabel.text = NSLocalizedString("commentThird", comment: "")
            rankDisplay(num:num)
            score30AudioPlayer.play()
        case 40:
            rankLabel.text = NSLocalizedString("commentFourth", comment: "")
            rankDisplay(num:num)
            score40AudioPlayer.play()
        case 50:
            rankLabel.text = NSLocalizedString("commentFifth", comment: "")
            rankDisplay(num:num)
            score50AudioPlayer.play()
        case 60:
            rankLabel.text = NSLocalizedString("commentSixth", comment: "")
            rankDisplay(num:num)
            score60AudioPlayer.play()
        case 70:
            rankLabel.text = NSLocalizedString("commentSeventh", comment: "")
            rankDisplay(num:num)
            score70AudioPlayer.play()
        case 80:
            rankLabel.text = NSLocalizedString("commentEighth", comment: "")
            rankDisplay(num:num)
            score80AudioPlayer.play()
        case 90:
            rankLabel.text = NSLocalizedString("commentNinth", comment: "")
            rankDisplay(num:num)
            score90AudioPlayer.play()
        default:
            rankLabel.text = NSLocalizedString("commentTenth", comment: "")
            rankDisplay(num:num)
            score100AudioPlayer.play()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
