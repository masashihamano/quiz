//
//  ViewController.swift
//  quiz
//
//  Created by 濱野将士 on 2017/11/12.
//  Copyright © 2017年 Masashi Hamano. All rights reserved.
//

import UIKit

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


class ViewController: UIViewController {
   
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBAction func startBtn(_ sender: UIButton) {
    }
    @IBAction func listBtn(_ sender: UIButton) {
    }
    @IBOutlet weak var myImageView: UIImageView!
    @IBOutlet weak var titleImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    //背景イメージ画像
        myImageView.image = UIImage(named: "background.jpg")
        myImageView.alpha = 0.1
    //タイトル画面イメージ
        titleImageView.image = UIImage(named: "title.jpg")
    }
    
    //【タブバー】画面が表示された時
    override func viewWillAppear(_ animated: Bool) {
        // AppDelegate にアクセスするための準備をして
        let myAp = UIApplication.shared.delegate as!  AppDelegate
        // プロパティの値を書き換える
        myAp.myCount += 1
        print("1画面目 count=\(myAp.myCount)")
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

