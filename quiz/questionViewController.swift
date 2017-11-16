//
//  questionViewController.swift
//  quiz
//
//  Created by 濱野将士 on 2017/11/16.
//  Copyright © 2017年 Masashi Hamano. All rights reserved.
//

import UIKit

class questionViewController: UIViewController {
    
    // スクリーン画面のサイズを取得
    let scWid: CGFloat = UIScreen.main.bounds.width  //画面の幅
    let scHei: CGFloat = UIScreen.main.bounds.height  //画面の高さ
    var barImageView:UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 制限時間バーの高さ・幅
        let barHeight = scHei*0.015
        let barWidth = scWid*0.8
        
        // 制限時間バーのX座標・Y座標・終端のX座標
        let barXPosition = scWid*0.3
        let barYPosition = scHei*0.3
        let barXPositionEnd = barXPosition + barWidth
        
        // UIImageViewを初期化
        barImageView = UIImageView()
        
        // 画像の表示する座標を指定する
        barImageView.frame = CGRect(x: barXPosition ,y: barYPosition ,width: barWidth ,height: barHeight)
        
        // バーに色を付ける
        barImageView.backgroundColor = .orange
        
        //　ラベル枠の枠線太さと色
        barImageView.layer.borderColor = UIColor.green.cgColor
        barImageView.layer.borderWidth = 2
        
        // barImageViewをViewに追加する
        self.view.addSubview(barImageView)
        
        // バーをアニメーションさせる
        // 10秒かけてバーを左側から等速で減少させる
        UIView.animate(withDuration: 10, delay: 0.0, options : UIViewAnimationOptions.curveLinear, animations: {() -> Void  in
        // アニメーション終了後の座標とサイズを指定
            self.barImageView.frame = CGRect(x: barXPositionEnd, y: barYPosition, width: 0, height: barHeight)
        },
                       completion: {(finished: Bool) -> Void in  // アニメーション終了後の処理
        })
    }

    
    
    @IBAction func answerBtn1(_ sender: UIButton) {
    }
    @IBAction func answerBtn2(_ sender: UIButton) {
    }
    @IBAction func answerBtn3(_ sender: UIButton) {
    }
    @IBAction func answerBtn4(_ sender: UIButton) {
        
    //アクションシートを作る
        let alertController = UIAlertController(
            title: "正解",message: "別名",
            preferredStyle: UIAlertControllerStyle.actionSheet)
        
    //wikipediaへのリンクボタンを追加
        alertController.addAction(UIAlertAction(
            title: "Wikipediaへ",
            style: .default,
            handler: { detail in self.wikipwdia("詳細画面へ") } ))
        
    // 次の問題ボタンを追加
        alertController.addAction(UIAlertAction(
            title: "次の問題へ",
            style: .cancel,
            handler: { action in self.next() } ))
        
        // アラートを表示する
        present(alertController, animated: true, completion: nil)
        
    }
    
    // wikipediaが選択されたとき呼ばれるメソッド
    func wikipwdia(_ activitiy:String!) {
        print("詳細画面へ")
    }
    // 次の問題が押されたとき呼ばれるメソッド
    func next() {
        print("次の問題")
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
