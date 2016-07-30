//
//  GameViewController.swift
//  Pokemon
//
//  Created by 尾高文香 on 2016/07/30.
//  Copyright © 2016年 com.odakaayaka. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
    
    @IBOutlet var imgView1: UIImageView!//メタモン
    @IBOutlet var imgView2: UIImageView!//モンスターボール
    
    @IBOutlet var resultLabel: UILabel!//スコアを表示するラベル
    @IBOutlet var nextStageButton: UIButton!//次のステージへいくボタン
    
    var timer: NSTimer!//画像を動かすためのタイマー
    var score: Int = 1000//スコアの値
    let defaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()//スコアを保存するための変数
    
    let width: CGFloat = UIScreen.mainScreen().bounds.size.width//画面幅
    let height: CGFloat = UIScreen.mainScreen().bounds.size.height
    
    var positionX: [CGFloat] = [0.0 , 0.0]
    var dx: [CGFloat] = [1.0 , -1.0]//画像の動かす幅の配列
    
    @IBAction func backFromSecondView(segue:UIStoryboardSegue){
        
    }
    
    func start(){
        resultLabel.hidden = true
        nextStageButton.hidden = true
        timer = NSTimer.scheduledTimerWithTimeInterval(0.010, target: self, selector: "up", userInfo: nil,repeats: true)
        timer.fire()
    }
    
    func up(){
        for i in 0..<2{
            if positionX[i] > width || positionX[i] < 0{
                dx[i] = dx[i] * (-1)
            }
            positionX[i] += dx[i]
        }
        imgView1.center.x = positionX[0]
        imgView2.center.x = positionX[1]
    }
    
    @IBAction func stop(){
        if timer.valid == true{
            timer.invalidate()
        }
        
        for i in 0..<2{
            score =  score - abs(Int(width/2 - positionX[i]))*2
        }
        if score > 970 {
            resultLabel.text = "GET! Score:" + String(score)
            nextStageButton.hidden = false
        }else{
            resultLabel.text = "Fail. Score:" + String(score)
            nextStageButton.hidden = true
        }
        resultLabel.hidden = false
    }
    
    @IBAction func retry(){
        score  = 1000
        positionX = [width/2 , width/2]
        if timer.valid == false{
            self.start()
        }
    }
    
    @IBAction func top(){
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        positionX = [width/2 , width/2]
        self.start()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
