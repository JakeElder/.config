; extends

; For /* sql */ comment followed by template string
(
  (comment) @comment
  (#match? @comment "^/\\*+\\s*sql\\s*\\*/$")
  .
  (template_string) @injection.content
  (#set! injection.language "sql")
  (#set! injection.include-children)
)
