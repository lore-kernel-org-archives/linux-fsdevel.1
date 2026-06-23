Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12B6239EF2C
	for <linux-fsdevel@vger.kernel.org>; Tue, 23 Jun 2026 20:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782246597; cv=none; b=mRkoybipdkgJdd24VsBLhdWCEqZ50kD19vO+2ADgPJhoywsD14P9OYqqy825nXDig8tRgbY1uHFWTku/PpCO3CEgRs/+QjJbeuNxAEWWQyI8uLg0Jsc7vgPS9fu+6KO68AlVGJ+UmYT2dhtPEzcmrUyMrq45BO+dKbD0du2nBag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782246597; c=relaxed/simple;
	bh=hVapvoYjzspplrcSGzdn17KYdrV1wLJkNy6Km1mftHg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HmuE0jsAL/fGBwwnOkamK0yhpcFeOrYehUNbV/oz8xhwoybb6O/J5LURlfgK6hpVUOHZYrLx6y1ELUgvHHkkJmIBBmfh17GCR3k+oVd00uYrmK2wK3aVbnQLulj9z7ixnorMx3PYOObpTIvkXaBuaUupuwjldl6fRJZ9nN/hiN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Af9w3SFp; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Af9w3SFp"
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-48673dc56a8so301796b6e.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 Jun 2026 13:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782246595; x=1782851395; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gurz/sSxVuazGvnegvHEJto36HD5VGkEPN8fTt1VmQ0=;
        b=Af9w3SFp64i29QymP7P/Y8fHOxqJ9+zi+4v67mXwDtzzF4liFNvj0mhos9bYA8NLlK
         3eoj6hfykl9ZWF2yITDlZ556FxSG/LDU85/OzC0va4CphaEqaHXcF6fpyLPXzmZSFgDP
         FiXoKZfe6twq8KpnYseWLBk4S3FLKPCotUyl0r5nhBWPecXzM7hWw+ldaKMph9Z7eRyI
         D5lxFDpttsvPugmdQHzLWQwl0M/39YP9XBJnJeXl9GwO/112BpcpLIi054N0SZYBvabq
         NB88KfOmowQh2AcJ56kHdQ2c862RBifQJVYCD7Aw9DlHsCHigd3y/6v/wvS7fxkpTtAh
         S+RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782246595; x=1782851395;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gurz/sSxVuazGvnegvHEJto36HD5VGkEPN8fTt1VmQ0=;
        b=JRiEnllaL+YxSbzyBjfPuy4NDipfSHSjbjYz/1EFqI14kkZefj5v3r3dy3SjA3sKho
         GGx87XbUAWSWDaIQqMHvRpMu9BkEAENyj/KKrX9hDICwgVXVcg8fMJZdyP1uppkykmAR
         NvwYbysJ5AREh0yxViapygZ+Yhhb4n1aSfnm7Aew4AGoPJI6iK+KoBjQDAX5hD55YWkD
         lF/G6d7wpyzSbr7RsqqxLDuMw1aPrzxBJs+ji0A5TbfzyHlu9Ts9Y2bqqYLS2qijFnie
         QYAhtSVktgROgFeej0x9eI0V/Z4tHNWLy2TY8Uxr8ryqHMutEFR/rijsi+NW9acoM72Q
         1EAA==
X-Gm-Message-State: AOJu0Ywyxrruhm27sGwS+X8YGKy8tbe0MgnEJQPOWKvXFHwu2xQF4VTY
	g5cOdnK7tzfKV3o2jgqQxSEdTlvSuud2H6pLu4p7iKxgd4gExTtNB1tr
X-Gm-Gg: AfdE7cnZDRc7yugiZSaURbYhgwzFwty9+8NnX89rOj79tfYAMEbLGxVsly6ZMCaG53h
	tnymuSVd01+/lC/w3cNiHB/H3IGhmue02AOdMJJBxf7OV+5E9tJulHHwzPgnecbmfRtMT4v+wKi
	NIsnstANGjoBH8HR/fLQzHuVjx/erW+p4GjneOTgolb4JZa+K946rHG9vIDKzRCAV8ERmex9LxE
	nHS82NKuXJcpIC+K6wZH//qxH8VN/dnD3YGr2QyuFPjbt2fz+czgYaTsIr5VPdlee55x7+KbEk1
	G8zp/ekOBjFPCe7wRyah/8SGB0fHXbKkRxctcVGUKLe3/S05pFcL9tg2uUKd6fTTePKL+wcXkhR
	jKAS7ViOfkxtInaTo8rxiyqd7RL3nBP+q8vRrT5P/5fa5c87xBaHs4YK1WPIaHWuJHyQ4PvPorw
	70s2hIoM1tPbK15+/CgSEj2/ahnhT3Kpxgv2fwLkpe7vz+cZHkyMUUq+cxSKmUmUw3
X-Received: by 2002:a05:6808:2294:b0:489:6b0a:f712 with SMTP id 5614622812f47-49079b97d56mr270454b6e.35.1782246594998;
        Tue, 23 Jun 2026 13:29:54 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:4d::])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-48aeea473f4sm7235837b6e.18.2026.06.23.13.29.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 13:29:54 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: brauner@kernel.org,
	hch@lst.de,
	djwong@kernel.org,
	miklos@szeredi.hu
Cc: linux-fsdevel@vger.kernel.org,
	fuse-devel@lists.linux.dev
Subject: [PATCH v1 2/2] fuse: use iomap helpers to update folio uptodate state
Date: Tue, 23 Jun 2026 13:28:42 -0700
Message-ID: <20260623202843.2064992-3-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260623202843.2064992-1-joannelkoong@gmail.com>
References: <20260623202843.2064992-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When fuse enables large folios, a large folio will be backed by
iomap_folio_state that keeps track of uptodate and dirty state in an
internal bitmap.

Fuse writethrough and notify store paths currently set or clear uptodate
state with folio_mark_uptodate() / folio_clear_uptodate(), which touch
only the folio-level flag, but on an iomap-backed folio, that leaves the
uptodate bitmap out of sync.

Use iomap helpers to update folio uptodate state, which will make the
corresponding updates to the iomap bitmap as well.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 fs/fuse/file.c   | 6 +++---
 fs/fuse/notify.c | 4 +++-
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index e052a0d44dee..12a2aa605f6b 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -1250,13 +1250,13 @@ static ssize_t fuse_send_write_pages(struct fuse_io_args *ia,
 		struct folio *folio = ap->folios[i];
 
 		if (err) {
-			folio_clear_uptodate(folio);
+			iomap_folio_clear_uptodate(folio);
 		} else {
 			if (count >= folio_size(folio) - offset)
 				count -= folio_size(folio) - offset;
 			else {
 				if (short_write)
-					folio_clear_uptodate(folio);
+					iomap_folio_clear_uptodate(folio);
 				count = 0;
 			}
 			offset = 0;
@@ -1335,7 +1335,7 @@ static ssize_t fuse_fill_write_pages(struct fuse_io_args *ia,
 
 		/* If we copied full folio, mark it uptodate */
 		if (tmp == folio_size(folio))
-			folio_mark_uptodate(folio);
+			iomap_folio_mark_uptodate(folio);
 
 		if (folio_test_uptodate(folio)) {
 			folio_unlock(folio);
diff --git a/fs/fuse/notify.c b/fs/fuse/notify.c
index 29578104ae6c..1ba763705d91 100644
--- a/fs/fuse/notify.c
+++ b/fs/fuse/notify.c
@@ -2,6 +2,8 @@
 
 #include "dev.h"
 #include "fuse_i.h"
+
+#include <linux/iomap.h>
 #include <linux/pagemap.h>
 
 static int fuse_notify_poll(struct fuse_conn *fc, unsigned int size,
@@ -192,7 +194,7 @@ static int fuse_notify_store(struct fuse_conn *fc, unsigned int size,
 		if (!folio_test_uptodate(folio) && !err && folio_offset == 0 &&
 		    (nr_bytes == folio_size(folio) || file_size == end)) {
 			folio_zero_segment(folio, nr_bytes, folio_size(folio));
-			folio_mark_uptodate(folio);
+			iomap_folio_mark_uptodate(folio);
 		}
 		folio_unlock(folio);
 		folio_put(folio);
-- 
2.52.0

