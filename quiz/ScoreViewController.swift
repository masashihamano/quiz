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
        
        
//        print("correctProblemNumber:\(correctProblemNumber)")
        
        
        func scoreList(){
            var scoregodname:Int = Int(arc4random()) % GodList.count
            scoregodname += 1

        //ファイルパスを取得(神様が格納されているプロパティリスト)
        let filePath = Bundle.main.path(forResource:"GodList", ofType:"plist")
        // プロパティリストからデータを取得（Dictionary型）
        let dic = NSDictionary(contentsOfFile: filePath!)

        //画像ファイル名を格納する配列を作成
        for(key,data) in dic!{
            print(data)
            print(key)

            let goddic:NSDictionary = data as! NSDictionary
//            let godinfo:NSDictionary = ["name":key,"image":goddic["image"]!]
            
            let scoreinfo:NSDictionary = ["name":key,"score100":goddic["score100"] as Any,"score90":goddic["score90"] as Any,"score80":goddic["score80"] as Any,"score70":goddic["score70"] as Any,"score60":goddic["score60"] as Any,"score50":goddic["score50"] as Any,"score40":goddic["score40"] as Any,"score30":goddic["score30"] as Any,"score20":goddic["score20"] as Any,"score10":goddic["score10"] as Any,"score0":goddic["score0"] as Any,"image":goddic["image"]!]

            GodList.append(scoreinfo)
        }

            
        
//        //今画面に表示したいデータの取得
//        let scorelInfo = dic![scoregodname] as! NSDictionary

        let scoreInfo = GodList[scoregodname] as! NSDictionary
            
        //Dictionaryからキー指定で取り出すと必ずAny型になるのでダウンキャスト変換が必要
        print(scoreInfo["image"] as! String)
        print(scoreInfo["name"] as! String)
            print(scoreInfo["score100"] as! String)
            print(scoreInfo["score90"] as! String)
            print(scoreInfo["score80"] as! String)
            print(scoreInfo["score70"] as! String)
            print(scoreInfo["score60"] as! String)
            print(scoreInfo["score50"] as! String)
            print(scoreInfo["score40"] as! String)
            print(scoreInfo["score30"] as! String)
            print(scoreInfo["score20"] as! String)
            print(scoreInfo["score10"] as! String)
            print(scoreInfo["score0"] as! String)

            
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
//                godImageView.image = UIImage(named:scoreInfo["score0"] as! String)
                 score0AudioPlayer.play()
            case 10:
                rankLabel.text = NSLocalizedString("commentFirst", comment: "")
//                godImageView.image = UIImage(named:scoreInfo["score10"] as! String)
                score10AudioPlayer.play()
            case 20:
                rankLabel.text = NSLocalizedString("commentSecond", comment: "")
//                godImageView.image = UIImage(named:scoreInfo["score20"] as! String)
                godImageView.image = UIImage(named: "Nandin.jpg")
                score20AudioPlayer.play()
            case 30:
                rankLabel.text = NSLocalizedString("commentThird", comment: "")
//                godImageView.image = UIImage(named:scoreInfo["score30"] as! String)
                score30AudioPlayer.play()
            case 40:
                rankLabel.text = NSLocalizedString("commentFourth", comment: "")
//                godImageView.image = UIImage(named:scoreInfo["score40"] as! String)
                score40AudioPlayer.play()
            case 50:
                rankLabel.text = NSLocalizedString("commentFifth", comment: "")
//                godImageView.image = UIImage(named:scoreInfo["score50"] as! String)
                score50AudioPlayer.play()
            case 60:
                rankLabel.text = NSLocalizedString("commentSixth", comment: "")
//                godImageView.image = UIImage(named:scoreInfo["score60"] as! String)
                score60AudioPlayer.play()
            case 70:
                rankLabel.text = NSLocalizedString("commentSeventh", comment: "")
//                godImageView.image = UIImage(named:scoreInfo["score70"] as! String)
                score70AudioPlayer.play()
            case 80:
                rankLabel.text = NSLocalizedString("commentEighth", comment: "")
//                godImageView.image = UIImage(named:scoreInfo["score80"] as! String)
                score80AudioPlayer.play()
            case 90:
                rankLabel.text = NSLocalizedString("commentNinth", comment: "")
//                godImageView.image = UIImage(named:scoreInfo["score90"] as! String)
                score90AudioPlayer.play()
            default:
                rankLabel.text = NSLocalizedString("commentTenth", comment: "")
                godImageView.image = UIImage(named: "godImg.jpg")
                score100AudioPlayer.play()
                
            }
            
        
        }
            
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
//        performSegue(withIdentifier: "showTitle", sender: nil)
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
        restartAudioPlayer.volume = 0.1
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
//        listAudioPlayer.volume = 0.5
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
        //        listAudioPlayer.volume = 0.5
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
        //        listAudioPlayer.volume = 0.5
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
        //        listAudioPlayer.volume = 0.5
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
        //        listAudioPlayer.volume = 0.5
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
        //        listAudioPlayer.volume = 0.5
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
        //        listAudioPlayer.volume = 0.5
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
        //        listAudioPlayer.volume = 0.5
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
        //        listAudioPlayer.volume = 0.5
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
        //        listAudioPlayer.volume = 0.5
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
        //        listAudioPlayer.volume = 0.5
            score100AudioPlayer.prepareToPlay()
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
