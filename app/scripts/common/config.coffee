do ->

	module = angular.module 'KalturaUsageDashboard.config', []


	module.config [
		'$urlRouterProvider'
		'$locationProvider'
		'$httpProvider'
		'RestangularProvider'
		'kmcProvider'
		($urlRouterProvider, $locationProvider, $httpProvider, RestangularProvider, kmcProvider) ->
			
			$locationProvider.html5Mode
				enabled: yes
				# requireBase: no
				requireBase: yes
			$locationProvider.hashPrefix '!'

			# $httpProvider.defaults.useXDomain = yes
			# $httpProvider.interceptors.push 'authHttpResponseInterceptor'
			# delete $httpProvider.defaults.headers.common['X-Requested-With']
			# $httpProvider.defaults.withCredentials = yes

			kmc = kmcProvider.$get()

			RestangularProvider.setBaseUrl "#{kmc.vars.service_url}/api_v3/index.php"
			RestangularProvider.setJsonp yes;
			RestangularProvider.setDefaultRequestParams 'jsonp',
				callback: 'JSON_CALLBACK'
				format: 9

			$urlRouterProvider.when '/usage-dashboard', [
				'redirector'
				(redirector) ->
					redirector 'usage-dashboard.overall-usage'
			]
			$urlRouterProvider.otherwise ($injector) ->
				$injector.get('redirector') 'usage-dashboard'
	]