def build_filters(states=None, categories=None):
    clauses = []
    params = {}

    if states:
        clauses.append("fo.customer_state = ANY(%(states)s)")
        params["states"] = states

    if categories:
        clauses.append("fo.product_category_name = ANY(%(categories)s)")
        params["categories"] = categories

    where_sql = ""

    if clauses:
        where_sql = "WHERE " + " AND ".join(clauses)

    return where_sql, params
