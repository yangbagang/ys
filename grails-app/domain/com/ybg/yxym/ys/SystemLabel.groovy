package com.ybg.yxym.ys

class SystemLabel {

    static constraints = {
        catalog nullable: true, unique: true
        labelName unique: true
    }

    String catalog//分类
    String labelName//标签
}
