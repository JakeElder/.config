; extends

; Block scalar values (the multi-line strings after |)
(block_scalar) @assignment.rhs

; Flow scalar values (quoted strings)
(flow_node
  (plain_scalar) @assignment.rhs)

(flow_node
  (double_quote_scalar) @assignment.rhs)

(flow_node
  (single_quote_scalar) @assignment.rhs)

; Mapping values (everything after the colon)
(block_mapping_pair
  value: (_) @assignment.rhs)

; Mapping keys
(block_mapping_pair
  key: (_) @assignment.lhs)
