WITH
  query_sql AS (
    SELECT
      QUERY_TEXT,
      EXECUTION_TIME,
      BYTES_SCANNED,
      PARTITIONS_SCANNED,
      PARTITIONS_TOTAL,
      BYTES_SPILLED_TO_LOCAL_STORAGE,
      BYTES_SPILLED_TO_REMOTE_STORAGE,
      ROWS_PRODUCED,
      CREDITS_USED_CLOUD_SERVICES,
      QUEUED_OVERLOAD_TIME,
      WAREHOUSE_SIZE
    FROM
      SNOWFLAKE.ACCOUNT_USAGE.QUERY_HISTORY
    WHERE
      QUERY_ID = '01c461a3-0005-876f-000d-b716001734e2'
    LIMIT
      1
  )
SELECT
  AI_COMPLETE (
    'mistral-large2',
    $$ENFORCEMENT_ID: 9f07a0d7-3313-4e16-93fb-bc90b01b202a QUERY_ID: 01c461a3-0005-876f-000d-b716001734e2
PATTERN: JOIN_INEFFICIENT_CONDITION
DIAGNOSTIC: A JOIN in this query (at node [2]) contained a complex join condition that was evaluated after the data sets were joined, which is less efficient than evaluating the condition before joining them.
SUGGESTION: Simplifying the JOIN condition could speed up this query by reducing the amount of data that this JOIN must process. ROOT_CAUSE: JOIN condition at node [2] wraps one or more columns in functions (CAST, DATE_TRUNC, UPPER, etc.), forcing evaluation post-join instead of pre-join, blocking partition pruning and increasing intermediate row cardinality. TELEMETRY: execution_time_ms= $$ || query_sql.EXECUTION_TIME || $$ bytes_scanned= $$ || query_sql.BYTES_SCANNED || $$ partitions_scanned= $$ || query_sql.PARTITIONS_SCANNED || $$ partitions_total= $$ || query_sql.PARTITIONS_TOTAL || $$ spill_local_bytes= $$ || query_sql.BYTES_SPILLED_TO_LOCAL_STORAGE || $$ spill_remote_bytes= $$ || query_sql.BYTES_SPILLED_TO_REMOTE_STORAGE || $$ rows_produced= $$ || query_sql.ROWS_PRODUCED || $$ queue_ms= $$ || query_sql.QUEUED_OVERLOAD_TIME || $$ warehouse_size= $$ || query_sql.WAREHOUSE_SIZE || $$ ORIGINAL_SQL: $$ || query_sql.QUERY_TEXT || $$ TASKS: 1. Analyze the JOIN condition at node [2] 2. Identify which columns are wrapped in functions 3. Extract those columns and pre-transform them in a CTE 4. Rewrite the JOIN ON clause to use direct column equality 5. Return the optimized single-line SQL 6. List each function-wrapped column as a separate change
Return valid JSON only: {"optimized_sql":"<RETURN_SINGLE_LINE_EXECUTABLE_SNOWFLAKE_SQL>","cost_impact":{"row_explosion":"data not available","estimated_credit_reduction_pct":"data not available","warehouse_downsize_recommended":false},"changes":[{"line":"<table or clause name>","change":"<what was changed>","reason":"<why>"}]} $$
  )
FROM
  query_sql;