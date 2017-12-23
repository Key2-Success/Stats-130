/* Name: Kitu Komya
   UID: 404-491-375
   Due Date: 2-16-17 */

/* 1-1 */
cd "C:\Users\Anon001\Desktop"

use "demographics.dta", clear
sort id
save "demographics.dta", replace

/* 1-2 */
use "scores.dta", clear
sort id
merge id using "demographics.dta"

describe // 60 total observations

drop _merge
save "demo_scores.dta", replace

/* 2 */
rename race hispanic
label define hispanic 0 "non-hispanic" 1 "hispanic"
label values hispanic hispanic
save "demo_scores.dta", replace

/* 3-1 */
sort teacher
by teacher: summarize score

/* 3-2 */
sort teacher score
by teacher: keep it _n == 1

/* 4-1 */
use "demo_scores.dta", replace
egen meanscore = mean(score), by(teacher)
egen sdscore = sd(score), by(teacher)

/* 4-2 */
gen normalized = (score - meanscore)/sdscore

/* 4-3 */
gen rank = "High" if normalized > 1.5
replace rank = "Low" if normalized < -1.5
replace rank = "Average" if normalized < 1.5 & normalized > -1.5

/* 5-1 */
ttest score, by(hispanic)

/* 5-2 */
tabulate score, teacher, chi2
