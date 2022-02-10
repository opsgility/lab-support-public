# LAB - Using Power BI to Visualize

Export table results and visualize them in Power BI and Pivot on values.

## Prerequisites

Ensure the steps from Lab 05-01 is complete and review the [Lab Pre-req Day 2](./!Lab-Pre-req-Day2.md) file for details on what is needed for this labnstration.

## Labs
See the [Lab Pre-req Day 2](./!Lab-Pre-req-Day2.md) file for details on what is needed for this labnstration.

### Lab: Visualize performance via Power BI
 
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
4. Click **Run** to ensure there are results
1. Click **Export** > **Export to Power BI** and open the `PowerBIQuery.txt` and show where that query is in the text.
1. Open **Power BI** on the local system
1. Go to **Data** > **Get Data** > **Blank query**
1. In the **Advanced editor** paste the contents from the `PowerBIQuery.txt` and save the window
1. Click **Edit Credentials**, choose **Organizational account**, and click **Sign in**
1. From the Azure AD login, use your Azure AD credentials that has access to Log Analytics
1. Then **Connect** to connect to Log Analytics
1. A table of results similar to the Log Analytics results earlier should then be displayed; click **Close & Apply** to commit the data to the Power BI book
1. Go to the **Report** tab
1. Double-click **Pie chart** icon to create pie chart item
1. Drag & drop **Source** from the Fields bar to Legend and drag & drop **Metrics** to Values

### Lab: Bring in additional query and cross link visualization

<!-- TODO: Important additional query to Power BI and add visualizations -->
