# LAB - Searching for values

Find where various value find in multiple tables.

## Contents <!-- omit in toc -->

- [Prerequisites](#prerequisites)
- [Labs](#labs)

## Prerequisites

Ensure the steps from Lab 04-02 is complete and review the [Lab Pre-req Day 1](./!Lab-Pre-req-Day1.md) file for details on what is needed for this labnstration.


## Labs

### Lab: Find all instances of Web App from suspecious IP

<!-- Revamp for searching by client IP rather than SQL instances -->

1. Go to the Azure portal and **Logs** of the Log Analytics workspace.
1. If a pop up window of example queries shows up, **close** it. See [Example Repo](#references) for contents of the pop-up.
1. On the **Tables** list on the left, expand **SQL Databases**
1. Double-click **AzureActivity** to add it to query window
1. Click **Run** to display all entries values (there will be alot of unrelated entries)
1. In query window after ``AzureActivity``, create a new line and put `| where ResourceProvider == "MICROSOFT.SQL"` on it.
1. Click **Run** to display all entries values for only SQL activity
1. In query after the last line, create a new line and put `| search "<webAppIdentifier>"` on it.
1. Run the query again and see that there is now all the entries relating to the web application.  This search through all columns and returns any entries with a value of that client
1. You can then visualize the values into a time line with `| summarize count() by bin(TimeGenerated, 15m)
| render timechart`

```kusto
union AzureActivity, AzureDiagnostics, AzureMetrics
| search "SampleDB"
| summarize count() by bin(TimeGenerated, 15m)
| render timechart 
```



## References
- [GitHub repo of examples](https://github.com/microsoft/AzureMonitorCommunity)
- [Log Analytics tutorial](https://docs.microsoft.com/en-us/azure/azure-monitor/logs/log-analytics-tutorial)
