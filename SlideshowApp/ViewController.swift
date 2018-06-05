//
//  ViewController.swift
//  SlideshowApp
//
//  Created by 菅野 英俊 on 2018/05/30.
//  Copyright © 2018年 菅野 英俊. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // Storyboard変数
    @IBOutlet weak var SlideshowButton_1: UIButton!
    @IBOutlet weak var UIImageView_1: UIImageView!
    @IBOutlet weak var UIImageView_2: UIImageView!
    
    // Flag変数
    var Flag_Slideshow_1: Bool = false
    
    // カウンター変数
    var alpha_tmp: Float = 1.0
    var ImageNumber: Int = 0
    
    // その他の変数
    var timer_1: Timer!
    var timerForPictureGo_1: Timer!
    var image: [UIImage] = [UIImage(named: "IMG_1400.jpg")!, UIImage(named: "IMG_1435.jpg")!, UIImage(named: "IMG_1383.jpg")!]

    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        //初期画像を格納する。
        UIImageView_1.image = image[0]
        UIImageView_1.alpha = 1.0
        UIImageView_2.image = image[0]
        UIImageView_2.alpha = 1.0
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // 各パラメータの初期化
        SlideshowButton_1.setTitle("再生する", for: .normal)
        Flag_Slideshow_1 = false
        alpha_tmp = 1.0
    }
    
    // 画面遷移直後にタイマー処理を掃除する。
    override func viewDidDisappear(_ animated: Bool){
        if self.timer_1 != nil {
            self.timer_1.invalidate()
            self.timer_1 = nil
        }
        
        if self.timerForPictureGo_1 != nil {
            self.timerForPictureGo_1.invalidate()
            self.timerForPictureGo_1 = nil
            
            // 画像の入れ替え処理を完了させる。
            UIImageView_2.image = UIImageView_1.image
            UIImageView_2.alpha = 1.0
        }
    }
    
    
    
    
    
    //進むボタン
    @IBAction func GoButton_1(_ sender: UIButton) {
        //スライドショーが実行されていない場合のみ実行する。
        if Flag_Slideshow_1 == false {
            PictureGo()
        }
    }
    
    
    //戻るボタン
    @IBAction func BackButton_1(_ sender: UIButton) {
        //スライドショーが実行されていない場合のみ実行する。
        if Flag_Slideshow_1 == false {
            PictureBack()
        }
    }
    
    
    //再生/停止ボタン
    @IBAction func SlideshowButton_1(_ sender: UIButton) {
        //スライドショーが実行中か停止中かを確認
        if Flag_Slideshow_1 == false {
            //スライドショーを実現する。
            self.timer_1 = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(PictureGo), userInfo: nil, repeats: true)
            
            //スライドショー実行ステータスにする。
            Flag_Slideshow_1 = true
            SlideshowButton_1.setTitle("停止する", for: .normal)
        }
        else if Flag_Slideshow_1 == true {
            //スライドショーを停止する。
            if self.timer_1 != nil {
                self.timer_1.invalidate()
                self.timer_1 = nil
            }
            
            //スライドショー停止ステータスにする。
            Flag_Slideshow_1 = false
            SlideshowButton_1.setTitle("再生する", for: .normal)
        }
    }
    
    
    //画像を進める関数
    @objc func PictureGo() {
        // 画像の差し替え (画像が入れ替わり切るまで「進む」ボタンの効果は出ない仕様。)
        if UIImageView_2.alpha == 1.0 {
            // 配列の中から画像の取り出し
            ImageNumber += 1

            self.timerForPictureGo_1 = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(PictureTuning), userInfo: nil, repeats: true)
        }
    }
    
    
    //画像を戻す関数
    func PictureBack() {
        // 画像の差し替え (画像が入れ替わり切るまで「戻る」ボタンの効果は出ない仕様。)
        if UIImageView_2.alpha == 1.0 {
            // 配列の中から画像の取り出し
            // 配列番号がマイナスになったら最後尾の配列番号に書き換える。
            ImageNumber -= 1
            if ImageNumber < 0 {
                ImageNumber = image.count - 1
            }

            self.timerForPictureGo_1 = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(PictureTuning), userInfo: nil, repeats: true)
        }
    }
    
    
    // 画像の透明度を調整する関数
    @objc func PictureTuning() {
        // 画像の透明度を変更する処理
        if UIImageView_2.alpha > 0.0 {
            // 裏側に次に表示する画像を用意する。
            let ImageNumber_tmp: Int = (ImageNumber) % image.count
            UIImageView_1.image = image[ImageNumber_tmp]
            
            //透明度を変更する。
            alpha_tmp -= 0.1
            UIImageView_2.alpha = CGFloat(alpha_tmp)
        }
            // 透明にする処理が完了した後の処理
        else {
            if self.timerForPictureGo_1 != nil {
                self.timerForPictureGo_1.invalidate()
                self.timerForPictureGo_1 = nil
            }
            
            // 画像の入れ替え処理
            UIImageView_2.image = UIImageView_1.image
            UIImageView_2.alpha = 1.0
            
            // alpha_tmpの初期化
            alpha_tmp = 1.0
        }
    }

    
    
    
    // 画面遷移時の処理
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let EPViewController: ExpandPictureViewController = segue.destination as! ExpandPictureViewController
        
        // 現在表示されている画像を遷移先に渡す。
        EPViewController.image_1 = UIImageView_2.image
    }
    
    
    
    @IBAction func unwind(_ segue: UIStoryboardSegue) {
    }
    
    


}









