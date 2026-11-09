Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794234212;
	b=IQEPTTmsF17Q0gV3nAS9VbkLxFNOmJF63HG9VhbTTdELMNrYNFlsOFQPv8nKl0xAJHpW
	 Pzj/Cmi4q+zijJ/V77dS7zRJ2MI/ySjW/Ea7dQYJpgTZvU9TxcoRQ3eRxfhG1ToT5P9OB
	 j6NbgpdME+R6nJvIzvbNRIdBq1p4mmPo9yiYzWGFhSx1s/6IUkprX9NqJfYZNcH5eALeV
	 /EszaNzkaDA9DDjay+FJEB2gAAoAG3GMe73jZTBLD8wUVlTTVjYRVNKGtQsENRRxkq2CQ
	 RCQYSfJEfTIdFaD+o0WjZ3/RH4M2JPalLJ2r/SQ4Vqd7DKTNaSNOxyWwcBjPbiO9DnQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794234212;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=e7wMXRUxOI6P4BY9HTco35pqpbkYeRSM4UFbAhX/OAo=;
	b=eYArKWkrryjPFfG1DaYZZ8tao6BnIkR0zuGyyZDG8L8kI/SZv6AFDYfHHjCLIQlFazrN
	 45OzVgYzsx/Pa2PR1mCsjHIlsWRqu9bBN1URJrtYDl0Rl6JiEjzHc3wk2qe/FoBVLw8p+
	 PVMBzMkmQpMZgOS/NLGq+FZcgYyaOJjr5miDv1gtQOzrsqmMy442vOn9XqsAWv+r4JmqL
	 kMWDYVnKRAzN2EF2Jm2eEcBx1nK04iC6KEeDoESR8xm1rupTXqgxsRrWAFkuTLR+izPhc
	 ufvtnPrVgVPb1hhZIbvvdkjW8VgrUUR8sbyxwfcRr5iCScCoRO3Renb7JTxJSIau9oQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="dk6kbo9/";
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91ACC606A321;
	Mon,  9 Nov 2026 14:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dk6kbo9/
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794234212;
	b=Aw0iG92Taa6fsrZ0Se+t/3vsiwstu3FbBsm9t0zli2SCDDF7SGy4ncAwMSx4SvrXMFER
	 HH7TBxv06qZT1QSOaJgrjpDxGeg/ZatJNd0Fkh+zNKwdJAqQsac3BeKSglDTHUp3CsQzW
	 bQ7+60iaC/0P+73Z1ROMhtES5NoZf23svcTid9/aCG8gQbcU6RXAjvrc7Iggfzn7+mD2G
	 HtXzGtWoCEwtP0pql7RUKVv7+hGyDYJ7gBVaWMwHmxasIN6xl/BbnNhRw06Lic1ZLIABm
	 MnAusnCXdxXujosPP05MzL8Gw7dDB7jGV4q9ACQtgz8AA3nFouqm4LEi0MJq3eQ64ug==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794234212;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=e7wMXRUxOI6P4BY9HTco35pqpbkYeRSM4UFbAhX/OAo=;
	b=STxYNyQ87K2XwEA6/b4S8JGyxi9TLsxCEgJDJhSXQhppPbZk+Xh677YrZPZCzgn4tzQl
	 u/1H7EtBInKwKqSvQ05nPB5U7/oHHT3pKMAK8uE++mUqzVhbrLahV+P7alqSy6ZCOlUyg
	 H7PMy1D4w3zae7Uu9EjwNKkxrvOjrTob9wOobfsXveUJq3klJnnh1nMc5GLruxJ+olSdx
	 Db4ad+CHn6ZsFSwDp2TgkBGp/BEmyfpiSqQ/cXUiaruD0DcufV1ZkoBwh4IW59gKTak3m
	 +HzdkuoeYll6xPKuocwxy4vlhIwvXL4/q2BVaNPVbPzRFPr8Xb5ZxiGmu4hzdy2h5Ag==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id B77451F0089F;
	Mon,  9 Nov 2026 14:23:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794234212;
	bh=e7wMXRUxOI6P4BY9HTco35pqpbkYeRSM4UFbAhX/OAo=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=dk6kbo9/hsgUnmF5v7GXb4sSJtesEW7T/IZ3C0iFVUQwmvobaIyuPEp3LMAzYQlSD
	 XjiMMS0QnVUeHAy2zihT5e/4gGPL8nKUv/0jZgMhyPJgSxXBfAmUBsnlWcth4xsx/Y
	 7zurHD2uVjHo4GS0ozf7lr+Lbukj5YiuacwmzLU0ScFX3igiI/26MtPWiWxkcqzNiD
	 YQ418TEiV9PCarMw9Kyp7XsAK/jd2G+agKPi0azU2tKi7JHgvf4hyRI+7zJ6V+uOcB
	 y5nFCezeNO7lL+aqpBoDh8OpoQVPpF3VApZnVwZzIH5WcDb6gxjKQ/NlwC3y1KWhOy
	 IDAggr+DqurFg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 4630C484F6;
	Mon,  9 Nov 2026 14:23:31 +0000 (UTC)
From: Alireza Haddadi via B4 Relay <devnull+alireza.haddadi.it.uu.se@kernel.org>
Date: Mon, 09 Nov 2026 15:23:24 +0100
Subject: [PATCH] mm/filemap: let sequential faults restart mmap readahead
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261109-mmap-miss-v1-1-8b44b33f3358@it.uu.se>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzNDQwML3dzcxALd3MziYt2kNNNEUwOgmEVqkhJQfUFRalpmBdis6NjaWgB
 ICNwhWwAAAA==
X-Change-ID: 20261108-mmap-miss-bf5a501088eb
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
 Jan Kara <jack@suse.cz>, Andrew Morton <akpm@linux-foundation.org>, 
 Vishal Moola <vishal.moola@gmail.com>, fujunjie <fujunjie1@qq.com>
Cc: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, Alireza Haddadi <alireza.haddadi@it.uu.se>, 
 Roman Gushchin <roman.gushchin@linux.dev>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794234210; l=6499;
 i=alireza.haddadi@it.uu.se; s=20261109; h=from:subject:message-id;
 bh=VesPRu4IT/ZtoA3aVaKTwKE/1K7QAS1jhjR+g2t6EGk=;
 b=Sy7KY/luAQ5Aohpe/Z/EdT8wc3l94GWWHUgSNGSFsVIL63SJOdCymXf/zizlciRttGQrO8eZW
 QildE77yaXXDKJY58RkrHHDCcxJV9LG1Qmi8uh3KQ4O3K/+lJ6jKbF+
X-Developer-Key: i=alireza.haddadi@it.uu.se; a=ed25519;
 pk=xbyB5yIjo8Ef+o8CJo4XbAn95znJPGlxM66RW0Y71Wk=
X-Endpoint-Received: by B4 Relay for alireza.haddadi@it.uu.se/20261109 with
 auth_id=1460
X-Original-From: Alireza Haddadi <alireza.haddadi@it.uu.se>
Reply-To: alireza.haddadi@it.uu.se
Content-Transfer-Encoding: 7bit

From: Alireza Haddadi <alireza.haddadi@it.uu.se>

After commit 0b9c0aeba938 ("mm/filemap: count only the faulting address
as a mmap hit"), once a file's mmap_miss goes over MMAP_LOTSAMISS it can
stay there until the file is closed.

With mmap_miss over the limit, do_sync_mmap_readahead() reads only the
page that faulted. Since nothing gets read ahead, no later fault can
land on a page that readahead brought in. In turn filemap_map_pages()
never counts a hit, and the counter never comes back down. From then
on every fault on the file reads only a single page, even when the
access has become sequential.

I ran into this on v7.3 with llama.cpp, where a model larger than its
memory limit sometimes ended up being read 4 KiB at a time, but other
programs hit it as well. Anything that does some random reads and then
reads the same open file in order faces the same problem. I tested the
following:

 - SQLite with mmap_size set, 300 random lookups followed by a full scan
   of a 1.8 GiB table. The scan took 9.3-14.2 s instead of 2.1 s in 8 of
   10 runs.

 - numpy.memmap, 1000 random rows sampled from the first 75% of a 4 GiB
   array and then the last 25% read sequentially, as a training and
   evaluation loop would do. The sequential part took 3.3 s instead of
   0.3 s in 5 of 5 runs.

Give a sequential reader a way back. When readahead is off and the page
before the faulting one is in the page cache, read the next page too
and mark it with PG_readahead. A sequential reader faults on that page
next, which starts async readahead. That path is not gated by mmap_miss,
and the pages it brings in count as hits again, so the counter drops
and readahead resumes. A random reader, however, rarely has the previous
page cached, so it keeps reading one page per fault, or at most two.
Forced THP readahead is left as it is.

This reproducer takes 100 random faults on a file of at least 4 GiB
and then reads 1 GiB of it in order:

	#define _GNU_SOURCE
	#include <fcntl.h>
	#include <stdio.h>
	#include <stdlib.h>
	#include <unistd.h>
	#include <sys/mman.h>
	#include <sys/resource.h>

	/* ./a.out FILE N: N random faults, then read 1 GiB in order */
	int main(int argc, char **argv)
	{
		long G = 1L << 30, i, flt, size;
		struct rusage ru;
		volatile char *p;
		int fd;

		if (argc != 3 || (fd = open(argv[1], O_RDONLY)) < 0)
			return 2;
		size = lseek(fd, 0, SEEK_END);
		posix_fadvise(fd, 0, 0, POSIX_FADV_DONTNEED);
		p = mmap(NULL, size, PROT_READ, MAP_SHARED, fd, 0);

		/* N random faults beyond 3 GiB */
		for (i = 0; i < atol(argv[2]); i++)
			p[3 * G + random() % (size - 3 * G) / 4096 * 4096];

		/* then read [2 GiB, 3 GiB) in order */
		getrusage(RUSAGE_SELF, &ru);
		flt = ru.ru_majflt;
		for (i = 2 * G; i < 3 * G; i += 4096)
			p[i];
		getrusage(RUSAGE_SELF, &ru);
		printf("%ld major faults for %ld pages\n",
		       ru.ru_majflt - flt, G / 4096);
		return 0;
	}

	$ ./a.out FILE 100
	before: 262144 major faults for 262144 pages
	after:       2 major faults for 262144 pages

I also ran the access patterns from that commit's changelog (random,
strides of 1021, 1024, 2053, and 4099 pages, and sequential, on a
20 GiB and a 4 GiB file in an 8 GiB guest). With this change, bytes
read stay within 0.1% and times within 3% in all cases, so its gains
are kept.

Fixes: 0b9c0aeba938 ("mm/filemap: count only the faulting address as a mmap hit")
Signed-off-by: Alireza Haddadi <alireza.haddadi@it.uu.se>
Cc: fujunjie <fujunjie1@qq.com>
Cc: Jan Kara <jack@suse.cz>
Cc: Vishal Moola <vishal.moola@gmail.com>
Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: Roman Gushchin <roman.gushchin@linux.dev>
---
Tested on mm-new (x86-64):

 - With the patch, no run gets stuck: the SQLite scan (10 runs) and
   the numpy pass (5 runs) take as long as their controls.
 - mm selftests: no new failures. droppable fails about once in 20
   runs, with and without this patch.
 - A KVM guest with KASAN, lockdep and DEBUG_VM ran the reproducer
   above, strided and interleaved access, and a 4-thread test: after
   200 random faults, 4 threads read the same file in order through
   one mapping, so they all take the new path at once; the file is
   twice the guest's memory, so this runs under reclaim. No reports,
   with or without the patch.
 - W=1 and sparse are clean, also with THP or LRU_GEN disabled.

The cost for random readers, once readahead is off: when every third
page is cached and each access lands just after a cached page, 1.77
pages are read per access instead of 0.89. Strided access reads the
same as before.

Forced THP readahead has a similar problem with mmap_miss. I left it
out to keep this change small and will look at it separately.

I can share the benchmark scripts (SQLite, numpy, the access patterns
of 0b9c0aeba938) if that helps.
---
 mm/filemap.c | 27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 93db8fc60ae0..0930aacee9fe 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -3403,8 +3403,33 @@ static struct file *do_sync_mmap_readahead(struct vm_fault *vmf)
 		 * Do we miss much more than hit in this file? If so,
 		 * stop bothering with read-ahead. It will only hurt.
 		 */
-		if (mmap_miss > MMAP_LOTSAMISS)
+		if (mmap_miss > MMAP_LOTSAMISS) {
+			struct folio *prev = NULL;
+
+			/*
+			 * Nothing is read ahead now, so mmap_miss stays high
+			 * forever.  If the previous page is cached, this may be
+			 * a sequential read: read the next page as well and
+			 * mark it, so that async readahead, which does not
+			 * check mmap_miss, restarts when the mark is hit.  The
+			 * pages it reads then count as hits and lower
+			 * mmap_miss.  A random reader rarely has the previous
+			 * page cached and keeps reading one page per fault.
+			 */
+			if (!force_thp_readahead && vmf->pgoff)
+				prev = xa_load(&mapping->i_pages,
+					       vmf->pgoff - 1);
+			if (prev && !xa_is_value(prev)) {
+				fpin = maybe_unlock_mmap_for_io(vmf, fpin);
+				ra->start = vmf->pgoff;
+				ra->size = 2;
+				ra->async_size = 1;
+				ra->order = 0;
+				ractl._index = ra->start;
+				page_cache_ra_order(&ractl, ra);
+			}
 			return fpin;
+		}
 	}
 
 	if (force_thp_readahead) {

---
base-commit: b95f8bb86713c860ce8536d22a988b949b884d5f
change-id: 20261108-mmap-miss-bf5a501088eb

Best regards,
--  
Alireza Haddadi <alireza.haddadi@it.uu.se>


