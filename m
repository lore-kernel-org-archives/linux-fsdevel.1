Received: from outgoing2021.csail.mit.edu (outgoing2021.csail.mit.edu [128.30.2.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E0582E62B7;
	Sat, 17 Oct 2026 03:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=128.30.2.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792208868; cv=none; b=hKLiVbN26BF5l6eCplN9EZ/vlEkYz2+u+qx6cMU0Btp0dqPT8zDLWIfRoPW+Muju1imfPTZQlbFkEMJQOoc+MSCyCJ8wWcNA0cN6wQ9V3DbCAWZwSHYPaFw8CfBvdP4gQvEfoF2Ly54o5wr4WgOCaRuVkzBt38Odv/7AoZTdkZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792208868; c=relaxed/simple;
	bh=jS2WQmeVsBQvwfgeYGMlFoJ2QBJJO8EwOJG0aPMBSIs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=swDL2f3CfBLbmXaJzu6W/U0+dFiZRp+sbm2+65hdFOOtzuBg9MGeBI+QkYDI3mT/1AZd3LOJ2sSCWVWBDTUHtza6qvtT1ePyM0zVf3UZ7WOA/eSi4MhDjnB3B+9rVw/nZ3O/klV4X4GMTZgk/BKYJ2QF074pjaiPPcaWYLxBMt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=csail.mit.edu; spf=pass smtp.mailfrom=csail.mit.edu; arc=none smtp.client-ip=128.30.2.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=csail.mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csail.mit.edu
Received: from escalante.csail.mit.edu ([128.52.128.198])
	by outgoing2021.csail.mit.edu with esmtp (Exim 4.95)
	(envelope-from <nickolai@csail.mit.edu>)
	id 1xHvOV-000755-CI;
	Fri, 16 Oct 2026 23:47:39 -0400
From: Nickolai Zeldovich <nickolai@csail.mit.edu>
To: Omar Sandoval <osandov@osandov.com>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
	Baoquan He <baoquan.he@linux.dev>,
	linux-debuggers@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Nickolai Zeldovich <nickolai@csail.mit.edu>
Subject: [PATCH v1] proc/kcore: advance the vmalloc retry by the last copy, not the total
Date: Fri, 16 Oct 2026 23:47:39 -0400
Message-ID: <20261017034739.793431-1-nickolai@csail.mit.edu>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A readv() or preadv() of /proc/kcore fails with EFAULT, although every
byte of the destination is writable, when the page of a later iovec is
not present at the moment the copy of a KCORE_VMALLOC chunk is retried:
swapped out, migrated by compaction or NUMA balancing, write-protected
by KSM, or unmapped by MADV_DONTNEED from another thread. Only root can
read /proc/kcore, and the read must use more than one iovec. On an
x86_64 defconfig kernel (v7.3-rc7) a preadv() of one vmalloc page into
two 2 KiB iovecs on separate pages, with a second thread repeatedly
unmapping the second page, failed 77701 of 200000 calls with EFAULT;
with the fix all 200000 succeed. Affected since v6.4.

read_kcore_iter() copies a KCORE_VMALLOC chunk with vread_iter(), which
writes to the user buffer with page faults disabled and stops at the
first iovec whose page is absent, after the earlier iovecs were
written; the loop then faults the rest of the buffer in and calls
vread_iter() again for what is left. It keeps the running total in
`read` and advances the source address and the remaining length by that
total:

	read += vread_iter(iter, src, left);
	if (read == tsz)
		break;
	src += read;
	left -= read;

In the reproducer the first call copies the 2048 bytes of the first
iovec and stops at the second: read is 2048, and src and left move by
2048, which is right. The page that fault_in_iov_iter_writeable() then
faults in is unmapped again before the second call, which copies 0
bytes: read is still 2048, but src moves by another 2048 to the end of
the chunk and left drops to 0. The third call has nothing to copy, src
moves by 2048 once more, left wraps around, and
fault_in_iov_iter_writeable() fails on that length, so the read returns
-EFAULT. When both short copies are non-zero (three or more iovecs) the
extra call also copies bytes from the wrong offset of the page into the
buffer before the failure. A single iovec is not affected: its nofault
copy is all or nothing, so a short copy is always empty and the advance
by the total is still the advance by the last copy.

Keep the return value of each vread_iter() call and advance src and
left by that; `read` stays the running total compared with tsz.

Found while formally verifying vread_iter() against the kernel binary.

Fixes: 4c91c07c93bb ("mm: vmalloc: convert vread() to vread_iter()")
Assisted-by: LLM
Signed-off-by: Nickolai Zeldovich <nickolai@csail.mit.edu>
---

Notes:
    With a single iovec the destination of each vread_iter() call is one
    copy_to_user_nofault() per source page, which copies all or nothing, so a
    plain read()/pread() can only see a zero-length short copy and never hits
    the second-short case; readv()/preadv() with several iovecs does, since
    the nofault copy stops at the first iovec whose page is absent after the
    earlier ones were written. The EFAULT is the same for any reason the
    destination page is absent at the retry (swap, migration by compaction or
    NUMA balancing, KSM write protection).
    
    The loop cannot return a full count with wrong data: once left wraps,
    fault_in_iov_iter_writeable() fails before any further copy, and read ==
    tsz is only reached when every short copy but the last was empty, in which
    case advancing by the total is advancing by the last copy. With three or
    more iovecs and two non-empty short copies the extra call copies bytes
    from the wrong offset of the same page into the buffer, but the read still
    fails with EFAULT.
    
    Reproducer (x86_64 defconfig, root, QEMU -smp 2; the second thread keeps
    the second iovec's page unmapped):
    
      gcc -O2 -pthread -static -o kcore_readv_retry_short kcore_readv_retry_short.c
      ./kcore_readv_retry_short
      before: ok 122299 EFAULT 77701      (exit 1)
      after:  ok 200000 EFAULT 0          (exit 0)
    
      /* preadv() of one vmalloc page from /proc/kcore into two iovecs while a
       * thread keeps unmapping the second iovec's page; root, CONFIG_PROC_KCORE */
      #define _GNU_SOURCE
      #include <elf.h>
      #include <errno.h>
      #include <fcntl.h>
      #include <pthread.h>
      #include <stdio.h>
      #include <stdlib.h>
      #include <string.h>
      #include <sys/mman.h>
      #include <sys/uio.h>
      #include <unistd.h>
    
      #define PG 4096UL
      static volatile int stop;
      static char *zap_page;
    
      static void *zapper(void *arg)
      {
      	while (!stop)
      		madvise(zap_page, PG, MADV_DONTNEED);
      	return NULL;
      }
    
      int main(void)
      {
      	int fd = open("/proc/kcore", O_RDONLY), i, best = -1;
      	long efault = 0, ok = 0;
      	Elf64_Ehdr eh;
      	Elf64_Phdr *ph;
      	off_t off;
      	unsigned long a;
      	char *buf = mmap(NULL, 2 * PG, PROT_READ | PROT_WRITE,
      			 MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
      	char *ref = malloc(PG);
      	struct iovec iov[2] = { { buf, PG / 2 }, { buf + PG, PG / 2 } };
      	pthread_t th;
    
      	if (pread(fd, &eh, sizeof(eh), 0) != sizeof(eh))
      		return 2;
      	ph = calloc(eh.e_phnum, sizeof(*ph));
      	if (pread(fd, ph, eh.e_phnum * sizeof(*ph), eh.e_phoff) < 0)
      		return 2;
      	for (i = 0; i < eh.e_phnum; i++)	/* vmalloc = largest non-RAM segment */
      		if (ph[i].p_type == PT_LOAD && ph[i].p_paddr == (Elf64_Addr)-1 &&
      		    (best < 0 || ph[i].p_memsz > ph[best].p_memsz))
      			best = i;
      	for (a = 0; ; a += PG) {		/* first page with live content */
      		if (pread(fd, ref, PG, ph[best].p_offset + a) != (ssize_t)PG)
      			continue;
      		for (i = 0; i < PG && !ref[i]; i++)
      			;
      		if (i < PG)
      			break;
      	}
      	off = ph[best].p_offset + a;
      	zap_page = buf + PG;
      	pthread_create(&th, NULL, zapper, NULL);
      	for (i = 0; i < 200000; i++) {
      		if (preadv(fd, iov, 2, off) == (ssize_t)PG)
      			ok++;
      		else if (errno == EFAULT)
      			efault++;
      	}
      	stop = 1;
      	pthread_join(th, NULL);
      	printf("ok %ld EFAULT %ld\n", ok, efault);
      	return efault != 0;
      }

 fs/proc/kcore.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/fs/proc/kcore.c b/fs/proc/kcore.c
index 390547b992ac..3264c99bd68a 100644
--- a/fs/proc/kcore.c
+++ b/fs/proc/kcore.c
@@ -531,12 +531,14 @@ static ssize_t read_kcore_iter(struct kiocb *iocb, struct iov_iter *iter)
 			 * again until we are done.
 			 */
 			while (true) {
-				read += vread_iter(iter, src, left);
+				size_t n = vread_iter(iter, src, left);
+
+				read += n;
 				if (read == tsz)
 					break;
 
-				src += read;
-				left -= read;
+				src += n;
+				left -= n;
 
 				if (fault_in_iov_iter_writeable(iter, left)) {
 					ret = -EFAULT;

base-commit: 70dd4ee72eb2d5793c62e71c14e3aba78e5a4e56
-- 
2.53.0

