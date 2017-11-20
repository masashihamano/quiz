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
    
    //前の画面から受け取るためのプロパティ
    var getGodName = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print("getGodName:\(getGodName)")
        
        //ファイルパスを取得(エリア名が格納されているプロパティリスト)
        let filePath = Bundle.main.path(forResource: "GodList", ofType: "plist")
        
        //ファイルの内容を読み込んでディクショナリー型に格納
        let dic = NSDictionary(contentsOfFile: filePath!)
        
        //今画面に表示したいデータの取得
        let detailInfo = dic![getGodName] as! NSDictionary
        
        //Dictionaryからキー指定で取り出すと必ずAny型になるのでダウンキャスト変換が必要
        print(detailInfo["description"] as! String)
        print(detailInfo["tarait"] as! String)
        print(detailInfo["image"] as! String)
        
        //タイトルをナビゲーションバーの真ん中に表示
        self.title = getGodName
        navigationItem.title = getGodName
        
        //説明、画像
        detailTextView.text = detailInfo["description"] as! String
//        detailTextView.text = detailInfo["trait"] as! String
        detailImageView.image = UIImage(named:detailInfo["image"] as! String)
        
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
