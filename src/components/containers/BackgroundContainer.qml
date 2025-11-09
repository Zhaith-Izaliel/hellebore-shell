import Quickshell
import Quickshell.Wayland

PanelWindow {
    id: root
    required property string name

    WlrLayershell {
        namespace: `hellebore-background-${root.name}`
        layer: WlrLayer.Bottom
    }

    color: "transparent"
}
