grails.plugin.springsecurity.controllerAnnotations.staticRules = [
        [pattern: '/static/**',      access: ['permitAll']],
        [pattern: '/login/**',          access: ['permitAll']],
        [pattern: '/jcaptcha/**',       access: ['permitAll']],
        [pattern: '/logout',         access: ['permitAll']],
        [pattern: '/assets/**',      access: ['permitAll']],
        [pattern: '/404',            access: ['permitAll']],
        [pattern: '/403',            access: ['permitAll']],
        [pattern: '/500',            access: ['permitAll']],
        [pattern: '/**/favicon.ico', access: ['permitAll']],

        [pattern: '/**',             access: 'isAuthenticated()']
]
grails.plugin.springsecurity.securityConfigType = "Annotation"
grails.plugin.springsecurity.webNo = '01'
grails.plugin.springsecurity.password.algorithm = 'bcrypt'
grails.plugin.springsecurity.logout.postOnly = false
grails.plugin.springsecurity.userLookup.userDomainClassName = 'com.ybg.yxym.system.SystemUser'
grails.plugin.springsecurity.userLookup.authorityJoinClassName = 'com.ybg.yxym.system.SystemUserRole'
grails.plugin.springsecurity.auth.loginFormUrl = '/login/form'
grails.plugin.springsecurity.authority.className = 'com.ybg.yxym.system.SystemRole'
grails.plugin.springsecurity.authority.nameField = 'authority'
grails.plugin.springsecurity.failureHandler.defaultFailureUrl = '/500'
grails.plugin.springsecurity.failureHandler.ajaxAuthFailUrl = '/500'
grails.plugin.springsecurity.adh.errorPage = '/403'
grails.plugin.springsecurity.adh.ajaxErrorPage = '/403'

jcaptcha.jcaptchaName = 'jcaptcha'
jcaptcha.enabled = true
jcaptcha.time = 5
jcaptcha.allowedNumberOfAttempts = 3

grails.json.legacy.builder = false