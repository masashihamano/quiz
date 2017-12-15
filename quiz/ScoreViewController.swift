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
//        var scoregodname:Int = Int(arc4random()) % GodList.count
//        scoregodname += 1

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

//            GodList.append(scoreinfo)
            GodList.append(data as! NSDictionary)

        }

        
        
        
        var RandomNumber:Int = Int(arc4random() % 35)
        
        //リストと画像を一致させる。
        
        
        for god in GodList {
            
            let scoreGodDisplay = Int(arc4random()) % GodList.count
            let score = GodList[scoreGodDisplay]
            
            if num == 0 {
                if (god["score"] as! String) == "s0" {
                    godImageView.image = UIImage(named:god["image"] as! String)
                }
              
            }else  if num == 10 {
                if (god["score"] as! String) == "s10" {
                    godImageView.image = UIImage(named:god["image"] as! String)
                }
                
            }else  if num == 20 {
                if (god["score"] as! String) == "s20" {
                    godImageView.image = UIImage(named:god["image"] as! String)
                }
                
            }else  if num == 30 {
                if (god["score"] as! String) == "s30" {
                    godImageView.image = UIImage(named:god["image"] as! String)
                }
            
            }else if num == 40 {
                if (god["score"] as! String) == "s40" {
                    godImageView.image = UIImage(named:god["image"] as! String)
                }

            }else if num == 50 {
                if (god["score"] as! String) == "s50" {
                    godImageView.image = UIImage(named:god["image"] as! String)
                }
              
            }else if num == 60 {
                if (god["score"] as! String) == "s60" {
                    godImageView.image = UIImage(named:god["image"] as! String)
                }
                
            }else if num == 70 {
                if (god["score"] as! String) == "s70" {
                    godImageView.image = UIImage(named:god["image"] as! String)
                }
                
            }else if num == 80 {
                if (god["score"] as! String) == "s80" {
                    godImageView.image = UIImage(named:god["image"] as! String)
                }
                
            }else if num == 90 {
                if (god["score"] as! String) == "s90" {
                    godImageView.image = UIImage(named:god["image"] as! String)
                }
                
            }else if num == 100 {
                if (god["score"] as! String) == "s100" {
                    godImageView.image = UIImage(named:god["image"] as! String)
                }else{
                }
            }

        }
    
    

                //今画面に表示したいデータの取得
//        let scoreInfo = GodList[scoregodname] as! NSDictionary
//
//        //Dictionaryからキー指定で取り出すと必ずAny型になるのでダウンキャスト変換が必要
//        print(scoreInfo["image"] as! String)
//        print(scoreInfo["name"] as! String)
//        print(scoreInfo["score"] as! String)

//        scoregodname = scoreInfo["score"] as! String

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
            godImageView.image = UIImage(named: "Nandin.jpg")
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
