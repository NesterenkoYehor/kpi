import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Qt.labs.qmlmodels

Rectangle {
    id: main
    width: 600
    height: 400
    visible: true
    color: "#373231"
    GridLayout {
        width: main.width
        height: main.height
        columns: 2
        rows: 3
        ColumnLayout {
            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.maximumWidth: main.width
            Layout.maximumHeight: main.height
            Layout.minimumWidth: 300
            Layout.minimumHeight: 400
            Layout.alignment: Qt.AlignLeft
            RowLayout {
                Layout.maximumWidth: 400
                Layout.maximumHeight: 30
                Layout.minimumWidth: 300
                Layout.minimumHeight: 30
                Layout.alignment: Qt.AlignTop
                Button {
                    id: login
                    Layout.leftMargin: 10
                    Layout.topMargin: 10
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    background: Rectangle {
                        id: loginBackground
                        color: "#72706f"
                        border.width: 1
                        border.color: "green"
                        radius: 5
                    }
                    MouseArea {
                        anchors.fill: login
                        hoverEnabled: true
                        onPressed: {
                            loginBackground.border.color = "green"
                            fieldsBackground.border.color = "black"
                            usersBackground.border.color = "black"
                            loginBackground.color = "#615e5d"
                            loader.source = "login.qml"
                        }
                        onReleased: {
                            loginBackground.color = "#8c8583"
                        }
                        onEntered: {
                            loginBackground.color = "#8c8583"
                        }
                        onExited: {
                            loginBackground.color = "#72706f"
                        }
                    }
                    Text {
                        text: "Login"
                        anchors.centerIn: parent
                    }
                }

                Button {
                    id: fields
                    Layout.leftMargin: 10
                    Layout.topMargin: 10
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    enabled: false
                    background: Rectangle {
                        id: fieldsBackground
                        color: "#72706f"
                        border.width: 1
                        border.color: "black"
                        radius: 5
                        opacity: 0.3
                    }
                    MouseArea {
                        anchors.fill: fields
                        hoverEnabled: true
                        onPressed: {
                            loginBackground.border.color = "black"
                            fieldsBackground.border.color = "green"
                            usersBackground.border.color = "black"
                            fieldsBackground.color = "#615e5d"
                            loader.source = "field_table.qml"
                        }
                        onReleased: {
                            fieldsBackground.color = "#8c8583"
                        }
                        onEntered: {
                            fieldsBackground.color = "#8c8583"
                        }
                        onExited: {
                            fieldsBackground.color = "#72706f"
                        }
                    }
                    Text {
                        text: "Fields"
                        anchors.centerIn: parent
                    }
                }

                Button {
                    id: users
                    Layout.leftMargin: 10
                    Layout.topMargin: 10
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    enabled: false
                    background: Rectangle {
                        id: usersBackground
                        color: "#72706f"
                        border.width: 1
                        border.color: "black"
                        radius: 5
                        opacity: 0.3
                    }
                    MouseArea {
                        anchors.fill: users
                        hoverEnabled: true
                        onPressed: {
                            loginBackground.border.color = "black"
                            fieldsBackground.border.color = "black"
                            usersBackground.border.color = "green"
                            usersBackground.color = "#615e5d"
                            loader.source = "user_table.qml"
                        }
                        onReleased: {
                            usersBackground.color = "#8c8583"
                        }
                        onEntered: {
                            usersBackground.color = "#8c8583"
                        }
                        onExited: {
                            usersBackground.color = "#72706f"
                        }
                    }
                    Text {
                        text: "Users"
                        anchors.centerIn: parent
                    }
                }
            }
            RowLayout {
                Layout.maximumWidth: 400
                Layout.maximumHeight: 370
                Layout.minimumWidth: 300
                Layout.minimumHeight: 370
                Layout.alignment: Qt.AlignBottom
                Loader {
                    id: loader
                    Layout.alignment: Qt.AlignTop | Qt.AlignHCenter
                    Layout.topMargin: 10
                    Layout.bottomMargin: 10
                    Layout.leftMargin: 10
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    source: "login.qml"
                }
            }
        }
    }
}