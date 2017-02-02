package com.ybg.yxym.ys

class UserWisdom {

    static belongsTo = [userBase: UserBase]

    static constraints = {
    }

    UserBase relatives
    Date createTime
}
