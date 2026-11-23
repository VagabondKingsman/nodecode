;;; edit-a-cell-then-read-it-whole — define-skill recorded by session experience-s-MJ1G3NHN-turn-1U7VXKP-DL0AWRW6EF, 2026-11-18T18:33:48Z
(in-package :nodecode.evolved)

(define-skill edit-a-cell-then-read-it-whole
 "After an incremental edit to a kept cell, read the whole cell back and delete or rewrite whichever clause the edit contradicts."
 ;; when to use: an edit or a rewritten define-skill lands new text beside old text in a cell whose value is a list of clauses, steps or facts, where the old text may now say the opposite
 ;; step: after the receipt, read the whole cell with help on its name - the receipt names the line changed, never the meaning the file now carries
 ;; step: compare the new clause with its neighbours and rewrite or drop any clause that now contradicts it, rather than leaving both standing
 ;; step: when the cell carries a number or a count, recount it off the live surface before trusting the old figure
 ;; evidence: 2026-11-18 - a memory cell was edited to say several experience verbs ride one call while its very next clause still said sightings go one per call; a further edit reconciled the two and a read-back showed the contradiction gone and the neighbouring clause intact
 ;; confidence: high - the contradiction and its reconciliation were read back clause by clause in the same round
 )
