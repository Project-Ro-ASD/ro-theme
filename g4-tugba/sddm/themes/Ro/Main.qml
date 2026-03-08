import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15

Rectangle {
    id: root
    width: Screen.width
    height: Screen.height
    color: "#FFFFFF"

    // --- SABİT ARKA PLAN (GÜN BATIMI ÇÖLÜ) ---
    Image {
        id: backgroundImage
        anchors.fill: parent
        source: "mojave_day.png"
        fillMode: Image.PreserveAspectCrop
        smooth: true
    }

    // --- MERKEZİ GİRİŞ PANELİ (BUZLU CAM) ---
    Rectangle {
        id: loginBox
        width: 380; height: 500
        anchors.centerIn: parent
        color: "#CCFFFFFF" // Aydınlık yarı saydam cam
        radius: 35
        border.color: "#FF9A8B" // Gün batımı pembesi/turuncusu kenarlık
        border.width: 1.5

        // Profil İkonu
        Rectangle {
            id: avatar
            width: 110; height: 110; radius: 55
            anchors.top: parent.top; anchors.topMargin: 40; anchors.horizontalCenter: parent.horizontalCenter
            color: "white"
            border.color: "#FF7E5F"
            border.width: 3
            Text {
                anchors.centerIn: parent
                text: userModel.lastUser ? userModel.lastUser.charAt(0).toUpperCase() : "👤"
                color: "#FF7E5F"; font.pixelSize: 50; font.bold: true
            }
        }

        // Kullanıcı Seçici
        ComboBox {
            id: userSelector
            anchors.top: avatar.bottom; anchors.topMargin: 30; anchors.horizontalCenter: parent.horizontalCenter
            width: 260; height: 45
            model: userModel; textRole: "name"; currentIndex: userModel.lastIndex
            background: Rectangle { color: "white"; radius: 15; border.color: "#E0E0E0" }
            contentItem: Text { text: userSelector.currentText; color: "#333333"; font.pixelSize: 16; font.bold: true; horizontalAlignment: Text.AlignHCenter; verticalAlignment: Text.AlignVCenter }
        }

        // Şifre Girişi
        Rectangle {
            id: passField
            width: 260; height: 45
            anchors.top: userSelector.bottom; anchors.topMargin: 15; anchors.horizontalCenter: parent.horizontalCenter
            color: "white"; radius: 15; border.color: "#E0E0E0"
            TextInput {
                id: passwordInput
                anchors.fill: parent; anchors.margins: 10
                verticalAlignment: TextInput.AlignVCenter; horizontalAlignment: TextInput.AlignHCenter
                echoMode: TextInput.Password; color: "#000000"; font.pixelSize: 18; focus: true
                passwordCharacter: "●"
                onAccepted: sddm.login(userSelector.currentText, passwordInput.text, sessionSelector.currentIndex)
            }
        }

        // Giriş Butonu
        Button {
            anchors.top: passField.bottom; anchors.topMargin: 30; anchors.horizontalCenter: parent.horizontalCenter
            width: 260; height: 50
            background: Rectangle {
                radius: 15
                gradient: Gradient {
                    GradientStop { position: 0.0; color: "#FF7E5F" }
                    GradientStop { position: 1.0; color: "#FEB47B" }
                }
            }
            contentItem: Text { text: "Giriş Yap"; color: "white"; font.pixelSize: 18; font.bold: true; horizontalAlignment: Text.AlignHCenter; verticalAlignment: Text.AlignVCenter }
            onClicked: sddm.login(userSelector.currentText, passwordInput.text, sessionSelector.currentIndex)
        }
    }

    // --- AÇIK TEMA ALT BAR VE BUTONLAR ---
    Rectangle {
        anchors.bottom: parent.bottom; width: parent.width; height: 80
        // Siyah yerine kum tonlarına uyumlu çok hafif beyaz şeffaf cam
        color: "#4DFFFFFF" 

        // Sol Alt: Oturum Seçimi
        ComboBox {
            id: sessionSelector
            anchors.left: parent.left; anchors.leftMargin: 30; anchors.verticalCenter: parent.verticalCenter
            width: 180; height: 40; model: sessionModel; textRole: "name"
            // Arka planı beyazlaştırıp kenarlarına gün batımı turuncusu verdik
            background: Rectangle { color: "#99FFFFFF"; radius: 10; border.color: "#FF9A8B"; border.width: 1 }
            // Açık zeminde okunması için yazıyı koyu gri yaptık
            contentItem: Text { text: sessionSelector.currentText; color: "#444444"; font.bold: true; horizontalAlignment: Text.AlignHCenter; verticalAlignment: Text.AlignVCenter }
        }

        // Sağ Alt: Güç Butonları Grubu
        Row {
            anchors.right: parent.right; anchors.rightMargin: 30; anchors.verticalCenter: parent.verticalCenter
            spacing: 15

            Button {
                text: "Uyut"; onClicked: sddm.suspend()
                background: Rectangle { color: "#99FFFFFF"; radius: 10; border.color: "#FF9A8B"; border.width: 1 }
                contentItem: Text { text: parent.text; color: "#444444"; font.bold: true; padding: 10 }
            }
            Button {
                text: "Yeniden Başlat"; onClicked: sddm.reboot()
                background: Rectangle { color: "#99FFFFFF"; radius: 10; border.color: "#FF9A8B"; border.width: 1 }
                contentItem: Text { text: parent.text; color: "#444444"; font.bold: true; padding: 10 }
            }
            Button {
                text: "Kapat"; onClicked: sddm.powerOff()
                // Kapat butonunu resimdeki sıcak pembe/kızıl tonuyla değiştirdik
                background: Rectangle { color: "#FF6A88"; radius: 10 }
                contentItem: Text { text: parent.text; color: "white"; font.bold: true; padding: 10 }
            }
        }
    }
}
