import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Qt.labs.qmlmodels

Rectangle {
    anchors.fill: parent
    color: "#373231"
    TableView {
        id: table
        anchors.fill: parent
        columnSpacing: 1
        rowSpacing: 1
        clip: true
        model: TableModel {
            id: tableModel
            TableModelColumn { display: "name" }
            TableModelColumn { display: "azot" }
            TableModelColumn { display: "bal" }
            TableModelColumn { display: "gumus" }
            TableModelColumn { display: "kaliy" }
            TableModelColumn { display: "ph" }
            TableModelColumn { display: "phosfor" }
            rows: [
                {
                    "name": "name",
                    "azot": "azot",
                    "bal": "bal",
                    "gumus": "gumus",
                    "kaliy": "kaliy",
                    "ph": "ph",
                    "phosfor": "phosfor"
                }
            ]
        }
        delegate: Rectangle {
            border.width: 1
            Layout.minimumWidth: 100
            Layout.minimumHeight: 25
            Layout.maximumHeight: 30
            implicitWidth: 100
            implicitHeight: 25
            Layout.fillWidth: true
            Layout.fillHeight: true
            Text {
                text: display
                anchors.centerIn: parent
            }
        }
    }
    Button {
        id: loadField
        width: 100
        height: 25
        anchors.verticalCenter: parent.verticalCenter
        background: Rectangle {
            id: loadFieldBackground
            color: "#72706f"
            border.width: 1
            border.color: "black"
            radius: 5
        }
        MouseArea {
            anchors.fill: loadField
            hoverEnabled: true
            onPressed: {
                loadFieldBackground.color = "#615e5d"
                var rows = JSON.parse(wws.load_fields())
                for (var i = 1; i <= rows["data"].length; i++) {
                    tableModel.insertRow(i, rows["data"][i - 1])
                }
            }
            onReleased: {
                loadFieldBackground.color = "#8c8583"
            }
            onEntered: {
                loadFieldBackground.color = "#8c8583"
            }
            onExited: {
                loadFieldBackground.color = "#72706f"
            }
        }
        Text {
            text: "Load"
            anchors.centerIn: parent
        }
    }
}