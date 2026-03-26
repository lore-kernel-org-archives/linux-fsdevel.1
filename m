Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30ACF165F1A
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Mar 2026 00:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774484100; cv=none; b=Ot6WLvr/jflgZN4lpwKfUDFrU/ijZFBvnVDMY+iAWjYfyetebQiywunD9gEHVNOz33E/xawYc6Q8YdoGdmTM+fytf7pEhpbecEt5Dde8hGy+Rqo8Iz6LPY3ArbpG8QJxtF/P/GPk12/J29vczE6PzMZl32z5/xPwLlGofMdkMKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774484100; c=relaxed/simple;
	bh=aDlHfep9rv53Inwi8Bo2mSSjgUexguYThgEuzmPAMFc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mKrqqqmM9R07AFQgE6ct/rfniQq0T5thQ+xuLw1bSLFmQUnuJY1hjngrdln+s5Th9XtBEVkPJQ06G9M+ckPPR0spBEBhcRsAwo0bO6pwDH9bCz248fDMKeInt5V5OFeGbzvKUkIuzNIEvD2T20jHC1u2XdVIc55tpK/vqbdRiWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LsNdWt2v; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LsNdWt2v"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-829afe24fb5so298769b3a.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Mar 2026 17:14:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774484098; x=1775088898; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yrBenhGvRwHPq/Mdnx3w0hWhdf5xW+E3HZRTVhRTrU0=;
        b=LsNdWt2vLuB0gFSUclZGFwMnyeJJViZGrCIhpqiuFHoPFJSHbMsbW8SrbmrgCTSrhi
         cHUUYaxdL1ct7NyqqJZm3RJs+vAe82mfa7ECTlYd7bMgmy9GopPpfpY9tSZc67C51c6W
         dcGCAzAqlafIdU31tu6Vk6TI7x/qQuJGpGgMIsi47K/iYFNMA/3tjeGIUSjld+otuO0/
         ASH28ozex5BcmasevB+d1ulLPQrEdnYc0Oc5WbuHzisW9ivgRIg0EWwncJJmY5LqeZwG
         w3f82pknRlL8VHootf1rwGqOT6rcE2K+d/kraS0weNQU8UWvB4dKyzpSPn3LyIGTkI5y
         8NJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774484098; x=1775088898;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yrBenhGvRwHPq/Mdnx3w0hWhdf5xW+E3HZRTVhRTrU0=;
        b=ODBvRvELfPcnhgTtYUGPljRLutcqwWJBG9dxpon0hAOn1t7gvtNuJ0htChBVpzIb3/
         JnjHBhIBVXo2DEPjR1adAoIinG2LpN3PYkglifPNF2JzzGqtgl+hmAH7WPS1DvjdO6jT
         IQpc5Q1TSdq1s+MfkfaUHhJ03MqS8+SbzN1nPOFhwnJR/g5ssnuBu5qyID/OmrT9qcgi
         rFRcj/SNw+UBDHMbj7kw/HmMCTkZkGRLFrA+KYLaU5sUl5NVTWQOWxTbGw9n0jn9ZPM8
         RUupF8daUElv3LQ/OVcFt+CglAvUafj+y5kNdXCvx0gwPNtoupZRAM/qtngXE9IpDtXR
         wjrQ==
X-Forwarded-Encrypted: i=1; AJvYcCUJ5W966rNV188M+Y8V7NEw3KXStk/Z0zESFcL3ppmg88IfNT3wCN9DW4Rs/smBgQVld5YMQPMmGsuKmPFk@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5PWjwYrRU9hRJe3/7Ofk//VJ5RqWIjV97hChvXAMbm9Wixbva
	3QO9UkNPKE7NoqzQ2xdsi4o+geAV/XGjNKbd2AnhaUryNP92AsWwnYJe
X-Gm-Gg: ATEYQzzSP1a/kpl4N9qFu7X+fgaMbkVolo08OYoOgG1h9o4PpU0TB/PHeWvGeZhKCYA
	QalPhHJzFb2C5mEodbNxEpjyZmoOFFvUM2gLD9+rzFl9c9atQkzUqxNGzfSsSLwS5vyZYhnGTQ4
	eM9Q8BFenA1FE5Y1d85ap8p+dlXvBtBvnxw45v3gAasRz1hVfsoMsT2nmjEPh9LUWAmqy5UCcNp
	xj25YeeJejk+P9PkEstoJyMBkBeE4L/wLcZXKY0xY+VcuwszbH21lrsA8WpQJaATTK8oTlyeuzA
	SdgBaphdv0q83GR87Pmxu5CtAkEqgcj5WWFgoV1jwOO/+qoL2CVIjOcI3s38NelmPuSZE4uvko0
	/ibE150kRHSfnDHrFUtZqgHMYKuTU7ZlbdNXnBn2wjUQGV3yMBm9Q+dyhFNRA3BLimyE28nkFi3
	FXbOzzdZz/HfBp8Jtz1w==
X-Received: by 2002:a05:6a00:1310:b0:829:71d3:1ddb with SMTP id d2e1a72fcca58-82c6e11d7a4mr5064000b3a.59.1774484098088;
        Wed, 25 Mar 2026 17:14:58 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:13::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82c7d3bf324sm897008b3a.40.2026.03.25.17.14.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 17:14:57 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: akpm@linux-foundation.org
Cc: hannes@cmpxchg.org,
	jack@suse.cz,
	willy@infradead.org,
	miklos@szeredi.hu,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v1] mm: fix writeback regression for strictlimit BDIs
Date: Wed, 25 Mar 2026 17:13:37 -0700
Message-ID: <20260326001337.828947-1-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 64dd89ae01f2 ("mm/block/fs: remove laptop_mode") removed this
unconditional writeback kick from balance_dirty_pages():

       if (unlikely(!writeback_in_progress(wb)))
	       wb_start_background_writeback(wb);

Earlier in balance_dirty_pages(), background writeback is started if the
global dirty count exceeds the global background threshold (nr_dirty >
gdtc->bg_thresh). However for BDIs with BDI_CAP_STRICTLIMIT set (eg
fuse), throttling is calculated using the per-wb threshold, not global
thresholds. This means the per-wb threshold can be exceeded while the
global nr_dirty is below gdtc->bg_thresh. This causes two problems:

a) background writeback is never proactively kicked off. The flusher
should be kicked off while the writer is still free-running, so that
dirty pages are drained before the writer hits the throttle threshold.
For strictlimit BDIs with global nr_dirty < gdtc->bg_thresh, this never
kicks off the flusher, so dirty pages pile up unchecked until the per-wb
freerun ceiling gets hit and IO is throttled

b) while IO is throttled, the flusher is still not started, which means
the writer basically sits in the throttle loop sleeping while waiting
for dirty pages to be cleaned but no writeback is running

This leads to severe stalls and degraded throughput. On fuse, buffered
write performance drops from 1400 MiB/s to 2000 KiB/s.

This fixes the issue by kicking off the flusher if wb_dirty exceeds
wb_bg_thresh for strictlimit BDIs. This restores performance back to its
original baseline.

Fixes: 64dd89ae01f2 ("mm/block/fs: remove laptop_mode")
Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 mm/page-writeback.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index 601a5e048d12..3f89b08b11b4 100644
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
-- 
2.52.0

