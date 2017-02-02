package com.ybg.yxym.ys

class RuiShareUser {

    static belongsTo = [share: RuiShare, userBase: UserBase]

    static constraints = {
    }

    Date createTime = new Date()
}
