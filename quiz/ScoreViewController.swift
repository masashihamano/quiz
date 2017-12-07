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
    //リスト音の変数
    var listAudioPlayer: AVAudioPlayer! = nil
    //0点のBGM
    var zeroAudioPlayer: AVAudioPlayer! = nil
    //100点のBGM
    var perfectAudioPlayer: AVAudioPlayer! = nil
    
    //QuizControllerより引き渡される値を格納する
    var correctProblemNumber: Int!
    
    //ランクを表示するメソッド
    func showRank(num: Int) {
        var text: String
        switch num {
        case 0:
            text = "問題外です"
            zeroAudioPlayer.play()
        case 10:
            text = "修行が足りない"
        case 20:
            text = "ざんねんでした！"
        case 30:
            text = "まだまだです"
        case 40:
            text = "もっとがんばりましょう"
        case 50:
            text = "もう少し頑張りましょう"
        case 60:
            text = "及第点です"
        case 70:
            text = "おめでとう！"
        case 80:
            text = "素晴らしい！"
        case 90:
            text = "満点まであとすこし！"
        default:
            text = "神レベル！"
            perfectAudioPlayer.play()
        }
        rankLabel.text = text
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //ボタン押した時の音
        restartSound()
        listSound()
        
        //BGM
        zeroSound()
        perfectSound()
        
        //背景画像
        myImageView.image = UIImage(named: "background.jpg")
        myImageView.alpha = 0.1
        
        //得点表示
        self.scoreLabel.text = String(correctProblemNumber*10)
        showRank(num: correctProblemNumber*10)
        
        //得点回りの装飾
        scoreLabel.layer.masksToBounds = true
        scoreLabel.layer.cornerRadius = scoreLabel.bounds.width / 2
        
    }
    
    
    @IBAction func startBtn(_ sender: UIButton) {
//        performSegue(withIdentifier: "showTitle", sender: nil)
        restartAudioPlayer.play()
    }
    
    
    @IBAction func listBtn(_ sender: Any) {
//        performSegue(withIdentifier: "showList", sender: nil)
        listAudioPlayer.play()
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
    
    func listSound() {
        // サウンドファイルのパスを生成
        let soundFile = Bundle.main.path(forResource: "list", ofType: "wav")! as NSString
        let soundClear = URL(fileURLWithPath: soundFile as String)
        //AVAudioPlayerのインスタンス化
        do {
            listAudioPlayer = try AVAudioPlayer(contentsOf: soundClear as URL, fileTypeHint:nil)
        }catch{
            print("AVAudioPlayerインスタンス作成失敗")
        }
        listAudioPlayer.volume = 0.5
        listAudioPlayer.prepareToPlay()
    }
    
    func zeroSound() {
        // サウンドファイルのパスを生成
        let soundFile = Bundle.main.path(forResource: "zero", ofType: "wav")! as NSString
        let soundClear = URL(fileURLWithPath: soundFile as String)
        //AVAudioPlayerのインスタンス化
        do {
            zeroAudioPlayer = try AVAudioPlayer(contentsOf: soundClear as URL, fileTypeHint:nil)
        }catch{
            print("AVAudioPlayerインスタンス作成失敗")
        }
//        listAudioPlayer.volume = 0.5
        zeroAudioPlayer.prepareToPlay()
    }
    
    func perfectSound() {
        // サウンドファイルのパスを生成
        let soundFile = Bundle.main.path(forResource: "perfect", ofType: "wav")! as NSString
        let soundClear = URL(fileURLWithPath: soundFile as String)
        //AVAudioPlayerのインスタンス化
        do {
            perfectAudioPlayer = try AVAudioPlayer(contentsOf: soundClear as URL, fileTypeHint:nil)
        }catch{
            print("AVAudioPlayerインスタンス作成失敗")
        }
        //        listAudioPlayer.volume = 0.5
            perfectAudioPlayer.prepareToPlay()
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
