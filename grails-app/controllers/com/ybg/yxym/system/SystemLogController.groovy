package com.ybg.yxym.system

import com.ybg.yxym.vo.AjaxPagingVo
import grails.converters.JSON
import grails.plugin.springsecurity.annotation.Secured
import grails.transaction.Transactional

@Transactional(readOnly = true)
@Secured(['ROLE_SUPER_ADMIN', 'ROLE_SYSTEM_ADMIN'])
class SystemLogController {

    def index() {
        //render html for ajax
    }

    def list() {
        def data = SystemLog.list(params)
        def count = SystemLog.count()

        def result = new AjaxPagingVo()
        result.data = data
        result.draw = Integer.valueOf(params.draw)
        result.error = ""
        result.success = true
        result.recordsTotal = count
        result.recordsFiltered = count
        render result as JSON
    }

    def show(SystemLog systemLog) {
        render systemLog as JSON
    }

}
