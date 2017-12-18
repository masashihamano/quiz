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

    //プロパティリストから読み込んだデータを格納する配列、問題の内容を入れておくメンバ変数
    var GodList:[NSDictionary] = []
    //選択された名前を保存するメンバ変数
    var godName = ""
    //問題数
    var quiznum = 1
    //問題数をカウント
    var count = 0
    //正解ボタン
    var CorrectAnswer = String()
    //正解数
    var correctProblemNumber: Int = 0
    //正解音
    var yesAudioPlayer: AVAudioPlayer! = nil
    //不正解音
    var noAudioPlayer: AVAudioPlayer! = nil
    //nextボタンの音
    var nextAudioPlayer: AVAudioPlayer! = nil
    
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
        nextSound()
        
    //アウトレットでnextボタンの画像を設定
        Next.setImage(UIImage(named: "next,png"), for: .normal)
    //問題文の文字設定
        QuestionLabel.font = UIFont.boldSystemFont(ofSize: 23)
        QuestionLabel.layer.cornerRadius = 5.0
        QuestionLabel.layer.masksToBounds = true
    //問題画像の枠
        QuestionImage.layer.cornerRadius = 5.0
        QuestionImage.layer.masksToBounds = true
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
/////////ここから問題出題/////////////
   
    func RandomQuestions(){
        var RandomNumber:Int = Int(arc4random() % 35)
        RandomNumber += 1
        allAnswerBtnEnabled()
        
        //問題数の表示
        count += 1
        //問題文
        QuestionLabel.text = "Q\(count)." + NSLocalizedString("question", comment: "")
        
        //ファイルパスを取得(神様が格納されているプロパティリスト)
        let filePath = Bundle.main.path(forResource:"GodList", ofType:"plist")
        // プロパティリストからデータを取得（Dictionary型）
        let dic = NSDictionary(contentsOfFile: filePath!)
        
        //画像ファイル名を格納する配列を作成
        for(key,data) in dic!{
                        print(data)
                        print(key)
            
            let goddic:NSDictionary = data as! NSDictionary
//            let godinfo:NSDictionary = ["name":key,"image":goddic["image"]!]
            let godinfo:NSDictionary = ["name":goddic["name"] as Any,"image":goddic["image"]!]
            
            
            
                        GodList.append(godinfo)
        }
        
        //今画面に表示したいデータの取得
        var detailInfo = GodList[RandomNumber]

        //Dictionaryからキー指定で取り出すと必ずAny型になるのでダウンキャスト変換が必要
        print(detailInfo["image"] as! String)
//        print(detailInfo["name"] as! String)
        print(detailInfo[NSLocalizedString("name",comment: "")] as! String)
  
        
//例え            wikiurl = detailInfo[NSLocalizedString("wikiLink",comment: "")] as! String
        
        
        for(key,data) in dic!{
            print(data)
            print(key)

            var _:NSDictionary = data as! NSDictionary
        }

        //4択を表示（不正解）
        //正解の神様の名前取得
        var correctGod = GodList[RandomNumber] as! NSDictionary
        
        //正解の神様を4択から除外
        GodList.remove(at: RandomNumber)
        
        var QList:[NSDictionary] = []
        
        for god in GodList {
            if correctGod != god {
                print(god[NSLocalizedString("name",comment: "")] as! String)
                
//例え            wikiurl = detailInfo[NSLocalizedString("wikiLink",comment: "")] as! String
                
                 QList.append(god)
            }
        }

            var selectBtn = [answerBtn1,answerBtn2,answerBtn3,answerBtn4]
            for i in 0...3{
                
            let incorrectRandomNumber = Int(arc4random()) % QList.count
                
            let detailInfo = QList[incorrectRandomNumber]
                print(incorrectRandomNumber, 1)
                print(incorrectRandomNumber, 2)
                print(incorrectRandomNumber, 3)
                print(incorrectRandomNumber, 4)
//            print(detailInfo["name"] as! String)
//            selectBtn[i]?.setTitle(detailInfo["name"] as? String, for: UIControlState())
            print(detailInfo[NSLocalizedString("name",comment: "")] as! String)
            selectBtn[i]?.setTitle(detailInfo[NSLocalizedString("name",comment: "")] as? String, for: UIControlState())
                
//例え            wikiurl = detailInfo[NSLocalizedString("wikiLink",comment: "")] as! String
                
                
                //オブジェクトを削除、1回使用した選択肢を削除する
                QList.remove(object: detailInfo)

        }
        
        //正解とボタンを一致させる
        var correctNumber:Int = Int(arc4random() % 4)
        correctNumber += 1
        CorrectAnswer = String(correctNumber)
        QuestionImage.image = UIImage(named:detailInfo["image"] as! String)
        
        if CorrectAnswer == "1" {
            answerBtn1.setTitle(detailInfo[NSLocalizedString("name",comment: "")] as? String, for: UIControlState())
//            answerBtn1.setTitle(detailInfo["name"] as? String, for: UIControlState())
        }else if CorrectAnswer == "2"{
            answerBtn2.setTitle(detailInfo[NSLocalizedString("name",comment: "")] as? String, for: UIControlState())
//            answerBtn2.setTitle(detailInfo["name"] as? String, for: UIControlState())
        }else if CorrectAnswer == "3"{
            answerBtn3.setTitle(detailInfo[NSLocalizedString("name",comment: "")] as? String, for: UIControlState())
//            answerBtn3.setTitle(detailInfo["name"] as? String, for: UIControlState())
        }else if CorrectAnswer == "4"{
            answerBtn4.setTitle(detailInfo[NSLocalizedString("name",comment: "")] as? String, for: UIControlState())
//            answerBtn4.setTitle(detailInfo["name"] as? String, for: UIControlState())
        }else{
        }
    }
    
//例え     wikiurl = detailInfo[NSLocalizedString("wikiLink",comment: "")] as! String
    
    
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
    //ボタン1が押された時
    @IBAction func answerBtn1Act(_ sender: Any) {
        UnHide()
        if (CorrectAnswer == "1"){
            resultImage.image = UIImage(named: "yes.png")
            resultImage.alpha = 0.9
            yesAudioPlayer.play()
            correctProblemNumber += 1
            allAnswerBtnDisabled()
            timerbarStop()
            nextBtn()
        }else{
            resultImage.image = UIImage(named: "no.png")
            resultImage.alpha = 0.9
            noAudioPlayer.play()
            allAnswerBtnDisabled()
            timerbarStop()
            nextBtn()
        }
    }
    //ボタン2が押された時
    @IBAction func answerBtn2Act(_ sender: Any) {
        UnHide()
        if (CorrectAnswer == "2"){
            resultImage.image = UIImage(named: "yes.png")
            resultImage.alpha = 0.9
            yesAudioPlayer.play()
            correctProblemNumber += 1
            allAnswerBtnDisabled()
            timerbarStop()
            nextBtn()
        }else{
            resultImage.image = UIImage(named: "no.png")
            resultImage.alpha = 0.9
            noAudioPlayer.play()
            allAnswerBtnDisabled()
            timerbarStop()
            nextBtn()
        }
    }
    //ボタン3が押された時
    @IBAction func answerBtn3Act(_ sender: Any) {
        UnHide()
        if (CorrectAnswer == "3"){
            resultImage.image = UIImage(named: "yes.png")
            resultImage.alpha = 0.9
            yesAudioPlayer.play()
            correctProblemNumber += 1
            allAnswerBtnDisabled()
            timerbarStop()
            nextBtn()
        }else{
            resultImage.image = UIImage(named: "no.png")
            resultImage.alpha = 0.9
            noAudioPlayer.play()
            allAnswerBtnDisabled()
            timerbarStop()
            nextBtn()
        }
    }
    //ボタン4が押された時
    @IBAction func answerBtn4Act(_ sender: Any) {
        UnHide()
        if (CorrectAnswer == "4"){
            resultImage.image = UIImage(named: "yes.png")
            resultImage.alpha = 0.9
            yesAudioPlayer.play()
            correctProblemNumber += 1
            allAnswerBtnDisabled()
            timerbarStop()
            nextBtn()
        }else{
            resultImage.image = UIImage(named: "no.png")
            resultImage.alpha = 0.9
            noAudioPlayer.play()
            allAnswerBtnDisabled()
            timerbarStop()
            nextBtn()
        }
    }
    
    //NEXTボタンのアクション
    @IBAction func Next(_ sender: Any) {
        
        //アクションの引数に対して画像を設定
        Next.setImage(UIImage(named: "next.png"), for: .normal)
        
        //10問終わったらscore画面へ遷移
        if quiznum == 10{
            quiznum += 1
            
            print("正解数：\(correctProblemNumber)")
            self.performSegue(withIdentifier: "showScore", sender: nil)
       
            //ゲーム画面→結果表示画面のViewControllerにプロパティの値を渡す
            func prepare(for segue: UIStoryboardSegue, sender: Any?) {
                let newVC = segue.destination as! ScoreViewController
                newVC.correctProblemNumber = self.correctProblemNumber
            }
        }else{
            //10問目までのアクション
            quiznum += 1
            oldtimebarhide()
            RandomQuestions()
            Hide()
            timebar()
            nextAudioPlayer.play()
        }
    }
    
//////タイマー関連ここから////////
    
    func timebar() {
        // タイムバーの高さ・幅
        let barHeight = scHei*0.015
        let barWidth = scWid*0.87
        
        // タイムバーのX(横)座標・Y(縦)座標・終端のX座標
        let barXPosition = scWid*0.11
        let barYPosition = scHei*0.0375
        let barXPositionEnd = barXPosition + barWidth
        
        // UIImageViewを初期化
        barImageView = UIImageView()

        // 画像の表示する座標を指定する
        barImageView.frame = CGRect(x: barXPosition ,y: barYPosition ,width: barWidth ,height: barHeight)
        
        // バーに色を付ける
        barImageView.backgroundColor = .green
        
        //　バーの枠線太さと色
        barImageView.layer.borderColor = UIColor.white.cgColor
        barImageView.layer.borderWidth = 2
        
        // barImageViewをViewに追加する
        self.view.addSubview(barImageView)
        
        // バーをアニメーションさせる
        // 10秒かけてバーを左側から等速で減少させる
        UIView.animate(withDuration: 10, delay: 0.0, options : UIViewAnimationOptions.curveLinear, animations: {() -> Void  in
            
        // アニメーション終了後の座標とサイズを指定
        self.barImageView.frame = CGRect(x: barXPositionEnd, y: barYPosition, width: 0, height: barHeight)
        },
            completion: {(finished: Bool) -> Void in
                
                if self.quiznum < 11{
                    
                    // アニメーション終了後の処理
                    self.resultImage.image = UIImage(named: "no.png")
                    self.resultImage.alpha = 0.9
                    self.UnHide()
                    self.view.bringSubview(toFront: self.resultImage)
                    self.noAudioPlayer.play()
                    self.allAnswerBtnDisabled()
                    self.nextBtn()
                    
                }
        })
    }
    
    //時間制限バーの停止
    func timerbarStop(){
        pauseLayer(layer: barImageView.layer)
    }
    
    func pauseLayer(layer: CALayer) {
        let pausedTime: CFTimeInterval = layer.convertTime(CACurrentMediaTime(), from: nil)
        layer.speed = 0.0
        layer.timeOffset = pausedTime
    }
    
    //前の問題の時間制限バーを隠す
    func oldtimebarhide() {
            barImageView.isHidden = true
    }
    
//////タイマー関連ここまで////////
    
    //Nextボタンを表示させる
    func nextBtn(){
        let nextImg = Next.setImage(UIImage(named: "next.png"), for: .normal)
    }
    
    //正解音の作成
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
        yesAudioPlayer.volume = 0.05
        yesAudioPlayer.prepareToPlay()
    }
    
    //不正解音の作成
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
        noAudioPlayer.volume = 0.2
        noAudioPlayer.prepareToPlay()
    }
    
    //nextボタンの音を作成
    func nextSound() {
        // サウンドファイルのパスを生成
        let soundFile = Bundle.main.path(forResource: "next", ofType: "wav")! as NSString
        let soundClear = URL(fileURLWithPath: soundFile as String)
        //AVAudioPlayerのインスタンス化
        do {
            nextAudioPlayer = try AVAudioPlayer(contentsOf: soundClear as URL, fileTypeHint:nil)
        }catch{
            print("AVAudioPlayerインスタンス作成失敗")
        }
        nextAudioPlayer.volume = 0.2
        nextAudioPlayer.prepareToPlay()
    }
    
    
    
    //scoreランダム表示
    //多言語化対応 → name
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}

//重複を回避するためのエクステンション
extension Array where Element: Equatable {
    
    // すべてのオブジェクトを削除
    mutating func remove(object: Element) {
        if let index = index(of: object){
            self.remove(at: index)
            self.remove(object: object)
        }
    }
    
}
