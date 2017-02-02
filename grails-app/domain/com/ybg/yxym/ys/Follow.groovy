package com.ybg.yxym.ys

class Follow {

    static belongsTo = [userBase: UserBase]

    static constraints = {
    }

    Date createTime = new Date()
    UserBase follow
}
