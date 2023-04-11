//
//  EncryptionService.swift
//  Navigation
//
//  Created by Artur Skaliy on 11.04.2023.
//

import Foundation
import RNCryptor

class EncryptionService {
    func encryptMessage(message: String, encryptionKey: String) throws -> String {
           let messageData = message.data(using: .utf8)!
           let cipherData = RNCryptor.encrypt(data: messageData, withPassword: encryptionKey)
           return cipherData.base64EncodedString()
       }

       func decryptMessage(encryptedMessage: String, encryptionKey: String) throws -> String {

           let encryptedData = Data.init(base64Encoded: encryptedMessage)!
           let decryptedData = try RNCryptor.decrypt(data: encryptedData, withPassword: encryptionKey)
           let decryptedString = String(data: decryptedData, encoding: .utf8)!

           return decryptedString
       }
    
    func generateEncryptionKey(withPassword password:String) throws -> String {
        let randomData = RNCryptor.randomData(ofLength: 32)
        let cipherData = RNCryptor.encrypt(data: randomData, withPassword: password)
        return cipherData.base64EncodedString()
    }
}
