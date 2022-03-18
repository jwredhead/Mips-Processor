// file = 0; split type = patterns; threshold = 100000; total count = 0.
#include <stdio.h>
#include <stdlib.h>
#include <strings.h>
#include "rmapats.h"

void  hsG_0__0 (struct dummyq_struct * I1210, EBLK  * I1204, U  I670);
void  hsG_0__0 (struct dummyq_struct * I1210, EBLK  * I1204, U  I670)
{
    U  I1460;
    U  I1461;
    U  I1462;
    struct futq * I1463;
    struct dummyq_struct * pQ = I1210;
    I1460 = ((U )vcs_clocks) + I670;
    I1462 = I1460 & ((1 << fHashTableSize) - 1);
    I1204->I722 = (EBLK  *)(-1);
    I1204->I726 = I1460;
    if (I1460 < (U )vcs_clocks) {
        I1461 = ((U  *)&vcs_clocks)[1];
        sched_millenium(pQ, I1204, I1461 + 1, I1460);
    }
    else if ((peblkFutQ1Head != ((void *)0)) && (I670 == 1)) {
        I1204->I728 = (struct eblk *)peblkFutQ1Tail;
        peblkFutQ1Tail->I722 = I1204;
        peblkFutQ1Tail = I1204;
    }
    else if ((I1463 = pQ->I1115[I1462].I740)) {
        I1204->I728 = (struct eblk *)I1463->I739;
        I1463->I739->I722 = (RP )I1204;
        I1463->I739 = (RmaEblk  *)I1204;
    }
    else {
        sched_hsopt(pQ, I1204, I1460);
    }
}
#ifdef __cplusplus
extern "C" {
#endif
void SinitHsimPats(void);
#ifdef __cplusplus
}
#endif
