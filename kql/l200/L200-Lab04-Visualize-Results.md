# LAB - Visualize Results

Show essential integrated visualization results
 
## Contents <!-- omit in toc -->

- [Prerequisites](#prerequisites)
- [Labs](#labs)

## Prerequisites

See the [Lab Pre-req Day 2](./!Lab-Pre-req-Day2.md) file for details on what is needed for this labnstration.

### Lab: Pull performance insights from App Service

1. Go to the Azure portal and **Logs** of the Log Analytics workspace.
1. If a pop up window of example queries shows up, **close** it. See [Example Repo](#references) for contents of the pop-up.
1. Add the following query:
```kusto
let Compute = InsightsMetrics
| where Name=="UtilizationPercentage"
| project TimeGenerated, Source=Origin, Metric=Val;
AppServiceHTTPLogs
| project TimeGenerated, Source=CsHost, Metric=toreal(TimeTaken)/100 
| union (Compute)
```
4. Values can be graphed in a line graph over a time period by using `| render timechart`. add the line and Click **Run** to see that visualization
1. These will be attempted to be summarized by values in the columns, but they can be further specific by adding a `| summarize avg(Metric) by Source, bin(TimeGenerated, 15m)` before teh `render` line
1. This is good rendering over 3 metrics (measurement, source, and time), and there are two other formats that are similar in formation:
```kusto
| render areachart
| render scatterchart
```
Replace the `| render timechart` line with each of those to show them.
7. But a more general chart may be useful like a bar chart by changing the render line to 
```kusto
| render barchart
| render columnchart
| render piechart
```
8. These incorporate TimeGenerated values, but its likely that isn't one of the values you need included, so that can be removed from the summarized line by getting rid of the `, bin(TimeGenerated, 15m)`.  You end up with just `| summarize avg(Metric) by Source`.

```kusto
let Compute = InsightsMetrics
| where Name=="UtilizationPercentage"
| project TimeGenerated, Source=Origin, Metric=Val;
AppServiceHTTPLogs
| project TimeGenerated, Source=CsHost, Metric=toreal(TimeTaken)/100 
| union (Compute)
| summarize avg(Metric) by Source, bin(TimeGenerated, 15m)
| render areachart
```





## References
- [GitHub repo of examples](https://github.com/microsoft/AzureMonitorCommunity)
- [Log Analytics tutorial](https://docs.microsoft.com/en-us/azure/azure-monitor/logs/log-analytics-tutorial)
