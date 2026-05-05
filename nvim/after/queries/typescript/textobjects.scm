; extends

; String textobjects - select any quoted string
(string) @string.outer

; String content - the text inside quotes
(string
  (string_fragment) @string.inner)

; Template strings
(template_string) @string.outer

; Template string content
(template_string
  (string_fragment) @string.inner)

; Type aliases as assignments
(type_alias_declaration) @assignment.outer

; Type alias name (left side)
(type_alias_declaration
  name: (type_identifier) @assignment.lhs)

; Type alias value (right side)
(type_alias_declaration
  value: (_) @assignment.rhs)

; Shorthand property identifier (e.g., { name } instead of { name: name })
(shorthand_property_identifier) @assignment.outer

; Import statements
(import_statement) @import.outer

; Import clause (the { foo, bar } part)
(import_clause) @import.inner

; Export statements
(export_statement) @export.outer

; Export clause (the { foo, bar } part)
(export_clause) @export.inner

; Import/Export source (the 'module' or "path" part after from)
(import_statement
  source: (string) @source.outer)

(export_statement
  source: (string) @source.outer)

; Import/Export source content (without quotes)
(import_statement
  source: (string
    (string_fragment) @source.inner))

(export_statement
  source: (string
    (string_fragment) @source.inner))

; Call arguments
(arguments
  (_) @argument.outer)

; Type identifiers (for navigation)
(type_identifier) @type.outer

; Array elements (for navigation - just array elements, not all items)
(array
  (_) @element.outer)

; Regex (for navigation)
(regex) @regex.outer

; Parameters (for navigation)
[
  (required_parameter)
  (optional_parameter)
] @parameter.outer
