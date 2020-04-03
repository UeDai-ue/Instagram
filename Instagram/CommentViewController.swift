

import UIKit
import Firebase
import SVProgressHUD

class CommentViewController: UIViewController {
    
    var postData : PostData?
    
    
    
    
    @IBOutlet weak var commentTextField: UITextField!
    
    @IBAction func handleCommentButton(_ sender: Any) {
        
        let name = Auth.auth().currentUser?.displayName
        let comment = commentTextField.text!
        let nameComment = name! + ":" + comment
        
        // 入力されていない時はHUDを出して何もしない
        if comment.isEmpty {
            SVProgressHUD.showError(withStatus: "コメントを入力して下さい")
            return
        }
        
        // 更新する
        // 更新データを作成する
        var updateValue: FieldValue
        
        // 追加する更新データを作成
        updateValue = FieldValue.arrayUnion([nameComment])
        
        // 更新データを書き込む
        let postRef = Firestore.firestore().collection(Const.PostPath).document(postData!.id)
        postRef.updateData(["comment": updateValue])
        
        // HUDで投稿完了を表示する
        SVProgressHUD.showSuccess(withStatus: "投稿しました")
        
        // 投稿処理が完了したので先頭画面に戻る
        UIApplication.shared.windows.first{ $0.isKeyWindow }?.rootViewController?.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func handleCancelButton(_ sender: Any) {
        // 画面を閉じる
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
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
