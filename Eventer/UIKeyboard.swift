//
//  UIKeyboard.swift
//  Eventer
//
//  Blog  : https://meniny.cn
//  Github: https://github.com/Meniny
//
//  No more shall we pray for peace
//  Never ever ask them why
//  No more shall we stop their visions
//  Of selfdestructing genocide
//  Dogs on leads march to war
//  Go ahead end it all...
//
//  Blow up the world
//  The final silence
//  Blow up the world
//  I don't give a damn!
//
//  Screams of terror, panic spreads
//  Bombs are raining from the sky
//  Bodies burning, all is dead
//  There's no place left to hide
//  Dogs on leads march to war
//  Go ahead end it all...
//
//  Blow up the world
//  The final silence
//  Blow up the world
//  I don't give a damn!
//
//  (A voice was heard from the battle field)
//
//  "Couldn't care less for a last goodbye
//  For as I die, so do all my enemies
//  There's no tomorrow, and no more today
//  So let us all fade away..."
//
//  Upon this ball of dirt we lived
//  Darkened clouds now to dwell
//  Wasted years of man's creation
//  The final silence now can tell
//  Dogs on leads march to war
//  Go ahead end it all...
//
//  Blow up the world
//  The final silence
//  Blow up the world
//  I don't give a damn!
//
//  When I wrote this code, only I and God knew what it was.
//  Now, only God knows!
//
//  So if you're done trying 'optimize' this routine (and failed),
//  please increment the following counter
//  as a warning to the next guy:
//
//  total_hours_wasted_here = 0
//
//  Created by Elias Abel on 2018/2/28.
//  
//

#if os(iOS)
    import Foundation
    import UIKit
    
    // MARK: - Keyboard
    
    public typealias KeyboardEventClosure = (_ notification: Foundation.Notification, _ duration: Double, _ curve: Double, _ frameBegin: CGRect, _ frameEnd: CGRect) -> Swift.Void
    
    public struct KeyboardEvent: Equatable {
        public static func ==(lhs: KeyboardEvent, rhs: KeyboardEvent) -> Bool {
            return lhs.notificationName == rhs.notificationName
        }
        
        private init() {
            fatalError("Use init(name:)")
        }
        
        public let notificationName: Foundation.Notification.Name
        private init(name: Foundation.Notification.Name) {
            notificationName = name
        }
        
        public static let willShow = KeyboardEvent.init(name: .UIKeyboardWillShow)
        public static let didShow = KeyboardEvent.init(name: .UIKeyboardDidShow)
        public static let willHide = KeyboardEvent.init(name: .UIKeyboardWillHide)
        public static let didHide = KeyboardEvent.init(name: .UIKeyboardDidHide)
        public static let willChangeFrame = KeyboardEvent.init(name: .UIKeyboardWillChangeFrame)
        public static let didChangeFrame = KeyboardEvent.init(name: .UIKeyboardDidChangeFrame)
    }
    
    public func observingKeyboard(event: KeyboardEvent, target: AnyObject, callback: @escaping KeyboardEventClosure) {
        
        Eventer.onMainThread(target, name: event.notificationName.rawValue, sender: nil, handler: { (notification) in
            guard let userInfo = notification.userInfo else {
                callback(notification, 0, 0, CGRect.zero, CGRect.zero)
                return
            }
            let duration = userInfo[UIKeyboardAnimationDurationUserInfoKey] as? Double
            let curve = userInfo[UIKeyboardAnimationCurveUserInfoKey] as? Double
            let keyboardFrameBegin = userInfo[UIKeyboardFrameBeginUserInfoKey] as? CGRect
            let keyboardFrameEnd = userInfo[UIKeyboardFrameEndUserInfoKey] as? CGRect
            
            callback(notification, duration ?? 0, curve ?? 0, keyboardFrameBegin ?? .zero, keyboardFrameEnd ?? .zero)
        })
    }
#endif
