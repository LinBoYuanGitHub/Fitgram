//
//  UploaderManager.swift
//  fitgram
//
//  Created by boyuan lin on 27/11/19.
//  Copyright © 2019 boyuan lin. All rights reserved.
//

import Foundation
import AliyunOSSiOS

class UploaderManager {

    var putRequest = OSSPutObjectRequest()
    var resumableRequest = OSSResumableUploadRequest()
    
    var isCancelled = false
    var isResumeUpload = false
    
    //const setting value for upload image
    public var OSSBucketName = "fitgramer"
    public var OSSEndPoint = "https://oss-ap-southeast-1.aliyuncs.com"
    let OSSCredentialProvider = OSSPlainTextAKSKPairCredentialProvider(plainTextAccessKey: "LTAI4FkQ7oYbSjgHYrFwc6Hc", secretKey: "5Y3ujMdMeQpw3u1ZiGvjsmAQRVGPTs")
    var client:OSSClient!
    
    static let shared = UploaderManager()
    private let folderPrefix = "foodDiaryImages/"
    
    
    init(){
        client = OSSClient(endpoint: OSSEndPoint, credentialProvider: OSSCredentialProvider)
    }
    
    func asyncPutImage(objectKey:String,filepath:String,uploadSuccessCallBack:@escaping (String) -> Void){
        if (objectKey.count == 0){
            return
        }
        let putRequest = OSSPutObjectRequest()
        putRequest.bucketName = OSSBucketName
        putRequest.objectKey = folderPrefix + objectKey
        putRequest.uploadingFileURL = URL(string: filepath)!
//        let textContent = "Hello OSS!"
//        putRequest.uploadingData = String(textContent).data(using: .utf8)!
        putRequest.uploadProgress = { bytesSent, totalByteSent, totalBytesExpectedToSend in
            print("Bytes sent: \(bytesSent), Total bytes sent:\(totalByteSent), Expected total bytes sent: \(totalBytesExpectedToSend)")
        }
        let putTask = client.putObject(putRequest)
        putTask.continue({ task in
            var result: String = ""
            if task.error == nil {
                result = "upload success"
            } else {
                result = "Failed to upload object. Error: " + task.error!.localizedDescription
            }
            print(result)
            return nil
        })
    }
    
    func asyncPutImage(objectKey:String, image:UIImage, uploadSuccessCallBack:@escaping (String) -> Void) {
        if (objectKey.count == 0){
            return
        }
        let putRequest = OSSPutObjectRequest()
        putRequest.bucketName = OSSBucketName
        putRequest.objectKey =  folderPrefix + objectKey
        guard let uploadingData = image.jpegData(compressionQuality: 0.8) else {
            return
        }
        putRequest.uploadingData = uploadingData
        putRequest.uploadProgress = { bytesSent, totalByteSent, totalBytesExpectedToSend in
            print("Bytes sent: \(bytesSent), Total bytes sent:\(totalByteSent), Expected total bytes sent: \(totalBytesExpectedToSend)")
        }
        let putTask = client.putObject(putRequest)
        putTask.continue({ task in
            var result: String = ""
            if task.error == nil {
                result = "upload success"
                uploadSuccessCallBack(objectKey)
            } else {
                result = "Failed to upload object. Error: " + task.error!.localizedDescription
            }
            print(result)
            return nil
        })
    }
    
    
    
}
