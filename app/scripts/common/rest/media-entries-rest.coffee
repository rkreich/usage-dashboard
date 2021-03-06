do ->

	module = angular.module 'KalturaUsageDashboard.rest.media-entries-report', []


	module.service 'mediaEntriesReport', [
		'RestFactory'
		(RestFactory) ->
			_.extend @, new RestFactory
				params:
					action: 'getGraphs'
					reportType: 5
					'reportInputFilter:interval': 'days'

			@addFetchInterceptor @modifiers([
				'count_total'
				'count_video'
				'count_audio'
				'count_image'
			]).extract.months

			@
	]