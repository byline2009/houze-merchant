//
//  StreamHandle.swift
//  Runner
//
//  Created by Dan Hon on 1/2/20.
//  Copyright © 2020 The Chromium Authors. All rights reserved.
//

import UIKit
import Flutter

class StreamHandle: FlutterStreamHandler {
    
    var eventSink: FlutterEventSink?
    
    func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
        eventSink = events
        return nil
    }
    
    func onCancel(withArguments arguments: Any?) -> FlutterError? {
        eventSink = nil
        return nil
    }
    
    func excuteEventSink(data: String) {
        if (eventSink != nil) {
            eventSink!(data)
        }
    }
}
