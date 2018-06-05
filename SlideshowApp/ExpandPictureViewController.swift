//
//  ExpandPictureViewController.swift
//  SlideshowApp
//
//  Created by 菅野 英俊 on 2018/06/02.
//  Copyright © 2018年 菅野 英俊. All rights reserved.
//

import UIKit

class ExpandPictureViewController: UIViewController {

    // Storyboard変数定義
    @IBOutlet weak var UIImageView_1: UIImageView!
    
    // その他変数
    var image_1: UIImage! = nil     //画像を格納する変数
    var width_tmp: CGFloat = CGFloat(1.0)
    var height_tmp: CGFloat = CGFloat(1.0)
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // UIImageViewのUserInterfaceの有効化,および画像のセット。
        UIImageView_1.isUserInteractionEnabled = true
        UIImageView_1.image = image_1
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // 各パラメータの初期化
        width_tmp = CGFloat(1.0)
        height_tmp = CGFloat(1.0)
    }
    

    // ピンチジェスチャー時の動作
    @IBAction func PinchAction_1(_ sender: UIPinchGestureRecognizer) {
        print(sender.scale)
        
        // 横倍率設定
        if sender.scale >= 1.3 {
            width_tmp = UIImageView_1.frame.size.width * CGFloat(1.3)
            height_tmp = UIImageView_1.frame.size.height * CGFloat(1.3)
        }
        else if sender.scale <= 0.7 {
            width_tmp = UIImageView_1.frame.size.width * CGFloat(0.7)
            height_tmp = UIImageView_1.frame.size.height * CGFloat(0.7)
        }
        else {
            width_tmp = UIImageView_1.frame.size.height * sender.scale
            height_tmp = UIImageView_1.frame.size.height * sender.scale
        }
        
        UIImageView_1.frame.size = CGSize(width: width_tmp, height: height_tmp)
    }
    

}
