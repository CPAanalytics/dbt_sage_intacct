with general_ledger_by_period as (
    select *
    from {{ ref('sage_intacct__general_ledger_by_period') }}
    where account_type = 'incomestatement'
), 

final as (
    select
        cast ({{ dbt.date_trunc("month", "period_first_day") }} as date) as period_date,
        account_no,
        account_title,
        account_type,
        book_id,
        category,
        classification,
        currency,
        entry_state,
        departmentid,
        locationid
        round(cast(period_net_amount as {{ dbt.type_numeric() }}),2) as amount
    from general_ledger_by_period
)

select *
from final
