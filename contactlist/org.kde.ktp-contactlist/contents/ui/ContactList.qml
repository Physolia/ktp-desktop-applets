/***************************************************************************
 *   Copyright (C) 2011 by Francesco Nwokeka <francesco.nwokeka@gmail.com> *
 *                                                                         *
 *   This program is free software; you can redistribute it and/or modify  *
 *   it under the terms of the GNU General Public License as published by  *
 *   the Free Software Foundation; either version 2 of the License, or     *
 *   (at your option) any later version.                                   *
 *                                                                         *
 *   This program is distributed in the hope that it will be useful,       *
 *   but WITHOUT ANY WARRANTY; without even the implied warranty of        *
 *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the         *
 *   GNU General Public License for more details.                          *
 *                                                                         *
 *   You should have received a copy of the GNU General Public License     *
 *   along with this program; if not, write to the                         *
 *   Free Software Foundation, Inc.,                                       *
 *   51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA            *
 ***************************************************************************/

import QtQuick 2.1
import QtQuick.Layouts 1.1
import org.kde.telepathy 0.1 as KTp
import org.kde.plasma.components 2.0 as PlasmaComponents
import org.kde.plasma.extras 2.0 as PlasmaExtras
import org.kde.plasma.plasmoid 2.0

Item {
    id: root
    Layout.minimumHeight: delegateHeight*3
    Layout.minimumWidth: 100
    height: delegateHeight*10
    width: 300
    property real delegateHeight: Math.ceil(theme.mSize(theme.defaultFont).height*2)

    onVisibleChanged: {
        if (visible)
            filterLineEdit.forceActiveFocus();
    }

    PlasmaComponents.TextField {
        id: filterLineEdit
        anchors {
            left:parent.left
            right:parent.right
            top:parent.top
        }

        focus: true
        clearButtonShown: true

        placeholderText: i18n("Search contacts...")

        Keys.onDownPressed: contactsList.incrementCurrentIndex();
        Keys.onUpPressed: contactsList.decrementCurrentIndex();
        Keys.onReturnPressed: contactsList.currentItem.clicked();

        onActiveFocusChanged: filterLineEdit.selectAll();
    }

    PlasmaExtras.ScrollArea {
        anchors {
            top:filterLineEdit.bottom
            left:parent.left
            right:parent.right
            bottom:parent.bottom
        }

        flickableItem: ListView {
            id: contactsList

            clip: true
            model: KTp.ContactsModel {
                id: contactsModel
                accountManager: telepathyManager.accountManager
                presenceTypeFilterFlags: KTp.ContactsModel.HideAllOffline
                globalFilterString: filterLineEdit.text
                sortRoleString: "presenceType"
            }


            boundsBehavior: Flickable.StopAtBounds

            delegate: ListContactDelegate {
                height: root.delegateHeight
            }

            highlight: PlasmaComponents.Highlight {
                hover: contactsList.focus
            }
        }
    }
}
