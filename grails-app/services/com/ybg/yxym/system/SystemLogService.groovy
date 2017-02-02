package com.ybg.yxym.system

import grails.transaction.Transactional

@Transactional
class SystemLogService {

    def addLog(String username,String comment,String ip,String type) {
        def systemLog = new SystemLog()
        systemLog.loginIp = ip
        systemLog.operator = username
        systemLog.operationMark = comment
        systemLog.operationDate = new Date()
        systemLog.type = type
        systemLog.remark = comment
        systemLog.save flush: true
    }
}
