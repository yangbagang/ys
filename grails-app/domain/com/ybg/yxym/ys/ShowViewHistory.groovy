package com.ybg.yxym.ys

class ShowViewHistory {

    static belongsTo = [show: RuiShow, userBase: UserBase]

    static constraints = {
    }

    Date createTime = new Date()//观看时间
    Date updateTime = new Date()//更新时间
    Short flag = 1 as Short//是否还在。1在，0离开。
}
