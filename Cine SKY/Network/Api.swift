//
//  Api.swift
//  Movs
//
//  Created by Bruno Lopes de Mello on 28/04/19.
//  Copyright © 2019 Bruno Lopes de Mello. All rights reserved.
//

import Foundation
import Alamofire

#if RELEASE
let debugRequests = false
#else
let debugRequests = true
#endif

// POST /api/v1/File/Upload
struct ResultUploadImage : Codable {
    var data : UploadImageData!
}
struct UploadImageData : Codable {
    var fileName : String!
}

class Api {
    
    let alamofireManager = Alamofire.SessionManager.default
    
    static let downloadManager: SessionManager = {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 3 * 60
        return Alamofire.SessionManager(configuration: configuration)
    }()
    
    
    public func requestCodable<T>(metodo: wMethods,
                                  url: String? = nil,
                                  objeto: T.Type,
                                  parametros: [String: Any],
                                  token: String = "",
                                  onSuccess: @escaping (_ response: HTTPURLResponse, _ objeto: T) -> Void,
                                  onFail: @escaping (_ response: HTTPURLResponse?, _ erroDescription: String) -> Void)
        where T: Codable {
            
            if !Utils.isConnectedToNetwork() {
                onFail(nil, "Verifique sua conexão com a internet e tente novamente")
                return
            }
            
            let parameters = parametros
            let tipoRequisicao = getTipoRequisicao(tipo: metodo)
            var urlRequisicao = ""
            
            if debugRequests && metodo == .wPOST {
                print("\n\n===========JSON===========")
                parametros.printJson()
                print("===========================\n\n")
            }
            
            if let url = url {
                urlRequisicao = url
            } else {
                onFail(nil, "Ocorreu um erro, nenhum método padrão esta definido e nenhuma url personalizada esta definida")
                return
            }
            
            let headers: HTTPHeaders = [
                "Content-Type": "application/json"
            ]
            
            var encoded: ParameterEncoding = JSONEncoding.default
            
            if tipoRequisicao == .get {
                encoded = URLEncoding.default
            }
            
            Alamofire.request(urlRequisicao,
                              method: tipoRequisicao,
                              parameters: parameters, encoding: encoded, headers: headers).debugLog()
                .responseJSON { (response) in
                    
                    if debugRequests {
                        print("""
                            \nDevice ID: \(UIDevice.current.identifierForVendor!.uuidString)
                            \n\nRequest: \(String(describing: response.request))
                            \nParametros: \n\(parametros)
                            \nTipo requisição:\(tipoRequisicao)\n\n
                            """)
                        print(response)
                    }
                    
                    switch response.result {
                    case .success:
                        
                        do {
                            let objeto = try JSONDecoder().decode(objeto.self, from: response.data!)
                            onSuccess(response.response!, objeto)
                        } catch (let error) {
                            print("\n\n===========Error===========")
                            print("Error Code: \(error._code)")
                            print("Error Messsage: \(error.localizedDescription)")
                            if let data = response.data, let str = String(data: data, encoding: String.Encoding.utf8){
                                print("Server Error: " + str)
                            }
                            debugPrint(error as Any)
                            print("===========================\n\n")
                        }
                        
                    case .failure(let error):
                        print("\n\n===========Error===========")
                        print("Error Code: \(error._code)")
                        print("Error Messsage: \(error.localizedDescription)")
                        if let data = response.data, let str = String(data: data, encoding: String.Encoding.utf8){
                            print("Server Error: " + str)
                        }
                        debugPrint(error as Any)
                        print("===========================\n\n")
                        onFail(response.response, "Sem resposta do servidor no momento (cod.80).")
                    }
            }
            
            
    }
    
    public func downloadFile(source: URL,
                             nomeArquivo: String = "",
                             salvar: Bool = false,
                             progressCompletion: ((Float) -> Void)? = nil,
                             completion: @escaping (_ response: DefaultDownloadResponse, _ path: URL?) -> Void) {
        
        var fileName = source.lastPathComponent
        if !nomeArquivo.isEmpty {
            fileName = nomeArquivo
        }
        if debugRequests {
            print("\n\nRequest: \(source.relativeString)")
        }
        
        //download
        let destination: DownloadRequest.DownloadFileDestination = { _, _ in
            var documentsDirectoryURL = try? FileManager()
                .url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: salvar)
            documentsDirectoryURL?.appendPathComponent(fileName)
            guard let fileURL = documentsDirectoryURL else { return (URL(fileURLWithPath: ""), []) }
            if !salvar {
                return (fileURL, [.removePreviousFile, .createIntermediateDirectories])
            } else {
                return (fileURL, [])
            }
        }
        
        Api.downloadManager
            .download(source.relativeString, to: destination).downloadProgress { (progress) in
                let percent = Float(progress.fractionCompleted)
                if let passProgress = progressCompletion {
                    passProgress(percent)
                }
            }.response { response in
                completion(response, response.destinationURL)
        }
        
    }
    
    private func getTipoRequisicao(tipo: wMethods) -> HTTPMethod {
        switch tipo {
        case .wGET:
            return .get
        case .wPOST:
            return .post
        }
    }
}
