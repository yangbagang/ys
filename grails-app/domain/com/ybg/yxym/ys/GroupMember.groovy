package com.ybg.yxym.ys

class GroupMember {

    static belongsTo = [group: UserGroup]

    static constraints = {
    }

    UserBase member
    Date joinTime
    Integer role = 0
}
