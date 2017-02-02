package com.ybg.yxym.ys

class ShowShare {

    static belongsTo = [show: RuiShow]

    static constraints = {
    }

    Date createTime = new Date()
    UserBase userBase

}
