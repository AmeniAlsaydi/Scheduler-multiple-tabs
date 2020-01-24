//
//  CreateEventController.swift
//  Scheduler
//
//  Created by Alex Paul on 11/20/19.
//  Copyright © 2019 Alex Paul. All rights reserved.
//

import UIKit

// states of this view controller
enum EventState {
  case newEvent
  case existingEvent
}

class CreateEventController: UIViewController {
  
  @IBOutlet weak var eventNameTextField: UITextField!
  @IBOutlet weak var datePicker: UIDatePicker!
  @IBOutlet weak var eventButton: UIButton!
  
  public var event: Event? 
  
  // private for setting: private for changing "setting"
  // public for getting: public for reading
  public private(set) var eventState = EventState.newEvent // this VC is in newEvent state by default
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // set the view controller as the delegate for the text field
    eventNameTextField.delegate = self
        
    updateUI()
  }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
   
    override func viewDidDisappear(_ animated: Bool) {
        
    }
  private func updateUI() {
    if let event = event { // coming from didSelectRowAt (an exisiting event) - if it exists we have the values to pass to the VC 
      self.event = event
      datePicker.date = event.date
      eventNameTextField.text = event.name
      eventButton.setTitle("Update Event", for: .normal)
      eventState = .existingEvent
    } else {
      // instantiate a default value for event
      event = Event(date: Date(), name: "") // Date()
      eventState = .newEvent
    }
  }
  
  @IBAction func datePickerChanged(sender: UIDatePicker) {
    // update date of event
    
    event?.date = sender.date
  }
}

extension CreateEventController: UITextFieldDelegate {
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    
    // dismiss the keyboard
    textField.resignFirstResponder()
    
    // update name of event
    event?.name = textField.text ?? "no event name"
    
    return true
  }
}
