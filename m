Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0B752773E4
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Mar 2026 23:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774568850; cv=none; b=UePKJJM586JLPcf7XAsj9ZuV1F0k/pl0DtjTBX+b0s0fNkx9u9ZoJ5aD2gdJxOI5o+UUcjTPTzNjhYsLQO7W8h7oVbaUFSpedxS/rNYrAH4wOXd4iu/wKc55beOo6mIzAmEXxw9L+EMa57rDU5+wTejEqhgem/Co/Qvbg5eoit4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774568850; c=relaxed/simple;
	bh=mSCi33KbGfXlStHvUtsNTRKTgCdb2BOaXVnw91QOpVc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CmsTe6GXWpz6S694yPHYMW+13tGGLgtUdB3bRbXKqpDPzUTavSCjrCjt7890MOowDAeGtDLjvRbb3PSdIB+qgpUf2cwKJKhe7TS2R2KWhj2gb1z/vdxBKeNOMwfHs9r2d3qxa3hPlzr8u18JbWB6VUc1LylOcF4fWWSWbzWK4ME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QBCK8/15; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QBCK8/15"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2b0ba3bfe16so14016395ad.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 26 Mar 2026 16:47:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774568848; x=1775173648; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hwh8cuNEpoLwXQSyJbOzsPP4ho/foZ01KLl/zuIjPAM=;
        b=QBCK8/15WEjR2Ze2ZGo9778+LbCqAolTI0qECzmVfSNrrFU0qXVnRAETFynmawQsMB
         McWeaeN9VZff3qbhl+/UNQrSU+su5weUozW2PZZmrvZVv2pBwBTNY1xcDUJO5BinezPR
         ohfjjgtOjRpWKbSj5UBHH+fO6NVdghDcyOrdOKdnXHp98aVBFC8FoJdhTSOohU8o0OZQ
         TjdKqQuQ43WThJ1FQpaa7KIjU42R03Qv7HPzBMjon0/nDY1AsOdjGrYBxaRfQB57IkMh
         HeeDaFrkhcuLg9ICQQMuMUjuQvqJ9HRgy5gkNq0UUn9NfIb5u5TXi+NV6X3SncMpZcrw
         fFEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774568848; x=1775173648;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hwh8cuNEpoLwXQSyJbOzsPP4ho/foZ01KLl/zuIjPAM=;
        b=niaGUhdnUGsAxGrgHIdJ7EmwArUdV4Gec0NMTfI2NY2vIhcFid0ZqpXiQLsR7j8Vbk
         h7SVs/Mtd151EkA+d+r6bPGCZyCVzFn+MjwCiQLO2lY5uUmBxmWvvj8Pe608FBAxHqfq
         jfyEMoXn67xv5lpDMJCS5jKyVU5SUlXKFlWpM/LyWjt5wcj81aB4pyEMFl+deLcioQkc
         1ZHstxuJQ9H6ZKx35A/XRnB4ZKsvtxMElAeYW7UptGkoZR/brHV/8YOkvHvEgKBq5U4A
         PDXmBBTeCTtWykSuvFg6Qpe+V8tDXtY8lidFF8FLT2RFcXvp7yk8Ic09nGKaLdwhDnJk
         2TYw==
X-Forwarded-Encrypted: i=1; AJvYcCW0MWTigWk/NjW272MdvsggyZUpT2UgdxFl3L5UwlNkD7rZuCeYtIvZTer1V1RB/tYicmkCNABCO7WQbFAV@vger.kernel.org
X-Gm-Message-State: AOJu0YzTnexfZhfEAIXZ4xcT89V66LWifYfqcG3YJrBxzFsbICma7FcD
	CyYct4Tt3gmuUK0o4Ti3EJVjwnnfkkrIIgv3nih2Ogm0x2Ry/EyzPPYm
X-Gm-Gg: ATEYQzx+wEysyeHTRHvKxr2OwBxC1O6+2lUw2D6zYA/yraCE1BfbdMNhe4XBertWMpp
	q2D+Kv/eMJgabJZHOoxaRaV6jIz6IYpJoW26dtvrULHEBn2ub+0Axy7cNENYxwM5k1zByHaoCe2
	kEKYLYejNT9Smeah61ZCfmxFwQRm3pFZ1O/P/Zqi5sH6YauxWX4uYMtWri9ULMM3HmqbEn5PQp6
	UQ12ISYISxLeeM8xtKoH4jWagXGVTzQ8CkL1BFuVNhkKKJrd/pvDH4uzJHX0Q3WIp0AAvqoXKPu
	ylUj1Objz4BQy5Fmd4AVsK97RjkB1nfx1at7vyzVdB8KBUmvJ42bcoPr7XJLBSCOwZRcIoRFyBX
	uNsIBJsRQYDmC4LFdZK8LvoJjZgil5U7QKAf2bU42V4o4+9gHXYW7A6cfksU81vGQBxpFvmJl82
	nJ+dBbKUToCiw3kv6F
X-Received: by 2002:a17:902:d4cf:b0:2b0:51f6:d469 with SMTP id d9443c01a7336-2b0ce5d7ee7mr2127515ad.23.1774568848344;
        Thu, 26 Mar 2026 16:47:28 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:2::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b0bc76bbdcsm42362145ad.5.2026.03.26.16.47.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 16:47:27 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: akpm@linux-foundation.org
Cc: jack@suse.cz,
	willy@infradead.org,
	miklos@szeredi.hu,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v1 1/1] mm: start background writeback based on per-wb threshold for strictlimit BDIs
Date: Thu, 26 Mar 2026 16:46:29 -0700
Message-ID: <20260326234629.840938-2-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260326234629.840938-1-joannelkoong@gmail.com>
References: <20260326234629.840938-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The proactive nr_dirty > gdtc->bg_thresh check in balance_dirty_pages()
only checks the global dirty threshold to start background writeback
while the writer is still free-running, but for strictlimit BDIs (eg
fuse), the per-wb dirty count can exceed the per-wb background threshold
while the global threshold is not yet exceeded, so background writeback
for this case never gets proactively started.

Add a per-wb threshold check for strictlimit BDIs so that background
writeback is started when wb_dirty exceeds wb_bg_thresh, which drains
dirty pages before the writer hits the throttle wall, matching the
proactive behavior that the global check provides for non-strictlimit
BDIs.

fio runs on fuse show about a 3-4% improvement in perf for buffered
writes:
fio --name=writeback_test --ioengine=psync --rw=write --bs=128k \
    --size=2G --numjobs=4 --ramp_time=10 --runtime=20 \
    --time_based --group_reporting=1 --direct=0

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 mm/page-writeback.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index c1a4b32af1a7..30f3d5a6270f 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -1835,7 +1835,9 @@ static int balance_dirty_pages(struct bdi_writeback *wb,
 			balance_domain_limits(mdtc, strictlimit);
 		}
 
-		if (nr_dirty > gdtc->bg_thresh && !writeback_in_progress(wb))
+		if (!writeback_in_progress(wb) &&
+		    (nr_dirty > gdtc->bg_thresh ||
+		     (strictlimit && gdtc->wb_dirty > gdtc->wb_bg_thresh)))
 			wb_start_background_writeback(wb);
 
 		/*
@@ -1862,15 +1864,9 @@ static int balance_dirty_pages(struct bdi_writeback *wb,
 		 * Unconditionally start background writeback if it's not
 		 * already in progress. We need to do this because the global
 		 * dirty threshold check above (nr_dirty > gdtc->bg_thresh)
-		 * doesn't account for these cases:
-		 *
-		 * a) strictlimit BDIs: throttling is calculated using per-wb
-		 * thresholds. The per-wb threshold can be exceeded even when
-		 * nr_dirty < gdtc->bg_thresh
-		 *
-		 * b) memcg-based throttling: memcg uses its own dirty count and
-		 * thresholds and can trigger throttling even when global
-		 * nr_dirty < gdtc->bg_thresh
+		 * doesn't account for the memcg-based throttling case. memcg
+		 * uses its own dirty count and thresholds and can trigger
+		 * throttling even when global nr_dirty < gdtc->bg_thresh
 		 *
 		 * Writeback needs to be started else the writer stalls in the
 		 * throttle loop waiting for dirty pages to be written back
-- 
2.52.0

