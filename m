Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794215469;
	b=b+u6K6KaVt/v0gIfUXQOOBTmwzuMZGeZ3ptQ/GMB897HK68K/GTlCStjwZpXx778Oj5Z
	 ZjiFR9HR/ZxuVuWc/6F4qcp4tqNkWhHRJZkROFDc7zfuPZvTlYLLu84Yx+BlxMH3K9yQH
	 cDugRly3qc2YUMYFPQWy8Bcq4648A9TOPsONKcEs/2lWrztASO/oF18lazBxPVq2oJeqC
	 S2xyriEOk2KQo9jepKK4BKhRDiTTeZpr9IQ9IWc1MhQ39BLfP7Ejt1p2fXaeRiGGgGs5F
	 a+ddtsGXlr5gat7mckAOcAvO1Mn15AF957iRr3rFSnLsCgDqcMp6nQBkzV4xBUVZlJQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794215469;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:X-B4-Tracking:To:Cc:
	 X-Mailer;
	bh=ceETPs2UDE7IxIJ30l+uzPMCZetkCltzW9DlghrZCVE=;
	b=bAucF14WuJ0hdAmijaJXdRR0rHkkD1hWMPfHq9GgclhGAIq3+r7jlnpXtz101t17Vq4D
	 lHvZwH9HjBefflpWx2aQFiXiWhAbPBizqQsNsYWbQWa2Uc/lJFkwbLgbTic78Nsad7fgk
	 rX+WepboRYeVJvCHSMd+b4VkoEPCw4r+Qq7RvKAATaj3F5LtiTpYUxRaXhvXu5nqMSo21
	 80wipxzOWVIaRw6nDwnQ2INLLw33GyKxh6Qv7+CHlBYmMHxnm5ATdapuap4pRHhJ5GVjX
	 QFZxfRMrA5J6guQIL+WxUwbR6o10DC9xtME5x8+wmJe3Q09R43vwX7rRMeg8VXCfulg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=aeYA9o7I;
	arc=none smtp.remote-ip=91.218.175.4
Received: from mta0.migadu.com (out-4.mta0.migadu.com [91.218.175.4])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A48A6606A321
	for <linux-fsdevel@vger.kernel.org>; Mon,  9 Nov 2026 09:11:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A48A6606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=aeYA9o7I
X-Envelope-To: linux-fsdevel@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=WUpuYALlic5UCEqO8xHXvlvF5G6I45TQIvrJRccV9iY=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794215465; v=1; x=1794820265;
 b=aeYA9o7IOM94e2cddbedQ0jaEEsGvDhlYUHbUfwWiOOH9ry/IOxTxIS/0F3pD1frKABfbmO8
 tv7wXc7yWTWMdQkPwj3fxNY6evbj2c/01Xsy8kTbwlVxbErsBoYttk3lmIdsifCb4nBVyJwvvUS
 04QCLOxvVk7Lkagrou1LA3Ks=
X-Envelope-To: linux-fsdevel@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id f507b16f9208fe5c;
	Mon, 09 Nov 2026 09:11:05 +0000
X-Mizu-Trace-ID: f507b16f9208fe5c
X-Migadu-Flow: FLOW_OUT
From: Qiliang Yuan <qiliang.yuan@linux.dev>
Date: Mon, 09 Nov 2026 04:10:55 -0500
Subject: [PATCH v2] mm/readahead: look two windows ahead for the hole on a
 marker hit
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
Content-Transfer-Encoding: 7bit
Message-Id: <20261109-bug-mm-readahead-async-overtaken-v2-1-06ead50562a2@linux.dev>
X-B4-Tracking: v=1; b=H4sIAB+O8WoC/5WNQQrCMBBFr1Jm7UgzUCmuvId0MUmmbdAkktRgK
 b27sTdw8+H9xXsbZElOMlybDZIUl10MFejUgJk5TILOVgZq6aJaItTvCb3HJGx5roOc12AwFkk
 LPySgJjN2WqwwKaiaV5LRfY7Efag8u7zEtB7Fon7vH/KiUKFpO93bXluyfJs8u+fZRA/Dvu9fy
 lw4OdAAAAA=
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
 Jan Kara <jack@suse.cz>, Andrew Morton <akpm@linux-foundation.org>
Cc: Joanne Koong <joannelkoong@gmail.com>, linux-fsdevel@vger.kernel.org, 
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 Qiliang Yuan <qiliang.yuan@linux.dev>
X-Mailer: b4 0.13.0

When a reader hits a folio marked for readahead that the readahead
state does not expect, page_cache_async_ra() starts the next readahead
at the first hole within one window after the folio. If that window is
fully cached, it reads nothing.

memcpy() in glibc loads the end of a large source before copying it
forward, so a loader that copies a file mapping out in pieces of a few
megabytes faults at the end of each piece first. mmap read-around then
reads a window centered on that fault, which reaches more than one
window past the readahead marker the copy has yet to hit. When the copy
reaches the marker, there is no hole within a window, no readahead is
issued, and the next piece faults on its end again. Every piece then
gets a synchronous read-around of order-0 folios, and threads copying
parts of one file also contend on the i_pages lock to insert them. A
copy from offset 0 avoids this as its first read-around is clamped to
the start of the file.

Look up to two windows ahead for the hole, which reaches past such a
read-around, so the reader keeps an asynchronous window and its folio
order keeps ramping up.

Copying a 16 GiB file out of a private mapping with memcpy() in 8 MiB
pieces, read_ahead_kb 8192, cold page cache, 32 vCPU VM, mean of two
runs:

                                  before    after
  1 thread from offset 2 GiB     7.62 s    2.00 s
  8 threads, one range each      3.26 s    1.08 s
  32 threads, one range each     4.05 s    1.34 s

Random touches read the same amount, and pread() copies and copies that
interleave 7 MiB chunks across threads take the same time within
run-to-run noise.

Signed-off-by: Qiliang Yuan <qiliang.yuan@linux.dev>
---
The program below copies FILE out of a mapping in 8 MiB pieces, each
thread taking one range. With a cold page cache, run as "pcopy FILE 1
2048" (one thread starting at 2 GiB) and "pcopy FILE 8" on a 16 GiB file:

                        7be4bc52fd9e    patched
  1 thread from 2 GiB      6.92 s        1.57 s
  8 threads                4.00 s        1.04 s

  /* pcopy FILE THREADS [SKIP_MB]: copy FILE out of a mapping */
  #include <fcntl.h>
  #include <pthread.h>
  #include <stdio.h>
  #include <stdlib.h>
  #include <string.h>
  #include <sys/mman.h>
  #include <sys/stat.h>
  #include <time.h>

  #define PIECE (8UL << 20)

  static char *map;
  static size_t skip, per;

  static void *copy(void *arg)
  {
  	size_t off = skip + (long)arg * per, end = off + per;
  	char *buf = malloc(PIECE);

  	for (; off < end; off += PIECE) {
  		memcpy(buf, map + off, PIECE);
  		asm volatile("" : : "r" (buf) : "memory");
  	}
  	free(buf);
  	return NULL;
  }

  int main(int argc, char **argv)
  {
  	int fd = open(argv[1], O_RDONLY), n = atoi(argv[2]);
  	struct timespec t0, t1;
  	pthread_t th[64];
  	struct stat st;

  	fstat(fd, &st);
  	skip = argc > 3 ? atol(argv[3]) << 20 : 0;
  	per = (st.st_size - skip) / n / PIECE * PIECE;
  	map = mmap(NULL, st.st_size, PROT_READ, MAP_PRIVATE, fd, 0);
  	posix_fadvise(fd, 0, 0, POSIX_FADV_DONTNEED);
  	clock_gettime(CLOCK_MONOTONIC, &t0);
  	for (long i = 0; i < n; i++)
  		pthread_create(&th[i], NULL, copy, (void *)i);
  	for (int i = 0; i < n; i++)
  		pthread_join(th[i], NULL);
  	clock_gettime(CLOCK_MONOTONIC, &t1);
  	printf("%.2f s\n", t1.tv_sec - t0.tv_sec + (t1.tv_nsec - t0.tv_nsec) / 1e9);
  	return 0;
  }
---
V1 -> V2:
- Rebase onto v7.4-rc2, the patch is unchanged; the numbers are from
  the v1 base, mm/readahead.c has not changed since
- Send from my linux.dev address

v1: https://lore.kernel.org/r/20261022-bug-mm-readahead-async-overtaken-v1-1-c05b8d8bd2da@gmail.com
---
 mm/readahead.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/mm/readahead.c b/mm/readahead.c
index 6e5563290287e..d7a511a9fdcbf 100644
--- a/mm/readahead.c
+++ b/mm/readahead.c
@@ -696,12 +696,15 @@ void page_cache_async_ra(struct readahead_control *ractl,
 	 * E.g. interleaved reads.
 	 * Query the pagecache for async_size, which normally equals to
 	 * readahead size. Ramp it up and use it as the new readahead size.
+	 * Look up to two windows ahead: read-around for a fault further on,
+	 * such as from a memcpy() that touches the end of its source first,
+	 * may already have filled the next one.
 	 */
 	rcu_read_lock();
-	start = page_cache_next_miss(ractl->mapping, index + 1, max_pages);
+	start = page_cache_next_miss(ractl->mapping, index + 1, 2 * max_pages);
 	rcu_read_unlock();
 
-	if (!start || start - index > max_pages)
+	if (!start || start - index > 2 * max_pages)
 		return;
 
 	ra->start = start;

---
base-commit: 7475ea8b58616b33c04afb976cf0fbaad9dd63fb
change-id: 20261022-bug-mm-readahead-async-overtaken-b2cf5bedea21

Best regards,
-- 
Qiliang Yuan <qiliang.yuan@linux.dev>

