; extends

(pair) @assignment.outer

(pair
  key: (string) @assignment.lhs)

(pair
  value: (_) @assignment.rhs)

; Array elements (for ]. navigation - just array elements)
(array
  (_) @element.outer)

; Comments (JSONC supports comments, JSON doesn't)
(comment) @comment.outer
