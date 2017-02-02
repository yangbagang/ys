package com.ybg.yxym.ys

class UserGroup {

    static belongsTo = [userBase: UserBase]

    static constraints = {
    }

    String name
    Date createTime
    Integer level = 1
}
