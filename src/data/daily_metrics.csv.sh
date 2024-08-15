#!/usr/bin/env bash

duckdb :memory: << EOF
SET enable_progress_bar = false;
COPY (
  SELECT
    date,
    onboarded_data_pibs,
    -ended_data_pibs as ended_data_pibs,
    onboarded_data_pibs - ended_data_pibs as data_delta_pibs,
    deals,
    data_on_active_deals_pibs,
    active_deals,
    unique_deal_making_clients,
    unique_deal_making_providers,
    clients_with_active_deals,
    providers_with_active_deals,
    active_address_count_daily,
    total_address_count,
    raw_power_pibs,
    raw_power_pibs - lag(raw_power_pibs) over (order by date) as raw_power_delta_pibs,
    quality_adjusted_power_pibs,
    quality_adjusted_power_pibs - lag(quality_adjusted_power_pibs) over (order by date) as quality_adjusted_power_delta_pibs,
    verified_data_power_pibs,
    network_utilization_ratio * 100 as network_utilization_ratio,
    circulating_fil,
    circulating_fil - lag(circulating_fil) over (order by date) as circulating_fil_delta,
    mined_fil,
    mined_fil - lag(mined_fil) over (order by date) as mined_fil_delta,
    vested_fil,
    vested_fil - lag(vested_fil) over (order by date) as vested_fil_delta,
    locked_fil,
    locked_fil - lag(locked_fil) over (order by date) as locked_fil_delta,
    burnt_fil,
    burnt_fil - lag(burnt_fil) over (order by date) as burnt_fil_delta,
    reward_per_wincount,
    reward_per_wincount - lag(reward_per_wincount) over (order by date) as reward_per_wincount_delta,
    sector_snap_raw_power_pibs,
    sector_expire_raw_power_pibs,
    sector_recover_raw_power_pibs,
    sector_fault_raw_power_pibs,
    sector_extended_raw_power_pibs,
    sector_terminated_raw_power_pibs,
    sector_onboarding_raw_power_pibs,
  FROM read_parquet('https://data.filecoindataportal.xyz/filecoin_daily_metrics.parquet')
) TO STDOUT (FORMAT 'CSV');
EOF
