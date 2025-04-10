; extends

; For /* sql */ comment followed by template string
(
  (comment) @comment
  (#match? @comment "^/\\*+\\s*sql\\s*\\*/$") ; Match /* sql */, /*  sql  */, /** sql **/, etc.
  . ; The template string must immediately follow the comment
  (template_string) @injection.content
  (#set! injection.language "sql")
  (#set! injection.include-children) ; Include template substitutions `${...}`
)
