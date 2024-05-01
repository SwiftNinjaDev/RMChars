//
//  ViewState.swift
//  RMChars
//
//  Created by Nikolai Kharkevich on 01.05.2024.
//

import StatefulMVVM

public typealias ViewState = ViewStateProtocol
public typealias Store<State: ViewState> = GenericStore<State>
