//
//  questionViewController.swift
//  quiz
//
//  Created by 濱野将士 on 2017/11/16.
//  Copyright © 2017年 Masashi Hamano. All rights reserved.
//

import UIKit
import AVFoundation

//ゲームに関係する定数
struct QuizStruct {
    static let timerDuration: Double = 10
    static let dataMaxCount: Int = 10
    static let defaultCounter: Int = 10
}

class questionViewController: UIViewController, UINavigationBarDelegate, UITextViewDelegate {
    
    
    @IBOutlet weak var QuestionLabel: UILabel!
    @IBOutlet weak var QuestionImage: UIImageView!
    
    @IBOutlet weak var answerBtn1: UIButton!
    @IBOutlet weak var answerBtn2: UIButton!
    @IBOutlet weak var answerBtn3: UIButton!
    @IBOutlet weak var answerBtn4: UIButton!
    
    @IBOutlet weak var resultImage: UIImageView!
    @IBOutlet weak var Next: UIButton!
    
    @IBOutlet weak var timerDisplayLabel: UILabel!
    @IBOutlet weak var problemCountLabel: UILabel!
    
    
    //プロパティリストから読み込んだデータを格納する配列、問題の内容を入れておくメンバ変数
    var GodList:[NSDictionary] = []
    //選択されたエリア名を保存するメンバ変数
    var godName = ""
    var quiznum = 1
    var myCount = 1
    
    var CorrectAnswer = String()
    var myButtonAry: [UIButton] = []

    var correctNum = String()
    
    var yesAudioPlayer: AVAudioPlayer! = nil
    var noAudioPlayer: AVAudioPlayer! = nil
//////時間制限バーここから////////
    // 時間計測用の変数.
    var count : Float = 0
    // 時間表示用のラベル.
    var myLabel : UILabel!
    // 停止/再開ボタン
    var stopBtn:UIButton!
    var startBtn:UIButton!
    // タイマー
    var timer : Timer!
    // 一時停止の際の時間を格納する
    var pauseTime:Float = 0
    // スクリーン画面のサイズを取得
    let scWid: CGFloat = UIScreen.main.bounds.width     //画面の幅
    let scHei: CGFloat = UIScreen.main.bounds.height    //画面の高さ
    
    var barImageView:UIImageView!
    
//////時間制限バーここまで////////
//////タイマーここから///////////
    //タイマー関連のメンバ変数
    var pastCounter: Int = 10
    var perSecTimer: Timer? = nil
    var doneTimer: Timer? = nil
    
    //正解数
    var correctProblemNumber: Int = 0
    
    //画面出現しきったタイミングに読み込まれる処理
    override func viewDidAppear(_ animated: Bool) {
        
        //ラベルを表示を「TIME:10」という表記へ変更
        timerDisplayLabel.text = "TIME:" + String(self.pastCounter)
        
        //ボタンを全て活性状態にする
        allAnswerBtnEnabled()
        
        //タイマーをセットする
        setTimer()
    }
    
    //画面が消えるタイミングに読み込まれる処理
    override func viewWillDisappear(_ animated: Bool) {
        
        //タイマーをリセットしておく
        resetTimer()
    }
/////////////////////
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
/////////////////////
        yesSound()
        noSound()
//////タイマーここまで///////////
    //時間制限バー表示
        timebar()
    //非表示にする
        Hide()
    //問題表示する
        RandomQuestions()
    //ゲーム内容リセットする
        resetGameValues()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
 /////////ここから/////////////
    //タイマーをセットするメソッド
    func setTimer() {
        
        //毎秒ごとにperSecTimerDoneメソッドを実行するタイマーを作成する
        self.perSecTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(questionViewController.perSecTimerDone), userInfo: nil, repeats: true)
        
        //指定秒数後にtimerDoneメソッドを実行するタイマーを作成する（問題の時間制限に到達した場合の実行）
        self.doneTimer = Timer.scheduledTimer(timeInterval: QuizStruct.timerDuration, target: self, selector: #selector(questionViewController.timerDone), userInfo: nil, repeats: true)
    }
    
    //毎秒ごとのタイマーで呼び出されるメソッド
    @objc func perSecTimerDone() {
        pastCounter -= 1
        timerDisplayLabel.text = "TIME:" + String(self.pastCounter)
       
    }
    
    //問題の時間制限に到達した場合に実行されるメソッド
    @objc func timerDone() {

    }
    
    //タイマーを破棄して再起動を行うメソッド
    func reloadTimer() {
        
        //タイマーを破棄する
        resetTimer()
        
        //結果表示ページへ遷移するか次の問題を表示する
        compareNextProblemOrResultView()
    }
    
/////////ここまで/////////////
    
    
    //画面が表示される時、常に発動
    override func viewWillAppear(_ animated: Bool) {

        RandomQuestions()
        //AppDelegateにアクセス
        let question = UIApplication.shared.delegate as! AppDelegate

    }
    
/////////ここから問題出題/////////////
    
    //4択問題を出題
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
        
        //不正解を三回繰り返す
        //正解をリストから削除する
        //for文の中で正解の神様を当て込む
        //ランダムナンバーを埋め込む　あまりを出す
        
        
        //選択ボタンを表示
        var selectBtn = [answerBtn1,answerBtn2,answerBtn3,answerBtn4]
        for i in 0...3{
            RandomNumber = Int(arc4random() % 31)
            RandomNumber += 1
            QuestionImage.image = UIImage(named:detailInfo["image"] as! String)
            let detailInfo = GodList[RandomNumber]
            
            print(detailInfo["name"] as! String)
            selectBtn[i]?.setTitle(detailInfo["name"] as? String, for: UIControlState())
        }
        
        //正解とボタンを一致させる
        var correctNumber:Int = Int(arc4random() % 4)
        correctNumber += 1
        CorrectAnswer = String(correctNumber)
        
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
        
        
        
        
        
        
      
     
//        for dic in (detailInfo["name"] as! String) {
//            let num = arc4random_uniform(31)
//            print(num)
//
//
//            let detailInfo = GodList[RandomNumber]
//            print(detailInfo["name"] as! String)
//
//
//        }
        
//        var incorrectBtn = [answerBtn1,answerBtn2,answerBtn3,answerBtn4]
//        for i in 0...3{
//            RandomNumber = Int(arc4random() % 31)
//            RandomNumber += 1
//
//            let detailInfo = GodList[RandomNumber]
//
//            print(detailInfo["name"] as! String)
//            incorrectBtn[i]?.setTitle(detailInfo["name"] as? String, for: UIControlState())
//        }


        
//            if CorrectAnswer == "1" {
//                incorrect.setTitle(detailInfo["name"] as? String, for: UIControlState())
//            }else if CorrectAnswer == "2"{
//                answerBtn2.setTitle(detailInfo["name"] as? String, for: UIControlState())
//            }else if CorrectAnswer == "3"{
//                answerBtn3.setTitle(detailInfo["name"] as? String, for: UIControlState())
//            }else if CorrectAnswer == "4"{
//                answerBtn4.setTitle(detailInfo["name"] as? String, for: UIControlState())
//            }else{
//            }
//
//            let detailInfo = GodList[RandomNumber]
//
//            print(detailInfo["name"] as! String)
//            incorrectBtn[i]?.setTitle(detailInfo["name"] as? String, for: UIControlState())
//
        
        
        
        
//        if (CorrectAnswer == "1"){
//            var incorrectBtn = [answerBtn2,answerBtn3,answerBtn4]
//            for i in 0...2{
//            RandomNumber = Int(arc4random() % 31)
//            correctProblemNumber += 1
//            let detailInfo = GodList[RandomNumber]
//            print(detailInfo["name"] as! String)
//            incorrectBtn[i]?.setTitle(detailInfo["name"] as? String, for: UIControlState())
//            }else {
//        }
//        }
        
        
        
        
    
/////////////
        
        
        //正解の問題を表示
//        for dic in (detailInfo["name"] as! String) {
//            let num = arc4random_uniform(31)
//            print(num)
//            QuestionImage.image = UIImage(named:detailInfo["image"] as! String)
//            answerBtn1.setTitle(detailInfo["name"] as? String, for: UIControlState())
//            CorrectAnswer = "1"
//
//        }
////        正解以外の問題を表示
//        var incorrectBtn = [answerBtn2,answerBtn3,answerBtn4]
//        for i in 0...2{
//            RandomNumber = Int(arc4random() % 31)
//            RandomNumber += 1
//
//            let detailInfo = GodList[RandomNumber]
//
//            print(detailInfo["name"] as! String)
//            incorrectBtn[i]?.setTitle(detailInfo["name"] as? String, for: UIControlState())
//        }



  ///////////////
    
        
        
        
        
   }
    
/////////問題終了後ここから/////////////
    
    //結果表示ページへ遷移するか次の問題を表示するかを決めるメソッド
    func compareNextProblemOrResultView() {
        
        if quiznum == QuizStruct.dataMaxCount {
            
//           （※処理）規定回数まで到達した場合は次の画面へ遷移する
            
            //タイマーを破棄する
            resetTimer()
            
            //次のコントローラーへ遷移する
            self.performSegue(withIdentifier: "showScore", sender: nil)
            
        } else {
            
//          （※処理）規定回数に達していない場合はカウントをリセットして次の問題を表示する
 
            //ボタンを全て活性にする
            allAnswerBtnEnabled()
            
            //ラベルの値を再セットする
            timerDisplayLabel.text = "TIME:" + String(pastCounter)
            
            //タイマーをセットする
            setTimer()
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
            
            //計算結果を入れる変数を初期化
            resetGameValues()
        }
    }
    
    //タイマー処理を全てリセットするメソッド
    func resetTimer() {
        perSecTimer!.invalidate()
        doneTimer!.invalidate()
    }
    
    //ゲームのカウントに関する数を初期化する
    func resetGameValues() {
        quiznum = 0
        correctProblemNumber = 0
        
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
            yesSound()
            correctProblemNumber += 1
            allAnswerBtnDisabled()
        }else{
            resultImage.image = UIImage(named: "no.png")
            noSound()
            allAnswerBtnDisabled()
        }
    }
    @IBAction func answerBtn2Act(_ sender: Any) {
        UnHide()
        if (CorrectAnswer == "2"){
            resultImage.image = UIImage(named: "yes.png")
            yesSound()
            correctProblemNumber += 1
            allAnswerBtnDisabled()
        }else{
            resultImage.image = UIImage(named: "no.png")
            noSound()
            allAnswerBtnDisabled()
        }
    }
    @IBAction func answerBtn3Act(_ sender: Any) {
        UnHide()
        if (CorrectAnswer == "3"){
            resultImage.image = UIImage(named: "yes.png")
            yesSound()
            correctProblemNumber += 1
            allAnswerBtnDisabled()
        }else{
            resultImage.image = UIImage(named: "no.png")
            noSound()
            allAnswerBtnDisabled()
        }
    }
    @IBAction func answerBtn4Act(_ sender: Any) {
        UnHide()
        if (CorrectAnswer == "4"){
            resultImage.image = UIImage(named: "yes.png")
            yesSound()
            correctProblemNumber += 1
            allAnswerBtnDisabled()
        }else{
            resultImage.image = UIImage(named: "no.png")
            noSound()
            allAnswerBtnDisabled()
        }
    }

    
    //10問終了後にスコア画面へ移動
    @IBAction func Next(_ sender: Any) {
        RandomQuestions()
        Hide()
        timebar()
        
        quiznum += 1
        print("今\(quiznum)問目")
        
        myCount += 1
        //カウントアップした数字をラベルに表示
        problemCountLabel.text = "Q\(myCount)."
        
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
    
    //////時間制限バーここから////////
    func timebar() {
        // 制限時間バーの高さ・幅
        let barHeight = scHei*0.015
        let barWidth = scWid*0.855
        
        // 制限時間バーのX(横)座標・Y(縦)座標・終端のX座標
        let barXPosition = scWid*0.1
        let barYPosition = scHei*0.085
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
        UIView.animate(withDuration: 10, delay: 0.0, options : UIViewAnimationOptions.curveLinear, animations: {() -> Void  in
            
            // アニメーション終了後の座標とサイズを指定
            self.barImageView.frame = CGRect(x: barXPositionEnd, y: barYPosition, width: 0, height: barHeight)
        },
                       completion: {(finished: Bool) -> Void in
                        // アニメーション終了後の処理
                        //                        //次のコントローラーへ遷移する
                        //                        self.performSegue(withIdentifier: "showScore", sender: nil)
                        //10秒経過時は不正解として次の問題を読み込む
                        self.pastCounter = QuizStruct.defaultCounter
                        //タイマーを再設定する
                        //                        self.reloadTimer()
                        
        })
    }
    //////時間制限バーここまで////////
    
    
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
    
    
    //↓の前に、正解不正解を一致させて正解をランダムに10問出題(現状答えが1のみ)
    
    //10秒経過した時に【不正解ボタン】を押された時と同じにする
    
    
    //やりすぎるとエラーになる現象
    //2回目やると時間バーがずれる
    //音がならない

    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
