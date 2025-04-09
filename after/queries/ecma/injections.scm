;; extends



; html template strings

(
  (_ (_ (_ (string_fragment) @injection.content)))
  (#lua-match? @injection.content "<\/[a-zA-z]*>")
  (#set! injection.language "html")
)


; ((comment) @htmlComment
;   (#match? @htmlComment "HTML")
;   .
;   (return_statement
;     (template_string
;       (
;         (string_fragment) *
;         (template_substitution) *
;       )* @injection.content
;       (#set! injection.language "html"))))

; ((comment) @htmlComment
;   (#match? @htmlComment "HTML")
;   .
;   (_ (template_string(_) @injection.content)  (#set! injection.language "html")))
;


; chatgpt recommendation
; ((comment) @htmlComment
;   (#match? @htmlComment "HTML")
;   .
;   (_
;     (template_string
;       (string_fragment) @injection.content
;       (#set! injection.language "html"))))



