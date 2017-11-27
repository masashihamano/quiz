//
//  DetailViewController.swift
//  quiz
//
//  Created by 濱野将士 on 2017/11/19.
//  Copyright © 2017年 Masashi Hamano. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var detailTextView: UITextView!
    @IBOutlet weak var detailImageView: UIImageView!
    
    @IBOutlet weak var wikiLabel: UILabel!
    
    
    
    //プロパティリストから読み込んだデータを格納する配列
    var GodList:[NSDictionary] = []
    //前の画面から受け取るためのプロパティ
    var getGodName = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let wikiString = "詳細はwikipediaへ"
        let attributedString = NSMutableAttributedString(string: wikiString)
        
        attributedString.addAttribute(.link,
                                      value: "https://www.wikipedia.org/",
                                      range: NSString(string: wikiString).range(of: "wikipedia"))
//        wikiLabel.attributedText = attributedString
//        wikiLabel.isSelectable = true
        
        
        print("getGodName:\(getGodName)")
        
        //ファイルパスを取得(エリア名が格納されているプロパティリスト)
        let filePath = Bundle.main.path(forResource: "GodList", ofType: "plist")
        
        //ファイルの内容を読み込んでディクショナリー型に格納
        let dic = NSDictionary(contentsOfFile: filePath!)
        
        //今画面に表示したいデータの取得
        let detailInfo = dic![getGodName] as! NSDictionary
        
        
        
//        // TableViewで扱いやすい配列（エリア名の入ってる配列）を作成
//        for(key,data) in dic!{
//        var godinfo:NSDictionary = ["name":key]
//        GodList.append(godinfo)
//
//        }
        
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
//        wikiLabel.text = detailInfo["wikipwdia"] as! String
        
        
//        let wikiLabel = NSMutableAttributedString(
//            string: string,
//            attributes: [wikipedia: NSURL(string: "http://www.wikipedia.org/")!])
        
        
        func wikiLabel(_ wikiLabel: UILabel!,
                      shouldInteractWith URL: URL,
                      in characterRange: NSRange,
                      interaction: UITextItemInteraction) -> Bool {
            
            UIApplication.shared.open(URL)
            
            return false
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
