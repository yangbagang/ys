package com.ybg.yxym.ys

class UserAchievement {

    static belongsTo = [userBase: UserBase, achievement: SystemAchievement]

    static constraints = {
    }
}
