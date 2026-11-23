;;; eval-form-escaping — define-skill recorded by session experience-s-MJ1G3NHN-turn-1U7VVAT-OSUWZHNHQ, 2026-11-18T17:46:02Z
(in-package :nodecode.evolved)

(define-skill eval-form-escaping
  "A tool block's form needs one level of escaping, so its quotes reach Lisp as plain string quotes; a doubly-escaped quote reaches it as a literal-quoted symbol and fails UNBOUND-VARIABLE, and two backslashes before a quote in a JSON wrapper reach the reader as a stray dot, SIMPLE-READER-ERROR: too many dots."
  ;; when to use: an eval call answers UNBOUND-VARIABLE for a name printed with literal quote characters around it, or a one-line bare form is refused with a paren left open
  ;; step: put the form bare in the block, with no JSON wrapper, so a string argument needs no escaping at all, and end its last line with the closing paren
  ;; step: a form that reads a named string must carry its strings object in the SAME call, as one JSON wrapper holding both form and strings; a strings object sent beside a bare form is refused
  ;; step: a multi-line shell script is never escaped by hand: write the whole file in a #>END block, then run bash on that path; or pass the text through strings and write-file
  ;; step: if JSON is used, an inner quote is one backslash-quote, never two; and a multi-line form sent inside a JSON wrapper reaches the reader as one line, so a definition sent that way loses its indentation and its closing paren falls inside the last ;; comment - send a definition bare, with real line breaks, as its own block
  ;; step: patching THIS cell with edit, a typed backslash-n in the new text aborts the compilation and drops the definition from help; add the step in plain words, or rewrite the cell whole with define-skill and read it back
  ;; evidence: 2026-11-18 - eight consecutive eval calls failed on hand-escaped shell chains while a #>END write-file and a bare multi-line sh both ran first try; the same day a reflection spent about ten calls on a doubly-escaped index call until the form was retyped bare, and then an edit carrying a typed backslash-n unregistered this very cell, which had to be rewritten whole
  ;; confidence: high - the same day shows both shapes side by side, plus the edit that broke the file
)
