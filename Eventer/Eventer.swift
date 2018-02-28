
//
//  Eventer.swift
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
//  Created by Elias Abel on 2016/1/8.
//  Copyright © 2016 Meniny Lab. All rights reserved.
//

import Foundation

////////////////////////////////////
// Internal
////////////////////////////////////

internal struct EventerStatic {
    internal static let instance = Eventer.init()
    internal static let queue = DispatchQueue(label: "cn.meniny.EventBus", attributes: [])
}

internal struct EventerObserver {
    internal let observer: NSObjectProtocol
    internal let name: String
}

////////////////////////////////////
// Eventer
////////////////////////////////////

open class Eventer {
    
    ////////////////////////////////////
    // Caches
    ////////////////////////////////////
    
    internal var cache: [UInt: [EventerObserver]] = [:]

    ////////////////////////////////////
    // Publish
    ////////////////////////////////////


    open class func post(_ name: String, sender: Any? = nil) {
        NotificationCenter.default.post(name: Notification.Name(rawValue: name), object: sender)
    }

    open class func post(_ name: String, sender: NSObject?) {
        NotificationCenter.default.post(name: Notification.Name(rawValue: name), object: sender)
    }

    open class func post(_ name: String, sender: Any? = nil, userInfo: [AnyHashable: Any]?) {
        NotificationCenter.default.post(name: Notification.Name(rawValue: name), object: sender, userInfo: userInfo)
    }

    open class func post(_ name: String, on thread: DispatchQueue, sender: Any? = nil) {
        thread.async {
            NotificationCenter.default.post(name: Notification.Name(rawValue: name), object: sender)
        }
    }

    open class func post(_ name: String, on thread: DispatchQueue, sender: NSObject?) {
        thread.async {
            NotificationCenter.default.post(name: Notification.Name(rawValue: name), object: sender)
        }
    }

    open class func post(_ name: String, on thread: DispatchQueue, sender: Any? = nil, userInfo: [AnyHashable: Any]?) {
        thread.async {
            NotificationCenter.default.post(name: Notification.Name(rawValue: name), object: sender, userInfo: userInfo)
        }
    }


    ////////////////////////////////////
    // Subscribe
    ////////////////////////////////////

    @discardableResult
    open class func on(_ target: AnyObject, name: String, sender: Any? = nil, queue: OperationQueue? = nil, handler: @escaping ((Notification) -> Void)) -> NSObjectProtocol {
        
        let id = UInt(bitPattern: ObjectIdentifier(target))
        let observer = NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: name), object: sender, queue: queue, using: handler)
        let namedObserver = EventerObserver(observer: observer, name: name)

        EventerStatic.queue.sync {
            if let namedObservers = EventerStatic.instance.cache[id] {
                EventerStatic.instance.cache[id] = namedObservers + [namedObserver]
            } else {
                EventerStatic.instance.cache[id] = [namedObserver]
            }
        }

        return observer
    }

    @discardableResult
    open class func onMainThread(_ target: AnyObject, name: String, sender: Any? = nil, handler: @escaping ((Notification) -> Void)) -> NSObjectProtocol {
        return Eventer.on(target, name: name, sender: sender, queue: OperationQueue.main, handler: handler)
    }

    @discardableResult
    open class func onBackgroundThread(_ target: AnyObject, name: String, sender: Any? = nil, handler: @escaping ((Notification) -> Void)) -> NSObjectProtocol {
        return Eventer.on(target, name: name, sender: sender, queue: OperationQueue(), handler: handler)
    }

    ////////////////////////////////////
    // Unregister
    ////////////////////////////////////

    open class func unregister(_ target: AnyObject) {
        
        let id = UInt(bitPattern: ObjectIdentifier(target))
        let center = NotificationCenter.default

        EventerStatic.queue.sync {
            
            guard let namedObservers = EventerStatic.instance.cache.removeValue(forKey: id) else { return }
            
            for namedObserver in namedObservers {
                center.removeObserver(namedObserver.observer)
            }
        }
    }

    open class func unregister(_ target: AnyObject, name: String) {
        
        let id = UInt(bitPattern: ObjectIdentifier(target))
        let center = NotificationCenter.default

        EventerStatic.queue.sync {
            
            guard let namedObservers = EventerStatic.instance.cache[id] else { return }
            
            EventerStatic.instance.cache[id] = namedObservers.filter({ (namedObserver: EventerObserver) -> Bool in
                if namedObserver.name == name {
                    center.removeObserver(namedObserver.observer)
                    return false
                }
                return true
            })
        }
    }

}
