

import UIKit
import Firebase
import SVProgressHUD

class CommentViewController: UIViewController {
    
    @IBOutlet weak var commentTextField: UITextField!
    
    @IBAction func handleCommentButton(_ sender: Any) {
        
        // 画像と投稿データの保存場所を定義する
        let postRef = Firestore.firestore().collection(Const.PostPath).document()
        
        // HUDで投稿処理中の表示を開始
        SVProgressHUD.show()
        
            // FireStoreに投稿データを保存する
            let name = Auth.auth().currentUser?.displayName
            let postDic = [
                "comment": name! + ":" + self.commentTextField.text!,
                ] as [String : Any]
            postRef.setData(postDic)
            // HUDで投稿完了を表示する
            SVProgressHUD.showSuccess(withStatus: "コメントしました")
            // 投稿処理が完了したので先頭画面に戻る
           UIApplication.shared.windows.first{ $0.isKeyWindow }?.rootViewController?.dismiss(animated: true, completion: nil)
            
        
    }
    
    @IBAction func handleCancelButton(_ sender: Any) {
        // 画面を閉じる
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
