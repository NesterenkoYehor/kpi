import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Rectangle {
    id: loginView
    width: parent.width
    height: parent.height
    color: "#373231"
    ColumnLayout {
        RowLayout {
            width: parent.width
            height: 50
            Text {
                Layout.alignment: Qt.AlignLeft
                text: "Login"
                color: "grey"
            }
            TextField {
                id: loginText
                Layout.alignment: Qt.AlignRight
                placeholderText: "Login"
            }
        }
        RowLayout {
            width: parent.width
            height: 50
            Text {
                Layout.alignment: Qt.AlignLeft
                text: "Password"
                color: "grey"
            }
            TextField {
                id: passwordText
                Layout.alignment: Qt.AlignRight
                placeholderText: "Password"
            }
        }
        RowLayout {
            width: parent.width
            height: 50
            Button {
                id: setData
                Layout.preferredWidth: 100
                Layout.preferredHeight: 25
                background: Rectangle {
                    id: setDataBackground
                    color: "#72706f"
                    border.width: 1
                    border.color: "black"
                    radius: 5
                }
                MouseArea {
                    anchors.fill: setData
                    hoverEnabled: true
                    onPressed: {
                        setDataBackground.color = "#615e5d"
                        if (wws.login(loginText.text, passwordText.text)) {
                            errorInAuth.text = ""
                            users.enabled = true
                            fields.enabled = true
                            usersBackground.opacity = 1
                            fieldsBackground.opacity = 1
                            errorInAuth.text = "Ok"
                            errorInAuth.color = "green"
                            // loader.source = "table.qml"
                        }
                        else {
                            errorInAuth.text = "Error in auth. Try again"
                            loginText.text = ""
                            passwordText.text = ""
                        }
                    }
                    onReleased: {
                        setDataBackground.color = "#8c8583"
                    }
                    onEntered: {
                        setDataBackground.color = "#8c8583"
                    }
                    onExited: {
                        setDataBackground.color = "#72706f"
                    }
                }
                Text {
                    text: "Submit"
                    anchors.centerIn: parent
                }
            }
            Button {
                id: resetData
                Layout.preferredWidth: 100
                Layout.preferredHeight: 25
                background: Rectangle {
                    id: resetDataBackground
                    color: "#72706f"
                    border.width: 1
                    border.color: "black"
                    radius: 5
                }
                MouseArea {
                    anchors.fill: resetData
                    hoverEnabled: true
                    onPressed: {
                        resetDataBackground.color = "#615e5d"
                        loginText.text = ""
                        passwordText.text = ""
                    }
                    onReleased: {
                        resetDataBackground.color = "#8c8583"
                    }
                    onEntered: {
                        resetDataBackground.color = "#8c8583"
                    }
                    onExited: {
                        resetDataBackground.color = "#72706f"
                    }
                }
                Text {
                    text: "Reset"
                    anchors.centerIn: parent
                }
            }
        }
        RowLayout {
            Text {
                id: errorInAuth
                color: "red"
            }
        }
    }
}