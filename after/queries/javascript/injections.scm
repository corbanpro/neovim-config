;; extends

; html template strings
((comment) @htmlComment
  (#match? @htmlComment "HTML")
  .
    (_(_(template_string(string_fragment) @injection.content
    (#set! injection.language "html")))))

; html template strings in objects
((comment) @htmlComment
  (#match? @htmlComment "HTML")
  .
  (pair
    value: (template_string
      (string_fragment)  @injection.content
      (#set! injection.language "html"))))

