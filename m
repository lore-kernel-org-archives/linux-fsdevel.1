Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794554849;
	b=jv6jUM9MqvGJYknUVcMOFvZTjQTxU0N5VI2Es70WH88gBBqW/YhZtod8QpAcqEo/Ug+y
	 zyk7IRJ+HQ2L27ptCtenf2CDlOC87s0PXXWr6ERADe3AQ6UR1TwgKuazLCK6IVsfOjst8
	 QcAKGfRI1f6aCSB0IlKxNfr/MwDx70GeG5q5qYOeBI66ok9g5CNf4wbatetnc0l8I1czf
	 VFC744Fp8T74i7ei9t//H/AEX6Kjgyoxv3ORBzuakcNirxADPLgKMfwUqaTR7VcWOoUhi
	 DtI7ZkHiulMkRtu1kriEtAcJ0JjeE4/i18S5qJBemRhOvCczuhiey6dcAkV2wYv0Eqg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794554849;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=hbenJVq9I5uwkDNPOZUGRpBZdFROzQQvvi7cvGqBcJI=;
	b=wlQErL3jHkLQO59CjglRVE9/6W+Bw4Xaht9lD3axfPQIhJZABtoQHPpMzCeNGtgRV1V9
	 hkesvpGf3+/F2TI5iEJ7gJEohEcfq53Pg8QvHx7HcprgKoCx2O6W5pUUyVt8gb8LkolRg
	 zdXRRdVxD+jQ+SOjIwV5+M+VWUpzNbNyLGzpwL5FJpPy6fPyOno5dSGfseSR6xgvjwdOP
	 bK/DWgTbmHq5X7O+Qh05kyhqv9ye5+aTWG0UUENPVtXFKg4EPKO4QATXksVRsNCX3FOjv
	 07i3ksnCvdlocdMVMz7ix+0Z42kOZNSUb8LGECllM0s1odrw6TE6dQl3oTtuwESC5zg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lmHcn2iB;
	arc=none smtp.remote-ip=74.125.82.171
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9C35606A321
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Nov 2026 07:27:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B9C35606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lmHcn2iB
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-37000e7234bso707259eec.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Nov 2026 23:27:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794554848; x=1795159648; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=hbenJVq9I5uwkDNPOZUGRpBZdFROzQQvvi7cvGqBcJI=;
        b=lmHcn2iBDfK/BEp8FbnWHVMIMWkAXFhf2+kKIrYPqhaPm2jkgLq8rlqYsTFU5B8x35
         ONmCydGkPIDiOPHZlMGJ+buRFq1okRBfcUo0goVfGScG9+hdeWYkAFuECIx91mnk5K7G
         bq6zlUkBc3uz/vduCikWfdKTsqLW6vy+pPk+3UjyovI+m7prOW0NnfG09SrILp265YK1
         tf8tN6fvj36I+IXcRE5Db88fPGSiGD51+jU6EEMR3zChhozReFDGmAqvOCovWxaxiqdh
         viPfWVSGwmzyCyYULIttrBU6Tr7G5OUzaU0hCn1Ka7dntjVSwBcvPoDqsg63PUUoGwCq
         wnOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794554848; x=1795159648;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hbenJVq9I5uwkDNPOZUGRpBZdFROzQQvvi7cvGqBcJI=;
        b=iyBBaXxCrap4447QjCGYr+a5zFHDZU6yYdKOejBpszZgkF5zrHgNKmSVWbdixvpTvX
         jr9AICO+lc4aI9QlgeSHeTncB1765p3xPWyuym2EdyvnSSxPlUAs4WoIvaG9v7MponNO
         xrL3nDViHJl0Ay0zLRyp/82HBnGVBoV6G6AiVzYIEKrpcMoXK9eCloIrGmfomrWXJr1f
         EKOLkzcmq3Dj0YPJ8Dmz9r7Ok7Fer71zOoynLtXzrNDXbfLzhOsLastlhyoFFsjqxcCk
         +2Hnm8He2Znq+thBCp/m988SP4h3syi9SAC0qsHn2zQBO9QUafWltPq8/QG6s4QuMTXU
         bIjQ==
X-Forwarded-Encrypted: i=1; AL+hErHQ7CzGr0CNrI7NENMMcHav/s5WwVElDieb+0dZERWdxWa/WubsWS+WeZH9Csrj/roDN6baXGrIEAtyKbA9@vger.kernel.org
X-Gm-Message-State: APuU4Z9uTxPfnrlylpP3AZp3Mp3eb4LZPpCc8pkZFh5Dtfomx+7bsnRg
	FaDBs4SUa+iyOgVAqAq7pOyPTKdtjbc2CS66pLAD0+VteaYCK6MZ9y9V
X-Gm-Gg: AYBFou3aLqDV+9tJFCpYcMANB1iSLwR+xQZw2q00tMlepq31vxtqpefhL8cl2xLwDJg
	8XK5xTm8z2zyGiWRa4QUrKFbAlxOSVHNSNeGhxZNZx9SBPFCiTpC22XWWdwu3j0TfoAHX2jjWBi
	j3DUPSSkZyGYtJKjbEE9zclmZMMdByyOYx05nWKt4BBlZoMQa7Sa+EYm6aQKHQVZQp+2NAnlYbO
	cRCoTLg3tp5eruBDWXPNp1x5rLB4LpwnJ8B+gvU5Y6GUcq6ylKi28YF9EBfX45uzboK0bwZG62J
	N8A6CJypYNDT4R7aDlpyWaa8VkTYd8JVMxGSbPlsQN/dTGN4KORoS9cWbkGj9r7p+i2FatlTi38
	jK6bXgFOP4u0DKcPJFnWtjkI8iRe3Kmsdu8grIvsj+eg+WkZCmEL1Je5GpIm+U1bvr+uz/YWBEs
	9TecfEbd89QM1kGXjaQyUAg8aq8pccD+b8FXj/NGXBep2aKkmUrKEwEpu+b0ojAdE62E9vh5xu2
	wMlPzJXElD82rvmqPKhkq2jDr0U7DpmYixwTw4S7lve2CbM6fvklm6CULWUzOWAF0RRvLQcB60t
	Uqk1ZaYhcSL/Jj6WTHH0sCa9usf0h+g5KtkQeQrWhdEutRKeCAq3SjUYoSsZnAfh0gcTIBKvGOb
	81rUILofabjPt
X-Received: by 2002:a05:7300:828e:b0:375:dbeb:b363 with SMTP id 5a478bee46e88-37966a575camr1303312eec.28.1794554847648;
        Thu, 12 Nov 2026 23:27:27 -0800 (PST)
Received: from LAPTOP-KD1TH5BD.tail375eb4.ts.net ([47.11.114.36])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3795378c2fesm4906698eec.1.2026.11.12.23.27.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 23:27:27 -0800 (PST)
From: Gopal Malaviya <gopalmalaviya53@gmail.com>
To: akpm@linux-foundation.org,
	willy@infradead.org,
	jack@suse.cz
Cc: linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	p.raghav@samsung.com
Subject: [PATCH] mm/readahead: don't skip the fallback after aligning index down
Date: Fri, 13 Nov 2026 07:27:11 +0000
Message-ID: <20261113072711.235264-1-gopalmalaviya53@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

page_cache_ra_order() rounds the start of the readahead window down to
the minimum folio size of the mapping, so on a file system with blocks
larger than the page size, index can end up below start. If adding the
first folio then fails, for example with -EEXIST because that folio is
already cached, the loop stops with index still below start, and the
check before the fallback

	if (ra->size > index - start)

wraps around, so do_page_cache_ra() is not called and nothing of the
window is read.

For example, with read_ahead_kb 128 and 16 KiB blocks, the mmap
read-around window for a fault on page 1042 starts at page 1026, index
becomes 1024, and if pages 1024-1027 are cached, pages 1028-1057 are
not read ahead.

Compare with the end of the window instead. Where index is not below
start, this is the same check and the same number of pages as before.

Tested in a KVM guest (x86_64, 2 vCPUs, 3 GiB) on mm-hotfixes-unstable,
with XFS with 16 KiB blocks and with ext4 on virtio-blk, read_ahead_kb
128. A test caches page 1026 of a file with pread() on a
POSIX_FADV_RANDOM descriptor, then faults page 1042 through a mapping,
and counts the cached pages of the window [1026, 1058) with mincore():

                                       before   after
  XFS, 16 KiB blocks                      6       32
  XFS, 16 KiB blocks, nothing cached     32       32
  ext4                                   32       32

Tracing shows the fallback now running after the -EEXIST, as
page_cache_ra_unbounded with index=1024 and nr_to_read=34.

Touching 1% of the pages of a cold 20 GiB file on XFS with 16 KiB
blocks, at random, at a stride of 2053 pages, or as random runs of 2
or 4 adjacent pages, reads the same amount before and after, within
5% over two runs each, at read_ahead_kb 128 and 8192.

Not tested: other block sizes, other file systems with large blocks,
and other architectures (built for i386 only).

The problem was pointed out by the Sashiko AI review of an unrelated
patch [1]. An AI assistant (Claude) helped with the analysis and the
test, and drafted this changelog. I reviewed, implemented, built and
tested the change.

[1] https://sashiko.dev/#/bug/linux-da6e8836-f808-4b39-9f04-de52995a0162

Fixes: d5ea5e5e50df ("readahead: properly shorten readahead when falling back to do_page_cache_ra()")
Signed-off-by: Gopal Malaviya <gopalmalaviya53@gmail.com>
---
 mm/readahead.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/mm/readahead.c b/mm/readahead.c
index 6e55632902..afcde18316 100644
--- a/mm/readahead.c
+++ b/mm/readahead.c
@@ -552,10 +552,12 @@ void page_cache_ra_order(struct readahead_control *ractl,
 fallback:
 	/*
 	 * ->readahead() may have updated readahead window size so we have to
-	 * check there's still something to read.
+	 * check there's still something to read. Compare with the end of the
+	 * window, as index may have been rounded down below start to the
+	 * minimum folio size.
 	 */
-	if (ra->size > index - start)
-		do_page_cache_ra(ractl, ra->size - (index - start),
+	if (index < start + ra->size)
+		do_page_cache_ra(ractl, start + ra->size - index,
 				 ra->async_size);
 }
 

base-commit: 76f5384740b2fd9ee5d71da9d49b271d37c5a51b
-- 
2.43.0

