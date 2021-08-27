//
//  LoginViewController.swift
//  Vebinar01G5
//
//  Created by HZ4ever on 10/06/2021.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var titleImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var loginLabel: UILabel!
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var backView: UIView!
    
    
    @IBOutlet weak var loadImageFirst: UIImageView!
    @IBOutlet weak var loadImageSecond: UIImageView!
    @IBOutlet weak var loadImageThird: UIImageView!
    
    let toTabBarSegueIdentifier = "fromLoginToTapBar"
    
    func animateTitle() {
        titleLabel.transform = CGAffineTransform(translationX: 0, y: -self.view.bounds.height / 2)
        
        UIView.animate(withDuration: 2,
                       delay: 1,
                       usingSpringWithDamping: 0.5,
                       initialSpringVelocity: 0,
                       options: .curveEaseOut,
                       animations: {
                        self.titleLabel.transform = .identity
                        },
                       completion: nil)
    }
    
    func animateLoginPasswordLabel() {
        loginLabel.transform = CGAffineTransform(translationX: -view.bounds.width, y: 0)
        passwordLabel.transform = CGAffineTransform(translationX: view.bounds.width, y: 0)
        
        UIView.animate(withDuration: 2,
                       delay: 1.0,
                       usingSpringWithDamping: 0.5,
                       initialSpringVelocity: 0,
                       options: [.curveEaseOut],
                       animations: {
                        self.loginLabel.transform = .identity
                        self.passwordLabel.transform = .identity
                       },
                       completion: nil)
    }
    
    func animateTextField() {
        let animation = CABasicAnimation(keyPath: "opacity")
        animation.fromValue = 0
        animation.toValue = 1
        animation.duration = 2
        animation.beginTime = CACurrentMediaTime() + 1.1
        animation.fillMode = CAMediaTimingFillMode.backwards
        
        loginTextField.layer.add(animation, forKey: nil)
        passwordTextField.layer.add(animation, forKey: nil)
    }
    
    func animateButton() {
        let animation = CASpringAnimation(keyPath: "transform.scale")
        animation.fromValue = 0
        animation.toValue = 1
        animation.stiffness = 200
        animation.mass = 2
        animation.duration = 2
        animation.beginTime = CACurrentMediaTime() + 1.2
        animation.fillMode = CAMediaTimingFillMode.backwards
        
        self.loginButton.layer.add(animation, forKey: nil)
    }
    
    func wrongPassOrLoginAnimateButoon() {
        let animation = CASpringAnimation(keyPath: "transform.scale")
        animation.fromValue = 0.5
        animation.toValue = 1
        animation.stiffness = 70
        animation.mass = 1
        animation.duration = 1
        
        self.loginButton.layer.add(animation, forKey: nil)
    }
    
    func firstLoadCicleAnimation(){
        UIView.animate(withDuration: 1.5, delay: 0, options: [.repeat, .autoreverse], animations: {
            self.loadImageFirst.alpha = 0.25
        }, completion: nil)
    }
    func secondLoadCicleAnimation(){
        UIView.animate(withDuration: 1.5, delay: 0.5, options: [.repeat, .autoreverse], animations: {
            self.loadImageSecond.alpha = 0.25
        }, completion: nil)
    }
    func thirdLoadCicleAnimation(){
        UIView.animate(withDuration: 1.5, delay: 1, options: [.repeat, .autoreverse], animations: {
            self.loadImageThird.alpha = 0.25
        }, completion: nil)
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        animateTitle()
        animateLoginPasswordLabel()
        animateTextField()
        animateButton()
        firstLoadCicleAnimation()
        secondLoadCicleAnimation()
        thirdLoadCicleAnimation()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWasShown), name: UIResponder.keyboardWillShowNotification, object: nil)
        //вызываем до место для добавления скролинга под клаву
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWasHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        // убираем это доп место
        
        //добавляем распознаватель жестов, для того чтобы при клике не на поле воода или кнопку логина, клава скрывалась
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(keyboardDie))
        backView.addGestureRecognizer(gestureRecognizer)
        
        //-MARK: Session
        
        let session = Session.instance
        session.userId = "228"
        session.token = "anton_hodyna"
        
        // Do any additional setup after loading the view.
    }
    

    @objc func keyboardDie() {
        self.scrollView.endEditing(true)
    }
    //функция убийства клавиатуры
    
    @objc func keyboardWasShown() {
        scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 250, right: 0)
        //вызываем до место для добавления скролинга под клаву
    }
    @objc func keyboardWasHide() {
        scrollView.contentInset = UIEdgeInsets.zero
        // убираем это доп место
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    func showAllert(message: String, completion: @escaping (UIAlertAction) -> Void) {
        let alertController = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        let allertAction = UIAlertAction(title: "Ok", style: .cancel, handler: completion)
        alertController.addAction(allertAction)
        present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func pressLoginButton(_ sender: Any) {
//        if let login = loginTextField.text,
//           let password = passwordTextField.text,
//           !login.isEmpty,
//           !password.isEmpty,
//           login == "login",
//           password == "password" {
            performSegue(withIdentifier: toTabBarSegueIdentifier, sender: nil)
//        }
//        else{
//            wrongPassOrLoginAnimateButoon()
//
//            showAllert(message: "Error login or password") { _ in
//                //self.backView.backgroundColor = UIColor.gray
//                return
//            }
//        }
    }
}
