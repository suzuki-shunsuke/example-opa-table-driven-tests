package main

test_deny_aws_cloudwatch_log_grop_retention_in_days {
	not any_deny_aws_cloudwatch_log_grop_retention_in_days
}

any_deny_aws_cloudwatch_log_grop_retention_in_days {
	seeds := [
		{
			"msg": "pass",
			"resource": {
				"type": "aws_cloudwatch_log_group",
				"address": "aws_cloudwatch_log_group.main",
				"values": {"retention_in_days": 7},
			},
			"exp": set(),
		},
		{
			"msg": "retention_in_days should be greater than 0",
			"resource": {
				"type": "aws_cloudwatch_log_group",
				"address": "aws_cloudwatch_log_group.main",
				"values": {"retention_in_days": 0},
			},
			"exp": {"aws_cloudwatch_log_group.main: retention_in_days should be set and greater than 0"},
		},
		{
			"msg": "retention_in_days should be set",
			"resource": {
				"type": "aws_cloudwatch_log_group",
				"address": "aws_cloudwatch_log_group.main",
				"values": {},
			},
			"exp": {"aws_cloudwatch_log_group.main: retention_in_days should be set and greater than 0"},
		},
	]

	some i
	seed := seeds[i]

	result := deny_aws_cloudwatch_log_grop_retention_in_days with input as wrap_single_resource(seed.resource)

	result != seed.exp
	trace(sprintf("FAIL %s (%d): %s, wanted %v, got %v", ["test_deny_aws_cloudwatch_log_grop_retention_in_days", i, seed.msg, seed.exp, result]))
}
