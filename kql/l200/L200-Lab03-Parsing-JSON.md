# LAB - Parsing JSON

Pivot on additional details of entries by parsing their columns based on JSON content.

## Contents <!-- omit in toc -->

- [Prerequisites](#prerequisites)
- [Labs](#labs)

## Prerequisites

Ensure the steps from Lab 04-03 is complete and review the [Lab Pre-req Day 1](./!Lab-Pre-req-Day1.md) file for details on what is needed for this labnstration.


## Labs


### Lab: Parse out request details from IIS log

1. Go to the Azure portal and **Logs** of the Log Analytics workspace.
1. If a pop up window of example queries shows up, **close** it. See [Example Repo](#references) for contents of the pop-up.
1. On the **Tables** list on the left, expand **Application**
1. Double-click **AppRequests** to add it to query window
1. Click **Run** to display all entries values
1. In query window after ``AppRequests``, create a new line and put `| where resultCode==500` on it.
1. Run the query again and see responses where there were errors
<!-- TODO: find some more details than just URL, perhaps IIS logs and query column -->
1. Further parsing of the query can then be done with `| extend parsedURL=parse_url(url)` as the last line
1. Then take the path property out to a custom column of its own with `| extend Path=tostring(parsedURL.path)`
1. This can be graphed over time using `| summarize count() by Path | render barchart` on the end, to see a summarize of requests by path **Run** button.

```kusto
AppRequests
| where resultCode == 500
| extend parsedURL=parse_url(url)
| extend Path=tostring(parsedURL.path)
| summarize count() by Path
| render barchart 
```



## References
- [GitHub repo of examples](https://github.com/microsoft/AzureMonitorCommunity)
- [Log Analytics tutorial](https://docs.microsoft.com/en-us/azure/azure-monitor/logs/log-analytics-tutorial)
