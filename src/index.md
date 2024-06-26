---
sql:
  metrics: ./data/metrics.parquet
---

# Filecoin Metrics

_A view into Filecoin Metrics. Powered by the [Filecoin Data Portal](https://github.com/davidgasquez/filecoin-data-portal/)._

```js
import {linePlot} from "./components/linePlot.js";
```

```sql id=m
select
  date,
  onboarded_data_pibs,
  avg(onboarded_data_pibs) over (order by date rows between 30 preceding and current row) as onboarded_data_pibs_30d_avg,
  data_on_active_deals_pibs,
  unique_deal_making_clients,
  avg(unique_deal_making_clients) over (order by date rows between 30 preceding and current row) as unique_deal_making_clients_30d_avg,
  unique_deal_making_providers,
  avg(unique_deal_making_providers) over (order by date rows between 30 preceding and current row) as unique_deal_making_providers_30d_avg,
  raw_power_pibs,
  quality_adjusted_power_pibs,
from metrics
```

<div class="grid grid-cols-2">

  <div class="card">
    <h2> Onboarded Data PiBs </h2>
    ${resize((width) => linePlot(width, m, "date", "onboarded_data_pibs_30d_avg"))}
  </div>

  <div class="card">
    <h2> Data on Active Deals PiBs </h2>
    ${resize((width) => linePlot(width, m, "date", "data_on_active_deals_pibs"))}
  </div>

  <div class="card">
    <h2> Unique Deal Making Clients </h2>
    ${resize((width) => linePlot(width, m, "date", "unique_deal_making_clients_30d_avg"))}
  </div>

  <div class="card">
    <h2> Unique Deal Making Providers </h2>
    ${resize((width) => linePlot(width, m, "date", "unique_deal_making_providers_30d_avg"))}
  </div>

  <div class="card">
    <h2> Raw Power PiBs </h2>
    ${resize((width) => linePlot(width, m, "date", "raw_power_pibs"))}
  </div>

  <div class="card">
    <h2> Quality Adjusted Power PiBs </h2>
    ${resize((width) => linePlot(width, m, "date", "quality_adjusted_power_pibs"))}
  </div>

</div>

<a href="/"> <img src="logo.svg" width="20px"> </a>
