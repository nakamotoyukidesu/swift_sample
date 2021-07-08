//
//  SignInViewController.swift
//  RamenInfo
//
//  Created by 藤田優作 on 2021/03/14.
//

import UIKit
import Firebase
import AuthenticationServices
import CryptoKit
import PKHUD


class SignInViewController: UIViewController,UITextFieldDelegate {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passMess: UILabel!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var twiiterButton: UIButton!
    
    fileprivate var currentNonce:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailTextField.delegate = self
        passMess.isHidden = true
        
        
        signInButton.layer.cornerRadius = 5.0
        twiiterButton.layer.cornerRadius = 5.0
        
        // ②レイアウトを作成する
//         IOS13以降のみ使えるので、そのように制限
        if #available(iOS 13.0, *) {
          // ここでインスタンス(ボタン)を生成
          let appleLoginButton = ASAuthorizationAppleIDButton(
              authorizationButtonType: .default,
              authorizationButtonStyle: .black
          )
          // ボタン押した時にhandleTappedAppleLoginButtonの関数を呼ぶようにセット
          appleLoginButton.addTarget(
              self,
              action: #selector(handleTappedAppleLoginButton(_:)),
              for: .touchUpInside
          )
          // ↓はレイアウトの設定
          // これを入れないと下の方で設定したAutoLayoutが崩れる
          appleLoginButton.translatesAutoresizingMaskIntoConstraints = false
          // Viewに追加
          view.addSubview(appleLoginButton)
          // ↓はAutoLayoutの設定
          // appleLoginButtonの中心を画面の中心にセットする
          appleLoginButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
          appleLoginButton.topAnchor.constraint(equalTo: self.signInButton.bottomAnchor, constant: 20).isActive = true
          appleLoginButton.bottomAnchor.constraint(equalTo: self.twiiterButton.topAnchor, constant: -20).isActive = true
          // appleLoginButtonの幅は、親ビューの幅の0.7倍
            appleLoginButton.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.7).isActive = true

        }
    }
    
    // ③appleLoginButtonを押した時の挙動を設定
      @available(iOS 13.0, *)
      @objc func handleTappedAppleLoginButton(_ sender: ASAuthorizationAppleIDButton) {
          // ランダムの文字列を生成
          let nonce = randomNonceString()
          // delegateで使用するため代入
          currentNonce = nonce
          // requestを作成
          let request = ASAuthorizationAppleIDProvider().createRequest()
          // sha256で変換したnonceをrequestのnonceにセット
          request.requestedScopes = [.email, .fullName]
          request.nonce = sha256(nonce)
          // controllerをインスタンス化する(delegateで使用するcontroller)
          let controller = ASAuthorizationController(authorizationRequests: [request])
          controller.delegate = self
          controller.presentationContextProvider = self
          controller.performRequests()
      }
    
    // ④randomで文字列を生成する関数を作成
     func randomNonceString(length: Int = 32) -> String {
         precondition(length > 0)
         let charset: Array<Character> =
             Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")
         var result = ""
         var remainingLength = length
         
         while remainingLength > 0 {
             let randoms: [UInt8] = (0 ..< 16).map { _ in
                 var random: UInt8 = 0
                 let errorCode = SecRandomCopyBytes(kSecRandomDefault, 1, &random)
                 if errorCode != errSecSuccess {
                     fatalError("Unable to generate nonce. SecRandomCopyBytes failed with OSStatus \(errorCode)")
                 }
                 return random
             }
             
             randoms.forEach { random in
                 if length == 0 {
                     return
                 }
                 
                 if random < charset.count {
                     result.append(charset[Int(random)])
                     remainingLength -= 1
                 }
             }
         }
         return result
     }
    
    // ⑤SHA256を使用してハッシュ変換する関数を用意
      @available(iOS 13, *)
      private func sha256(_ input: String) -> String {
        let inputData = Data(input.utf8)
        let hashedData = SHA256.hash(data: inputData)
        let hashString = hashedData.compactMap {
          return String(format: "%02x", $0)
        }.joined()

        return hashString
      }
      
    
  
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //キーボード閉じる
        textField.resignFirstResponder()
        return true
    }
    
    
    @IBAction func loginButton(_ sender: Any) {
        let email = emailTextField.text ?? ""
        let passWord = passwordTextField.text ?? ""
        Auth.auth().signIn(withEmail: email, password: passWord) { (result, error) in
            if let user = result?.user {
                self.performSegue(withIdentifier:"toMain" , sender: nil)
            }else {
                print("error")
                self.showErrorIfNeeded(error)
                return
            }
        }
        if passwordTextField.text!.count >= 6 {
            passMess.isHidden = true
        }else {
            passMess.isHidden = false
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
    
    private func showErrorIfNeeded(_ errorOrNil: Error?) {
        // エラーがなければ何もしません
        guard let error = errorOrNil else { return }
        let message = errorMessage(of: error) // エラーメッセージを取得
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    private func errorMessage(of error: Error) -> String {
        var message = "エラーが発生しました"
        guard let errcd = AuthErrorCode(rawValue: (error as NSError).code) else {
            return message
        }
        
        switch errcd {
        case .networkError: message = "ネットワークに接続できません"
        case .userNotFound: message = "ユーザが見つかりません"
        case .invalidEmail: message = "不正なメールアドレスです"
        case .emailAlreadyInUse: message = "このメールアドレスは既に使われています"
        case .wrongPassword: message = "入力した認証情報でサインインできません"
        case .userDisabled: message = "このアカウントは無効です"
        case .weakPassword: message = "パスワードが脆弱すぎます"
        // これは一例です。必要に応じて増減させてください
        default: break
        }
        return message
    }
    
    @IBAction func modoru(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension ViewController:UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textfield:UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
}

// ⑥extensionでdelegate関数に追記していく
extension SignInViewController: ASAuthorizationControllerDelegate,ASAuthorizationControllerPresentationContextProviding {
    
    // 認証が成功した時に呼ばれる関数
     @available(iOS 13.0, *)
    func authorizationController(controller _: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
       // credentialが存在するかチェック
        guard let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential else {
            return
        }
    
       // nonceがセットされているかチェック
       guard let nonce = currentNonce else {
         fatalError("Invalid state: A login callback was received, but no login request was sent.")
       }
       // credentialからtokenが取得できるかチェック
       guard let appleIDToken = appleIDCredential.identityToken else {
           print("Unable to fetch identity token")
           return
       }
       // tokenのエンコードを失敗
       guard let idTokenString = String(data: appleIDToken, encoding: .utf8) else {
            print("Unable to serialize token string from data: \(appleIDToken.debugDescription)")
           return
       }
       // 認証に必要なcredentialをセット
       let credential = OAuthProvider.credential(
           withProviderID: "apple.com",
           idToken: idTokenString,
           rawNonce: nonce
       )
       // Firebaseへのログインを実行
       Auth.auth().signIn(with: credential) { (authResult, error) in
          if let error = error {
              print(error)
              // 必要に応じて
              HUD.flash(.labeledError(title: "予期せぬエラー", subtitle: "再度お試しください。"), delay: 1)
              return
          }
          if let authResult = authResult {
              print(authResult)
            //ここにログインの処理

              // 必要に応じて
              HUD.flash(.labeledSuccess(title: "ログイン完了", subtitle: nil), onView: self.view, delay: 1) { _ in
                // 画面遷移など行う
                self.performSegue(withIdentifier: "toMain", sender: nil)

              }
          }
       }
   }
    
    //delegateのプロトコルに設定されているため、書いておく
    @available(iOS 13.0, *)
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return view.window!
    }
    
        // Appleのログイン側でエラーがあった時に呼ばれる
     @available(iOS 13.0, *)
     func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
          // Handle error.
          print("Sign in with Apple errored: \(error)")
        }
}
