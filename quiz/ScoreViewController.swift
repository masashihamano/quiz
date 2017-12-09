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

    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var rankLabel: UILabel!
    @IBOutlet weak var myImageView: UIImageView!
   
    
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
    
    //QuizControllerより引き渡される値を格納する
    var correctProblemNumber: Int!
    
    //ランクを表示するメソッド
    func showRank(num: Int) {
        var text: String
        switch num {
        case 0:
            text = "問題外です"
            score0AudioPlayer.play()
        case 10:
            text = "修行が足りない"
            score10AudioPlayer.play()
        case 20:
            text = "ざんねんでした！"
            score20AudioPlayer.play()
        case 30:
            text = "まだまだです"
            score30AudioPlayer.play()
        case 40:
            text = "もっとがんばりましょう"
            score40AudioPlayer.play()
        case 50:
            text = "もう少し頑張りましょう"
            score50AudioPlayer.play()
        case 60:
            text = "及第点です"
            score60AudioPlayer.play()
        case 70:
            text = "おめでとう！"
            score70AudioPlayer.play()
        case 80:
            text = "素晴らしい！"
            score80AudioPlayer.play()
        case 90:
            text = "満点まであとすこし！"
            score90AudioPlayer.play()
        default:
            text = "神レベル！"
            score100AudioPlayer.play()
        }
        rankLabel.text = text
        
    }
    
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
        
        //得点表示
        self.scoreLabel.text = String(correctProblemNumber*10)
        showRank(num: correctProblemNumber*10)
        
        //scoe文字の装飾
        scoreLabel.layer.masksToBounds = true
        scoreLabel.layer.cornerRadius = scoreLabel.bounds.width / 2
        scoreLabel.font = UIFont.boldSystemFont(ofSize: 48)
        
    }
    
    
    @IBAction func startBtn(_ sender: UIButton) {
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
        let soundFile = Bundle.main.path(forResource: "score0", ofType: "wav")! as NSString
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
