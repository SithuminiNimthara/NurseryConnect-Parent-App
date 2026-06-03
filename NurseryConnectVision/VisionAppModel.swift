import SwiftUI

@Observable
class VisionAppModel {
    var immersiveSpaceOpen = false
    var selectedZone: NurseryZone? = nil

    // Logic to select a zone, allowing for de-selection
    func selectZone(_ zone: NurseryZone) {
        if selectedZone == zone {
            selectedZone = nil
        } else {
            selectedZone = zone
        }
    }
}
