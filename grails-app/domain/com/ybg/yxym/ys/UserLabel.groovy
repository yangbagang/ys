package com.ybg.yxym.ys

class UserLabel {

    static belongsTo = [userBase: UserBase, systemLabel: SystemLabel]

    static constraints = {
    }
}
