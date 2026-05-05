; extends

; JSX-specific
(jsx_element) @tag
(jsx_self_closing_element) @tag

(jsx_attribute) @assignment.outer

(jsx_attribute
  (property_identifier) @assignment.lhs)

(jsx_attribute
  (string) @assignment.rhs)

(jsx_attribute
  (jsx_expression) @assignment.rhs)

; Parameters (for navigation)
[
  (required_parameter)
  (optional_parameter)
] @parameter.outer
