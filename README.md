# example-opa-table-driven-tests

Example of [OPA](https://www.openpolicyagent.org/)'s Policy Tests like [Table Driven Tests](https://github.com/golang/go/wiki/TableDrivenTests)

## Example

Please see [policy](policy).

```console
$ conftest verify

1 test, 1 passed, 0 warnings, 0 failures, 0 exceptions, 0 skipped
```

Please update the test.

```console
$ sed -i 's/retention_in_days": 0/retention_in_days": 2/' policy/cloudwatch_log_retention_in_days_test.rego
```

Then the test would be failed.

```console
$ conftest verify
FAIL - policy/cloudwatch_log_retention_in_days_test.rego -  - data.main.test_deny_aws_cloudwatch_log_grop_retention_in_days

1 test, 0 passed, 0 warnings, 1 failure, 0 exceptions, 0 skipped
```

Using the `--trace` option, we can check the trace log.

```console
$ conftest verify --trace --no-color | grep Note | sed 's/^.*Note "\(.*\)"$/\1/'
FAIL test_deny_aws_cloudwatch_log_grop_retention_in_days (1): retention_in_days should be greater than 0, wanted {\"aws_cloudwatch_log_group.main: retention_in_days should be set and greater than 0\"}, got set()
```

## LICENSE

[MIT](LICENSE)
