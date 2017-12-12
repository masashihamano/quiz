//
//  DetailViewController.swift
//  quiz
//
//  Created by 濱野将士 on 2017/11/19.
//  Copyright © 2017年 Masashi Hamano. All rights reserved.
//

import UIKit
import SafariServices
import AVFoundation

class DetailViewController: UIViewController, UITextViewDelegate {

    @IBOutlet weak var detailTextView: UITextView!
    @IBOutlet weak var detailImageView: UIImageView!
    
    @IBOutlet weak var wikiTextView: UITextView!
    
    //選択されたurlを保存するメンバ変数
    var wikiurl = ""
    
    //wikiの音
    var wikiAudioPlayer: AVAudioPlayer! = nil
    
    //プロパティリストから読み込んだデータを格納する配列
    var GodList:[NSDictionary] = []
    //前の画面から受け取るためのプロパティ
    var getGodName = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //wikiがタップされた時の音
        wikiSound()
        
        
        print("getGodName:\(getGodName)")
        
        //ファイルパスを取得(エリア名が格納されているプロパティリスト)
        let filePath = Bundle.main.path(forResource: "GodList", ofType: "plist")
        //ファイルの内容を読み込んでディクショナリー型に格納
        let dic = NSDictionary(contentsOfFile: filePath!)
        //今画面に表示したいデータの取得
        let detailInfo = dic![getGodName] as! NSDictionary
        
        //Dictionaryからキー指定で取り出すと必ずAny型になるのでダウンキャスト変換
        print(detailInfo["description"] as! String)
        print(detailInfo["english"] as! String)
        print(detailInfo["image"] as! String)
        print(detailInfo["wikipedia"] as! String)
        
        wikiurl = detailInfo["wikipedia"] as! String
        
        
        setupTextView()
        
        //タイトルをナビゲーションバーの真ん中に表示
        navigationItem.title = getGodName
        
        //説明、画像の表示
//        detailTextView.text = String(format: NSLocalizedString("key1", comment: ""), 1)
       
        detailTextView.text = detailInfo["description"] as! String
        detailImageView.image = UIImage(named:detailInfo["image"] as! String)
    
        wikiTextView.addObserver(self, forKeyPath: "contentSize", options: .new, context: nil)
        
        
    }

    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if let textView = object as? UITextView {
            var topCorrect = (textView.bounds.size.height - textView.contentSize.height * textView.zoomScale) / 2
            topCorrect = topCorrect < 0.0 ? 0.0 : topCorrect;
            textView.contentInset.top = topCorrect
        }
    }
    
    deinit {
        wikiTextView.removeObserver(self, forKeyPath: "contentSize")
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    
    func setupTextView() {
        
        let text = "詳細はwikipediaへ"
        
        wikiTextView.delegate = self
        wikiTextView.isSelectable = true
        wikiTextView.isEditable = false
        
        wikiTextView.textContainer.lineFragmentPadding = 0
        wikiTextView.textContainerInset = .zero
        wikiTextView.isScrollEnabled = false
        
        let attributedString = NSMutableAttributedString(string: text)
        let range = NSString(string: text).range(of: "wikipedia")
        
        print(wikiurl)
        
        attributedString.addAttribute(
            NSAttributedStringKey.link,
//            value: detailInfo["wikipwdia"] as! String,
            value: wikiurl,
            range: range)
    
        wikiTextView.attributedText = attributedString
        wikiTextView.linkTextAttributes = [NSAttributedStringKey.foregroundColor.rawValue: UIColor.blue]
        
        
        // 枠のカラー
        detailImageView.layer.borderColor = UIColor.white.cgColor
        // 枠の幅
        detailImageView.layer.borderWidth = 2
        // 枠を角丸にする場合
        detailImageView.layer.cornerRadius = 10.0
        detailTextView.layer.cornerRadius = 10.0
        wikiTextView.layer.cornerRadius = 10.0
        detailImageView.layer.masksToBounds = true
        detailTextView.layer.masksToBounds = true
        wikiTextView.layer.masksToBounds = true
        // 文字の大きさ
        detailTextView.font = UIFont.systemFont(ofSize: CGFloat(16))
        detailTextView.font = UIFont.boldSystemFont(ofSize: UIFont.labelFontSize)
        wikiTextView.font = UIFont.systemFont(ofSize: CGFloat(36))
//        wikiTextView.font = UIFont.boldSystemFont(ofSize: UIFont.labelFontSize)
        
        // 文字の中央寄せ
        wikiTextView.textAlignment = NSTextAlignment.center
        
      
//        wikiTextView.contentVerticalAlignment = UIControlContentVerticalAlignment.Center
        
        
    }
    
    // この Delegate の実装しない場合はデフォルトで URL を Safari で開く。
    func wikiTextView(_ wikiTextView: UITextView,
                  shouldInteractWith URL: URL,
                  in characterRange: NSRange,
                  interaction: UITextItemInteraction) -> Bool {
        
        wikiAudioPlayer.play()  //音ならない
        
        // UIApplication.shared.open(URL)
        let controller = SFSafariViewController(url: URL)
        self.present(controller, animated: true)
        
        return false
    
    }
    
    func wikiSound() {
        // サウンドファイルのパスを生成
        let soundFile = Bundle.main.path(forResource: "wiki", ofType: "wav")! as NSString
        let soundClear = URL(fileURLWithPath: soundFile as String)
        //AVAudioPlayerのインスタンス化
        do {
            wikiAudioPlayer = try AVAudioPlayer(contentsOf: soundClear as URL, fileTypeHint:nil)
        }catch{
            print("AVAudioPlayerインスタンス作成失敗")
        }
        //        restartAudioPlayer.volume = 0.1
        wikiAudioPlayer.prepareToPlay()
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
