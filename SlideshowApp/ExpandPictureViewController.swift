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
    
    
    
    
    // ピンチジェスチャー時の動作
    @IBAction func PinchAction_1(_ sender: UIPinchGestureRecognizer) {
        // 画像のスケールを変更する。
        UIImageView_1.transform = CGAffineTransform(scaleX: sender.scale, y: sender.scale)
    }
    

}
