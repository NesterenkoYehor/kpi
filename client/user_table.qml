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
            rows: [{"name": "name"}]
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
        id: loadUser
        width: 100
        height: 25
        anchors.verticalCenter: parent.verticalCenter
        background: Rectangle {
            id: loadUserBackground
            color: "#72706f"
            border.width: 1
            border.color: "black"
            radius: 5
        }
        MouseArea {
            anchors.fill: loadUser
            hoverEnabled: true
            onPressed: {
                loadUserBackground.color = "#615e5d"
                var rows = JSON.parse(wws.load_users())
                for (var i = 1; i <= rows["data"].length; i++) {
                    tableModel.insertRow(i, rows["data"][i - 1])
                }
            }
            onReleased: {
                loadUserBackground.color = "#8c8583"
            }
            onEntered: {
                loadUserBackground.color = "#8c8583"
            }
            onExited: {
                loadUserBackground.color = "#72706f"
            }
        }
        Text {
            text: "Load"
            anchors.centerIn: parent
        }
    }
}