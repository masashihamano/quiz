//
//  DetailViewController.swift
//  quiz
//
//  Created by 濱野将士 on 2017/11/19.
//  Copyright © 2017年 Masashi Hamano. All rights reserved.
//

import UIKit
import SafariServices

class DetailViewController: UIViewController, UITextViewDelegate {

    @IBOutlet weak var detailTextView: UITextView!
    @IBOutlet weak var detailImageView: UIImageView!
    
    @IBOutlet weak var wikiTextView: UITextView!
    
    
    
    
    
    
    
    //プロパティリストから読み込んだデータを格納する配列
    var GodList:[NSDictionary] = []
    //前の画面から受け取るためのプロパティ
    var getGodName = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupTextView()
        
//        let wikiLink = "詳細はwikipediaへ"
//        let attributedString = NSMutableAttributedString(string: wikiLink)
//
//        attributedString.addAttribute(.link,
//                                      value: "https://www.wikipedia.org/",
//                                      range: NSString(string: wikiLink).range(of: "wikipedia"))
//        wikiLabel.attributedText = attributedString
//        wikiLabel.isSelectable = true
        
        
        print("getGodName:\(getGodName)")
        
        //ファイルパスを取得(エリア名が格納されているプロパティリスト)
        let filePath = Bundle.main.path(forResource: "GodList", ofType: "plist")
        //ファイルの内容を読み込んでディクショナリー型に格納
        let dic = NSDictionary(contentsOfFile: filePath!)
        //今画面に表示したいデータの取得
        let detailInfo = dic![getGodName] as! NSDictionary
        
        
        
        // 配列（エリア名の入ってる配列）を作成
        for(key,data) in dic!{
        var godinfo:NSDictionary = ["name":key]
        GodList.append(godinfo)

        }
        
        //Dictionaryからキー指定で取り出すと必ずAny型になるのでダウンキャスト変換が必要
        print(detailInfo["description"] as! String)
        print(detailInfo["image"] as! String)
        print(detailInfo["wikipedia"] as! String)
        
        //タイトルをナビゲーションバーの真ん中に表示
        navigationItem.title = getGodName
        
        
        //説明、画像の表示
        detailTextView.text = detailInfo["description"] as! String
        detailImageView.image = UIImage(named:detailInfo["image"] as! String)
        //ウィキぺディア
//        wikiTextView.text = detailInfo["wikipwdia"] as! String
        
        
        
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
        
        attributedString.addAttribute(
            NSAttributedStringKey.link,
//            value: detailInfo["wikipwdia"] as! String,
            value: "https://www.wikipedia.org/",
            range: range)
        
        
        wikiTextView.attributedText = attributedString
        wikiTextView.linkTextAttributes = [NSAttributedStringKey.foregroundColor.rawValue: UIColor.blue]
        // 枠のカラー
        detailTextView.layer.borderColor = UIColor.orange.cgColor
        wikiTextView.layer.borderColor = UIColor.orange.cgColor
        // 枠の幅
        detailTextView.layer.borderWidth = 2
        wikiTextView.layer.borderWidth = 2
        // 枠を角丸にする場合
        detailTextView.layer.cornerRadius = 10.0
        wikiTextView.layer.cornerRadius = 10.0
        detailTextView.layer.masksToBounds = true
        wikiTextView.layer.masksToBounds = true
        // 文字の大きさ
        detailTextView.font = UIFont.systemFont(ofSize: CGFloat(16))
        detailTextView.font = UIFont.boldSystemFont(ofSize: UIFont.labelFontSize)
        wikiTextView.font = UIFont.systemFont(ofSize: CGFloat(36))
        
        // 文字の中央寄せ
        wikiTextView.textAlignment = NSTextAlignment.center
        
      
//        wikiTextView.contentVerticalAlignment = UIControlContentVerticalAlignment.Center
        
        
    }
    
    // この Delegate の実装しない場合はデフォルトで URL を Safari で開く。
    func wikiTextView(_ wikiTextView: UITextView,
                  shouldInteractWith URL: URL,
                  in characterRange: NSRange,
                  interaction: UITextItemInteraction) -> Bool {
        
        // UIApplication.shared.open(URL)
        let controller = SFSafariViewController(url: URL)
        self.present(controller, animated: true)
        
        return false
    
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
