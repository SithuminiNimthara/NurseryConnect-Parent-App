import SwiftUI
import RealityKit

struct ImmersiveNurseryTourView: View {
    @Environment(VisionAppModel.self) private var appModel

    var body: some View {
        RealityView { content, attachments in

            let floor = ModelEntity(
                mesh: .generateBox(size: [4.5, 0.02, 3.2]),
                materials: [
                    SimpleMaterial(
                        color: .init(red: 0.86, green: 0.78, blue: 1.0, alpha: 0.35),
                        isMetallic: false
                    )
                ]
            )
            floor.position = [0, -0.7, -1.6]
            content.add(floor)

            addNurseryObject(
                to: content,
                name: "Reading Corner",
                position: [-1.4, -0.35, -1.7],
                color: .systemPurple
            )

            addNurseryObject(
                to: content,
                name: "Play Area",
                position: [1.4, -0.35, -1.7],
                color: .systemOrange
            )

            addNurseryObject(
                to: content,
                name: "Meal Area",
                position: [-1.4, -0.35, -2.6],
                color: .systemGreen
            )

            addNurseryObject(
                to: content,
                name: "Rest Area",
                position: [1.4, -0.35, -2.6],
                color: .systemBlue
            )

            if let readingPanel = attachments.entity(for: "readingPanel") {
                readingPanel.position = [-1.4, 0.4, -1.7]
                content.add(readingPanel)
            }

            if let playPanel = attachments.entity(for: "playPanel") {
                playPanel.position = [1.4, 0.4, -1.7]
                content.add(playPanel)
            }

            if let mealPanel = attachments.entity(for: "mealPanel") {
                mealPanel.position = [-1.4, 0.4, -2.6]
                content.add(mealPanel)
            }

            if let restPanel = attachments.entity(for: "restPanel") {
                restPanel.position = [1.4, 0.4, -2.6]
                content.add(restPanel)
            }

            if let titlePanel = attachments.entity(for: "titlePanel") {
                titlePanel.position = [0, 1.0, -1.2]
                content.add(titlePanel)
            }

        } update: { content, attachments in

        } attachments: {
            Attachment(id: "titlePanel") {
                Text("Sunshine Room Spatial Tour")
                    .font(.largeTitle.bold())
                    .padding()
                    .glassBackgroundEffect()
            }

            Attachment(id: "readingPanel") {
                NurseryAreaPanel(area: .reading)
            }

            Attachment(id: "playPanel") {
                NurseryAreaPanel(area: .play)
            }

            Attachment(id: "mealPanel") {
                NurseryAreaPanel(area: .meal)
            }

            Attachment(id: "restPanel") {
                NurseryAreaPanel(area: .rest)
            }
        }
    }

    private func addNurseryObject(
        to content: RealityViewContent,
        name: String,
        position: SIMD3<Float>,
        color: UIColor
    ) {
        let entity = ModelEntity(
            mesh: .generateSphere(radius: 0.18),
            materials: [
                SimpleMaterial(
                    color: color.withAlphaComponent(0.85),
                    isMetallic: false
                )
            ]
        )

        entity.name = name
        entity.position = position
        content.add(entity)
    }
}
