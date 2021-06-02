import Foundation

func query(address: String, connectionProxyDictionary: [AnyHashable: Any]) -> String {
    let url = URL(string: address)
    let semaphore = DispatchSemaphore(value: 0)
    
    let config = URLSessionConfiguration.default
    config.requestCachePolicy = .reloadIgnoringLocalCacheData
    config.urlCache = nil
    config.connectionProxyDictionary = connectionProxyDictionary
    let session = URLSession(configuration: config)

    var result: String = ""
    let task = session.dataTask(with: url!) {(data, response, error) in
        if let error = error {
            print("error: \(error.localizedDescription)")
            semaphore.signal()
            return
        }
        result = String(data: data!, encoding: String.Encoding.utf8)!
        semaphore.signal()
    }
    
    task.resume()
    semaphore.wait()
    return result
}

let socksConnectionProxyDictionary: [AnyHashable: Any] = [
    kCFNetworkProxiesExcludeSimpleHostnames: false,
    kCFStreamPropertySOCKSProxyHost: "127.0.0.1",
    kCFStreamPropertySOCKSProxyPort: 1080,
    kCFStreamPropertySOCKSVersion: kCFStreamSocketSOCKSVersion5,
]

let httpConnectionProxyDictionary: [AnyHashable: Any] = [
    kCFNetworkProxiesExcludeSimpleHostnames: false,
    kCFNetworkProxiesHTTPProxy: "127.0.0.1",
    kCFNetworkProxiesHTTPPort: 9000,
]

print("--------SOCKS---------")
print("example.com: \(query(address: "http://example.com", connectionProxyDictionary: socksConnectionProxyDictionary))")
print("localhost: \(query(address: "http://localhost", connectionProxyDictionary: socksConnectionProxyDictionary))")

print("-----HTTP-PROXY-------")
print("example.com: \(query(address: "http://example.com", connectionProxyDictionary: httpConnectionProxyDictionary))")
print("localhost: \(query(address: "http://localhost", connectionProxyDictionary: httpConnectionProxyDictionary))")
print("----------------------")
