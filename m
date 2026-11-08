Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794128102;
	b=RLE+m/omdCWnIbeTH4hF7Fmx1KcI46/PHp7SI5qzBC+6ACbKOP4ygDqF5gg2Q7LbFGk+
	 vF9wUNfFVFQLwCI82V3hrmNeRwC6UtTd/Jq1ze0YpDMUYKOZicIZEPIoFFKkz9ldkpKUE
	 n3vgG3Z8wHhS2hKHGPT37i3EPm5F/tdyTd/Or+ywiUFEgf4sK0dSxui7weojL86WqUZzF
	 MWmhMmIBsZVSO/cm7z5NCY2Hsv3mWpLV9JmwP7EF+U0GtHy0RYZVrpCrsGmMip/OZiDUr
	 d1TZJJInKw80wC8+KqaEEncb0E5C0/0X7Q5AyCKOyTPBuYMd26ZhVQZyNcoZtPW2ccg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794128102;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=V6FT4KAZBmJIi4It1KRfQsBThfynsYK7WB3H1EWORGY=;
	b=bAxcxJQ/Jxwts4I10T3qU4GplewHY93ZPHIDyVvXP1EwIuWv5/e84ZD8zRn5nOBsCdd5
	 dz7/iUwLV1Upb6VFkNvx0gDjxYESjgc3LmHsN2Oolnv+XmWDu6MBe90xlJx8IyQnkx5KP
	 z/8RUaFP8GZqHFes0aa9dB1FueVpnJJbZFWos9CELHsvnqRd2b0Iat9hmxXWaNV20DfZv
	 ypaginEgaM5p44i30TKO51N0ogzhQSPYmRvo8HufWAgghW7veyL+Dwb+i9PIu8wFSp6tk
	 whqw3QM2mr96g9fNAZqK3aRsIakmPmXIxIJuu2WMzBxTL1fQuQVMqMdprB+6uMH6C1g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=iGxefxpe;
	arc=none smtp.remote-ip=209.85.128.43
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71FEF606A31C
	for <linux-fsdevel@vger.kernel.org>; Sun,  8 Nov 2026 08:55:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 71FEF606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=iGxefxpe
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4a2072b9832so165935e9.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 08 Nov 2026 00:55:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794128101; x=1794732901; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=V6FT4KAZBmJIi4It1KRfQsBThfynsYK7WB3H1EWORGY=;
        b=iGxefxpeWce+3+/L5xQxAOe9XHTUrTRccukwyIuf9W3zkFLhxQqPAQnER/eTnywxkx
         GBd6+id7tYtbEFdtnx37i6RIN2YRJlfGW/0ephEz5wONi1Umg5z5+5s3jfhEThPqu1zQ
         jJydZA//88B7Iz3K/bLwqeOYsMRiN8JuEyuECTWcazPurL4YBCtvx4Fwmu4JA71KYLxE
         rVA30uMooXgVIwYwcnP4OVlgO5hiEb2/F4OsBREy1x79eqH8lcmA2Npq20ZHneKH3GqR
         63rE3io5iFrmqDYqKzyHMdWt1q2PTQtqAm2/rNTLp0tZP/VlFWKebNqh4i6WeWER1SVs
         UEiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794128101; x=1794732901;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=V6FT4KAZBmJIi4It1KRfQsBThfynsYK7WB3H1EWORGY=;
        b=jww2SB/YUsqoTk1CzlgxapYmz1nPAR7ZUr4CKvkGVWeiWS5dOrSU9toKgolWz/3LH0
         dkq3diN7ax3Iyjeskzbz0a4HUpf2SFecDVEZoSpXYn8ud7hQTX39ENuc8lVA2C1kWRSs
         Ahqk/dn9CqAADR4SgvzZL5mDk1dJFPyXpYgysyX7RD0miLU3syBTObQC5boudfsvr+/L
         +847mzQmCbAuiCLvlvhbSGLytkRICpgZjrXL4CzgShbyjIldliMWgB5FyPg8gcsQ8zNO
         f22z/QEbu4yJoErlEMMdRbuOqzvlBAwiIoc9dfR2pradlcd4yJ6XvarkuKwa1KPMd5G9
         Hosw==
X-Forwarded-Encrypted: i=1; AL+hErH7YzZHtmT7Txd3Tr+3jHcx2oZVN1aTIi3qa0n84VMCQFng4sDEe3r3LmFO4uxi1r9f3UdsAlKJYbL9wg12@vger.kernel.org
X-Gm-Message-State: APuU4Z+y1wpEBmtQlKMYlVEPhf/kDXG3pNKdc4ohYvwwEYQB6L09WwDi
	exsqq9Ol7udMLoPpz/Irozw54WtS620dxV8AvaMGxydScVvoNKqVqS/f
X-Gm-Gg: AYBFou0gk4zZLfotSS+XhTOr8T0fPPTWu/a8BrKXigSU4Iu6WUAuwj7wu0MFfr3uQcx
	rs31W53TAoogOuQwHee5xzREoLZ8HBMVP7mAjP81eBC3EwkLjyeJWGjeY2hAonvOMSh8EL6bXy8
	X38ZWxD6MYgcdMtrKfyNLoS8aW1+Po+U2XUgs+Trgun+Dmfdw/21sUbNgg9f0/PLN0kU1zE0WZn
	lL4S089zZ/FkA2edc84vtMW74i1MBnC7agEF3M+wJndJ1n3XOt5P3KNQYUeR9Lh30UOiJAH5hdx
	6hi60Se74RNhouJQXXd1kiLZstFXnTAIQxh9XbCFsA0pykw7h8nbVQFwnMw1E63Jm2D3bnSTBOg
	B/skDloAl0e9pe/tVa2WgOJCgfjx7w03bsaM1RTsDkVc8Ne1OzuwCCX/a1khUI98T4h6a4rnB6u
	mGW5KFpl67WWPJIsGKiotJhH/NyJJSJ3GlajrlDsYFR/jURT3PBNtdKJp+bV/bOBDje46ubbqrR
	+12JTN4DYmshxym3n0YVkaDMJxw3DcT11P7XbgBtNp4vg+plGpfDYRlawj4S73Zk0e3vYSevLGS
	i7vQQB2+ZD+L1v2AAzCF2+N/3Wkv4Tsb8+aQgdTE8MWnkSyY+cB49Wqsl+JBJlX6rr0=
X-Received: by 2002:a05:600c:4504:b0:4a2:526b:d40f with SMTP id 5b1f17b1804b1-4b943f76422mr18343555e9.0.1794128100763;
        Sun, 08 Nov 2026 00:55:00 -0800 (PST)
Received: from localhost.localdomain ([2a06:c701:475e:f800:9c3f:1631:3855:dec8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b7e32ad610sm322985835e9.3.2026.11.08.00.54.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 00:55:00 -0800 (PST)
From: Avi Weiss <thnkslprpt@gmail.com>
To: willy@infradead.org,
	jack@suse.cz,
	akpm@linux-foundation.org,
	joannelkoong@gmail.com
Cc: linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Avi Weiss <thnkslprpt@gmail.com>
Subject: [PATCH v2] mm/page-writeback: avoid unnecessary strictlimit background wakeups
Date: Sun,  8 Nov 2026 10:54:57 +0200
Message-ID: <20261108085456.2093096-2-thnkslprpt@gmail.com>
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

balance_dirty_pages() includes pages under writeback in
gdtc->wb_dirty when checking the per-wb background threshold for
strictlimit BDIs. However, wb_over_bg_thresh() only considers
reclaimable dirty pages when deciding whether to start more
background writeback.

This can repeatedly wake the background worker even when there are
too few dirty pages to write. In a 15-second FUSE writeback test,
background wakeup requests dropped from 2657 to 682 (74% drop),
while writeback_start events remained nearly unchanged at 99 and 98.

Check wb_over_bg_thresh() before starting background writeback through
the strictlimit condition. Leave the global background threshold
check and the wakeup required for dirty throttling unchanged.

Fixes: 0437906841d0 ("mm: start background writeback based on per-wb threshold for strictlimit BDIs")
Reviewed-by: Joanne Koong <joannelkoong@gmail.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Avi Weiss <thnkslprpt@gmail.com>
---

v2:
- explain the preliminary strictlimit threshold check

v1: https://lore.kernel.org/r/20261031070515.3042848-2-thnkslprpt@gmail.com

 mm/page-writeback.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index 499a35473e4f..0529b4a7e99c 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -1824,9 +1824,15 @@ static int balance_dirty_pages(struct bdi_writeback *wb,
 			balance_domain_limits(mdtc, strictlimit);
 		}
 
+		/*
+		 * gdtc->wb_dirty includes pages under writeback, so use it as
+		 * a cheap preliminary check before wb_over_bg_thresh() decides
+		 * whether background writeback is needed.
+		 */
 		if (!writeback_in_progress(wb) &&
 		    (nr_dirty > gdtc->bg_thresh ||
-		     (strictlimit && gdtc->wb_dirty > gdtc->wb_bg_thresh)))
+		     (strictlimit && gdtc->wb_dirty > gdtc->wb_bg_thresh &&
+		      wb_over_bg_thresh(wb))))
 			wb_start_background_writeback(wb);
 
 		/*

base-commit: 36aad21d50d1af3f6954bb0c988257a908202477
-- 
2.43.0

