package com.ybg.yxym.ys

class RaceUser {

    static belongsTo = [race: Race]

    static constraints = {
    }

    Date createTime = new Date()
    UserBase userBase
}
