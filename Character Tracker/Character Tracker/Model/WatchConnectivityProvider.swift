//
//  WatchConnectivityProvider.swift
//  Character Tracker
//
//  Created by Isaac Lyons on 4/22/20.
//  Copyright © 2020 Isaac Lyons. All rights reserved.
//

import CoreData
import WatchConnectivity

final class WatchConnectivityProvider: NSObject {
    
    //MARK: Properties
    
    private let persistentContainer: NSPersistentContainer
    private let session: WCSession
    
    init(session: WCSession = .default, persistentContainer: NSPersistentContainer) {
        self.persistentContainer = persistentContainer
        self.session = session
        super.init()
        session.delegate = self
    }
    
    //MARK: Managing connection
    
    func connect() {
        guard WCSession.isSupported() else {
            return NSLog("Watch session is not supported")
        }
        
        print("Activating watch session")
        session.activate()
    }
    
    //MARK: Sending data to watch
    
    func noteCharactersDidChange() {
        
    }
    
}

//MARK: Watch Connectivity session delegate

extension WatchConnectivityProvider: WCSessionDelegate {
    func session(_ session: WCSession, didReceiveMessage message: [String : Any], replyHandler: @escaping ([String : Any]) -> Void) {
        guard let contentString = message[WatchCommunication.requestKey] as? String,
            let content = WatchCommunication.Content(rawValue: contentString) else {
                return replyHandler([:])
        }
        
        switch content {
        case .allCharacters:
            persistentContainer.performBackgroundTask { moc in
                do {
                    let fetchRequest: NSFetchRequest<Character> = Character.fetchRequest()
                    let allCharacters = try moc.fetch(fetchRequest)
                    let allNames = allCharacters.compactMap { $0.name }
                    replyHandler([WatchCommunication.responseKey: allNames])
                } catch {
                    NSLog("\(error)")
                    replyHandler([:])
                }
            }
        }
    }
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        print("Finished activating session")
    }
    
    func sessionDidBecomeInactive(_ session: WCSession) {
        print("Session became inactive")
    }
    
    func sessionDidDeactivate(_ session: WCSession) {
        print("Session deactivated")
    }
}
