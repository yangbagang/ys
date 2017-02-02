package com.ybg.yxym.ys

import com.ybg.yxym.vo.AjaxPagingVo
import grails.converters.JSON
import grails.transaction.Transactional

@Transactional(readOnly = true)
class RuiGiftController {

    static allowedMethods = [save: "POST", delete: "DELETE"]

    def index() {
        //render html for ajax
    }

    def list(String name) {
        def c = RuiGift.createCriteria()
        def gifts = c.list(max: params.length, offset: params.start) {
            like("name", "%${name}%")
        }

        def result = new AjaxPagingVo()
        result.data = gifts
        result.draw = Integer.valueOf(params.draw)
        result.error = ""
        result.success = true
        result.recordsTotal = gifts.totalCount
        result.recordsFiltered = gifts.totalCount
        render result as JSON
    }

    def show(RuiGift ruiGift) {
        render ruiGift as JSON
    }

    @Transactional
    def save(RuiGift ruiGift) {
        def result = [:]
        if (ruiGift == null) {
            result.success = false
            result.msg = "ruiGift is null."
            render result as JSON
            return
        }

        if (ruiGift.hasErrors()) {
            transactionStatus.setRollbackOnly()
            result.success = false
            result.msg = ruiGift.errors
            render result as JSON
            return
        }

        ruiGift.save flush:true

        result.success = true
        result.msg = ""
        render result as JSON
    }

    @Transactional
    def delete(RuiGift ruiGift) {
        def result = [:]
        if (ruiGift == null) {
            result.success = false
            result.msg = "ruiGift is null."
            render result as JSON
            return
        }

        ruiGift.flag = 0 as Short
        ruiGift.save flush: true

        result.success = true
        result.msg = ""
        render result as JSON
    }

    @Transactional
    def savePic(Long giftId, String picId) {
        def result = [:]
        def ruiGift = RuiGift.get(giftId)
        if (ruiGift == null) {
            result.success = false
            result.msg = "ruiGift is null."
            render result as JSON
            return
        }

        ruiGift.image = picId
        ruiGift.save flush: true

        result.success = true
        result.msg = ""
        render result as JSON
    }

}
