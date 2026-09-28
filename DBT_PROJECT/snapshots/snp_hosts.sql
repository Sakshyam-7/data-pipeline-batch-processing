{% snapshot snp_hosts %}

{{
    config(
      target_schema='snapshots',
      unique_key='host_id',
      strategy='check',
      check_cols=['is_superhost', 'response_rate']
    )
}}

SELECT * FROM {{ ref('stg_hosts') }}

{% endsnapshot %}