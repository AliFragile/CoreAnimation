//
//  ViewController.swift
//  CoreAnimation
//
//  Created by Алина Ражева on 21.11.2022.
//


// MARK: - АНИМАЦИЯ И ВСЕ ОБЪЕКТЫ ТОЛЬКО КОДОМ
import UIKit

class ViewController: UIViewController {
    
    let image = UIImageView()
    let button = UIButton()
    let label = UILabel()
    
    private var originCoordinate: CGFloat?      //Фиксируем центр, чтобы никуда                                                                  картинка не убегала

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(image)
        image.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: view.topAnchor, constant: -1),
            image.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            image.widthAnchor.constraint(equalToConstant: 1),
            image.heightAnchor.constraint(equalToConstant: 1),
            
            label.topAnchor.constraint(equalTo: view.topAnchor, constant: 300),
            label.widthAnchor.constraint(equalToConstant: 280),
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.widthAnchor.constraint(equalToConstant: 280),
            button.heightAnchor.constraint(equalToConstant: 60),
            button.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100)
        ])
        
        image.image = UIImage(named: "friends")
        image.alpha = 0
        
        label.text = "Hello, my friend! We're glad to see you!"
        // #colorLiteral()
        label.textColor =  #colorLiteral(red: 0.5725490451, green: 0, blue: 0.2313725501, alpha: 1)
        label.font = .boldSystemFont(ofSize: 24)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.alpha = 0
        
        button.backgroundColor = #colorLiteral(red: 0.8285633922, green: 0.6668385267, blue: 0.9275735617, alpha: 1)
        button.layer.cornerRadius = 15
        button.layer.borderWidth = 2
        button.layer.borderColor = #colorLiteral(red: 0.3407120705, green: 0.1766914725, blue: 0.9274448752, alpha: 1)
        button.setTitle("I want to see my friends!", for: .normal)
        button.setTitleColor(.systemPurple, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 24)
        button.setTitleColor(.black, for: .highlighted)
        
        button.addTarget(self, action: #selector(seeFriends), for: .touchUpInside)
    }

    @objc func seeFriends() {
        if image.alpha == 0 {
            button.isUserInteractionEnabled = false
            // Не получается применить вот эти два изменения, картинка начинает уезжать в сторону + слева в углу на мнгновение появляется картинка после завершения всех действий:
//            button.setTitle("Bye-bye!", for: .normal)
//            label.text = ""
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 12.0) {
               self.button.isUserInteractionEnabled = true
            }
            
            UIImageView.animate(withDuration: 7, animations: {
                self.image.frame.origin.y += 350
                self.image.frame.origin.x += 400
                self.image.transform = CGAffineTransform(rotationAngle: 0).scaledBy(x: 300, y: 300)
                
                //.translatedBy(x: , y: ) - перемещение
                self.image.alpha = 0.5
            }) { _ in
                UIImageView.animate(withDuration: 5) {
                    self.image.frame.origin.y += 200
                    self.image.frame.origin.x -= 200
                    
                    self.image.alpha = 1
                    self.label.alpha = 1
                }
            }
        } else {
            button.isUserInteractionEnabled = false
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 12.0) {
               self.button.isUserInteractionEnabled = true
            }
            
            UIImageView.animate(withDuration: 7, animations: {
                self.image.frame.origin.y -= 200
                self.image.frame.origin.x += 300
                self.image.transform = CGAffineTransform(rotationAngle: 0).scaledBy(x: 100, y: 100)
                
                self.image.alpha = 0.5
            }) { _ in
                UIImageView.animate(withDuration: 2) {
                    self.image.alpha = 0
                    self.label.text = "It was nice to see you!"
                }
            }
        }
    }
    //Есть еще другой способ:
//    image.animateKeyframes(withDuration: <#T##TimeInterval#>, delay: <#T##TimeInterval#>, options: <#T##UIView.KeyframeAnimationOptions#>, animations: <#T##() -> Void#>, completion: <#T##((Bool) -> Void)?#>)
    //self.image.origin.x = self.view.bounds.width
}


