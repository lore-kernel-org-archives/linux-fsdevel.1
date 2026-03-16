Received: from smtp02-ext3.udag.de (smtp02-ext3.udag.de [62.146.106.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D496B3A0B29;
	Mon, 16 Mar 2026 15:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.146.106.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773674818; cv=none; b=u59L9kTUAJC/JYgYs+CT2p+MA99ZA0crSZft7CuNmHrWXQCSZndrwJ8cioR/80nPMGEmXxJVUmhHRY+cMcYYAH2ThEFWZov4wAfT0HWgFLHEKMYgIbCHcblaqtQGer1ESx0m0OANURDTlpHLCk2nmIu0ZfCI4P3TJhFeonheqsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773674818; c=relaxed/simple;
	bh=au8IHXNsJEU5MGQRwMhO0yJRq2H3aX0mxkcgvCxDvIY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=I0cVzMIVYazqZB9jRYbNyqcwh3EQG9fwlx8t93PbJAVMAAPzMaH940RLxFsXe0w7D3Z4oo+EwCUWJCp6ZY9/XdIVWOdd9Hn6NqQ4t4hyuGjFcI4KI9OiFrGOEy0xlfgVT4X7HRduXC78APbam5ovSqOud+yPbk+BvwTuQI7PCak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=birthelmer.com; spf=pass smtp.mailfrom=birthelmer.com; dkim=pass (2048-bit key) header.d=birthelmer.com header.i=@birthelmer.com header.b=H/eQMPV8; arc=none smtp.client-ip=62.146.106.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=birthelmer.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birthelmer.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birthelmer.com header.i=@birthelmer.com header.b="H/eQMPV8"
Received: from fedora.fritz.box (200-143-067-156.ip-addr.inexio.net [156.67.143.200])
	by smtp02-ext3.udag.de (Postfix) with ESMTPA id 2E7F9E04B0;
	Mon, 16 Mar 2026 16:16:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=birthelmer.com;
	s=uddkim-202310; t=1773674214;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=rEnskxDtUFff5uk2c8tFVOcWWgB+jzLONqc5TsF8Xng=;
	b=H/eQMPV8tAHr+ES1zCO+moJsQ2tc+krGugI7YBNqLfq3+435wgzqrwvg8b/CX89VQ9Y+/l
	aX3NEwOBxlj2Gw73o8Oovyd7ikdrjjFVBxN85uNA2+9rYV+G41/wiGY9ld+YPHMg5DDXV0
	NUtfQ4s7B/B3fMCwgQs9ulzXjsJc4oRSXm+5BNqqe/RHMU7TTOU/mxAI2Do41eU0Vtdyp5
	2LfDrkrEdTpsZE5oTeK0C4UDrg/r5CGRKVLasiTbKPIqT1B38DfXHCWIzgts6pnuBdMZeE
	zojsXf1foTYroz8Ld3mZL4KCE8HyHwK4rIY1Mvi7Ai7ObxDBYJNg/GO1d7YbKA==
Authentication-Results: smtp02-ext3.udag.de;
	auth=pass smtp.auth=birthelmercom-0001 smtp.mailfrom=horst@birthelmer.com
From: Horst Birthelmer <horst@birthelmer.com>
Date: Mon, 16 Mar 2026 16:16:52 +0100
Subject: [PATCH] fuse: when copying a folio delay the mark dirty until the
 end
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260316-mark-dirty-per-folio-v1-1-8dc39c94b7ce@ddn.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MSQqAMAxA0atI1gYcq3gVcdFqqsGhkooo4t0tL
 t/i/wc8CZOHJnpA6GTPbgtI4wj6SW8jIQ/BkCWZSvJU4aplxoHluHEnQesWdmiorowyhbGlgpD
 uQpavf9t27/sBxF8D6GYAAAA=
X-Change-ID: 20260316-mark-dirty-per-folio-be87b6b4bf56
To: Miklos Szeredi <miklos@szeredi.hu>, 
 Joanne Koong <joannelkoong@gmail.com>
Cc: Bernd Schubert <bernd@bsbernd.com>, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Horst Birthelmer <hbirthelmer@ddn.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773674213; l=2341;
 i=hbirthelmer@ddn.com; s=20251006; h=from:subject:message-id;
 bh=7miT4/BYrqv+Ag7kXV0Kd/FiRiPRp3ZCeMvG7REh7UM=;
 b=he/2gqriox0SoZTVEzBn/e2xtDgG6Yn2qD4GhRtH6H98RPvBLcjn1LYYqly5PWkwkyeBxaY8J
 5HUkHkAa72WACyZietRm11yrDUzAvxdWytrbPGjCF4kmmBvGR6AW1g9
X-Developer-Key: i=hbirthelmer@ddn.com; a=ed25519;
 pk=v3BVDFoy16EzgHZ23ObqW+kbpURtjrwxgKu8YNDKjGg=

From: Horst Birthelmer <hbirthelmer@ddn.com>

Doing set_page_dirty_lock() for every page is inefficient
for large folios.
When copying a folio (and with large folios enabled,
this can be many pages) we can delay the marking dirty
and flush_dcache_page() until the whole folio is handled
and do it once per folio instead of once per page.

Signed-off-by: Horst Birthelmer <hbirthelmer@ddn.com>
---
Currently when doing a folio copy 
flush_dcache_page(cs->pg) and set_page_dirty_lock(cs->pg)
are called for every page.

We can do this at the end for the whole folio.
---
 fs/fuse/dev.c        | 9 +++++++--
 fs/fuse/fuse_dev_i.h | 1 +
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 0b0241f47170d4640f0b8f3cae8be1f78944a456..ae96a48f898e883b4e96147f3b27398261c5e844 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -855,7 +855,7 @@ void fuse_copy_finish(struct fuse_copy_state *cs)
 			buf->len = PAGE_SIZE - cs->len;
 		cs->currbuf = NULL;
 	} else if (cs->pg) {
-		if (cs->write) {
+		if (cs->write && !cs->copy_folio) {
 			flush_dcache_page(cs->pg);
 			set_page_dirty_lock(cs->pg);
 		}
@@ -1126,6 +1126,7 @@ static int fuse_copy_folio(struct fuse_copy_state *cs, struct folio **foliop,
 			folio_zero_range(folio, 0, size);
 	}
 
+	cs->copy_folio = true;
 	while (count) {
 		if (cs->write && cs->pipebufs && folio) {
 			/*
@@ -1167,8 +1168,12 @@ static int fuse_copy_folio(struct fuse_copy_state *cs, struct folio **foliop,
 		} else
 			offset += fuse_copy_do(cs, NULL, &count);
 	}
-	if (folio && !cs->write)
+	if (folio) {
 		flush_dcache_folio(folio);
+		if (cs->write)
+			folio_mark_dirty_lock(folio);
+	}
+	cs->copy_folio = false;
 	return 0;
 }
 
diff --git a/fs/fuse/fuse_dev_i.h b/fs/fuse/fuse_dev_i.h
index 134bf44aff0d39ae8d5d47cf1518efcf2f1cfc23..4a433d902266d573ad1c19adbdd573440e2a77b2 100644
--- a/fs/fuse/fuse_dev_i.h
+++ b/fs/fuse/fuse_dev_i.h
@@ -33,6 +33,7 @@ struct fuse_copy_state {
 	unsigned int offset;
 	bool write:1;
 	bool move_folios:1;
+	bool copy_folio:1;
 	bool is_uring:1;
 	struct {
 		unsigned int copied_sz; /* copied size into the user buffer */

---
base-commit: f338e77383789c0cae23ca3d48adcc5e9e137e3c
change-id: 20260316-mark-dirty-per-folio-be87b6b4bf56

Best regards,
-- 
Horst Birthelmer <hbirthelmer@ddn.com>

