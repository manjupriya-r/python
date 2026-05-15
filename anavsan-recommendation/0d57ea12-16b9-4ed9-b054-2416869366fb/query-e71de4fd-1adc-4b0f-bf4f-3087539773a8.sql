SELECT AI_COMPLETE(
            'mistral-large2',
            'You are a senior Snowflake SQL optimization engineer.

            I have a query flagged by Anavsan with the following diagnostic:
            Enforcement id = ANV-1

            QUERY ID: 01c4360a-0001-93bb-0010-30eb0081c00e

            DIAGNOSTIC SIGNAL:
            {
                "join_id": 1,
                "message": "A JOIN in this query has no join condition (at node [1]), which produces many more rows than the total number of rows that went in."
            }

            SUGGESTION FROM ANAVSAN:
            Adding at least one condition to define the relationship between columns in the joined data sets could speed up this query by reducing the number of rows that it produces.

            The original SQL for this query is:
            ' || (
                    SELECT QUERY_TEXT
                    FROM SNOWFLAKE.ACCOUNT_USAGE.QUERY_HISTORY
                    WHERE QUERY_ID = '01c4360a-0001-93bb-0010-30eb0081c00e'
                    LIMIT 1
            ) || '

            Return your response as a valid JSON object in this exact format, no extra text outside the JSON:

            {
                "query_id": "01c4360a-0001-93bb-0010-30eb0081c00e",
                "problem": {
                    "signal": "JOIN_NO_CONDITION",
                    "affected_node": 1,
                    "root_cause": "<one sentence explanation>"
                },
                "cost_impact": {
                    "row_explosion": "<before rows> -> <after rows>",
                    "estimated_credit_reduction_pct": "<number>%",
                    "warehouse_downsize_recommended": true or false
                },
                "optimized_sql": "<full rewritten SQL to run in Snowflake to update the fix in a single line, Eg : Select * from example table>",
                "changes": [
                    {
                        "line": "<table or clause name>",
                        "change": "<what was changed>",
                        "reason": "<why>"
                    }
                ]
            }'
            ) AS OPTIMIZED_REPORT;