import Foundation

extension String {
  static func suitesArrayConverter(array: [String]) -> String {
    var convertedArray = ""
    
    array.forEach { room in
      convertedArray += "・\(room)"
    }
    
    return convertedArray
  }
}
