Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792682681;
	b=xL2kbmacRmRsLmFm/Ss/od4VOTbL+Ac0kgiemFYu3LJs+e0mPesjVwijV17r6exj+l//
	 NxEOn4If29dlRAbY+FU9MYdRT5lBcajG53vJ0QxYUYrDd1smW9MZvD0Xt7uSXyv31PIWS
	 zo9MBRo5xIzACsWi2WNkOwSITqPe4d44VAYOtfq5lwDSN0xLSmdraKtjvtlZpiKq8Yixw
	 z7HWjCGmc4SrWe5uTyTSnKuBi6jpceWga4xepbNf8oQNU/x+RVvYWx2aGlGLhywxvpMsH
	 k94xht+uW5xvID+Kvq1fjIQ6agP2LyCqmX/qtT6b2OEq6uAGdFs9b/2OaiqJmn41izQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792682681;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:X-B4-Tracking:To:Cc:X-Mailer;
	bh=ULgRB/f/0nMMgaVufow+n/zddXTXxzXvwgPanbaVK50=;
	b=qSOjxaXJzTkOr3ZWoolFSe3ih92Z4w0EGPEpnkLunttmiabgsB+gtV6ezqEfP0N0GtQ0
	 yer7CZx9H73J58su/FtP9FyEMPoTrBNUhar2/zCVeH0CuiuV9Pqozc7VqWImuwZGPJ7IR
	 PIzRmsEdqZmhp7m0RUOO/STcxEKmJR1pxzO8a73sOKHeoJkGOF8BorXCQMolZQprX0PSo
	 UWi5qKoYuxfxHbEmkZjQh4S6nM3HLKi7gKK+ouTioqiCgki4AC4VrxI1sTNLN69WRUz6J
	 Y99S4gmM22ShjyA8sQRhTIMPIDpkOidOIk7O7liySsP20lIfvD0g8WLe99RgqakyKEw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=iCZ9Ekr+;
	arc=none smtp.remote-ip=74.125.82.51
Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDB2C606A31A
	for <linux-fsdevel@vger.kernel.org>; Thu, 22 Oct 2026 15:24:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DDB2C606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=iCZ9Ekr+
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-1517bda04a0so2274326c88.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Oct 2026 08:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792682680; x=1793287480; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ULgRB/f/0nMMgaVufow+n/zddXTXxzXvwgPanbaVK50=;
        b=iCZ9Ekr+4ODTg9sNbwPHDffrwMUb0YnY1YblLdZnY4zsGOOSyC2kPtauwrM7wAmkVT
         5lzEnsw7khWX9DWSjEHZeI5Kl2N7WlC5653hh/umA+IKMEQbgXENSqt4yppiJqJmXy0J
         mmqQM9u5e3lI3bM+xSom0Z8pX9uOdcYaPRjy3ZAapFLfQH7MRzvfqSKvfVvXEZWzH2vE
         x1XkwqqzjA1TukLyA2ov3d1YS2vI39I/VmxPAbdAjZA8213oS3FmrOqz/gP0Jnyc/nRm
         Ezqgw4IJihSbM6r8ApjwF6rYjoIfOLspKB8l8mLpa9i8RiwmjVd78GC3ajq6xYaPMOmQ
         fPkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792682680; x=1793287480;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=ULgRB/f/0nMMgaVufow+n/zddXTXxzXvwgPanbaVK50=;
        b=0580JjkJhNI0QG0fd3YIQzyAt9uq/KGqq7oi2tXOiJxaHJ4glcrz8G4Uxy4MT2YFkc
         WcXbK4kB6NkN1K76KkYxMPkUvEB/X6pQfJyRXA2Qguo7e+UGbhZ75zVPhgfVZoviQWWq
         abbdG+Rd/sYwwu1plg9G42usC29q8g3Bvrs5oAUDc2PkGFpij3rJWnetwxgnSWtj000/
         bR7ySqCV3W3pH96lS5XbcXF9V0g7PSYAQuBsXdKSPGXENMKT+X4uy1jcZaekkNXFHNuU
         +Y+mk8PXcq0g9mkP0/DPM/OWNaDvM8qyZhhMHTUzgDql9+RIoXKoRrSXxmOx78pYbz7F
         7QLw==
X-Forwarded-Encrypted: i=1; AKwUvBziAJ/Ril6wk7Pls+tgBq0M56pdDFcI01+6bwFAipqlJAoU8NjNsphNY8LgnvefWcqdKU1DZtPWsGzPAsnU@vger.kernel.org
X-Gm-Message-State: AFq9FYIXPyjPzXQ4xP5iylYBeBeUIoosM6g35tNE+goMEmntPhSzzX+A
	TbrA/lNg5mhFF4BIXZ6/n4+eKU83sK0NL803nF5ptpN8FmBbcsNx0mX8yphR/jkw
X-Gm-Gg: AYBFou2h8WUnFqQ7xSg9YIK5uzJqhBb655VpOM4J9PH/1gLP4lZrzKd2LOLIF/kwJ0u
	xoGTL1lUFva91LWncmZ/iXwH9VDYjr8QohUl0OnODMFekPGIHcxE+xIBuPMS0tHgA6ZqloFKf8L
	r2TPFM5ku8dp0/qa+R40O5W1Tmscx390ZmKmmTUZeaZ4ydSxlVJk3Jec0x9sIkkUZwm8nVBdztO
	g52TZiizPqivD/uGqRKad7UIsPdNAp/vqVDopvBX9jsRr4Qj5fVqzO8X6Q8lKL5LL5UuqM63kfF
	Z17iiYNaGYt2QWyoGbdbYtNP8c41wZ9Np1BxEWWizAXb7hn9ME1LUHdGgpmIVGMwA2X4zYSxUR8
	OvgJrR4q4PIAWQ33HHRCRfrAPCVqvXEMy2QuXdzxiDRrpCpAsy5GUYW+Sw8zsWJDl27pnzfwMRr
	Yz1LQGP90vNvMtC+OJEsAOc9F2X0MaauFlkTK5C+fUSKhPxsCvj0US5nf2dciFid22JXjHXsSKh
	BStRAZ9IjPgenSQ/5BZYJ1sQusUcnI+i7nw6GDW9N4fm7G6xkk=
X-Received: by 2002:a05:701b:418a:20b0:151:7f08:5961 with SMTP id a92af1059eb24-190a03341d1mr7652600c88.4.1792682679689;
        Thu, 22 Oct 2026 08:24:39 -0700 (PDT)
Received: from [127.0.1.1] ([23.254.208.9])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1903a180ca2sm13984187c88.6.2026.10.22.08.24.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 08:24:39 -0700 (PDT)
From: Qiliang Yuan <odys.yuan@gmail.com>
Date: Thu, 22 Oct 2026 23:24:33 +0800
Subject: [PATCH] mm/readahead: look two windows ahead for the hole on a
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
Message-Id: <20261022-bug-mm-readahead-async-overtaken-v1-1-c05b8d8bd2da@gmail.com>
X-B4-Tracking: v=1; b=H4sIALEq2moC/x2NwQqDMBAFf0X23AWz0B78ldLDJnnqIsayaaVF/
 PeGXgbmMnNQhRsqDd1Bjt2qbaVJuHSUZi0T2HJzkl5uoRfh+J54XdmhWecG1votibcd/tIFhaO
 k8RqRoRKoZZ6O0T7/xf1xnj+OvnebcgAAAA==
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
 Jan Kara <jack@suse.cz>, Andrew Morton <akpm@linux-foundation.org>
Cc: Joanne Koong <joannelkoong@gmail.com>, linux-fsdevel@vger.kernel.org, 
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 Qiliang Yuan <odys.yuan@gmail.com>
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

Signed-off-by: Qiliang Yuan <odys.yuan@gmail.com>
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
base-commit: 7be4bc52fd9e0e55dc9a2e0232b89427d2c4b614
change-id: 20261022-bug-mm-readahead-async-overtaken-b2cf5bedea21

Best regards,
-- 
Qiliang Yuan <odys.yuan@gmail.com>

