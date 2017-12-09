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
        titleImageView.image = UIImage(named: "title.jpg")
        
        titleLabel.layer.borderColor = UIColor.white.cgColor
        titleLabel.layer.borderWidth = 2
//        titleLabel.layer.cornerRadius = 25
        titleLabel.layer.masksToBounds = true
        titleLabel.font = UIFont.boldSystemFont(ofSize: 48)
   
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


}

