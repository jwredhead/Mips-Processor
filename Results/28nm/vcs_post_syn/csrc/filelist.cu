PIC_LD=ld

ARCHIVE_OBJS=
ARCHIVE_OBJS += _1205_archive_1.so
_1205_archive_1.so : archive.2/_1205_archive_1.a
	@$(AR) -s $<
	@$(PIC_LD) -shared  -o .//../simv.daidir//_1205_archive_1.so --whole-archive $< --no-whole-archive
	@rm -f $@
	@ln -sf .//../simv.daidir//_1205_archive_1.so $@


ARCHIVE_OBJS += _prev_archive_1.so
_prev_archive_1.so : archive.2/_prev_archive_1.a
	@$(AR) -s $<
	@$(PIC_LD) -shared  -o .//../simv.daidir//_prev_archive_1.so --whole-archive $< --no-whole-archive
	@rm -f $@
	@ln -sf .//../simv.daidir//_prev_archive_1.so $@



VCS_ARC0 =_csrc0.so

VCS_OBJS0 =objs/a/amcQw_d.o 



%.o: %.c
	$(CC_CG) $(CFLAGS_CG) -c -o $@ $<

$(VCS_ARC0) : $(VCS_OBJS0)
	$(PIC_LD) -shared  -o .//../simv.daidir//$(VCS_ARC0) $(VCS_OBJS0)
	rm -f $(VCS_ARC0)
	@ln -sf .//../simv.daidir//$(VCS_ARC0) $(VCS_ARC0)

CU_UDP_OBJS = \
objs/udps/JgPNT.o objs/udps/eAW1F.o objs/udps/Y9h1d.o objs/udps/aBrjq.o objs/udps/qUKec.o  \
objs/udps/v17TT.o objs/udps/WJG2Y.o objs/udps/PhkAb.o objs/udps/c09Aa.o objs/udps/hFH2J.o  \
objs/udps/UccnW.o objs/udps/y4a7N.o objs/udps/cdUtU.o objs/udps/qIhZj.o objs/udps/Nsp79.o  \
objs/udps/IvISp.o objs/udps/Z0GwU.o objs/udps/mTxzr.o objs/udps/p67Zp.o objs/udps/LSJP2.o  \
objs/udps/GuLzc.o objs/udps/SUeu0.o objs/udps/pNeY8.o objs/udps/Gjg4Z.o objs/udps/m9acZ.o  \
objs/udps/F8h38.o objs/udps/UD227.o objs/udps/uQ6gx.o objs/udps/qTbGp.o objs/udps/hg6Rm.o  \
objs/udps/TUgSV.o objs/udps/uNh9C.o objs/udps/nH2AU.o objs/udps/ScI2G.o objs/udps/t6H9V.o  \
objs/udps/eZijI.o objs/udps/JIUcK.o objs/udps/ajvLe.o objs/udps/W7e2i.o objs/udps/kBv7Y.o  \
objs/udps/TFYxL.o objs/udps/Eaw85.o objs/udps/cfY91.o objs/udps/u96GI.o objs/udps/ysDG2.o  \
objs/udps/rEMb1.o objs/udps/E3u6e.o objs/udps/z87aW.o objs/udps/tCVaR.o objs/udps/jwWjN.o  \
objs/udps/zieZ3.o objs/udps/tPmZh.o objs/udps/HNcdd.o objs/udps/id6Mc.o objs/udps/ZycYe.o  \
objs/udps/JzzcM.o objs/udps/K0FAD.o objs/udps/vYf51.o objs/udps/sBVUP.o objs/udps/LS66s.o  \
objs/udps/Aw1WF.o objs/udps/UxIwk.o objs/udps/Hz6M0.o objs/udps/YffJQ.o objs/udps/c8ZbZ.o  \
objs/udps/Z0bgF.o objs/udps/KQQ1H.o objs/udps/BcyNP.o objs/udps/CZfJ6.o objs/udps/mSfbM.o  \
objs/udps/Ux6u8.o objs/udps/e37Qb.o 

CU_LVL_OBJS = \
SIM_l.o 

MAIN_OBJS = \


CU_OBJS = $(MAIN_OBJS) $(ARCHIVE_OBJS) $(VCS_ARC0) $(CU_UDP_OBJS) $(CU_LVL_OBJS)

