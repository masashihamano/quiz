//
//  questionViewController.swift
//  quiz
//
//  Created by 濱野将士 on 2017/11/16.
//  Copyright © 2017年 Masashi Hamano. All rights reserved.
//

import UIKit


/////////ここコピペ/////////////
//回答した番号の識別用enum
enum Answer: Int {
    case one = 1
    case two = 2
    case three = 3
    case four = 4
}

//ゲームに関係する定数
struct QuizStruct {
    static let timerDuration: Double = 10
    static let dataMaxCount: Int = 5
    static let limitTimer: Double = 10.000
    static let defaultCounter: Int = 10
}
/////////ここまでコピペ/////////////

class questionViewController: UIViewController, UINavigationBarDelegate, UITextViewDelegate {
    
    //プロパティリストから読み込んだデータを格納する配列、問題の内容を入れておくメンバ変数
    var GodList:[NSDictionary] = []
    //選択されたエリア名を保存するメンバ変数
    var godName = ""
    
    //Quiz画面の作成
    
    
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
    
    
    var CorrectAnswer = String()
   
//////時間制限バー////////
    
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
    
//////時間制限バー////////
///////////////ここからコピペ//////////////////////
    //タイマー関連のメンバ変数
    var pastCounter: Int = 10
    var perSecTimer: Timer? = nil
    var doneTimer: Timer? = nil
    
    //問題関連のメンバ変数
    var counter: Int = 0
    
    //正解数と経過した時間
    var correctProblemNumber: Int = 0
    var totalSeconds: Double = 0.000
    
    //問題毎の回答時間を算出するための時間を一時的に格納するためのメンバ変数
    var tmpTimerCount: Double!
    
    //タイム表示用のメンバ変数
    var timeProblemSolvedZero: Date!  //画面表示時点の時間
    var timeProblemSolvedOne: Date!   //第1問回答時点の時間
    var timeProblemSolvedTwo: Date!   //第2問回答時点の時間
    var timeProblemSolvedThree: Date! //第3問回答時点の時間
    var timeProblemSolvedFour: Date!  //第4問回答時点の時間
    var timeProblemSolvedFive: Date!  //第5問回答時点の時間
    
//    //画面出現中のタイミングに読み込まれる処理
//    override func viewWillAppear(_ animated: Bool) {
//
//        RandomQuestions()
//
//
//    }
    
    //画面出現しきったタイミングに読み込まれる処理
    override func viewDidAppear(_ animated: Bool) {
        
        //ラベルを表示を「しばらくお待ちください...」から「あと10秒」という表記へ変更する
        timerDisplayLabel.text = "あと" + String(self.pastCounter) + "秒"
        
        //ボタンを全て活性状態にする
        allAnswerBtnEnabled()
        
        //1問目の解き始めの時間を保持する
        timeProblemSolvedZero = Date()
        
        //タイマーをセットする
        setTimer()
    }
    
    //画面が消えるタイミングに読み込まれる処理
    override func viewWillDisappear(_ animated: Bool) {
        
        //タイマーをリセットしておく
        resetTimer()
    }
/////////ここまでコピペ/////////////
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
    //非表示にする
        Hide()
    //問題表示する
        RandomQuestions()
        
//////時間制限バー////////
        // 制限時間バーの高さ・幅
        let barHeight = scHei*0.015
        let barWidth = scWid*0.8
        
        // 制限時間バーのX座標・Y座標・終端のX座標
        let barXPosition = scWid*0.5
        let barYPosition = scHei*9.0
        let barXPositionEnd = barXPosition + barWidth
        
        // UIImageViewを初期化
        barImageView = UIImageView()
        
        // 画像の表示する座標を指定する
        barImageView.frame = CGRect(x: barXPosition ,y: barYPosition ,width: barWidth ,height: barHeight)
        
        // バーに色を付ける
        barImageView.backgroundColor = .white
        
        //　ラベル枠の枠線太さと色
        barImageView.layer.borderColor = UIColor.orange.cgColor
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
                        
        })
    }
//////時間制限バーここまで////////
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
 /////////ここからコピペ/////////////
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
        timerDisplayLabel.text = "あと" + String(self.pastCounter) + "秒"
    }
    
    //問題の時間制限に到達した場合に実行されるメソッド
    @objc func timerDone() {
        
        //10秒経過時は不正解として次の問題を読み込む
        totalSeconds = self.totalSeconds + QuizStruct.limitTimer
        pastCounter = QuizStruct.defaultCounter
        
        switch counter {
        case 0:
            timeProblemSolvedOne = Date()
        case 1:
            timeProblemSolvedTwo = Date()
        case 2:
            timeProblemSolvedThree = Date()
        case 3:
            timeProblemSolvedFour = Date()
        case 4:
            timeProblemSolvedFive = Date()
        default:
            tmpTimerCount = 0.000
        }
        
        //該当の問題の回答番号を取得する
//        let targetProblem: NSDictionary = GodList[counter] as NSDictionary
//        let targetAnswer: Int = Int(targetProblem[1] as! String)!
        
        //カウンターの値に+1をする
//        counter += 1
        
        //もし回答の数字とメソッドの引数が同じならば正解数の値に+1する
//        if answer == targetAnswer {
//            correctProblemNumber += 1
//        }
        
        //タイマーを再設定する
        reloadTimer()
        
    }
    
    //タイマーを破棄して再起動を行うメソッド
    func reloadTimer() {
        
        //タイマーを破棄する
        resetTimer()
        
        //結果表示ページへ遷移するか次の問題を表示する
        compareNextProblemOrResultView()
    }
    
 /////////ここまでコピペ/////////////
    
    
    //画面が表示される時、常に発動
    override func viewWillAppear(_ animated: Bool) {

        RandomQuestions()
        
        //AppDelegateにアクセス
        let question = UIApplication.shared.delegate as! AppDelegate

        //グローバル変数(AppDelegateのプロパティ)の値を書き換える(カウントアップ)
        question.myCount += 1

        //カウントアップした数字をラベルに表示
        problemCountLabel.text = "Q\(question.myCount)."
    }
    
    
    
    //4択問題を出題
    func RandomQuestions(){
        var RandomNumber:Int = Int(arc4random() % 31)
        RandomNumber += 1
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
//            var godwiki:NSDictionary = ["name":key,"wiki":goddic["wikipedia"]]
            
                        GodList.append(godinfo)
//                        GodList.append(godwiki)
        }
        
        //今画面に表示したいデータの取得
        let detailInfo = GodList[RandomNumber] as! NSDictionary
        

        //Dictionaryからキー指定で取り出すと必ずAny型になるのでダウンキャスト変換が必要
        print(detailInfo["image"] as! String)
        print(detailInfo["name"] as! String)
//        print(detailInfo["wiki"] as! String)
        
        
        
//        QuestionImage.image = UIImage(named:detailInfo["image"] as! String)
//        answerBtn1.setTitle(detailInfo["name"] as! String, for: UIControlState())
//        answerBtn2.setTitle = GodList[RandomNumber] as! NSDictionary
//        answerBtn3.setTitle(detailInfo[""] as! String, for: UIControlState())
//        answerBtn4.setTitle(detailInfo[""] as! String, for: UIControlState())
//        CorrectAnswer = "1"
        
        for(key,data) in dic!{
            print(data)
            print(key)
            
            var _:NSDictionary = data as! NSDictionary
        
        }
        
        for _ in (detailInfo["name"] as! String) {
            let num = arc4random_uniform(31)
            print(num)
            QuestionImage.image = UIImage(named:detailInfo["image"] as! String)
            answerBtn1.setTitle(detailInfo["name"] as? String, for: UIControlState())
            CorrectAnswer = "1"
        }
        
        //不正解を三回繰り返す
        //正解をリストから削除する
     
        
        //問題を10問だす1...10
//        //配列から画像の名前と同じ名前をボタンに表示させる
//        switch (RandomNumber){
//        case 0:
//            QuestionImage.image = UIImage(named:detailInfo["image"] as! String)
//            answerBtn1.setTitle(detailInfo["name"] as! String, for: UIControlState())
//            answerBtn2.setTitle(detailInfo[""] as! String, for: UIControlState())
//            answerBtn3.setTitle(detailInfo[""] as! String, for: UIControlState())
//            answerBtn4.setTitle(detailInfo[""] as! String, for: UIControlState())
//            CorrectAnswer = "1"
        

        
//    switch(RandomNumber){
//    case 1:
//        QuestionImage.image = UIImage(named: "Ganesa.jpg")
//        answerBtn1.setTitle("Ganesa", for: UIControlState())
//        answerBtn2.setTitle("Krsna", for: UIControlState())
//        answerBtn3.setTitle("Agni", for: UIControlState())
//        answerBtn4.setTitle("Naga", for: UIControlState())
//        CorrectAnswer = "1"
//        break
//    case 2:
//        QuestionImage.image = UIImage(named: "Brahma.jpg")
//        answerBtn1.setTitle("Vishnu", for: UIControlState())
//        answerBtn2.setTitle("Brahma", for: UIControlState())
//        answerBtn3.setTitle("Parvathi", for: UIControlState())
//        answerBtn4.setTitle("Rama", for: UIControlState())
//        CorrectAnswer = "2"
//        break

//    default:
//        QuestionImage.image = UIImage(named: "Jagannatha.gif")
//        answerBtn1.setTitle("Jagannatha", for: UIControlState())
//        answerBtn2.setTitle("Agni", for: UIControlState())
//        answerBtn3.setTitle("krsna", for: UIControlState())
//        answerBtn4.setTitle("Indra", for: UIControlState())
//        CorrectAnswer = "1"
//        break
//        }
        
        
   }
  
    
/////////ここからコピペ/////////////
    
    //タイマー処理を全てリセットするメソッド
    func resetTimer() {
        perSecTimer!.invalidate()
        doneTimer!.invalidate()
    }
    
    
    //結果表示ページへ遷移するか次の問題を表示するかを決めるメソッド
    func compareNextProblemOrResultView() {
        
        if counter == QuizStruct.dataMaxCount {
            
            /**
             *（処理）規定回数まで到達した場合は次の画面へ遷移する
             */
            
            //タイマーを破棄する
            resetTimer()
            
//            //Realmに計算結果データを保存する
//            let gameScoreObject = GameScore.create()
//            gameScoreObject.correctAmount = self.correctProblemNumber
//            gameScoreObject.timeCount = NSString(format:"%.3f", self.totalSeconds) as String
//            gameScoreObject.createDate = Date()
//            gameScoreObject.save()
            
            //次のコントローラーへ遷移する
            self.performSegue(withIdentifier: "showScore", sender: nil)
            
        } else {
            
            /**
             *（処理）規定回数に達していない場合はカウントをリセットして次の問題を表示する
             */
            
            //ボタンを全て活性にする
            allAnswerBtnEnabled()
            
            //ラベルの値を再セットする
            timerDisplayLabel.text = "あと" + String(pastCounter) + "秒"
            
            //タイマーをセットする
            setTimer()
        }
    }
    
    //セグエを呼び出したときに呼ばれるメソッド
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        //セグエ名で判定を行う
        if segue.identifier == "showScore" {
            
            //遷移先のコントローラーの変数を用意する
            let scoreController = segue.destination as! ScoreViewController
            
//            //遷移先のコントローラーに渡したい変数を格納（型を合わせてね）
//            ScoreViewController.correctProblemNumber = correctProblemNumber
//            ScoreViewController.totalSeconds = NSString(format:"%.3f", totalSeconds) as String
            
            //計算結果を入れる変数を初期化
            self.resetGameValues()
        }
    }
    
    //ゲームのカウントに関する数を初期化する
    func resetGameValues() {
        counter = 0
        correctProblemNumber = 0
        totalSeconds = 0.000
    }
    
    
    
/////////ここまでコピペ/////////////
    
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
    
    
    //correct,noの画像表示
    @IBAction func answerBtn1Act(_ sender: Any) {
        UnHide()
        if (CorrectAnswer == "1"){
            resultImage.image = UIImage(named: "yes.png")
        }else{
            resultImage.image = UIImage(named: "no.png")
        }
    }
    @IBAction func answerBtn2Act(_ sender: Any) {
        UnHide()
        if (CorrectAnswer == "2"){
            resultImage.image = UIImage(named: "yes.png")
        }else{
            resultImage.image = UIImage(named: "no.png")
        }
    }
    @IBAction func answerBtn3Act(_ sender: Any) {
        UnHide()
        if (CorrectAnswer == "3"){
            resultImage.image = UIImage(named: "yes.png")
        }else{
            resultImage.image = UIImage(named: "no.png")
        }
    }
    @IBAction func answerBtn4Act(_ sender: Any) {
        UnHide()
        if (CorrectAnswer == "4"){
            resultImage.image = UIImage(named: "yes.png")
        }else{
            resultImage.image = UIImage(named: "no.png")
        }
    }

    //回答後に表示
    @IBAction func Next(_ sender: Any) {
        RandomQuestions()
        Hide()
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
