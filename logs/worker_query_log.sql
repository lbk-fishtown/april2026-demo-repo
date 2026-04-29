-- 2026-04-10T01:56:12.538Z
CREATE OR REPLACE MACRO list_item(arr, idx) AS (CASE
  WHEN idx < 0 THEN list_extract(arr, CAST(len(arr) + idx + 1 AS BIGINT))
  ELSE list_extract(arr, CAST(idx + 1 AS BIGINT))
END);

-- 2026-04-10T01:56:12.545Z
CREATE OR REPLACE MACRO _snow_round(x) AS (case when x >= 0 then floor(x + 0.5) else ceil(x - 0.5) end);

-- 2026-04-10T01:56:12.545Z
CREATE OR REPLACE MACRO timestamp_unit(x) AS (CASE 
    WHEN x::double < 31536000000 THEN 1.0
    WHEN x::double < 31536000000000 THEN 1000.0
    WHEN x::double < 31536000000000000 THEN 1000000.0
    ELSE 1000000000.0
END);

-- 2026-04-10T01:56:12.545Z
CREATE OR REPLACE MACRO snowflake_to_timestamp_ntz(val) AS (CASE WHEN val IS NULL THEN NULL ELSE CAST(val AS TIMESTAMP) END);

-- 2026-04-10T01:56:12.545Z
CREATE OR REPLACE MACRO sdf_snowflake_to_binary(val) AS (CAST(val AS BLOB));

-- 2026-04-10T01:56:12.545Z
CREATE OR REPLACE MACRO list_agg(x) AS (list(x));

-- 2026-04-10T01:56:12.546Z
CREATE OR REPLACE MACRO sdf_cast_from_variant(val) AS (val);

-- 2026-04-10T01:56:12.546Z
CREATE OR REPLACE MACRO sdf_snowflake_to_variant(val) AS (val);

-- 2026-04-10T01:56:12.546Z
CREATE OR REPLACE MACRO to_date(val) AS (CASE WHEN val IS NULL THEN NULL ELSE CAST(val AS DATE) END);

-- 2026-04-10T01:56:12.546Z
CREATE OR REPLACE MACRO to_varchar(val) AS (CASE WHEN val IS NULL THEN NULL ELSE CAST(val AS VARCHAR) END);

-- 2026-04-10T01:56:12.546Z
CREATE OR REPLACE MACRO _normalize_datetime_part(part) AS (CASE
    -- Year
    WHEN part = 'y' THEN 'year'
    WHEN part = 'yy' THEN 'year'
    WHEN part = 'yyy' THEN 'year'
    WHEN part = 'yyyy' THEN 'year'
    WHEN part = 'yr' THEN 'year'
    WHEN part = 'years' THEN 'year'
    WHEN part = 'yrs' THEN 'year'
    WHEN part = 'year' THEN 'year'
    -- Quarter
    WHEN part = 'q' THEN 'quarter'
    WHEN part = 'qtr' THEN 'quarter'
    WHEN part = 'qtrs' THEN 'quarter'
    WHEN part = 'quarter' THEN 'quarter'
    WHEN part = 'quarters' THEN 'quarter'
    -- Month
    WHEN part = 'mm' THEN 'month'
    WHEN part = 'mon' THEN 'month'
    WHEN part = 'mons' THEN 'month'
    WHEN part = 'month' THEN 'month'
    WHEN part = 'months' THEN 'month'
    -- Week
    WHEN part = 'w' THEN 'week'
    WHEN part = 'wk' THEN 'week'
    WHEN part = 'weekofyear' THEN 'week'
    WHEN part = 'woy' THEN 'week'
    WHEN part = 'wy' THEN 'week'
    WHEN part = 'week' THEN 'week'
    -- Day
    WHEN part = 'd' THEN 'day'
    WHEN part = 'dd' THEN 'day'
    WHEN part = 'day' THEN 'day'
    WHEN part = 'days' THEN 'day'
    WHEN part = 'dayofmonth' THEN 'day'
    -- Day of Week
    WHEN part = 'dw' THEN 'dayofweek'
    WHEN part = 'weekday' THEN 'dayofweek'
    WHEN part = 'dayofweek' THEN 'dayofweek'
    WHEN part = 'dow' THEN 'dayofweek'
    -- Day of Week ISO
    WHEN part = 'dw_iso' THEN 'isodow'
    WHEN part = 'weekday_iso' THEN 'isodow'
    WHEN part = 'isodow' THEN 'isodow'
    WHEN part = 'dow_iso' THEN 'isodow'
    WHEN part = 'dayofweek_iso' THEN 'isodow'
    WHEN part = 'dayofweekiso' THEN 'isodow'
    -- Day of Year
    WHEN part = 'dy' THEN 'dayofyear'
    WHEN part = 'yearday' THEN 'dayofyear'
    WHEN part = 'dayofyear' THEN 'dayofyear'
    WHEN part = 'doy' THEN 'dayofyear'
    -- Hour
    WHEN part = 'h' THEN 'hour'
    WHEN part = 'hh' THEN 'hour'
    WHEN part = 'hr' THEN 'hour'
    WHEN part = 'hour' THEN 'hour'
    WHEN part = 'hours' THEN 'hour'
    WHEN part = 'hrs' THEN 'hour'
    -- Minute
    WHEN part = 'm' THEN 'minute'
    WHEN part = 'mi' THEN 'minute'
    WHEN part = 'min' THEN 'minute'
    WHEN part = 'minute' THEN 'minute'
    WHEN part = 'minutes' THEN 'minute'
    WHEN part = 'mins' THEN 'minute'
    -- Second
    WHEN part = 's' THEN 'second'
    WHEN part = 'sec' THEN 'second'
    WHEN part = 'second' THEN 'second'
    WHEN part = 'seconds' THEN 'second'
    WHEN part = 'secs' THEN 'second'
    -- Millisecond
    WHEN part = 'ms' THEN 'millisecond'
    WHEN part = 'msec' THEN 'millisecond'
    WHEN part = 'millisecond' THEN 'millisecond'
    WHEN part = 'milliseconds' THEN 'millisecond'
    -- Microsecond
    WHEN part = 'us' THEN 'microsecond'
    WHEN part = 'usec' THEN 'microsecond'
    WHEN part = 'microsecond' THEN 'microsecond'
    WHEN part = 'microseconds' THEN 'microsecond'
    -- Nanosecond
    WHEN part = 'ns' THEN 'microsecond'
    WHEN part = 'nsec' THEN 'microsecond'
    WHEN part = 'nanosec' THEN 'microsecond'
    WHEN part = 'nsecond' THEN 'microsecond'
    WHEN part = 'nanosecond' THEN 'microsecond'
    WHEN part = 'nanoseconds' THEN 'microsecond'
    WHEN part = 'nanosecs' THEN 'microsecond'
    WHEN part = 'nseconds' THEN 'microsecond'
    -- Epoch
    WHEN part = 'epoch_second' THEN 'epoch_second'
    WHEN part = 'epoch' THEN 'epoch_second'
    WHEN part = 'epoch_seconds' THEN 'epoch_second'
    WHEN part = 'epoch_millisecond' THEN 'epoch_millisecond'
    WHEN part = 'epoch_milliseconds' THEN 'epoch_millisecond'
    WHEN part = 'epoch_microsecond' THEN 'epoch_microsecond'
    WHEN part = 'epoch_microseconds' THEN 'epoch_microsecond'
    WHEN part = 'epoch_nanosecond' THEN 'epoch_nanosecond'
    WHEN part = 'epoch_nanoseconds' THEN 'epoch_nanosecond'
    -- Timezone
    WHEN part = 'timezone_hour' THEN 'timezone_hour'
    WHEN part = 'tzh' THEN 'timezone_hour'
    WHEN part = 'timezone_minute' THEN 'timezone_minute'
    WHEN part = 'tzm' THEN 'timezone_minute'
    ELSE part
END);

-- 2026-04-10T01:56:12.547Z
CREATE OR REPLACE MACRO _sdf_internal_ilike_any(val, escape, patterns) AS (EXISTS (
    SELECT 1
    FROM UNNEST(patterns) p(pattern)
    WHERE val ILIKE p.pattern ESCAPE escape
));

-- 2026-04-10T01:56:12.549Z
CREATE OR REPLACE MACRO _null_to_timestamp_tz() AS (struct_pack(ts := NULL::timestamp, tz := NULL::interval));

-- 2026-04-10T01:56:12.549Z
CREATE OR REPLACE MACRO _to_timestamp(v, p, safe) AS (CASE
WHEN v IS NULL THEN NULL
ELSE (
    WITH 
    dedup_spaces AS (
        SELECT regexp_replace(trim(CAST(v AS VARCHAR)), '\s+', ' ', 'g' ) AS val
    ),
    parts_processed AS (
        -- split the string into date, time and timezone
        SELECT
        -- Replace T separator with space for ISO 8601 format
        substring(val, 11, 1) = 'T' as has_t,
        CASE WHEN has_t THEN substring(val, 1, 10) || ' ' || substring(val, 12) ELSE val END as without_t,
        regexp_replace(without_t, ' ([+-])', '\1') as x,
        split_part(x, ' ', 1) as date_part_str,
        substring(x, length(date_part_str) + 2) as rest_part_str,
        regexp_extract(rest_part_str, '^\s*\d{1,2}\s*(:\s*\d{1,2}\s*(:\s*\d{1,2}(\.\d*)?)?)?', 0) as time_part_str_with_space,
        trim(substring(rest_part_str, length(time_part_str_with_space) + 1)) as timezone_part_str,
        rtrim(left(time_part_str_with_space, 1) || replace(substring(time_part_str_with_space, 2), ' ', ''), '.') as time_part_str,
        CASE 
            -- MM/DD/YYYY or M/D/YYYY formats (with optional time), time_part only HH:MM:SS is valid, timezone_part must be empty
            WHEN date_part_str ~ '\d{1,2}/\d{1,2}/\d{4}' AND ((NOT has_t AND time_part_str ~ '\d{1,2}:\d{1,2}:\d{1,2}') OR time_part_str = '') AND timezone_part_str = '' THEN strptime(date_part_str, '%-m/%-d/%Y')
            -- YYYY-M-D format (flexible month/day digits)
            WHEN date_part_str ~ '\d{4}-\d{1,2}-\d{1,2}' THEN strptime(date_part_str, '%Y-%-m-%-d')
            -- timestamp
            WHEN date_part_str ~ '\s*\d+\s*' THEN to_timestamp(CAST(date_part_str AS DOUBLE) / timestamp_unit(date_part_str))
            -- Fallback
            ELSE NULL
        END AS date_part,
        CASE 
            -- in case of MM/DD/YYYY or M/D/YYYY, only HH:MM:SS is valid 
            WHEN date_part_str ~ '\d{1,2}/\d{1,2}/\d{4}' AND time_part_str ~ '\d{1,2}:\d{1,2}:\d{1,2}' THEN
                strptime(time_part_str, '%H:%M:%S')
            -- HH:MM, HH:MM:SS, HH:MM:SS.fractional seconds
            WHEN time_part_str ~ '\d{1,2}:\d{1,2}(:\d{1,2}(\.\d+)?)?' THEN 
                'epoch'::timestamp + time_part_str::interval    
            -- HH
            WHEN time_part_str ~ '\d{1,2}' THEN strptime(time_part_str, '%H')
            -- timestamp
            WHEN date_part_str ~ '\s*\d+\s*' THEN to_timestamp(CAST(date_part_str AS DOUBLE) / timestamp_unit(date_part_str))
            -- fallback
            ELSE 'epoch'::timestamp
        END AS time_part
        FROM dedup_spaces
    ),
    pre_processed AS (
        SELECT 
        has_t,
        CASE 
            WHEN date_part IS NULL THEN (
                IF(safe, NULL, error('Invalid timestamp: ' || v)) 
            )
            ELSE 
            make_timestamp(
                year(date_part),
                month(date_part),
                day(date_part),
                hour(time_part),
                minute(time_part),
                floor(microsecond(time_part) / pow(10, 6 - p)) * pow(10, -p)
            ) 
        END as date_time_without_timezone,
        CASE
            -- timestamp
            WHEN date_part_str ~ '\s*\d+\s*' THEN '+00:00'
            -- fallback
            ELSE timezone_part_str
        END AS timezone_part_str2,
        CASE 
            WHEN timezone_part_str2 ~ '[+-]\d{2}(:?\d{2})?' THEN 
                strptime('+00:00', '%z') - strptime(timezone_part_str2, '%z')
            WHEN timezone_part_str2 = 'Z' THEN
                interval '0 seconds'
            WHEN timezone_part_str2 ~ '\d{1,2}' THEN
                interval (timezone_part_str2 || ' hour')                                    
            ELSE 
                NULL
        END AS tz
        FROM parts_processed
    ),
    processed AS (
        SELECT
        has_t,
        timezone_part_str2,
        struct_pack(
            ts := date_time_without_timezone,
            tz := -tz
        ) as result
        FROM pre_processed
    )
    SELECT 
      CASE 
        WHEN has_t AND timezone_part_str2 != '' AND timezone_part_str2 !~ '([+-]\d{2}:\d{2}|Z)' THEN
            IF(safe, NULL, error('Invalid timestamp: ' || v))
        WHEN timezone_part_str2 != '' AND timezone_part_str2 !~ '([+-]\d{2}(:?\d{2})?|Z|\d+)' THEN
            IF(safe, NULL, error('Invalid timestamp: ' || v))
        ELSE
            result
        END
      FROM processed
)
END);

-- 2026-04-10T01:56:12.549Z
CREATE OR REPLACE MACRO _to_time_with_precision(v, p, safe) AS (CASE WHEN v IS NULL THEN NULL 
ELSE (
WITH pre_processed1 AS (
SELECT 
    trim(regexp_replace(v, ':\s+', ':', 'g')) AS time_part_str
),
pre_processed2 AS (
SELECT
    CASE
    -- with fractional seconds
    WHEN time_part_str ~ '\d{1,2}:\d{1,2}:\d{1,2}\.\d+.*' THEN 
        TRY(CASE  
            WHEN p = 0 THEN strptime(regexp_replace(time_part_str, '(\.\d+)', '', 'g'), '%H:%M:%S')
            WHEN p = 3 THEN strptime(regexp_replace(time_part_str, '(\.\d{3})\d+', '\1', 'g'), '%H:%M:%S.%f')
            ELSE strptime(regexp_replace(time_part_str, '(\.\d{6})\d+', '\1', 'g'), '%H:%M:%S.%f')
        END)
    -- without fractional seconds
    WHEN time_part_str ~ '\d{1,2}:\d{1,2}:\d{1,2}' THEN TRY(strptime(time_part_str, '%H:%M:%S'))
    -- without fractional seconds and no seconds
    WHEN time_part_str ~ '\d{1,2}:\d{1,2}' THEN TRY(strptime(time_part_str, '%H:%M'))
    -- timestamp
    WHEN time_part_str ~ '\d+' THEN to_timestamp(CAST(time_part_str AS DOUBLE) / timestamp_unit(time_part_str))
    -- fallback
    ELSE NULL
    END AS time_part
    FROM pre_processed1
),
processed AS (
SELECT
    CASE WHEN time_part IS NULL THEN (
        IF(safe, NULL, error('Invalid time: ' || v))
    )
    ELSE
    make_time(
    hour(time_part),
    minute(time_part),
    microsecond(time_part) / 1000000.0
    ) 
    END AS result
    FROM pre_processed2
)
SELECT result FROM processed
)
END);

-- 2026-04-10T01:56:12.549Z
CREATE OR REPLACE MACRO _to_date(v, safe) AS (WITH pre_processed AS (
    SELECT trim(v) as val
)
SELECT 
    CASE 
        WHEN val ~ '\d{1,2}/\d{1,2}/\d{4}( \d{1,2}:\d{1,2}:\d{1,2})?' THEN strptime(regexp_replace(val, '(\d{1,2}/\d{1,2}/\d{4}).*', '\1', 'g'), '%-m/%-d/%Y')::date
        WHEN val ~ '\d{4}-\d{1,2}-\d{1,2}(T\d{1,2}:\d{1,2}:\d{1,2}(\.\d+)?(\s*[+-]\d{2}:\d{2})?)?' THEN strptime(regexp_replace(val, '(\d{4}-\d{1,2}-\d{1,2}).*', '\1', 'g'), '%Y-%-m-%-d')::date
        WHEN val ~ '\d{4}-\d{1,2}-\d{1,2}(\s+\d{1,2}(:\s*\d{1,2}(:\s*\d{1,2}(\.\s*\d+)?)?)?(\s*[+-]\d{2}(:?\d{2})?)?)?' THEN strptime(regexp_replace(val, '(\d{4}-\d{1,2}-\d{1,2}).*', '\1', 'g'), '%Y-%-m-%-d')::date
        WHEN val ~ '\d+' THEN to_timestamp(CAST(val AS DOUBLE) / timestamp_unit(val))::date
    ELSE
        IF(safe, NULL, error('Invalid date: ' || v))
    END AS result
    FROM pre_processed);

-- 2026-04-10T01:56:12.552Z
CREATE OR REPLACE MACRO _parse_url_json(u, permissive) AS (WITH processed AS (
    SELECT
    CASE 
        WHEN permissive IS NULL OR u IS NULL THEN NULL 
        ELSE (
            WITH raw AS (
                SELECT
                    -- Extract URI components using a single regex
                    -- 1 scheme  2 username  3 password  4 host(no userinfo)  5 port  6 path  7 query  8 fragment
                    regexp_extract(u, '^(?:([^:/?#]+):)?(?://(?:(?:([^:@/?#]*)(?::([^@/?#]*))?)@)?([^:/?#]*)(?::([0-9]+))?)?([^?#]*)(?:\?([^#]*))?(?:#(.*))?$', 1) AS scheme,
                    regexp_extract(u, '^(?:([^:/?#]+):)?(?://(?:(?:([^:@/?#]*)(?::([^@/?#]*))?)@)?([^:/?#]*)(?::([0-9]+))?)?([^?#]*)(?:\?([^#]*))?(?:#(.*))?$', 2) AS username,
                    regexp_extract(u, '^(?:([^:/?#]+):)?(?://(?:(?:([^:@/?#]*)(?::([^@/?#]*))?)@)?([^:/?#]*)(?::([0-9]+))?)?([^?#]*)(?:\?([^#]*))?(?:#(.*))?$', 3) AS password,
                    regexp_extract(u, '^(?:([^:/?#]+):)?(?://(?:(?:([^:@/?#]*)(?::([^@/?#]*))?)@)?([^:/?#]*)(?::([0-9]+))?)?([^?#]*)(?:\?([^#]*))?(?:#(.*))?$', 4) AS host_core,
                    regexp_extract(u, '^(?:([^:/?#]+):)?(?://(?:(?:([^:@/?#]*)(?::([^@/?#]*))?)@)?([^:/?#]*)(?::([0-9]+))?)?([^?#]*)(?:\?([^#]*))?(?:#(.*))?$', 5) AS port,
                    regexp_extract(u, '^(?:([^:/?#]+):)?(?://(?:(?:([^:@/?#]*)(?::([^@/?#]*))?)@)?([^:/?#]*)(?::([0-9]+))?)?([^?#]*)(?:\?([^#]*))?(?:#(.*))?$', 6) AS path_raw,
                    regexp_extract(u, '^(?:([^:/?#]+):)?(?://(?:(?:([^:@/?#]*)(?::([^@/?#]*))?)@)?([^:/?#]*)(?::([0-9]+))?)?([^?#]*)(?:\?([^#]*))?(?:#(.*))?$', 7) AS query,
                    regexp_extract(u, '^(?:([^:/?#]+):)?(?://(?:(?:([^:@/?#]*)(?::([^@/?#]*))?)@)?([^:/?#]*)(?::([0-9]+))?)?([^?#]*)(?:\?([^#]*))?(?:#(.*))?$', 8) AS fragment
                )
            , norm AS (
            SELECT
                NULLIF(scheme, '') AS scheme,
                -- Rebuild the Snowflake-style host (including userinfo)
                CASE
                WHEN (coalesce(username,'') <> '' OR coalesce(password,'') <> '')
                    THEN concat_ws('', username, CASE WHEN coalesce(password,'')<>'' THEN ':'||password ELSE '' END, '@', host_core)
                ELSE NULLIF(host_core,'')
                END AS host,
                NULLIF(port,'') AS port,
                -- Remove leading "/" from path (Snowflake behavior)
                CASE
                WHEN path_raw IS NULL OR path_raw='' THEN NULL
                ELSE regexp_replace(path_raw, '^/+', '')
                END AS path,
                NULLIF(query,'') AS query,
                NULLIF(fragment,'') AS fragment
            FROM raw
            )
            , params AS (
            -- Convert query string into JSON object: {"k":"v", ...}
            -- If duplicate keys appear, keep the last one (consistent with Snowflake-like overwrite semantics)
            SELECT
                CASE
                WHEN query IS NULL OR query='' THEN NULL
                ELSE (
                    to_json(
                    map_from_entries(
                        list_transform(
                        str_split(query, '&'),
                        x -> struct_pack(
                                key := regexp_extract(x, '^([^=]+)=?.*$', 1),
                                value := regexp_extract(x, '^[^=]+=(.*)$', 1)
                            )
                        )
                    )
                    )::JSON
                )
                END AS parameters
            FROM norm
            )
            SELECT
            CASE
                -- "Strict" mode: missing scheme → return NULL (Snowflake throws an error)
                WHEN scheme IS NULL OR scheme='' THEN 
                    struct_pack(error := 'scheme not specified')::JSON
                ELSE 
                struct_pack(
                    fragment := fragment,
                    host := host,
                    parameters := parameters,
                    path := path,
                    port := port,
                    query := query,
                    scheme := scheme
                )::JSON
            END
            FROM norm, params
        ) 
    END AS result)
    SELECT CASE WHEN permissive = 0 AND TRY(result->>'error') IS NOT NULL THEN error('Error parsing URL: scheme not specified') ELSE result END
    FROM processed);

-- 2026-04-10T01:56:12.553Z
CREATE OR REPLACE MACRO regexp_instr_core(subject, pattern, pos, occurrence, opt, regexp_parameters, group_num) AS (SELECT
    CASE
        WHEN opt IS NOT NULL AND opt NOT IN (0, 1) THEN error('Return option must be 0, 1, or NULL: ' || opt)
        WHEN subject IS NULL OR pattern IS NULL THEN NULL
        WHEN mt = '' THEN 0
        ELSE pos - 1
            + strpos(bstr, mt)
            + opt * length(mt)
    END
FROM (
    SELECT
        -- Search starting from specified position (Snowflake's pos)
        substring(subject, pos) AS bstr,
        CASE
            -- Calculate the actual group to use:
            -- If group_num is explicitly provided, use it
            -- Otherwise if contains 'e', default to 1
            -- Otherwise use 0 (entire match)
            WHEN regexp_parameters IS NULL THEN
                regexp_extract(
                    substring(subject, pos),
                    pattern,
                    COALESCE(
                        group_num,
                        CASE
                            WHEN strpos(regexp_parameters, 'e') > 0 THEN 1
                            ELSE 0
                        END
                    )::integer
                )
            ELSE
                regexp_extract(
                    substring(subject, pos),
                    pattern,
                    COALESCE(
                        group_num,
                        CASE
                            WHEN strpos(regexp_parameters, 'e') > 0 THEN 1
                            ELSE 0
                        END
                    )::integer,
                    replace(regexp_parameters, 'e', '')
                )
        END AS mt
) s);

-- 2026-04-10T01:56:12.553Z
CREATE OR REPLACE MACRO _sdf_internal_like_all(val, escape, patterns) AS (NOT EXISTS (
    SELECT 1
    FROM UNNEST(patterns) p(pattern)
    WHERE NOT (val LIKE p.pattern ESCAPE escape)
));

-- 2026-04-10T01:56:12.553Z
CREATE OR REPLACE MACRO _sdf_internal_like_any(val, escape, patterns) AS (EXISTS (
    SELECT 1
    FROM UNNEST(patterns) p(pattern)
    WHERE val LIKE p.pattern ESCAPE escape
));

-- 2026-04-10T01:56:12.553Z
CREATE OR REPLACE MACRO _dateaddinterval(arg0, arg1) AS ((arg0 + arg1)::date);

-- 2026-04-10T01:56:12.553Z
CREATE OR REPLACE MACRO _timestamp_ntz_to_varchar(arg0, arg1) AS (WITH 
pre_processed AS (
    SELECT 
        CASE 
            WHEN arg1 = 0 THEN arg0::timestamp_s
            ELSE arg0
        END as t
),
processed AS (
    SELECT 
        strftime('%Y-%m-%d %H:%M:%S.%g', t) as t_without_padding,
        length(t_without_padding) as length,
        CASE 
            WHEN length = 19 THEN t || '.000'
            ELSE rpad(t_without_padding, 23, '0')
        END as result
        FROM pre_processed
)
SELECT 
    result
FROM processed);

-- 2026-04-10T01:56:12.554Z
CREATE OR REPLACE MACRO _int_to_timestamp_ltz(arg0) AS ((TIMESTAMP '1970-01-01' + arg0 * INTERVAL 1 SECOND) AT TIME ZONE 'UTC');

-- 2026-04-10T01:56:12.554Z
CREATE OR REPLACE MACRO _int_to_timestamp_ntz(arg0) AS (TIMESTAMP '1970-01-01' + arg0 * INTERVAL 1 SECOND);

-- 2026-04-10T01:56:12.554Z
CREATE OR REPLACE MACRO _varchar_to_timestamp_ltz_with_precision(arg0, arg1, arg2) AS (WITH x AS (SELECT _to_timestamp(arg0, arg1, arg2) AS t)
SELECT 
    CASE 
        WHEN t IS NULL THEN NULL
        WHEN t.tz IS NULL THEN t.ts AT TIME ZONE 'UTC' 
        ELSE t.ts + t.tz 
    END result 
FROM x);

-- 2026-04-10T01:56:12.554Z
CREATE OR REPLACE MACRO _varchar_to_timestamp_tz_with_precision(arg0, arg1, arg2) AS (WITH x AS (SELECT _to_timestamp(arg0, arg1, arg2) AS t)
SELECT 
    CASE 
        WHEN t IS NULL THEN NULL
        WHEN t.tz IS NULL THEN struct_pack(ts := t.ts, tz := (t.ts AT TIME ZONE 'UTC')::timestamp - t.ts)
        ELSE t
    END result 
FROM x);

-- 2026-04-10T01:56:12.555Z
CREATE OR REPLACE MACRO _timestamp_ltz_to_timestamp_tz(arg0, arg1) AS (struct_pack(ts := arg0 AT TIME ZONE 'UTC', tz := arg0 - (arg0 AT TIME ZONE 'UTC')::timestamp));

-- 2026-04-10T01:56:12.555Z
CREATE OR REPLACE MACRO _timestamp_tz_to_timestamp_ltz(arg0) AS (CASE
    WHEN arg0 IS NULL THEN NULL
    WHEN arg0.tz IS NULL THEN arg0.ts AT TIME ZONE 'UTC'
    ELSE arg0.ts + arg0.tz
END);

-- 2026-04-10T01:56:12.555Z
CREATE OR REPLACE MACRO get_field(json_col, field_name) AS (json_col->>field_name);

-- 2026-04-10T01:56:12.555Z
CREATE OR REPLACE MACRO flatten(input) AS (CASE
  WHEN json_type(input::JSON) = 'ARRAY' THEN
    list_transform(
      range(json_array_length(input::JSON)::BIGINT),
      i -> struct_pack(
        SEQ := 1::BIGINT,
        KEY := NULL::VARCHAR,
        PATH := '[' || i || ']',
        INDEX := i,
        VALUE := json_extract(input::JSON, '$[' || i || ']'),
        THIS := input::JSON
      )
    )
  ELSE
    list_transform(
      json_keys(input::JSON),
      k -> struct_pack(
        SEQ := 1::BIGINT,
        KEY := k,
        PATH := k,
        INDEX := NULL::BIGINT,
        VALUE := json_extract(input::JSON, '$.' || k),
        THIS := input::JSON
      )
    )
END);

-- 2026-04-10T01:56:12.556Z
CREATE OR REPLACE MACRO __get_26(arg0, arg1) AS (arg0->>arg1);

-- 2026-04-10T01:56:12.556Z
CREATE OR REPLACE MACRO __get_40(arg0, arg1) AS (arg0->>CASE WHEN arg1 < 0 THEN length(arg0) + arg1::bigint ELSE arg1::bigint END);

-- 2026-04-10T01:56:12.556Z
CREATE OR REPLACE MACRO __get_50(arg0, arg1) AS (arg0->>CASE WHEN arg1 < 0 THEN length(arg0) + arg1::bigint ELSE arg1::bigint END);

-- 2026-04-10T01:56:12.556Z
CREATE OR REPLACE MACRO __get_63(arg0, arg1) AS (arg0->>CASE WHEN arg1 < 0 THEN length(arg0) + arg1::bigint ELSE arg1::bigint END);

-- 2026-04-10T01:56:12.556Z
CREATE OR REPLACE MACRO add_months_172(arg0, arg1) AS (CASE 
    WHEN arg0 IS NULL OR arg1 IS NULL THEN NULL
    ELSE (
        WITH t AS (
            SELECT
                arg0,
                arg1,
                date_trunc('month', arg0) AS first_of_month,
                EXTRACT(day FROM arg0)    AS day_of_month
        ),
        t2 AS (
            SELECT
                -- The first day of the target month: the first day of the current month + arg1 months
                first_of_month + arg1 * INTERVAL 1 MONTH AS target_first,
                day_of_month
            FROM t
        ),
        t3 AS (
            SELECT
                target_first,
                day_of_month,
                -- The last day of the target month: the first day of the next month - 1 day
                (target_first + INTERVAL 1 MONTH - INTERVAL 1 DAY) AS target_last
            FROM t2
        )
        SELECT
            -- If the day of the original date is greater than the number of days in the target month, use the last day of the target month
            (target_first
            + (LEAST(day_of_month, EXTRACT(day FROM target_last)) - 1)
              * INTERVAL 1 DAY)::date
        FROM t3
    )
END);

-- 2026-04-10T01:56:12.556Z
CREATE OR REPLACE MACRO add_months_222(arg0, arg1) AS (CASE
    WHEN arg0 IS NULL OR arg1 IS NULL THEN NULL
    ELSE (
        WITH t0 AS (
            SELECT
                -- The original timestamp
                _to_timestamp(arg0, 6, false).ts                    AS ts_val
        ), 
        t1 AS (
            SELECT
                ts_val,
                -- The date part
                CAST(ts_val AS DATE)      AS d,
                -- The day of the original date
                EXTRACT(day FROM d) AS day_of_month
            FROM t0
        ),
        t2 AS (
            SELECT
                ts_val,
                day_of_month,
                -- The first day of the target month: the first day of the current month + arg1 months
                date_trunc('month', d) + arg1 * INTERVAL 1 MONTH AS target_first
            FROM t1
        ),
        t3 AS (
            SELECT
                ts_val,
                day_of_month,
                target_first,
                -- The last day of the target month: the first day of the next month - 1 day
                target_first + INTERVAL 1 MONTH - INTERVAL 1 DAY AS target_last,
                -- Calculate the "aligned date" (end-of-month alignment logic)
                (
                    target_first
                    + (LEAST(day_of_month, EXTRACT(day FROM target_last)) - 1)
                      * INTERVAL 1 DAY
                )::DATE AS new_date
            FROM t2
        )
        SELECT
            -- Use the year, month, and day of new_date + the hour, minute, and second of the original timestamp to re-assemble the TIMESTAMP
            make_timestamp(
                EXTRACT(year  FROM new_date),
                EXTRACT(month FROM new_date),
                EXTRACT(day   FROM new_date),
                EXTRACT(hour  FROM ts_val),
                EXTRACT(minute FROM ts_val),
                EXTRACT(microsecond FROM ts_val)/1000000.0
            )
        FROM t3
    )
END);

-- 2026-04-10T01:56:12.556Z
CREATE OR REPLACE MACRO array_size_1183(arg0) AS (length(arg0));

-- 2026-04-10T01:56:12.556Z
CREATE OR REPLACE MACRO array_size_1195(arg0) AS (length(arg0));

-- 2026-04-10T01:56:12.556Z
CREATE OR REPLACE MACRO concat_2653(arg0) AS (list_reduce(arg0, (x, y) -> x || y));

-- 2026-04-10T01:56:12.556Z
CREATE OR REPLACE MACRO concat_ws_2683(arg0) AS ((
  WITH t AS (
    SELECT arg0[1] AS separator, arg0[2:] as arr
  )
  SELECT list_reduce(arr, (x, y) -> x || separator || y) AS result
  FROM t
));

-- 2026-04-10T01:56:12.557Z
CREATE OR REPLACE MACRO convert_timezone_2768(arg0, arg1, arg2) AS (arg2 at time zone arg0 at time zone arg1);

-- 2026-04-10T01:56:12.557Z
CREATE OR REPLACE MACRO convert_timezone_2785(arg0, arg1, arg2) AS (error('Invalid argument types for function'));

-- 2026-04-10T01:56:12.557Z
CREATE OR REPLACE MACRO convert_timezone_2806(arg0, arg1) AS (struct_pack(ts := (arg1 at time zone 'UTC')::timestamp, tz := (arg1::timestamp at time zone arg0)::timestamp - arg1::timestamp));

-- 2026-04-10T01:56:12.557Z
CREATE OR REPLACE MACRO convert_timezone_2827(arg0, arg1) AS (struct_pack(ts := arg1::timestamp, tz := (arg1::timestamp at time zone arg0)::timestamp - arg1::timestamp));

-- 2026-04-10T01:56:12.557Z
CREATE OR REPLACE MACRO convert_timezone_2848(arg0, arg1) AS ((WITH x AS (SELECT _to_timestamp(arg1, 6, false) AS t) 
SELECT struct_pack(
  ts := ((t.ts + t.tz) at time zone 'UTC' at time zone arg0)::timestamp, 
  tz := ((t.ts + t.tz) at time zone arg0) - (t.ts + t.tz))
AS result FROM x));

-- 2026-04-10T01:56:12.557Z
CREATE OR REPLACE MACRO convert_timezone_2868(arg0, arg1) AS (struct_pack(
  ts := ((arg1.ts + arg1.tz) at time zone 'UTC' at time zone arg0)::timestamp, 
  tz := ((arg1.ts + arg1.tz) at time zone arg0 - (arg1.ts + arg1.tz))
));

-- 2026-04-10T01:56:12.557Z
CREATE OR REPLACE MACRO date_3439(arg0) AS ((
  WITH x AS (SELECT _to_timestamp(arg0, 0, true) AS t)
  SELECT t.ts::date FROM x
));

-- 2026-04-10T01:56:12.558Z
CREATE OR REPLACE MACRO date_3455(arg0, arg1) AS (CASE
    WHEN arg1 = 'MM/DD/YYYY' THEN STRPTIME(arg0, '%m/%d/%Y')
    WHEN arg1 = 'YYYY-MM-DD' THEN STRPTIME(arg0, '%Y-%m-%d')
    WHEN arg1 = 'DD/MM/YYYY' THEN STRPTIME(arg0, '%d/%m/%Y')
    WHEN arg1 = 'DD-MON-YYYY' THEN STRPTIME(arg0, '%d-%b-%Y')
    WHEN arg1 = 'MON DD, YYYY' THEN STRPTIME(arg0, '%b %d, %Y')
    WHEN arg1 = 'YYYY.MM.DD' THEN STRPTIME(arg0, '%Y.%m.%d')
    ELSE STRPTIME(arg0, '%Y-%m-%d')  -- fallback
END::DATE);

-- 2026-04-10T01:56:12.558Z
CREATE OR REPLACE MACRO date_part_3529(arg0, arg1) AS (date_part(_normalize_datetime_part(arg0), arg1));

-- 2026-04-10T01:56:12.559Z
CREATE OR REPLACE MACRO extract_3529(arg0, arg1) AS (date_part(_normalize_datetime_part(arg0), arg1));

-- 2026-04-10T01:56:12.560Z
CREATE OR REPLACE MACRO date_part_3598(arg0, arg1) AS (date_part(_normalize_datetime_part(arg0), arg1));

-- 2026-04-10T01:56:12.561Z
CREATE OR REPLACE MACRO extract_3598(arg0, arg1) AS (date_part(_normalize_datetime_part(arg0), arg1));

-- 2026-04-10T01:56:12.561Z
CREATE OR REPLACE MACRO date_part_3673(arg0, arg1) AS (date_part(_normalize_datetime_part(arg0), arg1));

-- 2026-04-10T01:56:12.562Z
CREATE OR REPLACE MACRO extract_3673(arg0, arg1) AS (date_part(_normalize_datetime_part(arg0), arg1));

-- 2026-04-10T01:56:12.562Z
CREATE OR REPLACE MACRO date_part_3703(arg0, arg1) AS (date_part(_normalize_datetime_part(arg0), arg1));

-- 2026-04-10T01:56:12.563Z
CREATE OR REPLACE MACRO extract_3703(arg0, arg1) AS (date_part(_normalize_datetime_part(arg0), arg1));

-- 2026-04-10T01:56:12.563Z
CREATE OR REPLACE MACRO date_part_3736(arg0, arg1) AS (date_part(_normalize_datetime_part(arg0), arg1));

-- 2026-04-10T01:56:12.564Z
CREATE OR REPLACE MACRO extract_3736(arg0, arg1) AS (date_part(_normalize_datetime_part(arg0), arg1));

-- 2026-04-10T01:56:12.564Z
CREATE OR REPLACE MACRO date_part_3767(arg0, arg1) AS (date_part(_normalize_datetime_part(arg0), arg1));

-- 2026-04-10T01:56:12.565Z
CREATE OR REPLACE MACRO extract_3767(arg0, arg1) AS (date_part(_normalize_datetime_part(arg0), arg1));

-- 2026-04-10T01:56:12.565Z
CREATE OR REPLACE MACRO date_trunc_3789(arg0, arg1) AS (null::varchar);

-- 2026-04-10T01:56:12.565Z
CREATE OR REPLACE MACRO date_trunc_3865(arg0, arg1) AS (date_trunc(
  _normalize_datetime_part(arg0),
  arg1
)::date);

-- 2026-04-10T01:56:12.566Z
CREATE OR REPLACE MACRO date_trunc_3910(arg0, arg1) AS (date_trunc(
  _normalize_datetime_part(arg0),
  make_timestamp(
    1970, 1, 1, hour(arg1), minute(arg1), microsecond(arg1) / 1000000.0
  )
)::time);

-- 2026-04-10T01:56:12.567Z
CREATE OR REPLACE MACRO date_trunc_3940(arg0, arg1) AS (date_trunc(
  _normalize_datetime_part(arg0),
  make_timestamp(
    1970, 1, 1, hour(arg1), minute(arg1), microsecond(arg1) / 1000000.0
  )
)::time);

-- 2026-04-10T01:56:12.567Z
CREATE OR REPLACE MACRO date_trunc_4013(arg0, arg1) AS (date_trunc(
  _normalize_datetime_part(arg0),
  arg1
)::timestamp);

-- 2026-04-10T01:56:12.568Z
CREATE OR REPLACE MACRO date_trunc_4041(arg0, arg1) AS (date_trunc(
  _normalize_datetime_part(arg0),
  arg1
));

-- 2026-04-10T01:56:12.568Z
CREATE OR REPLACE MACRO date_trunc_4111(arg0, arg1) AS (date_trunc(
  _normalize_datetime_part(arg0),
  arg1
));

-- 2026-04-10T01:56:12.569Z
CREATE OR REPLACE MACRO date_trunc_4138(arg0, arg1) AS (date_trunc(
  _normalize_datetime_part(arg0),
  arg1
));

-- 2026-04-10T01:56:12.569Z
CREATE OR REPLACE MACRO date_trunc_4208(arg0, arg1) AS (date_trunc(
  _normalize_datetime_part(arg0),
  arg1
));

-- 2026-04-10T01:56:12.570Z
CREATE OR REPLACE MACRO date_trunc_4235(arg0, arg1) AS (date_trunc(
  _normalize_datetime_part(arg0),
  arg1
));

-- 2026-04-10T01:56:12.570Z
CREATE OR REPLACE MACRO date_trunc_4262(arg0, arg1) AS (error('Unsupported argument type for DATE_TRUNC'));

-- 2026-04-10T01:56:12.570Z
CREATE OR REPLACE MACRO dateadd_4316(arg0, arg1, arg2) AS (CASE
    WHEN lower(arg0) = 'year' THEN CAST(arg2 AS TIMESTAMP) + _snow_round(arg1) * (INTERVAL 1 YEAR)
    WHEN lower(arg0) = 'month' THEN CAST(arg2 AS TIMESTAMP) + _snow_round(arg1) * (INTERVAL 1 MONTH)
    WHEN lower(arg0) = 'day' THEN CAST(arg2 AS TIMESTAMP) + _snow_round(arg1) * (INTERVAL 1 DAY)
    WHEN lower(arg0) = 'hour' THEN CAST(arg2 AS TIMESTAMP) + _snow_round(arg1) * (INTERVAL 1 HOUR)
    WHEN lower(arg0) = 'minute' THEN CAST(arg2 AS TIMESTAMP) + _snow_round(arg1) * (INTERVAL 1 MINUTE)
    WHEN lower(arg0) = 'second' THEN CAST(arg2 AS TIMESTAMP) + _snow_round(arg1) * (INTERVAL 1 SECOND)
    WHEN lower(arg0) = 'millisecond' THEN CAST(arg2 AS TIMESTAMP) + _snow_round(arg1) * (INTERVAL 1 MILLISECOND)
    WHEN lower(arg0) = 'microsecond' THEN CAST(arg2 AS TIMESTAMP) + _snow_round(arg1) * (INTERVAL 1 MICROSECOND)
    WHEN lower(arg0) = 'nanosecond' THEN CAST(arg2 AS TIMESTAMP) + floor(arg1 / 1000) * (INTERVAL 1 MICROSECOND)
    ELSE NULL
END::date);

-- 2026-04-10T01:56:12.570Z
CREATE OR REPLACE MACRO timestampadd_4316(arg0, arg1, arg2) AS (CASE
    WHEN lower(arg0) = 'year' THEN CAST(arg2 AS TIMESTAMP) + _snow_round(arg1) * (INTERVAL 1 YEAR)
    WHEN lower(arg0) = 'month' THEN CAST(arg2 AS TIMESTAMP) + _snow_round(arg1) * (INTERVAL 1 MONTH)
    WHEN lower(arg0) = 'day' THEN CAST(arg2 AS TIMESTAMP) + _snow_round(arg1) * (INTERVAL 1 DAY)
    WHEN lower(arg0) = 'hour' THEN CAST(arg2 AS TIMESTAMP) + _snow_round(arg1) * (INTERVAL 1 HOUR)
    WHEN lower(arg0) = 'minute' THEN CAST(arg2 AS TIMESTAMP) + _snow_round(arg1) * (INTERVAL 1 MINUTE)
    WHEN lower(arg0) = 'second' THEN CAST(arg2 AS TIMESTAMP) + _snow_round(arg1) * (INTERVAL 1 SECOND)
    WHEN lower(arg0) = 'millisecond' THEN CAST(arg2 AS TIMESTAMP) + _snow_round(arg1) * (INTERVAL 1 MILLISECOND)
    WHEN lower(arg0) = 'microsecond' THEN CAST(arg2 AS TIMESTAMP) + _snow_round(arg1) * (INTERVAL 1 MICROSECOND)
    WHEN lower(arg0) = 'nanosecond' THEN CAST(arg2 AS TIMESTAMP) + floor(arg1 / 1000) * (INTERVAL 1 MICROSECOND)
    ELSE NULL
END::date);

-- 2026-04-10T01:56:12.571Z
CREATE OR REPLACE MACRO timeadd_4316(arg0, arg1, arg2) AS (CASE
    WHEN lower(arg0) = 'year' THEN CAST(arg2 AS TIMESTAMP) + _snow_round(arg1) * (INTERVAL 1 YEAR)
    WHEN lower(arg0) = 'month' THEN CAST(arg2 AS TIMESTAMP) + _snow_round(arg1) * (INTERVAL 1 MONTH)
    WHEN lower(arg0) = 'day' THEN CAST(arg2 AS TIMESTAMP) + _snow_round(arg1) * (INTERVAL 1 DAY)
    WHEN lower(arg0) = 'hour' THEN CAST(arg2 AS TIMESTAMP) + _snow_round(arg1) * (INTERVAL 1 HOUR)
    WHEN lower(arg0) = 'minute' THEN CAST(arg2 AS TIMESTAMP) + _snow_round(arg1) * (INTERVAL 1 MINUTE)
    WHEN lower(arg0) = 'second' THEN CAST(arg2 AS TIMESTAMP) + _snow_round(arg1) * (INTERVAL 1 SECOND)
    WHEN lower(arg0) = 'millisecond' THEN CAST(arg2 AS TIMESTAMP) + _snow_round(arg1) * (INTERVAL 1 MILLISECOND)
    WHEN lower(arg0) = 'microsecond' THEN CAST(arg2 AS TIMESTAMP) + _snow_round(arg1) * (INTERVAL 1 MICROSECOND)
    WHEN lower(arg0) = 'nanosecond' THEN CAST(arg2 AS TIMESTAMP) + floor(arg1 / 1000) * (INTERVAL 1 MICROSECOND)
    ELSE NULL
END::date);

-- 2026-04-10T01:56:12.571Z
CREATE OR REPLACE MACRO dateadd_4381(arg0, arg1, arg2) AS (CASE
    WHEN lower(arg0) = 'year' THEN CAST(arg2 AS DATE) + _snow_round(arg1) * (INTERVAL 1 YEAR)
    WHEN lower(arg0) = 'month' THEN CAST(arg2 AS DATE) + _snow_round(arg1) * (INTERVAL 1 MONTH)
    WHEN lower(arg0) = 'day' THEN CAST(arg2 AS DATE) + _snow_round(arg1) * (INTERVAL 1 DAY)
    WHEN lower(arg0) = 'hour' THEN CAST(arg2 AS TIMESTAMP) + _snow_round(arg1) * (INTERVAL 1 HOUR)
    WHEN lower(arg0) = 'minute' THEN CAST(arg2 AS TIMESTAMP) + _snow_round(arg1) * (INTERVAL 1 MINUTE)
    WHEN lower(arg0) = 'second' THEN CAST(arg2 AS TIMESTAMP) + _snow_round(arg1) * (INTERVAL 1 SECOND)
    WHEN lower(arg0) = 'millisecond' THEN CAST(arg2 AS TIMESTAMP) + _snow_round(arg1) * (INTERVAL 1 MILLISECOND)
    WHEN lower(arg0) = 'microsecond' THEN CAST(arg2 AS TIMESTAMP) + _snow_round(arg1) * (INTERVAL 1 MICROSECOND)
    WHEN lower(arg0) = 'nanosecond' THEN CAST(arg2 AS TIMESTAMP) + floor(arg1 / 1000) * (INTERVAL 1 MICROSECOND)
    ELSE NULL
END::date);

-- 2026-04-10T01:56:12.571Z
CREATE OR REPLACE MACRO timestampadd_4381(arg0, arg1, arg2) AS (CASE
    WHEN lower(arg0) = 'year' THEN CAST(arg2 AS DATE) + _snow_round(arg1) * (INTERVAL 1 YEAR)
    WHEN lower(arg0) = 'month' THEN CAST(arg2 AS DATE) + _snow_round(arg1) * (INTERVAL 1 MONTH)
    WHEN lower(arg0) = 'day' THEN CAST(arg2 AS DATE) + _snow_round(arg1) * (INTERVAL 1 DAY)
    WHEN lower(arg0) = 'hour' THEN CAST(arg2 AS TIMESTAMP) + _snow_round(arg1) * (INTERVAL 1 HOUR)
    WHEN lower(arg0) = 'minute' THEN CAST(arg2 AS TIMESTAMP) + _snow_round(arg1) * (INTERVAL 1 MINUTE)
    WHEN lower(arg0) = 'second' THEN CAST(arg2 AS TIMESTAMP) + _snow_round(arg1) * (INTERVAL 1 SECOND)
    WHEN lower(arg0) = 'millisecond' THEN CAST(arg2 AS TIMESTAMP) + _snow_round(arg1) * (INTERVAL 1 MILLISECOND)
    WHEN lower(arg0) = 'microsecond' THEN CAST(arg2 AS TIMESTAMP) + _snow_round(arg1) * (INTERVAL 1 MICROSECOND)
    WHEN lower(arg0) = 'nanosecond' THEN CAST(arg2 AS TIMESTAMP) + floor(arg1 / 1000) * (INTERVAL 1 MICROSECOND)
    ELSE NULL
END::date);

-- 2026-04-10T01:56:12.571Z
CREATE OR REPLACE MACRO timeadd_4381(arg0, arg1, arg2) AS (CASE
    WHEN lower(arg0) = 'year' THEN CAST(arg2 AS DATE) + _snow_round(arg1) * (INTERVAL 1 YEAR)
    WHEN lower(arg0) = 'month' THEN CAST(arg2 AS DATE) + _snow_round(arg1) * (INTERVAL 1 MONTH)
    WHEN lower(arg0) = 'day' THEN CAST(arg2 AS DATE) + _snow_round(arg1) * (INTERVAL 1 DAY)
    WHEN lower(arg0) = 'hour' THEN CAST(arg2 AS TIMESTAMP) + _snow_round(arg1) * (INTERVAL 1 HOUR)
    WHEN lower(arg0) = 'minute' THEN CAST(arg2 AS TIMESTAMP) + _snow_round(arg1) * (INTERVAL 1 MINUTE)
    WHEN lower(arg0) = 'second' THEN CAST(arg2 AS TIMESTAMP) + _snow_round(arg1) * (INTERVAL 1 SECOND)
    WHEN lower(arg0) = 'millisecond' THEN CAST(arg2 AS TIMESTAMP) + _snow_round(arg1) * (INTERVAL 1 MILLISECOND)
    WHEN lower(arg0) = 'microsecond' THEN CAST(arg2 AS TIMESTAMP) + _snow_round(arg1) * (INTERVAL 1 MICROSECOND)
    WHEN lower(arg0) = 'nanosecond' THEN CAST(arg2 AS TIMESTAMP) + floor(arg1 / 1000) * (INTERVAL 1 MICROSECOND)
    ELSE NULL
END::date);

-- 2026-04-10T01:56:12.571Z
CREATE OR REPLACE MACRO dateadd_4450(arg0, arg1, arg2) AS (CASE
    WHEN lower(arg0) = 'year' THEN CAST(arg2 AS DATE) + _snow_round(arg1) * (INTERVAL 1 YEAR)
    WHEN lower(arg0) = 'month' THEN CAST(arg2 AS DATE) + _snow_round(arg1) * (INTERVAL 1 MONTH)
    WHEN lower(arg0) = 'day' THEN CAST(arg2 AS DATE) + _snow_round(arg1) * (INTERVAL 1 DAY)
    WHEN lower(arg0) = 'hour' THEN CAST(arg2 AS TIMESTAMP) + _snow_round(arg1) * (INTERVAL 1 HOUR)
    WHEN lower(arg0) = 'minute' THEN CAST(arg2 AS TIMESTAMP) + _snow_round(arg1) * (INTERVAL 1 MINUTE)
    WHEN lower(arg0) = 'second' THEN CAST(arg2 AS TIMESTAMP) + _snow_round(arg1) * (INTERVAL 1 SECOND)
    WHEN lower(arg0) = 'millisecond' THEN CAST(arg2 AS TIMESTAMP) + _snow_round(arg1) * (INTERVAL 1 MILLISECOND)
    WHEN lower(arg0) = 'microsecond' THEN CAST(arg2 AS TIMESTAMP) + _snow_round(arg1) * (INTERVAL 1 MICROSECOND)
    WHEN lower(arg0) = 'nanosecond' THEN CAST(arg2 AS TIMESTAMP) + floor(arg1 / 1000) * (INTERVAL 1 MICROSECOND)
    ELSE NULL
END::TIMESTAMP);

-- 2026-04-10T01:56:12.572Z
CREATE OR REPLACE MACRO timestampadd_4450(arg0, arg1, arg2) AS (CASE
    WHEN lower(arg0) = 'year' THEN CAST(arg2 AS DATE) + _snow_round(arg1) * (INTERVAL 1 YEAR)
    WHEN lower(arg0) = 'month' THEN CAST(arg2 AS DATE) + _snow_round(arg1) * (INTERVAL 1 MONTH)
    WHEN lower(arg0) = 'day' THEN CAST(arg2 AS DATE) + _snow_round(arg1) * (INTERVAL 1 DAY)
    WHEN lower(arg0) = 'hour' THEN CAST(arg2 AS TIMESTAMP) + _snow_round(arg1) * (INTERVAL 1 HOUR)
    WHEN lower(arg0) = 'minute' THEN CAST(arg2 AS TIMESTAMP) + _snow_round(arg1) * (INTERVAL 1 MINUTE)
    WHEN lower(arg0) = 'second' THEN CAST(arg2 AS TIMESTAMP) + _snow_round(arg1) * (INTERVAL 1 SECOND)
    WHEN lower(arg0) = 'millisecond' THEN CAST(arg2 AS TIMESTAMP) + _snow_round(arg1) * (INTERVAL 1 MILLISECOND)
    WHEN lower(arg0) = 'microsecond' THEN CAST(arg2 AS TIMESTAMP) + _snow_round(arg1) * (INTERVAL 1 MICROSECOND)
    WHEN lower(arg0) = 'nanosecond' THEN CAST(arg2 AS TIMESTAMP) + floor(arg1 / 1000) * (INTERVAL 1 MICROSECOND)
    ELSE NULL
END::TIMESTAMP);

-- 2026-04-10T01:56:12.572Z
CREATE OR REPLACE MACRO timeadd_4450(arg0, arg1, arg2) AS (CASE
    WHEN lower(arg0) = 'year' THEN CAST(arg2 AS DATE) + _snow_round(arg1) * (INTERVAL 1 YEAR)
    WHEN lower(arg0) = 'month' THEN CAST(arg2 AS DATE) + _snow_round(arg1) * (INTERVAL 1 MONTH)
    WHEN lower(arg0) = 'day' THEN CAST(arg2 AS DATE) + _snow_round(arg1) * (INTERVAL 1 DAY)
    WHEN lower(arg0) = 'hour' THEN CAST(arg2 AS TIMESTAMP) + _snow_round(arg1) * (INTERVAL 1 HOUR)
    WHEN lower(arg0) = 'minute' THEN CAST(arg2 AS TIMESTAMP) + _snow_round(arg1) * (INTERVAL 1 MINUTE)
    WHEN lower(arg0) = 'second' THEN CAST(arg2 AS TIMESTAMP) + _snow_round(arg1) * (INTERVAL 1 SECOND)
    WHEN lower(arg0) = 'millisecond' THEN CAST(arg2 AS TIMESTAMP) + _snow_round(arg1) * (INTERVAL 1 MILLISECOND)
    WHEN lower(arg0) = 'microsecond' THEN CAST(arg2 AS TIMESTAMP) + _snow_round(arg1) * (INTERVAL 1 MICROSECOND)
    WHEN lower(arg0) = 'nanosecond' THEN CAST(arg2 AS TIMESTAMP) + floor(arg1 / 1000) * (INTERVAL 1 MICROSECOND)
    ELSE NULL
END::TIMESTAMP);

-- 2026-04-10T01:56:12.572Z
CREATE OR REPLACE MACRO dateadd_4548(arg0, arg1, arg2) AS (CASE
    WHEN lower(arg0) = 'year' THEN CAST(arg2 AS TIMESTAMP) + _snow_round(arg1) * (INTERVAL 1 YEAR)
    WHEN lower(arg0) = 'month' THEN CAST(arg2 AS TIMESTAMP) + _snow_round(arg1) * (INTERVAL 1 MONTH)
    WHEN lower(arg0) = 'day' THEN CAST(arg2 AS TIMESTAMP) + _snow_round(arg1) * (INTERVAL 1 DAY)
    WHEN lower(arg0) = 'hour' THEN CAST(arg2 AS TIMESTAMP) + _snow_round(arg1) * (INTERVAL 1 HOUR)
    WHEN lower(arg0) = 'minute' THEN CAST(arg2 AS TIMESTAMP) + _snow_round(arg1) * (INTERVAL 1 MINUTE)
    WHEN lower(arg0) = 'second' THEN CAST(arg2 AS TIMESTAMP) + _snow_round(arg1) * (INTERVAL 1 SECOND)
    WHEN lower(arg0) = 'millisecond' THEN CAST(arg2 AS TIMESTAMP) + _snow_round(arg1) * (INTERVAL 1 MILLISECOND)
    WHEN lower(arg0) = 'microsecond' THEN CAST(arg2 AS TIMESTAMP) + _snow_round(arg1) * (INTERVAL 1 MICROSECOND)
    WHEN lower(arg0) = 'nanosecond' THEN CAST(arg2 AS TIMESTAMP) + floor(arg1 / 1000) * (INTERVAL 1 MICROSECOND)
    ELSE NULL
END);

-- 2026-04-10T01:56:12.572Z
CREATE OR REPLACE MACRO timestampadd_4548(arg0, arg1, arg2) AS (CASE
    WHEN lower(arg0) = 'year' THEN CAST(arg2 AS TIMESTAMP) + _snow_round(arg1) * (INTERVAL 1 YEAR)
    WHEN lower(arg0) = 'month' THEN CAST(arg2 AS TIMESTAMP) + _snow_round(arg1) * (INTERVAL 1 MONTH)
    WHEN lower(arg0) = 'day' THEN CAST(arg2 AS TIMESTAMP) + _snow_round(arg1) * (INTERVAL 1 DAY)
    WHEN lower(arg0) = 'hour' THEN CAST(arg2 AS TIMESTAMP) + _snow_round(arg1) * (INTERVAL 1 HOUR)
    WHEN lower(arg0) = 'minute' THEN CAST(arg2 AS TIMESTAMP) + _snow_round(arg1) * (INTERVAL 1 MINUTE)
    WHEN lower(arg0) = 'second' THEN CAST(arg2 AS TIMESTAMP) + _snow_round(arg1) * (INTERVAL 1 SECOND)
    WHEN lower(arg0) = 'millisecond' THEN CAST(arg2 AS TIMESTAMP) + _snow_round(arg1) * (INTERVAL 1 MILLISECOND)
    WHEN lower(arg0) = 'microsecond' THEN CAST(arg2 AS TIMESTAMP) + _snow_round(arg1) * (INTERVAL 1 MICROSECOND)
    WHEN lower(arg0) = 'nanosecond' THEN CAST(arg2 AS TIMESTAMP) + floor(arg1 / 1000) * (INTERVAL 1 MICROSECOND)
    ELSE NULL
END);

-- 2026-04-10T01:56:12.572Z
CREATE OR REPLACE MACRO timeadd_4548(arg0, arg1, arg2) AS (CASE
    WHEN lower(arg0) = 'year' THEN CAST(arg2 AS TIMESTAMP) + _snow_round(arg1) * (INTERVAL 1 YEAR)
    WHEN lower(arg0) = 'month' THEN CAST(arg2 AS TIMESTAMP) + _snow_round(arg1) * (INTERVAL 1 MONTH)
    WHEN lower(arg0) = 'day' THEN CAST(arg2 AS TIMESTAMP) + _snow_round(arg1) * (INTERVAL 1 DAY)
    WHEN lower(arg0) = 'hour' THEN CAST(arg2 AS TIMESTAMP) + _snow_round(arg1) * (INTERVAL 1 HOUR)
    WHEN lower(arg0) = 'minute' THEN CAST(arg2 AS TIMESTAMP) + _snow_round(arg1) * (INTERVAL 1 MINUTE)
    WHEN lower(arg0) = 'second' THEN CAST(arg2 AS TIMESTAMP) + _snow_round(arg1) * (INTERVAL 1 SECOND)
    WHEN lower(arg0) = 'millisecond' THEN CAST(arg2 AS TIMESTAMP) + _snow_round(arg1) * (INTERVAL 1 MILLISECOND)
    WHEN lower(arg0) = 'microsecond' THEN CAST(arg2 AS TIMESTAMP) + _snow_round(arg1) * (INTERVAL 1 MICROSECOND)
    WHEN lower(arg0) = 'nanosecond' THEN CAST(arg2 AS TIMESTAMP) + floor(arg1 / 1000) * (INTERVAL 1 MICROSECOND)
    ELSE NULL
END);

-- 2026-04-10T01:56:12.573Z
CREATE OR REPLACE MACRO dateadd_4644(arg0, arg1, arg2) AS (CASE
    WHEN lower(arg0) = 'year' THEN CAST(arg2 AS TIMESTAMP) + _snow_round(arg1) * (INTERVAL 1 YEAR)
    WHEN lower(arg0) = 'month' THEN CAST(arg2 AS TIMESTAMP) + _snow_round(arg1) * (INTERVAL 1 MONTH)
    WHEN lower(arg0) = 'day' THEN CAST(arg2 AS TIMESTAMP) + _snow_round(arg1) * (INTERVAL 1 DAY)
    WHEN lower(arg0) = 'hour' THEN CAST(arg2 AS TIMESTAMP) + _snow_round(arg1) * (INTERVAL 1 HOUR)
    WHEN lower(arg0) = 'minute' THEN CAST(arg2 AS TIMESTAMP) + _snow_round(arg1) * (INTERVAL 1 MINUTE)
    WHEN lower(arg0) = 'second' THEN CAST(arg2 AS TIMESTAMP) + _snow_round(arg1) * (INTERVAL 1 SECOND)
    WHEN lower(arg0) = 'millisecond' THEN CAST(arg2 AS TIMESTAMP) + _snow_round(arg1) * (INTERVAL 1 MILLISECOND)
    WHEN lower(arg0) = 'microsecond' THEN CAST(arg2 AS TIMESTAMP) + _snow_round(arg1) * (INTERVAL 1 MICROSECOND)
    WHEN lower(arg0) = 'nanosecond' THEN CAST(arg2 AS TIMESTAMP) + floor(arg1 / 1000) * (INTERVAL 1 MICROSECOND)
    ELSE NULL
END);

-- 2026-04-10T01:56:12.573Z
CREATE OR REPLACE MACRO timestampadd_4644(arg0, arg1, arg2) AS (CASE
    WHEN lower(arg0) = 'year' THEN CAST(arg2 AS TIMESTAMP) + _snow_round(arg1) * (INTERVAL 1 YEAR)
    WHEN lower(arg0) = 'month' THEN CAST(arg2 AS TIMESTAMP) + _snow_round(arg1) * (INTERVAL 1 MONTH)
    WHEN lower(arg0) = 'day' THEN CAST(arg2 AS TIMESTAMP) + _snow_round(arg1) * (INTERVAL 1 DAY)
    WHEN lower(arg0) = 'hour' THEN CAST(arg2 AS TIMESTAMP) + _snow_round(arg1) * (INTERVAL 1 HOUR)
    WHEN lower(arg0) = 'minute' THEN CAST(arg2 AS TIMESTAMP) + _snow_round(arg1) * (INTERVAL 1 MINUTE)
    WHEN lower(arg0) = 'second' THEN CAST(arg2 AS TIMESTAMP) + _snow_round(arg1) * (INTERVAL 1 SECOND)
    WHEN lower(arg0) = 'millisecond' THEN CAST(arg2 AS TIMESTAMP) + _snow_round(arg1) * (INTERVAL 1 MILLISECOND)
    WHEN lower(arg0) = 'microsecond' THEN CAST(arg2 AS TIMESTAMP) + _snow_round(arg1) * (INTERVAL 1 MICROSECOND)
    WHEN lower(arg0) = 'nanosecond' THEN CAST(arg2 AS TIMESTAMP) + floor(arg1 / 1000) * (INTERVAL 1 MICROSECOND)
    ELSE NULL
END);

-- 2026-04-10T01:56:12.573Z
CREATE OR REPLACE MACRO timeadd_4644(arg0, arg1, arg2) AS (CASE
    WHEN lower(arg0) = 'year' THEN CAST(arg2 AS TIMESTAMP) + _snow_round(arg1) * (INTERVAL 1 YEAR)
    WHEN lower(arg0) = 'month' THEN CAST(arg2 AS TIMESTAMP) + _snow_round(arg1) * (INTERVAL 1 MONTH)
    WHEN lower(arg0) = 'day' THEN CAST(arg2 AS TIMESTAMP) + _snow_round(arg1) * (INTERVAL 1 DAY)
    WHEN lower(arg0) = 'hour' THEN CAST(arg2 AS TIMESTAMP) + _snow_round(arg1) * (INTERVAL 1 HOUR)
    WHEN lower(arg0) = 'minute' THEN CAST(arg2 AS TIMESTAMP) + _snow_round(arg1) * (INTERVAL 1 MINUTE)
    WHEN lower(arg0) = 'second' THEN CAST(arg2 AS TIMESTAMP) + _snow_round(arg1) * (INTERVAL 1 SECOND)
    WHEN lower(arg0) = 'millisecond' THEN CAST(arg2 AS TIMESTAMP) + _snow_round(arg1) * (INTERVAL 1 MILLISECOND)
    WHEN lower(arg0) = 'microsecond' THEN CAST(arg2 AS TIMESTAMP) + _snow_round(arg1) * (INTERVAL 1 MICROSECOND)
    WHEN lower(arg0) = 'nanosecond' THEN CAST(arg2 AS TIMESTAMP) + floor(arg1 / 1000) * (INTERVAL 1 MICROSECOND)
    ELSE NULL
END);

-- 2026-04-10T01:56:12.573Z
CREATE OR REPLACE MACRO dateadd_4741(arg0, arg1, arg2) AS (struct_pack(
  ts:= CASE
        WHEN lower(arg0) = 'year' THEN arg2.ts + _snow_round(arg1) * (INTERVAL 1 YEAR)
        WHEN lower(arg0) = 'month' THEN arg2.ts + _snow_round(arg1) * (INTERVAL 1 MONTH)
        WHEN lower(arg0) = 'day' THEN arg2.ts + _snow_round(arg1) * (INTERVAL 1 DAY)
        WHEN lower(arg0) = 'hour' THEN arg2.ts + _snow_round(arg1) * (INTERVAL 1 HOUR)
        WHEN lower(arg0) = 'minute' THEN arg2.ts + _snow_round(arg1) * (INTERVAL 1 MINUTE)
        WHEN lower(arg0) = 'second' THEN arg2.ts + _snow_round(arg1) * (INTERVAL 1 SECOND)
        WHEN lower(arg0) = 'millisecond' THEN arg2.ts + _snow_round(arg1) * (INTERVAL 1 MILLISECOND)
        WHEN lower(arg0) = 'microsecond' THEN arg2.ts + _snow_round(arg1) * (INTERVAL 1 MICROSECOND)
        WHEN lower(arg0) = 'nanosecond' THEN arg2.ts + floor(arg1 / 1000) * (INTERVAL 1 MICROSECOND)
        ELSE NULL
    END,
  tz:= arg2.tz
));

-- 2026-04-10T01:56:12.573Z
CREATE OR REPLACE MACRO timestampadd_4741(arg0, arg1, arg2) AS (struct_pack(
  ts:= CASE
        WHEN lower(arg0) = 'year' THEN arg2.ts + _snow_round(arg1) * (INTERVAL 1 YEAR)
        WHEN lower(arg0) = 'month' THEN arg2.ts + _snow_round(arg1) * (INTERVAL 1 MONTH)
        WHEN lower(arg0) = 'day' THEN arg2.ts + _snow_round(arg1) * (INTERVAL 1 DAY)
        WHEN lower(arg0) = 'hour' THEN arg2.ts + _snow_round(arg1) * (INTERVAL 1 HOUR)
        WHEN lower(arg0) = 'minute' THEN arg2.ts + _snow_round(arg1) * (INTERVAL 1 MINUTE)
        WHEN lower(arg0) = 'second' THEN arg2.ts + _snow_round(arg1) * (INTERVAL 1 SECOND)
        WHEN lower(arg0) = 'millisecond' THEN arg2.ts + _snow_round(arg1) * (INTERVAL 1 MILLISECOND)
        WHEN lower(arg0) = 'microsecond' THEN arg2.ts + _snow_round(arg1) * (INTERVAL 1 MICROSECOND)
        WHEN lower(arg0) = 'nanosecond' THEN arg2.ts + floor(arg1 / 1000) * (INTERVAL 1 MICROSECOND)
        ELSE NULL
    END,
  tz:= arg2.tz
));

-- 2026-04-10T01:56:12.573Z
CREATE OR REPLACE MACRO timeadd_4741(arg0, arg1, arg2) AS (struct_pack(
  ts:= CASE
        WHEN lower(arg0) = 'year' THEN arg2.ts + _snow_round(arg1) * (INTERVAL 1 YEAR)
        WHEN lower(arg0) = 'month' THEN arg2.ts + _snow_round(arg1) * (INTERVAL 1 MONTH)
        WHEN lower(arg0) = 'day' THEN arg2.ts + _snow_round(arg1) * (INTERVAL 1 DAY)
        WHEN lower(arg0) = 'hour' THEN arg2.ts + _snow_round(arg1) * (INTERVAL 1 HOUR)
        WHEN lower(arg0) = 'minute' THEN arg2.ts + _snow_round(arg1) * (INTERVAL 1 MINUTE)
        WHEN lower(arg0) = 'second' THEN arg2.ts + _snow_round(arg1) * (INTERVAL 1 SECOND)
        WHEN lower(arg0) = 'millisecond' THEN arg2.ts + _snow_round(arg1) * (INTERVAL 1 MILLISECOND)
        WHEN lower(arg0) = 'microsecond' THEN arg2.ts + _snow_round(arg1) * (INTERVAL 1 MICROSECOND)
        WHEN lower(arg0) = 'nanosecond' THEN arg2.ts + floor(arg1 / 1000) * (INTERVAL 1 MICROSECOND)
        ELSE NULL
    END,
  tz:= arg2.tz
));

-- 2026-04-10T01:56:12.574Z
CREATE OR REPLACE MACRO dateadd_4842(arg0, arg1, arg2) AS (CASE
    WHEN lower(arg0) = 'year' THEN CAST(arg2 AS TIMESTAMP) + _snow_round(arg1) * (INTERVAL 1 YEAR)
    WHEN lower(arg0) = 'month' THEN CAST(arg2 AS TIMESTAMP) + _snow_round(arg1) * (INTERVAL 1 MONTH)
    WHEN lower(arg0) = 'day' THEN CAST(arg2 AS TIMESTAMP) + _snow_round(arg1) * (INTERVAL 1 DAY)
    WHEN lower(arg0) = 'hour' THEN CAST(arg2 AS TIMESTAMP) + _snow_round(arg1) * (INTERVAL 1 HOUR)
    WHEN lower(arg0) = 'minute' THEN CAST(arg2 AS TIMESTAMP) + _snow_round(arg1) * (INTERVAL 1 MINUTE)
    WHEN lower(arg0) = 'second' THEN CAST(arg2 AS TIMESTAMP) + _snow_round(arg1) * (INTERVAL 1 SECOND)
    WHEN lower(arg0) = 'millisecond' THEN CAST(arg2 AS TIMESTAMP) + _snow_round(arg1) * (INTERVAL 1 MILLISECOND)
    WHEN lower(arg0) = 'microsecond' THEN CAST(arg2 AS TIMESTAMP) + _snow_round(arg1) * (INTERVAL 1 MICROSECOND)
    WHEN lower(arg0) = 'nanosecond' THEN CAST(arg2 AS TIMESTAMP) + floor(arg1 / 1000) * (INTERVAL 1 MICROSECOND)
    ELSE NULL
END);

-- 2026-04-10T01:56:12.574Z
CREATE OR REPLACE MACRO timestampadd_4842(arg0, arg1, arg2) AS (CASE
    WHEN lower(arg0) = 'year' THEN CAST(arg2 AS TIMESTAMP) + _snow_round(arg1) * (INTERVAL 1 YEAR)
    WHEN lower(arg0) = 'month' THEN CAST(arg2 AS TIMESTAMP) + _snow_round(arg1) * (INTERVAL 1 MONTH)
    WHEN lower(arg0) = 'day' THEN CAST(arg2 AS TIMESTAMP) + _snow_round(arg1) * (INTERVAL 1 DAY)
    WHEN lower(arg0) = 'hour' THEN CAST(arg2 AS TIMESTAMP) + _snow_round(arg1) * (INTERVAL 1 HOUR)
    WHEN lower(arg0) = 'minute' THEN CAST(arg2 AS TIMESTAMP) + _snow_round(arg1) * (INTERVAL 1 MINUTE)
    WHEN lower(arg0) = 'second' THEN CAST(arg2 AS TIMESTAMP) + _snow_round(arg1) * (INTERVAL 1 SECOND)
    WHEN lower(arg0) = 'millisecond' THEN CAST(arg2 AS TIMESTAMP) + _snow_round(arg1) * (INTERVAL 1 MILLISECOND)
    WHEN lower(arg0) = 'microsecond' THEN CAST(arg2 AS TIMESTAMP) + _snow_round(arg1) * (INTERVAL 1 MICROSECOND)
    WHEN lower(arg0) = 'nanosecond' THEN CAST(arg2 AS TIMESTAMP) + floor(arg1 / 1000) * (INTERVAL 1 MICROSECOND)
    ELSE NULL
END);

-- 2026-04-10T01:56:12.574Z
CREATE OR REPLACE MACRO timeadd_4842(arg0, arg1, arg2) AS (CASE
    WHEN lower(arg0) = 'year' THEN CAST(arg2 AS TIMESTAMP) + _snow_round(arg1) * (INTERVAL 1 YEAR)
    WHEN lower(arg0) = 'month' THEN CAST(arg2 AS TIMESTAMP) + _snow_round(arg1) * (INTERVAL 1 MONTH)
    WHEN lower(arg0) = 'day' THEN CAST(arg2 AS TIMESTAMP) + _snow_round(arg1) * (INTERVAL 1 DAY)
    WHEN lower(arg0) = 'hour' THEN CAST(arg2 AS TIMESTAMP) + _snow_round(arg1) * (INTERVAL 1 HOUR)
    WHEN lower(arg0) = 'minute' THEN CAST(arg2 AS TIMESTAMP) + _snow_round(arg1) * (INTERVAL 1 MINUTE)
    WHEN lower(arg0) = 'second' THEN CAST(arg2 AS TIMESTAMP) + _snow_round(arg1) * (INTERVAL 1 SECOND)
    WHEN lower(arg0) = 'millisecond' THEN CAST(arg2 AS TIMESTAMP) + _snow_round(arg1) * (INTERVAL 1 MILLISECOND)
    WHEN lower(arg0) = 'microsecond' THEN CAST(arg2 AS TIMESTAMP) + _snow_round(arg1) * (INTERVAL 1 MICROSECOND)
    WHEN lower(arg0) = 'nanosecond' THEN CAST(arg2 AS TIMESTAMP) + floor(arg1 / 1000) * (INTERVAL 1 MICROSECOND)
    ELSE NULL
END);

-- 2026-04-10T01:56:12.574Z
CREATE OR REPLACE MACRO dateadd_4940(arg0, arg1, arg2) AS (CASE
    WHEN lower(arg0) = 'year' THEN CAST(arg2 AS TIMESTAMP) + _snow_round(arg1) * (INTERVAL 1 YEAR)
    WHEN lower(arg0) = 'month' THEN CAST(arg2 AS TIMESTAMP) + _snow_round(arg1) * (INTERVAL 1 MONTH)
    WHEN lower(arg0) = 'day' THEN CAST(arg2 AS TIMESTAMP) + _snow_round(arg1) * (INTERVAL 1 DAY)
    WHEN lower(arg0) = 'hour' THEN CAST(arg2 AS TIMESTAMP) + _snow_round(arg1) * (INTERVAL 1 HOUR)
    WHEN lower(arg0) = 'minute' THEN CAST(arg2 AS TIMESTAMP) + _snow_round(arg1) * (INTERVAL 1 MINUTE)
    WHEN lower(arg0) = 'second' THEN CAST(arg2 AS TIMESTAMP) + _snow_round(arg1) * (INTERVAL 1 SECOND)
    WHEN lower(arg0) = 'millisecond' THEN CAST(arg2 AS TIMESTAMP) + _snow_round(arg1) * (INTERVAL 1 MILLISECOND)
    WHEN lower(arg0) = 'microsecond' THEN CAST(arg2 AS TIMESTAMP) + _snow_round(arg1) * (INTERVAL 1 MICROSECOND)
    WHEN lower(arg0) = 'nanosecond' THEN CAST(arg2 AS TIMESTAMP) + floor(arg1 / 1000) * (INTERVAL 1 MICROSECOND)
    ELSE NULL
END);

-- 2026-04-10T01:56:12.574Z
CREATE OR REPLACE MACRO timestampadd_4940(arg0, arg1, arg2) AS (CASE
    WHEN lower(arg0) = 'year' THEN CAST(arg2 AS TIMESTAMP) + _snow_round(arg1) * (INTERVAL 1 YEAR)
    WHEN lower(arg0) = 'month' THEN CAST(arg2 AS TIMESTAMP) + _snow_round(arg1) * (INTERVAL 1 MONTH)
    WHEN lower(arg0) = 'day' THEN CAST(arg2 AS TIMESTAMP) + _snow_round(arg1) * (INTERVAL 1 DAY)
    WHEN lower(arg0) = 'hour' THEN CAST(arg2 AS TIMESTAMP) + _snow_round(arg1) * (INTERVAL 1 HOUR)
    WHEN lower(arg0) = 'minute' THEN CAST(arg2 AS TIMESTAMP) + _snow_round(arg1) * (INTERVAL 1 MINUTE)
    WHEN lower(arg0) = 'second' THEN CAST(arg2 AS TIMESTAMP) + _snow_round(arg1) * (INTERVAL 1 SECOND)
    WHEN lower(arg0) = 'millisecond' THEN CAST(arg2 AS TIMESTAMP) + _snow_round(arg1) * (INTERVAL 1 MILLISECOND)
    WHEN lower(arg0) = 'microsecond' THEN CAST(arg2 AS TIMESTAMP) + _snow_round(arg1) * (INTERVAL 1 MICROSECOND)
    WHEN lower(arg0) = 'nanosecond' THEN CAST(arg2 AS TIMESTAMP) + floor(arg1 / 1000) * (INTERVAL 1 MICROSECOND)
    ELSE NULL
END);

-- 2026-04-10T01:56:12.575Z
CREATE OR REPLACE MACRO timeadd_4940(arg0, arg1, arg2) AS (CASE
    WHEN lower(arg0) = 'year' THEN CAST(arg2 AS TIMESTAMP) + _snow_round(arg1) * (INTERVAL 1 YEAR)
    WHEN lower(arg0) = 'month' THEN CAST(arg2 AS TIMESTAMP) + _snow_round(arg1) * (INTERVAL 1 MONTH)
    WHEN lower(arg0) = 'day' THEN CAST(arg2 AS TIMESTAMP) + _snow_round(arg1) * (INTERVAL 1 DAY)
    WHEN lower(arg0) = 'hour' THEN CAST(arg2 AS TIMESTAMP) + _snow_round(arg1) * (INTERVAL 1 HOUR)
    WHEN lower(arg0) = 'minute' THEN CAST(arg2 AS TIMESTAMP) + _snow_round(arg1) * (INTERVAL 1 MINUTE)
    WHEN lower(arg0) = 'second' THEN CAST(arg2 AS TIMESTAMP) + _snow_round(arg1) * (INTERVAL 1 SECOND)
    WHEN lower(arg0) = 'millisecond' THEN CAST(arg2 AS TIMESTAMP) + _snow_round(arg1) * (INTERVAL 1 MILLISECOND)
    WHEN lower(arg0) = 'microsecond' THEN CAST(arg2 AS TIMESTAMP) + _snow_round(arg1) * (INTERVAL 1 MICROSECOND)
    WHEN lower(arg0) = 'nanosecond' THEN CAST(arg2 AS TIMESTAMP) + floor(arg1 / 1000) * (INTERVAL 1 MICROSECOND)
    ELSE NULL
END);

-- 2026-04-10T01:56:12.575Z
CREATE OR REPLACE MACRO datediff_4983(arg0, arg1, arg2) AS (datediff(
  _normalize_datetime_part(arg0),
  arg1,
  arg2
)::bigint);

-- 2026-04-10T01:56:12.575Z
CREATE OR REPLACE MACRO timediff_4983(arg0, arg1, arg2) AS (datediff(
  _normalize_datetime_part(arg0),
  arg1,
  arg2
)::bigint);

-- 2026-04-10T01:56:12.576Z
CREATE OR REPLACE MACRO TIMESTAMPDIFF_4983(arg0, arg1, arg2) AS (datediff(
  _normalize_datetime_part(arg0),
  arg1,
  arg2
)::bigint);

-- 2026-04-10T01:56:12.576Z
CREATE OR REPLACE MACRO datediff_5017(arg0, arg1, arg2) AS (datediff(
  _normalize_datetime_part(arg0),
  arg1,
  arg2
)::bigint);

-- 2026-04-10T01:56:12.577Z
CREATE OR REPLACE MACRO timediff_5017(arg0, arg1, arg2) AS (datediff(
  _normalize_datetime_part(arg0),
  arg1,
  arg2
)::bigint);

-- 2026-04-10T01:56:12.577Z
CREATE OR REPLACE MACRO TIMESTAMPDIFF_5017(arg0, arg1, arg2) AS (datediff(
  _normalize_datetime_part(arg0),
  arg1,
  arg2
)::bigint);

-- 2026-04-10T01:56:12.578Z
CREATE OR REPLACE MACRO datediff_5057(arg0, arg1, arg2) AS (datediff(
  _normalize_datetime_part(arg0),
  arg1,
  arg2
)::bigint);

-- 2026-04-10T01:56:12.578Z
CREATE OR REPLACE MACRO timediff_5057(arg0, arg1, arg2) AS (datediff(
  _normalize_datetime_part(arg0),
  arg1,
  arg2
)::bigint);

-- 2026-04-10T01:56:12.579Z
CREATE OR REPLACE MACRO TIMESTAMPDIFF_5057(arg0, arg1, arg2) AS (datediff(
  _normalize_datetime_part(arg0),
  arg1,
  arg2
)::bigint);

-- 2026-04-10T01:56:12.579Z
CREATE OR REPLACE MACRO datediff_5125(arg0, arg1, arg2) AS (datediff(
  _normalize_datetime_part(arg0),
  _to_timestamp(arg1, 6, false).ts,
  _to_timestamp(arg2, 6, false).ts
)::bigint);

-- 2026-04-10T01:56:12.580Z
CREATE OR REPLACE MACRO timediff_5125(arg0, arg1, arg2) AS (datediff(
  _normalize_datetime_part(arg0),
  _to_timestamp(arg1, 6, false).ts,
  _to_timestamp(arg2, 6, false).ts
)::bigint);

-- 2026-04-10T01:56:12.580Z
CREATE OR REPLACE MACRO TIMESTAMPDIFF_5125(arg0, arg1, arg2) AS (datediff(
  _normalize_datetime_part(arg0),
  _to_timestamp(arg1, 6, false).ts,
  _to_timestamp(arg2, 6, false).ts
)::bigint);

-- 2026-04-10T01:56:12.581Z
CREATE OR REPLACE MACRO datediff_5172(arg0, arg1, arg2) AS (datediff(
  _normalize_datetime_part(arg0),
  _to_timestamp(arg1, 6, false).ts,
  _to_timestamp(arg2, 6, false).ts
)::bigint);

-- 2026-04-10T01:56:12.582Z
CREATE OR REPLACE MACRO timediff_5172(arg0, arg1, arg2) AS (datediff(
  _normalize_datetime_part(arg0),
  _to_timestamp(arg1, 6, false).ts,
  _to_timestamp(arg2, 6, false).ts
)::bigint);

-- 2026-04-10T01:56:12.582Z
CREATE OR REPLACE MACRO TIMESTAMPDIFF_5172(arg0, arg1, arg2) AS (datediff(
  _normalize_datetime_part(arg0),
  _to_timestamp(arg1, 6, false).ts,
  _to_timestamp(arg2, 6, false).ts
)::bigint);

-- 2026-04-10T01:56:12.583Z
CREATE OR REPLACE MACRO datediff_5224(arg0, arg1, arg2) AS (datediff(
  _normalize_datetime_part(arg0),
  _to_timestamp(arg1, 6, false).ts,
  _to_timestamp(arg2, 6, false).ts
)::bigint);

-- 2026-04-10T01:56:12.583Z
CREATE OR REPLACE MACRO timediff_5224(arg0, arg1, arg2) AS (datediff(
  _normalize_datetime_part(arg0),
  _to_timestamp(arg1, 6, false).ts,
  _to_timestamp(arg2, 6, false).ts
)::bigint);

-- 2026-04-10T01:56:12.584Z
CREATE OR REPLACE MACRO TIMESTAMPDIFF_5224(arg0, arg1, arg2) AS (datediff(
  _normalize_datetime_part(arg0),
  _to_timestamp(arg1, 6, false).ts,
  _to_timestamp(arg2, 6, false).ts
)::bigint);

-- 2026-04-10T01:56:12.585Z
CREATE OR REPLACE MACRO day_5255(arg0) AS (EXTRACT(DAY FROM arg0.ts));

-- 2026-04-10T01:56:12.585Z
CREATE OR REPLACE MACRO dayofmonth_5297(arg0) AS (EXTRACT(DAYOFMONTH FROM arg0.ts));

-- 2026-04-10T01:56:12.585Z
CREATE OR REPLACE MACRO dayofweek_5325(arg0) AS (EXTRACT(DOW FROM arg0));

-- 2026-04-10T01:56:12.585Z
CREATE OR REPLACE MACRO dayofweek_5340(arg0) AS (EXTRACT(DOW FROM arg0.ts));

-- 2026-04-10T01:56:12.585Z
CREATE OR REPLACE MACRO dayofweek_5353(arg0) AS (error('EXTRACT does not support VARCHAR argument type'));

-- 2026-04-10T01:56:12.585Z
CREATE OR REPLACE MACRO dayofweekiso_5368(arg0) AS (error('EXTRACT does not support VARCHAR argument type'));

-- 2026-04-10T01:56:12.585Z
CREATE OR REPLACE MACRO dayofweekiso_5383(arg0) AS (((EXTRACT(DOW FROM arg0.ts) + 6) % 7) + 1);

-- 2026-04-10T01:56:12.585Z
CREATE OR REPLACE MACRO dayofweekiso_5404(arg0) AS (((EXTRACT(DOW FROM arg0) + 6) % 7) + 1);

-- 2026-04-10T01:56:12.585Z
CREATE OR REPLACE MACRO endswith_6003(arg0, arg1) AS (CASE
  WHEN arg0 IS NULL OR arg1 IS NULL THEN NULL
  WHEN arg0 = '' THEN TRUE
  WHEN arg1 = '' THEN FALSE
  ELSE ends_with(arg0, arg1)
END);

-- 2026-04-10T01:56:12.585Z
CREATE OR REPLACE MACRO iff_7097(arg0, arg1, arg2) AS (CASE WHEN arg0 THEN arg1 ELSE arg2 END);

-- 2026-04-10T01:56:12.585Z
CREATE OR REPLACE MACRO left_7753(arg0, arg1) AS (CASE
  WHEN arg1 < 0 THEN ''
  ELSE left(arg0, CAST(arg1 AS BIGINT))
END);

-- 2026-04-10T01:56:12.585Z
CREATE OR REPLACE MACRO lpad_8072(arg0, arg1) AS (lpad(arg0, CAST(arg1 AS INTEGER), ' '));

-- 2026-04-10T01:56:12.586Z
CREATE OR REPLACE MACRO lpad_8087(arg0, arg1, arg2) AS (CASE 
  WHEN arg0 IS NULL OR arg1 IS NULL OR arg2 IS NULL THEN NULL
  WHEN arg1 < 0 THEN ''
  WHEN length(arg2) > 0 THEN lpad(arg0, CAST(arg1 AS INTEGER), arg2) ELSE LEFT(arg0, CAST(arg1 AS INTEGER)) 
END);

-- 2026-04-10T01:56:12.586Z
CREATE OR REPLACE MACRO ltrim_8128(arg0, arg1) AS (CASE
  WHEN arg0 IS NULL OR arg1 IS NULL THEN NULL
  WHEN arg1 = '' THEN arg0
  ELSE ltrim(arg0, arg1)
END);

-- 2026-04-10T01:56:12.586Z
CREATE OR REPLACE MACRO md5_binary_8474(arg0) AS (CASE
    WHEN arg0 IS NULL THEN NULL
    ELSE from_hex(md5(CAST(arg0 AS VARCHAR)))
END);

-- 2026-04-10T01:56:12.586Z
CREATE OR REPLACE MACRO md5_hex_8503(arg0) AS (md5(arg0));

-- 2026-04-10T01:56:12.586Z
CREATE OR REPLACE MACRO md5_hex_8515(arg0) AS (md5(arg0));

-- 2026-04-10T01:56:12.586Z
CREATE OR REPLACE MACRO month_8767(arg0) AS (EXTRACT(MONTH FROM arg0.ts));

-- 2026-04-10T01:56:12.586Z
CREATE OR REPLACE MACRO nvl_9084(arg0, arg1) AS (CASE WHEN arg0 IS NOT NULL THEN arg0 ELSE arg1 END);

-- 2026-04-10T01:56:12.586Z
CREATE OR REPLACE MACRO nvl2_9102(arg0, arg1, arg2) AS (CASE WHEN arg0 IS NOT NULL THEN arg1 ELSE arg2 END);

-- 2026-04-10T01:56:12.586Z
CREATE OR REPLACE MACRO parse_json_9275(arg0) AS (arg0);

-- 2026-04-10T01:56:12.586Z
CREATE OR REPLACE MACRO parse_url_9288(arg0) AS (_parse_url_json(arg0, 0));

-- 2026-04-10T01:56:12.586Z
CREATE OR REPLACE MACRO parse_url_9302(arg0, arg1) AS (_parse_url_json(arg0, arg1));

-- 2026-04-10T01:56:12.587Z
CREATE OR REPLACE MACRO position_9415(arg0, arg1) AS (position(arg0 IN arg1));

-- 2026-04-10T01:56:12.587Z
CREATE OR REPLACE MACRO position_9432(arg0, arg1, arg2) AS (CASE WHEN arg0 IS NULL OR arg1 IS NULL OR arg2 IS NULL THEN NULL ELSE
(
WITH t0 AS (SELECT if(arg2 > 0, arg2, 1) as pos),
      t1 AS (SELECT *, IF(pos > length(arg1) AND pos > 1, NULL, substring(arg1, pos::BIGINT)) as sub FROM t0),
      t2 AS (SELECT *, position(arg0 IN sub) as relative FROM t1)
SELECT if(relative = 0 OR relative IS NULL, 0, relative + pos - 1) as absolute FROM t2
) END);

-- 2026-04-10T01:56:12.587Z
CREATE OR REPLACE MACRO quarter_9537(arg0) AS (EXTRACT(QUARTER FROM arg0.ts));

-- 2026-04-10T01:56:12.587Z
CREATE OR REPLACE MACRO regexp_9954(arg0, arg1) AS (arg0 ~ arg1);

-- 2026-04-10T01:56:12.587Z
CREATE OR REPLACE MACRO regexp_instr_10081(arg0, arg1) AS (if(
  arg0 is null OR arg1 is null, 
  null,
  regexp_instr_core(arg0, arg1, 1, 1, 0, 'c', NULL::INTEGER)
));

-- 2026-04-10T01:56:12.587Z
CREATE OR REPLACE MACRO regexp_instr_10102(arg0, arg1, arg2) AS (if(
  arg0 is null OR arg1 is null OR arg2 is null, 
  null,
  regexp_instr_core(arg0, arg1, arg2::bigint, 1, 0, 'c', NULL::INTEGER)
));

-- 2026-04-10T01:56:12.587Z
CREATE OR REPLACE MACRO regexp_instr_10124(arg0, arg1, arg2, arg3) AS (if(
  arg0 is null OR arg1 is null OR arg2 is null OR arg3 is null, 
  null,
  regexp_instr_core(arg0, arg1, arg2::bigint, arg3, 0, 'c', NULL::INTEGER)
));

-- 2026-04-10T01:56:12.587Z
CREATE OR REPLACE MACRO regexp_instr_10147(arg0, arg1, arg2, arg3, arg4) AS (if(
  arg0 is null OR arg1 is null OR arg2 is null OR arg3 is null OR arg4 is null, 
  null,
  regexp_instr_core(arg0, arg1, arg2::bigint, arg3, arg4, 'c', NULL::INTEGER)
));

-- 2026-04-10T01:56:12.587Z
CREATE OR REPLACE MACRO regexp_instr_10171(arg0, arg1, arg2, arg3, arg4, arg5) AS (if(
  arg0 is null OR arg1 is null OR arg2 is null OR arg3 is null OR arg4 is null OR arg5 is null, 
  null,
  regexp_instr_core(arg0, arg1, arg2::bigint, arg3, arg4, if(arg5 is null, 'c', arg5), NULL::INTEGER)
));

-- 2026-04-10T01:56:12.587Z
CREATE OR REPLACE MACRO regexp_instr_10196(arg0, arg1, arg2, arg3, arg4, arg5, arg6) AS (if(
  arg0 is null OR arg1 is null OR arg2 is null OR arg3 is null OR arg4 is null OR arg5 is null OR arg6 is null, 
  null,
  regexp_instr_core(arg0, arg1, arg2::bigint, arg3, arg4, if(arg5 is null, 'c', arg5), arg6)
));

-- 2026-04-10T01:56:12.587Z
CREATE OR REPLACE MACRO regexp_replace_10237(arg0, arg1) AS (regexp_replace(arg0, arg1, '', 'g'));

-- 2026-04-10T01:56:12.588Z
CREATE OR REPLACE MACRO regexp_replace_10252(arg0, arg1, arg2) AS (regexp_replace(arg0, arg1, arg2, 'g'));

-- 2026-04-10T01:56:12.588Z
CREATE OR REPLACE MACRO regexp_substr_10308(arg0, arg1) AS (regexp_extract(arg0::varchar, arg1::varchar));

-- 2026-04-10T01:56:12.588Z
CREATE OR REPLACE MACRO regexp_substr_10323(arg0, arg1, arg2) AS (list_extract(
  regexp_extract_all(
    substr(arg0, arg2::bigint),
    arg1,
    0
  ),
  CAST(1 AS BIGINT)
));

-- 2026-04-10T01:56:12.588Z
CREATE OR REPLACE MACRO regexp_substr_10346(arg0, arg1, arg2, arg3) AS (CASE WHEN arg3 > 0 THEN
  list_extract(
    regexp_extract_all(
      substr(arg0, arg2::bigint),
      arg1,
      0
    ),
    CAST(arg3 AS BIGINT)
  )
ELSE
  error('Occurrence must be positive')
END);

-- 2026-04-10T01:56:12.588Z
CREATE OR REPLACE MACRO regexp_substr_10374(arg0, arg1, arg2, arg3, arg4) AS (COALESCE(
  TRY(list_extract(
    regexp_extract_all(
      substr(arg0, arg2::bigint),
      concat(
        CASE WHEN strpos(arg4, 'i') > 0 THEN '(?i)' ELSE '' END,
        CASE WHEN strpos(arg4, 'm') > 0 THEN '(?m)' ELSE '' END,
        CASE WHEN strpos(arg4, 's') > 0 THEN '(?s)' ELSE '' END,
        arg1
      ),
      if(strpos(arg4, 'e') > 0, 1, 0)::integer
    ),
    CAST(arg3 AS BIGINT)
  )),
  list_extract(
    regexp_extract_all(
      substr(arg0, arg2::bigint),
      concat(
        CASE WHEN strpos(arg4, 'i') > 0 THEN '(?i)' ELSE '' END,
        CASE WHEN strpos(arg4, 'm') > 0 THEN '(?m)' ELSE '' END,
        CASE WHEN strpos(arg4, 's') > 0 THEN '(?s)' ELSE '' END,
        arg1
      ),
      0
    ),
    CAST(arg3 AS BIGINT)
  )
));

-- 2026-04-10T01:56:12.588Z
CREATE OR REPLACE MACRO regexp_substr_10419(arg0, arg1, arg2, arg3, arg4, arg5) AS (CASE WHEN arg0 is null OR arg1 is null OR arg2 is null OR arg3 is null OR arg4 is null OR arg5 is null THEN null ELSE
list_extract(
  try(
    regexp_extract_all(
      substr(arg0, arg2::bigint),
      
      concat(
        CASE WHEN strpos(arg4, 'i') > 0 THEN '(?i)' ELSE '' END,
        CASE WHEN strpos(arg4, 'm') > 0 THEN '(?m)' ELSE '' END,
        CASE WHEN strpos(arg4, 's') > 0 THEN '(?s)' ELSE '' END,
        arg1
      ),
      coalesce(arg5, if(strpos(arg4, 'e') > 0, 1, 0))::integer
    )
  ),
  CAST(arg3 AS BIGINT)
) END);

-- 2026-04-10T01:56:12.588Z
CREATE OR REPLACE MACRO repeat_10666(arg0, arg1) AS (repeat(arg0, CAST(arg1 AS BIGINT)));

-- 2026-04-10T01:56:12.588Z
CREATE OR REPLACE MACRO replace_10680(arg0, arg1) AS (replace(arg0, arg1, ''));

-- 2026-04-10T01:56:12.588Z
CREATE OR REPLACE MACRO right_10838(arg0, arg1) AS (CASE
  WHEN arg1 < 0 THEN ''
  ELSE right(arg0, CAST(arg1 AS BIGINT))
END);

-- 2026-04-10T01:56:12.589Z
CREATE OR REPLACE MACRO rlike_10855(arg0, arg1) AS (arg0 ~ arg1);

-- 2026-04-10T01:56:12.589Z
CREATE OR REPLACE MACRO rpad_11038(arg0, arg1) AS (rpad(arg0, CAST(arg1 AS INTEGER), ' '));

-- 2026-04-10T01:56:12.589Z
CREATE OR REPLACE MACRO rpad_11053(arg0, arg1, arg2) AS (CASE 
  WHEN arg0 IS NULL OR arg1 IS NULL OR arg2 IS NULL THEN NULL
  WHEN arg1 < 0 THEN ''
  WHEN length(arg2) > 0 THEN rpad(arg0, CAST(arg1 AS INTEGER), arg2) ELSE LEFT(arg0, CAST(arg1 AS INTEGER)) 
END);

-- 2026-04-10T01:56:12.589Z
CREATE OR REPLACE MACRO rtrim_11094(arg0, arg1) AS (CASE
  WHEN arg0 IS NULL OR arg1 IS NULL THEN NULL
  WHEN arg1 = '' THEN arg0
  ELSE rtrim(arg0, arg1)
END);

-- 2026-04-10T01:56:12.589Z
CREATE OR REPLACE MACRO split_part_11685(arg0, arg1, arg2) AS (split_part(arg0, arg1, CAST(arg2 AS BIGINT)));

-- 2026-04-10T01:56:12.589Z
CREATE OR REPLACE MACRO startswith_13859(arg0, arg1) AS (CASE
  WHEN arg0 IS NULL OR arg1 IS NULL THEN NULL
  WHEN arg0 = '' THEN TRUE
  WHEN arg1 = '' THEN FALSE
  ELSE starts_with(arg0, arg1)
END);

-- 2026-04-10T01:56:12.589Z
CREATE OR REPLACE MACRO substring_14067(arg0, arg1) AS (substring(arg0, CAST(arg1 AS BIGINT)));

-- 2026-04-10T01:56:12.589Z
CREATE OR REPLACE MACRO substr_14067(arg0, arg1) AS (substring(arg0, CAST(arg1 AS BIGINT)));

-- 2026-04-10T01:56:12.589Z
CREATE OR REPLACE MACRO substring_14083(arg0, arg1, arg2) AS (CASE
  WHEN arg2 < 0 THEN ''
  WHEN arg1 > 0 THEN substring(arg0, CAST(arg1 AS BIGINT), CAST(arg2 AS BIGINT))
  WHEN arg1 = 0 THEN substring(arg0, 1,                    CAST(arg2 AS BIGINT))
  WHEN arg1 < -length(arg0) THEN ''
  ELSE substring(arg0, CAST(length(arg0) + arg1 + 1 AS BIGINT), CAST(arg2 AS BIGINT))
END);

-- 2026-04-10T01:56:12.589Z
CREATE OR REPLACE MACRO substr_14083(arg0, arg1, arg2) AS (CASE
  WHEN arg2 < 0 THEN ''
  WHEN arg1 > 0 THEN substring(arg0, CAST(arg1 AS BIGINT), CAST(arg2 AS BIGINT))
  WHEN arg1 = 0 THEN substring(arg0, 1,                    CAST(arg2 AS BIGINT))
  WHEN arg1 < -length(arg0) THEN ''
  ELSE substring(arg0, CAST(length(arg0) + arg1 + 1 AS BIGINT), CAST(arg2 AS BIGINT))
END);

-- 2026-04-10T01:56:12.590Z
CREATE OR REPLACE MACRO sysdate_14199() AS (current_timestamp);

-- 2026-04-10T01:56:12.590Z
CREATE OR REPLACE MACRO time_15379(arg0) AS (TIME '00:00:00');

-- 2026-04-10T01:56:12.590Z
CREATE OR REPLACE MACRO to_date_15806(arg0) AS (_to_date(arg0, false));

-- 2026-04-10T01:56:12.590Z
CREATE OR REPLACE MACRO to_date_15821(arg0) AS (arg0::date);

-- 2026-04-10T01:56:12.590Z
CREATE OR REPLACE MACRO to_date_15835(arg0, arg1) AS (CASE
    WHEN arg1 = 'MM/DD/YYYY' THEN STRPTIME(arg0, '%m/%d/%Y')
    WHEN arg1 = 'YYYY-MM-DD' THEN STRPTIME(arg0, '%Y-%m-%d')
    WHEN arg1 = 'DD/MM/YYYY' THEN STRPTIME(arg0, '%d/%m/%Y')
    WHEN arg1 = 'DD-MON-YYYY' THEN STRPTIME(arg0, '%d-%b-%Y')
    WHEN arg1 = 'MON DD, YYYY' THEN STRPTIME(arg0, '%b %d, %Y')
    WHEN arg1 = 'YYYY.MM.DD' THEN STRPTIME(arg0, '%Y.%m.%d')
    ELSE STRPTIME(arg0, '%Y-%m-%d')  -- fallback
END::DATE);

-- 2026-04-10T01:56:12.590Z
CREATE OR REPLACE MACRO to_time_16371(arg0) AS (_to_time_with_precision(arg0, 6, false));

-- 2026-04-10T01:56:12.590Z
CREATE OR REPLACE MACRO to_time_16386(arg0) AS (arg0::time);

-- 2026-04-10T01:56:12.590Z
CREATE OR REPLACE MACRO to_time_16401(arg0) AS ((arg0 at time zone 'UTC')::timestamp::time);

-- 2026-04-10T01:56:12.590Z
CREATE OR REPLACE MACRO to_time_16416(arg0) AS (arg0.ts::time);

-- 2026-04-10T01:56:12.591Z
CREATE OR REPLACE MACRO to_time_16431(arg0) AS (arg0::timestamp::time);

-- 2026-04-10T01:56:12.591Z
CREATE OR REPLACE MACRO to_timestamp_ltz_16458(arg0) AS ((
  WITH x AS (SELECT _to_timestamp(arg0, 6, false) AS t)
  SELECT 
    CASE WHEN t.tz IS NULL THEN t.ts AT TIME ZONE 'UTC' 
    ELSE t.ts + t.tz 
    END result 
  FROM x
));

-- 2026-04-10T01:56:12.591Z
CREATE OR REPLACE MACRO to_timestamp_ltz_16485(arg0) AS (arg0 at time zone 'UTC');

-- 2026-04-10T01:56:12.591Z
CREATE OR REPLACE MACRO to_timestamp_ltz_16500(arg0) AS (arg0);

-- 2026-04-10T01:56:12.591Z
CREATE OR REPLACE MACRO to_timestamp_ltz_16515(arg0) AS ((arg0.ts + arg0.tz) at time zone 'UTC');

-- 2026-04-10T01:56:12.591Z
CREATE OR REPLACE MACRO to_timestamp_ltz_16543(arg0, arg1) AS (CASE WHEN arg0 IS NULL THEN NULL ELSE 
  CASE arg1 
    WHEN 0 THEN (TIMESTAMP '1970-01-01' + (CAST(arg0 AS DOUBLE) / pow(10, arg1)) * INTERVAL 1 SECOND)
    WHEN 3 THEN (TIMESTAMP '1970-01-01' + (CAST(arg0 AS DOUBLE) / pow(10, arg1)) * INTERVAL 1 SECOND)
    WHEN 6 THEN (TIMESTAMP '1970-01-01' + (CAST(arg0 AS DOUBLE) / pow(10, arg1)) * INTERVAL 1 SECOND)
    WHEN 9 THEN (TIMESTAMP '1970-01-01' + (CAST(arg0 AS DOUBLE) / pow(10, arg1)) * INTERVAL 1 SECOND)
  ELSE 
    NULL 
  END
END);

-- 2026-04-10T01:56:12.591Z
CREATE OR REPLACE MACRO to_timestamp_ntz_16582(arg0) AS (CASE WHEN arg0 IS NULL THEN NULL ELSE 
  (TIMESTAMP '1970-01-01' + arg0 * INTERVAL 1 SECOND)
END);

-- 2026-04-10T01:56:12.591Z
CREATE OR REPLACE MACRO to_timestamp_16582(arg0) AS (CASE WHEN arg0 IS NULL THEN NULL ELSE 
  (TIMESTAMP '1970-01-01' + arg0 * INTERVAL 1 SECOND)
END);

-- 2026-04-10T01:56:12.591Z
CREATE OR REPLACE MACRO to_timestamp_ntz_16605(arg0) AS ((
  WITH x AS (SELECT _to_timestamp(arg0, 6, false) AS t)
  SELECT t.ts::timestamp FROM x
));

-- 2026-04-10T01:56:12.591Z
CREATE OR REPLACE MACRO to_timestamp_16605(arg0) AS ((
  WITH x AS (SELECT _to_timestamp(arg0, 6, false) AS t)
  SELECT t.ts::timestamp FROM x
));

-- 2026-04-10T01:56:12.592Z
CREATE OR REPLACE MACRO to_timestamp_ntz_16624(arg0) AS (arg0 at time zone 'UTC');

-- 2026-04-10T01:56:12.592Z
CREATE OR REPLACE MACRO to_timestamp_16624(arg0) AS (arg0 at time zone 'UTC');

-- 2026-04-10T01:56:12.592Z
CREATE OR REPLACE MACRO to_timestamp_ntz_16640(arg0) AS (arg0.ts::timestamp);

-- 2026-04-10T01:56:12.592Z
CREATE OR REPLACE MACRO to_timestamp_16640(arg0) AS (arg0.ts::timestamp);

-- 2026-04-10T01:56:12.592Z
CREATE OR REPLACE MACRO to_timestamp_ntz_16670(arg0, arg1) AS (CASE WHEN arg0 IS NULL THEN NULL ELSE 
  CASE arg1 
    WHEN 0 THEN (TIMESTAMP '1970-01-01' + (CAST(arg0 AS DOUBLE) / pow(10, arg1)) * INTERVAL 1 SECOND)
    WHEN 3 THEN (TIMESTAMP '1970-01-01' + (CAST(arg0 AS DOUBLE) / pow(10, arg1)) * INTERVAL 1 SECOND)
    WHEN 6 THEN (TIMESTAMP '1970-01-01' + (CAST(arg0 AS DOUBLE) / pow(10, arg1)) * INTERVAL 1 SECOND)
    WHEN 9 THEN (TIMESTAMP '1970-01-01' + (CAST(arg0 AS DOUBLE) / pow(10, arg1)) * INTERVAL 1 SECOND)
  ELSE 
    NULL 
  END
END);

-- 2026-04-10T01:56:12.592Z
CREATE OR REPLACE MACRO to_timestamp_16670(arg0, arg1) AS (CASE WHEN arg0 IS NULL THEN NULL ELSE 
  CASE arg1 
    WHEN 0 THEN (TIMESTAMP '1970-01-01' + (CAST(arg0 AS DOUBLE) / pow(10, arg1)) * INTERVAL 1 SECOND)
    WHEN 3 THEN (TIMESTAMP '1970-01-01' + (CAST(arg0 AS DOUBLE) / pow(10, arg1)) * INTERVAL 1 SECOND)
    WHEN 6 THEN (TIMESTAMP '1970-01-01' + (CAST(arg0 AS DOUBLE) / pow(10, arg1)) * INTERVAL 1 SECOND)
    WHEN 9 THEN (TIMESTAMP '1970-01-01' + (CAST(arg0 AS DOUBLE) / pow(10, arg1)) * INTERVAL 1 SECOND)
  ELSE 
    NULL 
  END
END);

-- 2026-04-10T01:56:12.592Z
CREATE OR REPLACE MACRO to_timestamp_tz_16720(arg0) AS (_to_timestamp(arg0, 6, false));

-- 2026-04-10T01:56:12.592Z
CREATE OR REPLACE MACRO to_varchar_16772(arg0) AS ((with t as (
    select struct_extract(arg0, 'ts') as ts, struct_extract(arg0, 'tz') as tz
),
t1 as (
    select ts, CASE WHEN tz IS NULL THEN ts at time zone 'Asia/Kathmandu' - ts ELSE tz end as tz
    from t        
)
select strftime('%Y-%m-%d %H:%M:%S.%g', ts) || ' ' || 
CASE 
WHEN EXTRACT(epoch FROM tz) = 0 THEN 'Z' 
ELSE (
  CASE 
    WHEN EXTRACT(epoch FROM tz) < 0 THEN '+' 
    ELSE '-' 
  END
  || LPAD(FLOOR(ABS(EXTRACT(epoch FROM tz) / 3600))::INT::VARCHAR, 2, '0')
  || LPAD(ABS((EXTRACT(epoch FROM tz) % 3600) / 60)::INT::VARCHAR, 2, '0')
)
END
from t1));

-- 2026-04-10T01:56:12.592Z
CREATE OR REPLACE MACRO to_varchar_16810(arg0) AS (strftime('%Y-%m-%d %H:%M:%S.000', arg0.ts) || ' ' || 
CASE WHEN arg0.tz IS NULL THEN ''
WHEN EXTRACT(epoch FROM arg0.tz) = 0 THEN 'Z' 
ELSE (
  CASE 
    WHEN EXTRACT(epoch FROM arg0.tz) < 0 THEN '+' 
    ELSE '-' 
  END
  || LPAD(FLOOR(ABS(EXTRACT(epoch FROM arg0.tz) / 3600))::INT::VARCHAR, 2, '0')
  || LPAD(ABS((EXTRACT(epoch FROM arg0.tz) % 3600) / 60)::INT::VARCHAR, 2, '0')
)
END);

-- 2026-04-10T01:56:12.593Z
CREATE OR REPLACE MACRO to_varchar_16847(arg0) AS (strftime('%Y-%m-%d %H:%M:%S.%g', arg0.ts) || ' ' || 
CASE WHEN EXTRACT(epoch FROM arg0.tz) = 0 THEN 'Z' 
ELSE (
  CASE 
    WHEN EXTRACT(epoch FROM arg0.tz) < 0 THEN '+' 
    ELSE '-' 
  END
  || LPAD(FLOOR(ABS(EXTRACT(epoch FROM arg0.tz) / 3600))::INT::VARCHAR, 2, '0')
  || LPAD(ABS((EXTRACT(epoch FROM arg0.tz) % 3600) / 60)::INT::VARCHAR, 2, '0')
)
END);

-- 2026-04-10T01:56:12.593Z
CREATE OR REPLACE MACRO to_varchar_16870(arg0) AS ((
  WITH pre_processed AS (
    SELECT 
      arg0 AS t, 
      arg0 AT TIME ZONE 'UTC' AS tz
    ),
    processed AS (
      SELECT 
      (tz - t) AS dt,
      case 
        when substring(dt::varchar, 1, 1) = '-'
        then replace(substring(dt::varchar, 1, 6), ':', '')
        else '+' || replace(substring(dt::varchar, 1, 5), ':', '')
      end AS offset_str,
      strftime('%Y-%m-%d %H:%M:%S.%g', tz) AS tz_ms,
      tz_ms || ' ' || offset_str AS result
      FROM pre_processed
    )
  SELECT 
    result
  FROM processed
));

-- 2026-04-10T01:56:12.593Z
CREATE OR REPLACE MACRO to_varchar_16916(arg0, arg1) AS (strftime(arg0, arg1));

-- 2026-04-10T01:56:12.593Z
CREATE OR REPLACE MACRO trim_16977(arg0) AS (trim(arg0, ' '));

-- 2026-04-10T01:56:12.593Z
CREATE OR REPLACE MACRO trim_16992(arg0, arg1) AS (CASE
  WHEN arg0 IS NULL OR arg1 IS NULL THEN NULL
  WHEN arg1 = '' THEN arg0
  ELSE trim(arg0, arg1)
END);

-- 2026-04-10T01:56:12.593Z
CREATE OR REPLACE MACRO try_to_date_17360(arg0) AS (_to_date(arg0, true));

-- 2026-04-10T01:56:12.593Z
CREATE OR REPLACE MACRO try_to_date_17375(arg0) AS (TRY_CAST(arg0 AS date));

-- 2026-04-10T01:56:12.593Z
CREATE OR REPLACE MACRO try_to_time_17862(arg0) AS (_to_time_with_precision(arg0, 6, true));

-- 2026-04-10T01:56:12.593Z
CREATE OR REPLACE MACRO try_to_time_17877(arg0) AS (error('Cannot convert value to TIME: ' || arg0));

-- 2026-04-10T01:56:12.594Z
CREATE OR REPLACE MACRO try_to_timestamp_ltz_17927(arg0) AS ((
  WITH x AS (SELECT _to_timestamp(arg0, 6, true) AS t)
  SELECT 
    CASE WHEN t.tz IS NULL THEN t.ts AT TIME ZONE 'UTC' 
    ELSE t.ts + t.tz 
    END result 
  FROM x
));

-- 2026-04-10T01:56:12.594Z
CREATE OR REPLACE MACRO try_to_timestamp_ntz_17970(arg0) AS (error('Cannot TRY_CAST value to TIMESTAMP_NTZ: ' || arg0));

-- 2026-04-10T01:56:12.594Z
CREATE OR REPLACE MACRO try_to_timestamp_ntz_17985(arg0) AS ((
  WITH x AS (SELECT _to_timestamp(arg0, 6, true) AS t)
  SELECT t.ts::timestamp FROM x
));

-- 2026-04-10T01:56:12.594Z
CREATE OR REPLACE MACRO try_to_timestamp_ntz_18002(arg0, arg1) AS ((
  WITH x AS (SELECT _to_timestamp(arg0, 6, true) AS t)
  SELECT t.ts::timestamp FROM x
));

-- 2026-04-10T01:56:12.594Z
CREATE OR REPLACE MACRO try_to_timestamp_tz_18020(arg0) AS (_to_timestamp(arg0, 6, true));

-- 2026-04-10T01:56:12.594Z
CREATE OR REPLACE MACRO try_to_timestamp_tz_18044(arg0) AS (error('Cannot TRY_CAST value to TIMESTAMP_TZ: ' || arg0));

-- 2026-04-10T01:56:12.594Z
CREATE OR REPLACE MACRO week_18604(arg0) AS (EXTRACT(WEEK FROM arg0.ts));

-- 2026-04-10T01:56:12.595Z
CREATE OR REPLACE MACRO weekiso_18632(arg0) AS (STRFTIME('%V', arg0.ts));

-- 2026-04-10T01:56:12.595Z
CREATE OR REPLACE MACRO weekiso_18647(arg0) AS (STRFTIME('%V', arg0::timestamp));

-- 2026-04-10T01:56:12.595Z
CREATE OR REPLACE MACRO weekofyear_18662(arg0) AS (strftime('%V', arg0.ts));

-- 2026-04-10T01:56:12.595Z
CREATE OR REPLACE MACRO weekofyear_18677(arg0) AS (strftime('%V', arg0::timestamp));

-- 2026-04-10T01:56:12.595Z
CREATE OR REPLACE MACRO yearofweek_18781(arg0) AS (strftime('%G', arg0::timestamp));

-- 2026-04-10T01:56:12.595Z
ATTACH '/Users/lee/Documents/GitHub/sa-standard-shared-demo/target/db/state/analytics.db' AS analytics;

-- 2026-04-10T01:56:12.598Z
CREATE SCHEMA IF NOT EXISTS analytics.dbt_lbk_fusion_mig;

-- 2026-04-10T01:56:12.598Z
ATTACH '/Users/lee/Documents/GitHub/sa-standard-shared-demo/target/db/state/raw.db' AS raw;

-- sidecar_exec::9baf3ee9-a9f1-4d71-889c-8975a939a0ff
-- 2026-04-10T01:56:12.603Z
DESCRIBE analytics.dbt_lbk_fusion_mig.dim_parts;

-- sidecar_exec::08707995-afa9-4015-8143-225f5c164a37
-- 2026-04-10T01:56:12.606Z
DESCRIBE analytics.dbt_lbk_fusion_mig.stg_tpch_parts;

-- sidecar_exec::bc0f2480-feb6-4828-b9b6-a9ec32c78211
-- 2026-04-10T01:56:12.606Z
DESCRIBE raw.tpch_sf001.part;

-- check_exists::source.analytics.tpch_sf001.part::e690b9ed-a7f8-4668-8c61-b5ad8aa0f609
-- 2026-04-10T01:56:12.734Z
SELECT * FROM (SELECT 1 FROM information_schema.tables WHERE table_catalog = 'raw' AND table_schema = 'tpch_sf001' AND table_name = 'part' LIMIT 1) AS __runner_subquery LIMIT 1;

-- adhoc::model.analytics.stg_tpch_parts::c7930e94-0808-4569-a1f7-0a05905fe36d
-- 2026-04-10T01:56:12.740Z
SELECT * FROM (select * from ANALYTICS.DBT_LBK_FUSION_MIG.STG_TPCH_PARTS) AS __runner_subquery LIMIT 10;

-- adhoc::model.analytics.dim_parts::f7dd5f16-6e67-4298-8060-ad6c4ef6836d
-- 2026-04-10T01:56:12.852Z
SELECT * FROM (select * from ANALYTICS.DBT_LBK_FUSION_MIG.DIM_PARTS) AS __runner_subquery LIMIT 10;

