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

#include "config.h"

#include <KPushButton>
#include <KTelepathy/PeopleManager>
#include <KTelepathy/PersonSetModel>
#include <KTelepathy/PersonSet>

Config::Config(QWidget* parent)
    : KDialog(parent)
{
    QWidget *widget = new QWidget(this);

    ui.setupUi(widget);
    setMainWidget(widget);
    setupContactsList();
}

Config::~Config()
{
}

void Config::activateOkButton()
{
    button(Ok)->setEnabled(true);
}

void Config::setupContactsList()
{
    // set list to show nepomuk model
    ui.contactsList->setModel(new KTelepathy::PersonSetModel(KTelepathy::PeopleManager::instance()->everyone()));

    // disable ok button until a list item is selected
    button(Ok)->setEnabled(false);
    connect(ui.contactsList, SIGNAL(clicked(QModelIndex)), this, SLOT(activateOkButton()));
}
