//
//  questionViewController.swift
//  quiz
//
//  Created by 濱野将士 on 2017/11/16.
//  Copyright © 2017年 Masashi Hamano. All rights reserved.
//

import UIKit
import AVFoundation


class questionViewController: UIViewController, UINavigationBarDelegate, UITextViewDelegate {
    
    
    @IBOutlet weak var QuestionLabel: UILabel!
    @IBOutlet weak var QuestionImage: UIImageView!
    
    @IBOutlet weak var answerBtn1: UIButton!
    @IBOutlet weak var answerBtn2: UIButton!
    @IBOutlet weak var answerBtn3: UIButton!
    @IBOutlet weak var answerBtn4: UIButton!
    
    @IBOutlet weak var resultImage: UIImageView!
    @IBOutlet weak var Next: UIButton!
    
    @IBOutlet weak var problemCountLabel: UILabel!
    
    
    //プロパティリストから読み込んだデータを格納する配列、問題の内容を入れておくメンバ変数
    var GodList:[NSDictionary] = []
    //選択されたエリア名を保存するメンバ変数
    var godName = ""
    //問題数
    var quiznum = 1
    //正解ボタン
    var CorrectAnswer = String()
    //正解数
    var correctProblemNumber: Int = 0
    //正解音
    var yesAudioPlayer: AVAudioPlayer! = nil
    //不正解音
    var noAudioPlayer: AVAudioPlayer! = nil
    
    //時間制限バーの画面
    var barImageView:UIImageView!
    //画面の幅
    let scWid: CGFloat = UIScreen.main.bounds.width
    //画面の高さ
    let scHei: CGFloat = UIScreen.main.bounds.height
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

    //時間制限バーを表示
        timebar()
    //非表示にする
        Hide()
    //問題表示する
        RandomQuestions()
    //問題ナンバーをリセットする
        resetproblemCount()
    //正解・不正解の音
        yesSound()
        noSound()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
/////////ここから問題出題/////////////
   
    func RandomQuestions(){
        var RandomNumber:Int = Int(arc4random() % 31)
        RandomNumber += 1
        allAnswerBtnEnabled()
        QuestionLabel.text = "What is my name?"
        
        //ファイルパスを取得(エリア名が格納されているプロパティリスト)
        let filePath = Bundle.main.path(forResource:"GodList", ofType:"plist")
        // プロパティリストからデータを取得（Dictionary型）
        let dic = NSDictionary(contentsOfFile: filePath!)
        
        //画像ファイル名を格納する配列を作成
        for(key,data) in dic!{
                        print(data)
                        print(key)
            
            var goddic:NSDictionary = data as! NSDictionary
            var godinfo:NSDictionary = ["name":key,"image":goddic["image"]]
            
                        GodList.append(godinfo)
        }
        
        //今画面に表示したいデータの取得
        let detailInfo = GodList[RandomNumber]
        
        //Dictionaryからキー指定で取り出すと必ずAny型になるのでダウンキャスト変換が必要
        print(detailInfo["image"] as! String)
        print(detailInfo["name"] as! String)
       
        for(key,data) in dic!{
            print(data)
            print(key)
            
            var _:NSDictionary = data as! NSDictionary
        }

        //不正解の選択肢を出題
        GodList.remove(at: RandomNumber)
        var QList = GodList

            var selectBtn = [answerBtn1,answerBtn2,answerBtn3,answerBtn4]
            for i in 0...3{
                RandomNumber = Int(arc4random()) % QList.count
                
            let detailInfo = QList[RandomNumber] as! NSDictionary
            print(detailInfo["name"] as! String)
            selectBtn[i]?.setTitle(detailInfo["name"] as? String, for: UIControlState())
                
                //1回利用した選択肢を削除する
                QList.remove(at: RandomNumber)
                
            }
        
        //正解とボタンを一致させる
        var correctNumber:Int = Int(arc4random() % 4)
        correctNumber += 1
        CorrectAnswer = String(correctNumber)
        QuestionImage.image = UIImage(named:detailInfo["image"] as! String)
        
        if CorrectAnswer == "1" {
            answerBtn1.setTitle(detailInfo["name"] as? String, for: UIControlState())
        }else if CorrectAnswer == "2"{
            answerBtn2.setTitle(detailInfo["name"] as? String, for: UIControlState())
        }else if CorrectAnswer == "3"{
            answerBtn3.setTitle(detailInfo["name"] as? String, for: UIControlState())
        }else if CorrectAnswer == "4"{
            answerBtn4.setTitle(detailInfo["name"] as? String, for: UIControlState())
        }else{
        }
   }
    
    //セグエを呼び出したときに呼ばれるメソッド
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //セグエ名で判定を行う
        if segue.identifier == "showScore" {
            //遷移先のコントローラーの変数を用意する
            let ScoreViewController = segue.destination as! ScoreViewController
            //遷移先のコントローラーに渡したい変数を格納（型を合わせる）
            ScoreViewController.correctProblemNumber = correctProblemNumber
        }
    }
    
    //問題数を初期化する
    func resetproblemCount(){
        quiznum = 1
    }
    
/////////ここまで/////////////
    
    //非表示にする関数
    func Hide(){
        resultImage.isHidden = true
        Next.isHidden = true
    }
    func UnHide(){
        resultImage.isHidden = false
        Next.isHidden = false
    }
    
    //全ボタンを非活性にする
    func allAnswerBtnDisabled() {
        answerBtn1.isEnabled = false
        answerBtn2.isEnabled = false
        answerBtn3.isEnabled = false
        answerBtn4.isEnabled = false
    }
    //全ボタンを活性にする
    func allAnswerBtnEnabled() {
        answerBtn1.isEnabled = true
        answerBtn2.isEnabled = true
        answerBtn3.isEnabled = true
        answerBtn4.isEnabled = true
    }
    
    //◯,×の画像表示
    @IBAction func answerBtn1Act(_ sender: Any) {
        UnHide()
        if (CorrectAnswer == "1"){
            resultImage.image = UIImage(named: "yes.png")
            yesAudioPlayer.play()
            correctProblemNumber += 1
            allAnswerBtnDisabled()
            timerbarStop()
        }else{
            resultImage.image = UIImage(named: "no.png")
            noAudioPlayer.play()
            allAnswerBtnDisabled()
            timerbarStop()
        }
    }
    @IBAction func answerBtn2Act(_ sender: Any) {
        UnHide()
        if (CorrectAnswer == "2"){
            resultImage.image = UIImage(named: "yes.png")
            yesAudioPlayer.play()
            correctProblemNumber += 1
            allAnswerBtnDisabled()
            timerbarStop()
        }else{
            resultImage.image = UIImage(named: "no.png")
            noAudioPlayer.play()
            allAnswerBtnDisabled()
            timerbarStop()
        }
    }
    @IBAction func answerBtn3Act(_ sender: Any) {
        UnHide()
        if (CorrectAnswer == "3"){
            resultImage.image = UIImage(named: "yes.png")
            yesAudioPlayer.play()
            correctProblemNumber += 1
            allAnswerBtnDisabled()
            timerbarStop()
        }else{
            resultImage.image = UIImage(named: "no.png")
            noAudioPlayer.play()
            allAnswerBtnDisabled()
            timerbarStop()
        }
    }
    @IBAction func answerBtn4Act(_ sender: Any) {
        UnHide()
        if (CorrectAnswer == "4"){
            resultImage.image = UIImage(named: "yes.png")
            yesAudioPlayer.play()
            correctProblemNumber += 1
            allAnswerBtnDisabled()
            timerbarStop()
        }else{
            resultImage.image = UIImage(named: "no.png")
            noAudioPlayer.play()
            allAnswerBtnDisabled()
            timerbarStop()
        }
    }
    
    //NEXTボタンのアクション
    @IBAction func Next(_ sender: Any) {
        RandomQuestions()
        Hide()
        timebar()
        timerbarReset()
        
        //問題数の表示
        quiznum += 1
//          print("今\(quiznum)問目")
        //カウントアップした数字をラベルに表示
        problemCountLabel.text = "Q\(quiznum)."
        
        //10問終わったらscore画面へ遷移
        if quiznum == 11{
            print("正解数：\(correctProblemNumber)")
            self.performSegue(withIdentifier: "showScore", sender: nil)
            
            //ゲーム画面→結果表示画面のViewControllerにプロパティの値を渡す
            func prepare(for segue: UIStoryboardSegue, sender: Any?) {
                let newVC = segue.destination as! ScoreViewController
                newVC.correctProblemNumber = self.correctProblemNumber
            }
        }
    }
    
//////タイマー関連ここから////////
    
    func timebar() {
        // 制限時間バーの高さ・幅
        let barHeight = scHei*0.015
        let barWidth = scWid*0.855
        
        // 制限時間バーのX(横)座標・Y(縦)座標・終端のX座標
        let barXPosition = scWid*0.1
        let barYPosition = scHei*0.025
        let barXPositionEnd = barXPosition + barWidth
        
        // UIImageViewを初期化
        barImageView = UIImageView()

        // 画像の表示する座標を指定する
        barImageView.frame = CGRect(x: barXPosition ,y: barYPosition ,width: barWidth ,height: barHeight)
        
        // バーに色を付ける
        barImageView.backgroundColor = .green
        
        //　ラベル枠の枠線太さと色
        barImageView.layer.borderColor = UIColor.white.cgColor
        barImageView.layer.borderWidth = 2
        
        // barImageViewをViewに追加する
        self.view.addSubview(barImageView)
        
        // バーをアニメーションさせる
        // 10秒かけてバーを左側から等速で減少させる
        UIView.animate(withDuration: 5, delay: 0.0, options : UIViewAnimationOptions.curveLinear, animations: {() -> Void  in
            
        // アニメーション終了後の座標とサイズを指定
        self.barImageView.frame = CGRect(x: barXPositionEnd, y: barYPosition, width: 0, height: barHeight)
        },
                       
            completion: {(finished: Bool) -> Void in
                
        // アニメーション終了後の処理
        self.resultImage.image = UIImage(named: "no.png")
        self.UnHide()
//          self.resultImage.isHidden = false
        self.view.bringSubview(toFront: self.resultImage)
        self.noAudioPlayer.play()
        self.allAnswerBtnDisabled()
                        
        })
    }
    
    
    //時間制限バーの一時停止
    func timerbarStop(){
        pauseLayer(layer: barImageView.layer)
    }
    
    func pauseLayer(layer: CALayer) {
        let pausedTime: CFTimeInterval = layer.convertTime(CACurrentMediaTime(), from: nil)
        layer.speed = 0.0
        layer.timeOffset = pausedTime
    }
    
    //時間制限バーのリセット
    func timerbarReset(){
        resumeLayer(layer: barImageView.layer)
    }
    
    func resumeLayer(layer: CALayer) {
        let pausedTime: CFTimeInterval = layer.timeOffset
        layer.speed = 1.0
        layer.timeOffset = 0.0
        layer.beginTime = 0.0
        let timeSincePause: CFTimeInterval = layer.convertTime(CACurrentMediaTime(), from: nil) - pausedTime
        layer.beginTime = timeSincePause
    }
    
    
    
//    resetEmitterLayer:(id)sender
    
    
    
//////タイマー関連ここまで////////
    
    
    func yesSound() {
        // サウンドファイルのパスを生成
        let soundFile = Bundle.main.path(forResource: "yes", ofType: "mp3")! as NSString
        let soundClear = URL(fileURLWithPath: soundFile as String)
        //AVAudioPlayerのインスタンス化
        do {
            yesAudioPlayer = try AVAudioPlayer(contentsOf: soundClear as URL, fileTypeHint:nil)
        }catch{
            print("AVAudioPlayerインスタンス作成失敗")
        }
        yesAudioPlayer.prepareToPlay()
    }
    
    func noSound() {
        // サウンドファイルのパスを生成
        let soundFile = Bundle.main.path(forResource: "no", ofType: "mp3")! as NSString
        let soundClear = URL(fileURLWithPath: soundFile as String)
        //AVAudioPlayerのインスタンス化
        do {
            noAudioPlayer = try AVAudioPlayer(contentsOf: soundClear as URL, fileTypeHint:nil)
        }catch{
            print("AVAudioPlayerインスタンス作成失敗")
        }
        noAudioPlayer.prepareToPlay()
    }
    

    
    //選択肢が重複する
    
    //11問目が一瞬表示され、不正解音が鳴る
    //タイマーのアニメーションが戻らない
    
    
    //CustomTableViewCellうまく接続できず
    
    //オートレイアウト
    //wikipedia　→　plistからnameと連動させる、中央寄せ
    //多言語化対応
    
    
    //時々エラーになる



    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
