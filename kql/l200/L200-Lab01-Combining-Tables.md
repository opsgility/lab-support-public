# LAB - Combining relevant tables together

Combining multiple relevant tables together to expose details

## Contents <!-- omit in toc -->

- [Prerequisites](#prerequisites)
- [Labs](#labs)

## Prerequisites

Ensure the steps in [Lab Setup](./L100-Lab00-Lab-Setup.md) file have been completed.


## Labs


### Lab: Combining Log Analytics Tables with Unions

1. Go to the Azure portal and **Logs** of the Log Analytics workspace.
1. If a pop up window of example queries shows up, **close** it. See [Example Repo](#references) for contents of the pop-up.
1. Add in the following performance query for App Services insights
```kusto
AppServiceHTTPLogs
| summarize avg(TimeTaken) by CsHost, bin(TimeGenerated, 15m)
```
1. Click **Run** to display all entries values
1. Add in this `let` command at the start of the command to include the VM insight table `InsightMetrics` in the query:
```kusto
let Compute = InsightsMetrics
| where Name=="UtilizationPercentage" ;
```
1. After the `AppServiceHTTPLogs` add in the following line to add rows into the query results via `union`:
```kusto
| union (Compute)
```
***NOTE:***  This will end up with a lot of additional entries with empty columns because InsightMetrics is using different columns to AppServiceHTTPLogs.  We can use `project` to translate them to similar column names
1. Remove the semi-colon (`;`) of the `let` command and use this `project` command to include the columns need for VM CPU performance:
```kusto
| project TimeGenerated, Source=Origin, Metric=Val ;
```
1. Before the `union` line includ this line to columns for the App Service:
```kusto
| project TimeGenerated, Source=CsHost, Metric=TimeTaken 
``` 
1. Clicking **Run** now you'll see that there are two `Metric` columns (`_int` and `_real`) because the Metric values are different types of data.  This can be resolved by casting the Metric values to the same type by convertig the integer (`int`) values of the `AppServiceHTTPLogs` to real with the command `toreal()` by changing its `project` line to:
```kusto
| project TimeGenerated, Source=CsHost, Metric=toreal(TimeTaken)
```
1. The summarize the results by adding this line at the end of the query:
```kusto
| summarize avg(Metric) by Source, bin(TimeGenerated, 15m)
```
1. Render the results to a time line chart with:
```kusto
| render timechart
```
1. Click **Run** you'll see that the results are skewed because the TimeTaken is in the thousands due to the miliseconds of response time, but the CPU utilization will never get over 100%.  By dividing the TimeTaken by 100 on the `| project` to scale it down to a similar value of the CPU utilization, the values will show up similarly:
```kusto
| project TimeGenerated, Source=CsHost, Metric=toreal(TimeTaken)/100
```

The resulting query should look like:
```kusto
let Compute = InsightsMetrics
| where Name=="UtilizationPercentage"
| project TimeGenerated, Source=Origin, Metric=Val;
AppServiceHTTPLogs
| project TimeGenerated, Source=CsHost, Metric=toreal(TimeTaken)/100 
| union (Compute)
| summarize avg(Metric) by Source, bin(TimeGenerated, 15m)
| render timechart 
```



## References
- [GitHub repo of examples](https://github.com/microsoft/AzureMonitorCommunity)
- [Log Analytics tutorial](https://docs.microsoft.com/en-us/azure/azure-monitor/logs/log-analytics-tutorial)
