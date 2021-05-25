//
//  MypageViewController.swift
//  RamenInfo
//
//  Created by 藤田優作 on 2021/01/12.
//

import UIKit
import Firebase
import MessageUI

class MypageViewController: UIViewController,UIImagePickerControllerDelegate & UINavigationControllerDelegate,MFMailComposeViewControllerDelegate {
    
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var mailLabel: UILabel!
    @IBOutlet weak var contactButton: UIButton!
    @IBOutlet weak var TosingUpButton: UIButton!
    
    var userName = String()
    
    @IBAction func back(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        print("押された")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let user = Auth.auth().currentUser {
            self.nameLabel.text = user.displayName ?? "不明"
            self.mailLabel.text = user.email ?? "不明"
//            print(user.photoURL)
            print(self.nameLabel.text)
            print(self.mailLabel.text)
        }else {
            print("エラー")
        }
        self.TosingUpButton.layer.cornerRadius = 40.0
        self.contactButton.layer.cornerRadius = 40.0
        // Do any additional setup after loading the view.
//        mainview.backgroundColor = UIColor(red: 1.00, green: 1.00, blue: 0.00, alpha: 1.00)
        
    }
    
    
    @IBAction func sendMail(_ sender: Any) {
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients(["2020sukil@gmail.com"]) // 宛先アドレス
            mail.setSubject("RamenInfoお問い合わせ") // 件名
            mail.setMessageBody("お問い合わせ内容：", isHTML: false) // 本文
            present(mail, animated: true, completion: nil)
        } else {
            print("送信できません")
        }
    }
    
    
    @IBAction func LogoutButton(_ sender: Any) {
        
        let firebaseAuth = Auth.auth()
        
        do{
            try firebaseAuth.signOut()
        } catch let error as NSError {
            print("エラー",error)
        }
        
        self.navigationController?.popViewController(animated: true)
    }
    
    
    
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
          switch result {
          case .cancelled:
              print("キャンセル")
          case .saved:
              print("下書き保存")
          case .sent:
              print("送信成功")
          default:
              print("送信失敗")
          }
          dismiss(animated: true, completion: nil)
      }
   
    // 写真を選んだ後に呼ばれる処理
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        // 選択した写真を取得する
        let image = info[.originalImage] as! UIImage
        // ビューに表示する
        profileImage.image = image
        // 写真を選ぶビューを引っ込める
        self.dismiss(animated: true)
    }
    @IBAction func tapImage(_ sender: Any) {
        // カメラロールが利用可能か？
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            // 写真を選ぶビュー
            let pickerView = UIImagePickerController()
            // 写真の選択元をカメラロールにする
            // 「.camera」にすればカメラを起動できる
            pickerView.sourceType = .photoLibrary
            // デリゲート
            pickerView.delegate = self
            // ビューに表示
            self.present(pickerView, animated: true)
        }
    }
    
    
    @IBAction func modoru(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
