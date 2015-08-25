//
//  ViewController.swift
//  ScrollViewTutorial01
//
//  Created by Pablo on 23/8/15.
//  Copyright (c) 2015 Pablo Marcos. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var firstTextField: UITextField!
    @IBOutlet weak var secondTextField: UITextField!
    
    // GestureRecognizer to catch the tap on ScrollView
    var scrollGestureRecognizer: UITapGestureRecognizer!
    var keyboardHeight:CGFloat!
    
    var textFields: [UITextField]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // For avoid the incorrect offset of the scroll view
        automaticallyAdjustsScrollViewInsets = false
        
        // Keyboard notifications
        var center: NSNotificationCenter = NSNotificationCenter.defaultCenter()
        center.addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
        center.addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)
        
        // Get the Tap gesture on ScrollView to hide the keyboard
        scrollGestureRecognizer = UITapGestureRecognizer(target: self, action: "hideKeyBoard")
        scrollView.addGestureRecognizer(scrollGestureRecognizer)
        
        textFields = [firstTextField, secondTextField]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Custom functions
    func setScrollViewPosition(){
        // Modificamos el valor de la constante del constraint inferior, le damos la altura del teclado más 20 de marge. De este modo estamos agrandando el Scroll View lo suficiente para poder hacer scroll hacia arriba y trasladar el UITextField hasta que quede a la vista del usuario. Ejecutamos el cambio en el constraint con la función layoutIfNeeded().
        bottomConstraint.constant = keyboardHeight + 20
        self.view.layoutIfNeeded()
        
        // Calculamos la altura de la pantalla
        let screenSize: CGRect = UIScreen.mainScreen().bounds
        let screenHeight: CGFloat = screenSize.height
        
        // Recorremos el array de textFields en busca de quien tiene el foco
        for textField in textFields {
            if textField.isFirstResponder() {
                // Guardamos la posición 'Y' del UITextField
                let yPositionField = textField.frame.origin.y
                // Guardamos la altura del UITextField
                let heightField = textField.frame.size.height
                // Calculamos la 'Y' máxima del UITextField
                let yPositionMaxField = yPositionField + heightField
                // Calculate max Y position for a view that is not hidden
                let Ymax = screenHeight - keyboardHeight
                
                // Comprobamos si nuestra 'Y' máxima del UITextField es superior a la Ymax
                if Ymax < yPositionMaxField {
                    // El UITextField queda oculto por el teclado, entonces movemos el Scroll View
                    scrollView.setContentOffset(CGPointMake(0, self.keyboardHeight - 20), animated: true)
                }
            }
        }
    }
    
    
    // MARK: - NSNotification functions
    
    func keyboardWillShow(notification: NSNotification) {
        var info:NSDictionary = notification.userInfo!
        var keyboardSize = (info[UIKeyboardFrameBeginUserInfoKey] as! NSValue).CGRectValue()
        keyboardHeight = keyboardSize.height
        println("El teclado se va a mostrar y tiene una altura de: \(keyboardSize.height)")
        setScrollViewPosition()
    }
    
    func keyboardWillHide(notification: NSNotification) {
        bottomConstraint.constant = 40
        self.view.layoutIfNeeded()
    }
    
    // MARK: - UITapGestureRecognizer functions
    
    func hideKeyBoard(){
        view.endEditing(true)
    }
    

}

