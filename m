Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D8A02E612E
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Mar 2026 21:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774561946; cv=none; b=VqolPlqmH6Owecq78EXqUUJvLjq8JIloCW9DKqh8UwZ1SHU0ShAFE6COGihDazrA4sVJUDx6ePBK5sRZbwlbedn/u8mKlYaFhQybIKbR9CD/zEtTPnKh75vB3MtdD02ikTRCeF+8ceuS3mnfltEA+RzmFp6EGX54grC/4qsRVcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774561946; c=relaxed/simple;
	bh=faEIcCWFgjH/sgJccQIKyoXSmvwnIsBfLO3wPuf0KNE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NgN4zwd0H+EtbvDUVss9hBiGfj6I8CSG2Al475JyQ1tpCqi7GV/giBkDR69u67wIjogk+BpmmCYq+diW0QSI5kQxkiA9+S5Fz3q8K/9Y0ML5dCR8tGAtG1GE/jEcnC8hiMllrRkEEERdDo3RJQotL5MPLPSvBIIJTIvVke+1rQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H/1QozY+; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H/1QozY+"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-82985f42664so901033b3a.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 26 Mar 2026 14:52:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774561945; x=1775166745; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yEEQm0TpXR/MnKCD8+SMXgQ9B5RQcWrE+GNArOaCAS4=;
        b=H/1QozY+15Okiedz/EQbOrihJVD10X4I4EQS63VWxFybaTaFUoRILdzGIpyX2h7z3x
         zpG39cNVXK83gCT66kt0SsDem0zeHhb/gELnSUnOn8p/hOWqSOkhGoRiG3n1cTMh5fsc
         pgj8g3n5G3Drbmf9QlQ2LeoPKiELHezSlMafmfboMpR4BHD7Jnn8MeHuql50IWS7BjM2
         aGjFiSSabuqUE/dxoMoALCrOwfTbUoUQ80ITJ4OepTsICQRymHw8Qlm8ib+um9AuZeYW
         JinVuC/LIjpdJDtIACXFPYgoxSKcX8pABKoBWNkVaHUKtEwU1HVwlMXtCJriEnZoXFg6
         qd5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774561945; x=1775166745;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yEEQm0TpXR/MnKCD8+SMXgQ9B5RQcWrE+GNArOaCAS4=;
        b=qDiRl3gllb2RhLAEHjNn3aeNrIOWO4OJD3pYlxoUHWklqLQ/oHRTrMaekUJNAbx4qt
         tmZ9A4bEXhgzy25OJHrIMCrIlraY76BRXOXtP1J3SZqrVctK/3Zfo/lHdthdZzBOdZhq
         OsD7kRmPkhueURgiTrKzt0N+xnHDmyn4ok5533jESYUmezMcNI2/XKJCeOf9K2dVE+fz
         2lrsXh4NSSMnOtjX+l3sTOEUo2qwLCpWxG5h52ogUhSgAPZsqiyz2nqxCEfrIzwahgBA
         gzj0NmFDksYuXoQ+Hym/eFhev4jAZjINSD02UP9uh8+sGd4U9GqguT6suxq5/zAJt9jn
         IImw==
X-Forwarded-Encrypted: i=1; AJvYcCXbIFIbIauXJfXGVB0yHGXa624dL9F0ul/jbzIZUc9CIya0RYN50PuOMxkqTFnSfJWe4J5lVY3VYG/OFWIl@vger.kernel.org
X-Gm-Message-State: AOJu0YxIxdoWGqcM0kxcsiGUmyqJ8wSCO1KY4xnjc4w9Q3C4U074t8H0
	HL+gHTsQSi8the2bR4ns32QyTqNr1fiieR2GCnrytCU1TWod0oSc34Eu
X-Gm-Gg: ATEYQzwR+JIdWdIOBDs3JwEGcccXjCkVCq1y2UmI2qIUEDbz8Li43qS/xRQhtS4q1hT
	5Pj2nipXkmDcMZ0pA4tuY6/PpKKyQC/WqJ7iuHRqu8Ws+/NZnlJRMNwm/JbL07O5VeWVZjXX+J4
	xVfxO0GWvVgLUd89wHJKpjIohDTBEQLhi2Utg/CGrdQnLnQjh3DrJqAD0D2VcGYin24gYQhPNG8
	QHkc/GgkviR1SXGombxkiikOICrW5N6QLsdKIaf0OBmlDmtVraZ5mbFeaykUAMOeO51Vp5halzI
	8io0gpJMKrJUl4BvmFpY1VUPD2cigVzhmqG+7ORQaVeLBVW2YnboAsU+J3IkfqDnWuHJcp2NfNv
	pNh65nJOYEAgMJu9sT5eytYyRDVNKnLTys//AKga2r5eo6z1u1APOtdQ5Gn4fjpZQ8jQp7cgiRk
	ZqnLN2nB44Gy9JMg6J
X-Received: by 2002:a05:6a00:4147:b0:824:a4d3:38e4 with SMTP id d2e1a72fcca58-82c9605da77mr64432b3a.61.1774561944831;
        Thu, 26 Mar 2026 14:52:24 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:3::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82c964f9e9bsm8476b3a.49.2026.03.26.14.52.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 14:52:24 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: akpm@linux-foundation.org
Cc: jack@suse.cz,
	hch@infradead.org,
	hannes@cmpxchg.org,
	willy@infradead.org,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 1/1] mm: reinstate unconditional writeback start in balance_dirty_pages()
Date: Thu, 26 Mar 2026 14:51:27 -0700
Message-ID: <20260326215127.3857682-2-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260326215127.3857682-1-joannelkoong@gmail.com>
References: <20260326215127.3857682-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 64dd89ae01f2 ("mm/block/fs: remove laptop_mode") removed this
unconditional writeback start from balance_dirty_pages():

       if (unlikely(!writeback_in_progress(wb)))
	       wb_start_background_writeback(wb);

This logic needs to be reinstated to prevent performance regressions for
strictlimited BDIs and memcg setups. The problem occurs because:

a) For strictlimited BDIs, throttling is calculated using per-wb
thresholds. The per-wb threshold can be exceeded even when the global
dirty threshold was not exceeded (nr_dirty < gdtc->bg_thresh)

b) For memcg-based throttling, memcg uses its own dirty count /
thresholds and can trigger throttling even when the global threshold
isn't exceeded

Without the unconditional writeback start, IO is throttled as it waits
for dirty pages to be written back but there is no writeback running.
This leads to severe stalls. On fuse, buffered write performance
dropped from 1400 MiB/s to 2000 KiB/s.

Reinstate the unconditional writeback start so that writeback is
guaranteed to be running whenever IO needs to be throttled.

Fixes: 64dd89ae01f2 ("mm/block/fs: remove laptop_mode")
Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 mm/page-writeback.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index 601a5e048d12..c1a4b32af1a7 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -1858,6 +1858,27 @@ static int balance_dirty_pages(struct bdi_writeback *wb,
 			break;
 		}
 
+		/*
+		 * Unconditionally start background writeback if it's not
+		 * already in progress. We need to do this because the global
+		 * dirty threshold check above (nr_dirty > gdtc->bg_thresh)
+		 * doesn't account for these cases:
+		 *
+		 * a) strictlimit BDIs: throttling is calculated using per-wb
+		 * thresholds. The per-wb threshold can be exceeded even when
+		 * nr_dirty < gdtc->bg_thresh
+		 *
+		 * b) memcg-based throttling: memcg uses its own dirty count and
+		 * thresholds and can trigger throttling even when global
+		 * nr_dirty < gdtc->bg_thresh
+		 *
+		 * Writeback needs to be started else the writer stalls in the
+		 * throttle loop waiting for dirty pages to be written back
+		 * while no writeback is running.
+		 */
+		if (unlikely(!writeback_in_progress(wb)))
+			wb_start_background_writeback(wb);
+
 		mem_cgroup_flush_foreign(wb);
 
 		/*
-- 
2.52.0

