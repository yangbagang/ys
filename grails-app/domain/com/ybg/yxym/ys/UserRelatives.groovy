package com.ybg.yxym.ys

class UserRelatives {

    static belongsTo = [userBase: UserBase]

    static constraints = {
    }

    UserBase relatives
    Date createTime
}
