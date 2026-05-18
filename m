Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24201382383
	for <linux-fsdevel@vger.kernel.org>; Mon, 18 May 2026 18:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779128770; cv=none; b=ojcU+bhgdl4HTYUoy+Ggo8LkIffbhARMBfpNyr5MuMRG0WUPi67U0qvZ9QM9GtmQ0s2kjOfTs2J2nFqaIVelhGw7B2gcOtkqfsOxCZdKTQi/bibgGaCmBrMQf69TYJnfZgJBwe4bVYUZx6oRfPrj29YuIWwIcTXXNF7tVgxHV6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779128770; c=relaxed/simple;
	bh=AJQ8X8vekQbsX2A2arXJ8CBDC1jAwqSdrm7rYzzgrNs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cEbgQ9QNnbKvDSu28n/R/xhggRUUZlyJQY6iYE9nBMvq+kCEzD+cclE56e8xHYXbSmuD79XvfHOs6Z7H6av6BEe73w7oYQGGlioc9PL723Yw2jRR02vo7FhVTkc6iCe98kMX2OSiiRtcth/SUdwKfUh03nJEaw7LyN+u0IGgvhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GEOOYRjr; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GEOOYRjr"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-67c2d57a5ceso4478865a12.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 May 2026 11:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779128767; x=1779733567; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fjppO2+PwKNhaclh25OQ0CMNeNNbO/jvr0ag7TFBQ9k=;
        b=GEOOYRjr7jabRzKpTfVGB0uROawVxK9+gZC7t6JzLZuza8bI8fA5GU8No9N5/RJD4q
         /nYGbgo2h5IBgIRtLW7/+0KGvVAmcSPNAp4MC9y840M2z6OfodXPqgs3yzflzxjcOVbm
         O6dt8LJQLosfx+DPnFjPEc4iw70Rjuo93T+B2IaCFFoak8Ccs17MGNtHvC4sDZ2Jvbaz
         PCuJdzzLKpCwByYP6F+9CwTmfsh7bGEnxviW2j8E3GZhiRaKjnFYaRlHAh/s+G4Bsy39
         QXYiUT5qrmafgcv1hdLCmmXP121m3c+d9MH17sCgnpLDZj+23cApWZjF5eLktsqNFjJO
         MwLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779128767; x=1779733567;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fjppO2+PwKNhaclh25OQ0CMNeNNbO/jvr0ag7TFBQ9k=;
        b=KRTbEvAcUsAkfpWjxXFs6q1PacgJJOSjoau4P7VTl/VsAryIxarGhEDFFp/iFbGmWx
         96QvU5UjEwQ8snGiISRGYkoxCxXu5ktvNbqvKQz4htWWnXBy5sH9a2OXS78Ff8ZNLMpF
         k6sk6fsfRGT03Xd/kYWRXa+KnEwkO3sYeT0We26Ya7/zk55NE6UCG6aMiXZ3+k8qgzzO
         7Dqi+Y11THFsuUc5I613MbInQWHEgm7vV5Ii4mKwcMpOENmuMzIlCeFlKH8X8A2quBdv
         aj3F/gER21LPuhOA4JhMkbwPeMGMBQFtASrrr3ISzaXQM1p1C7jjuxbUh27Ww4b9Gi4I
         gGLw==
X-Forwarded-Encrypted: i=1; AFNElJ/n5F1GE9R0xv4Snt0eALsrPD0V7VVFUFRoDX3sNOISY4bb09eW8iOzhgONq5YER22XwVn7Q7mZiIz0ix5M@vger.kernel.org
X-Gm-Message-State: AOJu0YwcUabR2xLSYjYrNC59pQgNwKLJCMXViXs95Q6coyTphXFrfM6T
	J900zE2bCl2pLTX2ZZX2B06d/sQ1htMdC23eFGohgAUZvW0+12bcIoSb
X-Gm-Gg: Acq92OEed+xgWK9GAfzkmaZVWFt7mgglbtMSDpOHaJla3fXlMxeZ7/+bYMfbgPkE3Hw
	MOtGWhUPaeIf/erY9MqlqfjsRvgnJ3CJ2Nkl5us4cR3k8rFGHkikVxutYkx65+JhMh5s13+28OU
	hjhDXH6eVqEyRAlUTAdvY4oOyScpZWOUErMM9Dm80kXMRTrgwMqC3vX6Hx3SiVxte4lRfRGhCyL
	VIh0l6qLkouIV6xo0bnalQCX7dEep9c+voIHJwoV49Huv5dUjMr5mJPyI2ttrRKvj64/+VKZ3rg
	A+ggLlEPEQYGw9dxqINE/qjfB+4HBa4e98mXl/ok8ntLuULu0HWzRbn3RKXkK3n6TJ1XnH7DAm2
	5L5i4FjBtJkeuXDO493/22jOjiOR5rbJBxcvVMWxK4j1/cLSOdxZY9+StBTlQkeVs7r5W5K2JV7
	avieNBLl3lAOTGvVze
X-Received: by 2002:aa7:c652:0:b0:681:5b68:b26d with SMTP id 4fb4d7f45d1cf-683bc4b5ae7mr5810099a12.6.1779128767128;
        Mon, 18 May 2026 11:26:07 -0700 (PDT)
Received: from localhost ([2a03:2880:32ff:70::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-68310b3e973sm5691646a12.3.2026.05.18.11.26.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 11:26:05 -0700 (PDT)
From: Vlad Poenaru <vlad.wing@gmail.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Joanne Koong <joannelkoong@gmail.com>,
	Breno Leitao <leitao@debian.org>,
	Josef Bacik <josef@toxicpanda.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 6.18.y] fuse: avoid 0x10 fault in fuse_readahead when max_pages == 0
Date: Mon, 18 May 2026 11:26:02 -0700
Message-ID: <20260518182602.3107764-1-vlad.wing@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When fc->max_read is smaller than PAGE_SIZE (common on aarch64 with
64K base pages if the FUSE server advertises a small max_read in INIT),
max_pages = min(fc->max_pages, fc->max_read / PAGE_SIZE) is 0, so
cur_pages is 0 on every outer iteration.

fuse_io_alloc(NULL, 0) then calls fuse_folios_alloc(0, ...), which
calls kzalloc(0, ...) and gets back ZERO_SIZE_PTR == (void *)16.
The "if (!ia->ap.folios)" guard in fuse_io_alloc does not catch
ZERO_SIZE_PTR, so fuse_io_alloc happily returns an ia whose
ap.folios is 0x10.

The inner "while (pages < cur_pages)" loop runs zero times, then
fuse_send_readpages(ia, ...) dereferences ap->folios[0] in
folio_pos(), faulting at virtual address 0x10:

  Unable to handle kernel NULL pointer dereference at virtual address
  0000000000000010
   fuse_readahead+0x14c/0x490
   read_pages+0x80/0x318
   page_cache_ra_unbounded+0x1c0/0x2b0
   page_cache_ra_order+0xb8/0x368
   page_cache_sync_ra+0x210/0x320
   filemap_get_pages+0x290/0xdb0
   generic_file_read_iter+0xd0/0x540
   fuse_file_read_iter+0x8c/0x158
   __arm64_sys_read+0x1a0/0x488

addr2line on the aarch64 vmlinux maps fuse_readahead+0x14c to
fs/fuse/file.c:897 inlined into :999, i.e. "folio_pos(ap->folios[0])"
inside fuse_send_readpages.  The faulting instruction "ldr x8, [x8]"
loads ap->folios[0]; ap->folios was previously loaded as 0x10
(ZERO_SIZE_PTR).

Without this fix the function would also spin forever, since
"nr_pages -= pages" makes no progress when pages stays 0; in practice
the NULL deref masks the spin.

Bail out of the outer loop if cur_pages is 0 -- there is no work we
can issue via FUSE in this iteration, and remaining folios will be
handled by read_pages() falling back to ->read_folio.

Note: this code was rewritten in mainline by commit 4ea907108a5c
("fuse: use iomap for readahead"), which switched fuse_readahead to
iomap and removed the buggy loop entirely.  This patch therefore
applies only to stable branches that still carry the pre-iomap
readahead path.

Fixes: 3eab9d7bc2f4 ("fuse: convert readahead to use folios")
Reported-by: Breno Leitao <leitao@debian.org>
Cc: stable@vger.kernel.org
Signed-off-by: Vlad Poenaru <vlad.wing@gmail.com>
---
 fs/fuse/file.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 6014d588845c..782178124512 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -974,6 +974,16 @@ static void fuse_readahead(struct readahead_control *rac)
 		unsigned cur_pages = min(max_pages, nr_pages);
 		unsigned int pages = 0;
 
+		/*
+		 * If max_pages == 0 (e.g. fc->max_read < PAGE_SIZE on a
+		 * 64K-page kernel), cur_pages is 0 and we cannot make
+		 * progress.  Bailing here avoids passing 0 to fuse_io_alloc,
+		 * which would return an ia whose ap.folios is ZERO_SIZE_PTR
+		 * (0x10) -- later dereferenced by fuse_send_readpages.
+		 */
+		if (!cur_pages)
+			break;
+
 		if (fc->num_background >= fc->congestion_threshold &&
 		    rac->ra->async_size >= readahead_count(rac))
 			/*
-- 
2.53.0-Meta

