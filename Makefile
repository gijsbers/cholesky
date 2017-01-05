TARGETS    = single symposdef decompose decompose2
DEPS       = 
SNETC	   = snetc
SNETCFLAGS = -v1 -g -lm -O3 -q -distrib nodist -threading front
CLEANS     = 
CFLAGS     = -Wall -g -O3

.PRECIOUS: single symposdef

targets: $(TARGETS)

opt:
	$(CC) $(CFLAGS) -O3 single.c -o single-opt -lm
	$(CC) $(CFLAGS) -O3 symposdef.c -o symposdef-opt -lm

single: single.c tags
	$(CC) $(CFLAGS) -o $@ $< -lm
	./$@

symposdef: symposdef.c tags
	$(CC) $(CFLAGS) -o $@ $< -lm
	./$@

decompose: decompose.snet deboxes.o
	$(SNETC) $(SNETCFLAGS) $^ -o $@

decompose2: decompose2.snet deboxes.o
	$(SNETC) $(SNETCFLAGS) $^ -o $@

deboxes.o: deboxes.c
	$(CC) $(CFLAGS) -c -I$(SNET_INCLUDES) $<

tags: single.c symposdef.c deboxes.c
	ctags $^

clean:
	$(RM) $(RMFLAGS) -- *.o *.a *.lo *.la *.Plo $(TARGETS) core vgcore.*
	$(RM) $(RMFLAGS) -- $(patsubst %.snet,%.[ch],decompose.snet decompose2.snet)

