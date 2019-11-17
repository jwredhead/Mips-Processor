PIC_LD=ld

ARCHIVE_OBJS=
ARCHIVE_OBJS += _141696_archive_1.so
_141696_archive_1.so : archive.9/_141696_archive_1.a
	@$(AR) -s $<
	@$(PIC_LD) -shared  -o .//../simv.daidir//_141696_archive_1.so --whole-archive $< --no-whole-archive
	@rm -f $@
	@ln -sf .//../simv.daidir//_141696_archive_1.so $@


ARCHIVE_OBJS += _prev_archive_1.so
_prev_archive_1.so : archive.9/_prev_archive_1.a
	@$(AR) -s $<
	@$(PIC_LD) -shared  -o .//../simv.daidir//_prev_archive_1.so --whole-archive $< --no-whole-archive
	@rm -f $@
	@ln -sf .//../simv.daidir//_prev_archive_1.so $@



VCS_ARC0 =_csrc0.so

VCS_OBJS0 =objs/amcQw_d.o 



%.o: %.c
	$(CC_CG) $(CFLAGS_CG) -c -o $@ $<

$(VCS_ARC0) : $(VCS_OBJS0)
	$(PIC_LD) -shared  -o .//../simv.daidir//$(VCS_ARC0) $(VCS_OBJS0)
	rm -f $(VCS_ARC0)
	@ln -sf .//../simv.daidir//$(VCS_ARC0) $(VCS_ARC0)

CU_UDP_OBJS = \
objs/udps/NbR7Z.o objs/udps/LLJ5Z.o objs/udps/cbM8b.o objs/udps/I0u4R.o objs/udps/K7iI9.o  \
objs/udps/rFcCA.o objs/udps/JC4Kr.o objs/udps/mBC1t.o objs/udps/IKyEG.o objs/udps/z3S5t.o  \
objs/udps/CpDPW.o objs/udps/vmbYn.o objs/udps/ecJ0S.o objs/udps/cpUzV.o objs/udps/z2Ghv.o  \
objs/udps/ITCe7.o objs/udps/qJW2v.o objs/udps/xNj1Y.o objs/udps/JZx86.o objs/udps/G2Kqc.o  \
objs/udps/kFWHT.o objs/udps/ha6a0.o objs/udps/CacUe.o objs/udps/nyyMk.o objs/udps/h2WbZ.o  \
objs/udps/b3bnm.o 

CU_LVL_OBJS = \
SIM_l.o 

MAIN_OBJS = \


CU_OBJS = $(MAIN_OBJS) $(ARCHIVE_OBJS) $(VCS_ARC0) $(CU_UDP_OBJS) $(CU_LVL_OBJS)

