Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793430325;
	b=UDpF0sBPvPsv76mihersDjFgXgsl5nY9CzUL+Z4o7XpEPDtJi5LyL+AJLIlpUa6iHWhl
	 Z4fvfiVaiiBQeMVjnEKcNay15w7/Hgel1RkVr12gaqi6OngWJq5hwcGkuOlVbXCRelcYN
	 BmscnpK4uF2YpbuLI2wDiFPRXozNR8V0MC7KvJO2RPKoaN4/mGHH3g68GMapdj42CYB9G
	 cyrago/3WoN2qBY57ECObbT2Ap9TMlLXHmFEw+47cBRxsDY0SaLDvDVbnwYxgpIIrS1oR
	 n+jiICi2Qf5AgvAtxfYZtBLaVLqp5vaog2A4hPAqH4zDzL+puYyrSVKxRE/5JWJQUog==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793430325;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Iufanw/5KFAPDTTrdzVdPmEyBabAy2noz2vvQUjeASc=;
	b=zwrCM2Rds4rPuZGTNgBd+HcH7JAJMdhl3OE+G+z3FJZqhSiEk78wmmJorkjVwDS0zIG+
	 CR4RXKloBF7nXpOmN3vquI9t9RedMH/8LEw/jJ6Ipzrk/VDPJrn0wIcIrgKlxrlWc9dkC
	 taxD22yTE84zuH4pOisrSf+Hn31n8gsV1bw46Ea4qdhbQeHwLvEyQ81hYO5uJr56X0WLJ
	 JdSE7BF5M0DU6oGzhKqVLB428NXWBRnOIeXPa866S1N9hjK81v3/u0TcCwLzTdu+pNV/n
	 5VNu6UqRl60UHssIReUtPEJJ3L3guN7i1ujoSiK82XRlcehMPNu5k0q3wo6Q159xoRw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FV31nvDo;
	arc=none smtp.remote-ip=209.85.128.46
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86F50606A31A
	for <linux-fsdevel@vger.kernel.org>; Sat, 31 Oct 2026 07:05:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 86F50606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FV31nvDo
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4a59100fa83so12384615e9.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 31 Oct 2026 00:05:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793430324; x=1794035124; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Iufanw/5KFAPDTTrdzVdPmEyBabAy2noz2vvQUjeASc=;
        b=FV31nvDoIjKAJUOaMuSEBDeDz0AWHffKOUNNU8NqBCX6rFZ28ZcYyiCXaHNPPJ+Js+
         Ud10cpoZ45oiBbYZHefVj9T4VJg9kmFObiLnjJ06T+5Ikdqwz2Zrd4+Aev7vBJlL45+E
         pEdnBavwUcxwiNAnpFH4K7ZsNR0VCh3HSuBx0MTp5lLYoDMcmMg8CsXSB9ncQU5G2g1A
         Uv/BYr1oMz6UpX/mdL90eXr83s+0m8pHdf4EC9Ifqy0JpU6JxiU2KVX1hy6vDoEx3nhN
         6EKDX3QTWDsriGnjK0OmhsC7fXNKo4yn/Ebjk/caMvEoX+t7a6RKTrAbQwKw9YqKoUEv
         yRbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793430324; x=1794035124;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Iufanw/5KFAPDTTrdzVdPmEyBabAy2noz2vvQUjeASc=;
        b=Wpc4C9+uh+sif87cItE/7iWI7aS1xh8WVUwtYTe9FuqdTOlQZOTRHOkWUcM/VZ/sO0
         9/umyf6+vHYDpuuq4ZLlBx72LWERtm1P9Q6JED1EXqat92dN99Asr56dHsELnQng8nHW
         N9tQX64BXDd0zySLqrMCOU7Oy0ejT382CX3WD6ZYZyGxzU9V8e5CoPOXgIpnnC88Alm0
         rNdbLvKOHAMEmbx1zkyBG5e0ewiv6oF3cSqBW39dKyzzSMZ+3S9kj9cEcCHRnaXwiyjX
         +aeWVxAPddVyPON9+R8NaklTBNdsfjbR/SCxf/o6elkoPkvPPDaNyKY9lsq6Zc88PBFV
         Lk0Q==
X-Forwarded-Encrypted: i=1; AKwUvBxfQwueDV2IqIC6KiY5onpkX4E4UrG515bS9C6EJxZ+E+iRP/YPcDCmd0dIgUfYrlpLP6V/Bk6D4ATAEtr7@vger.kernel.org
X-Gm-Message-State: AFq9FYKcOo7cNXqRa/8AGosm/yDHXAS+N2It/CIxAEIQlqsvUQ3E3hN5
	a806weCjRTCIMsnDDo5yXk/XQpwLkKJ8WnJ/KFpu0hgOJIOz1m2LQrPh
X-Gm-Gg: AYBFou03ZMDau1ZZqBiKZjdkf51cSBvAEaYfFjKYYAoZEZ3eA8980NyuokO9TzShqZj
	8kuVZ65pyZ3f2ikSYhoh3illHv8fmrfV+h44AqcNzBW05jbF0ynkQ3CnNmNtMfmKWc++58BOOYJ
	wVmlMoHV74pXjnoD2QJAK2DXONpVNTs87+658vWWqDhDS8ELkxIZGfDXVltva4hP8LaNs+P9LsQ
	SBcZYnT0oaiLixCBtBA5TLKl1UGIFON1Mv9KWNpi4UKmJc4HoQrGHOadDXbruvZsynVaKNVoVMy
	uB8h03RCJHVDYU6mPjnhRVIvxu5dUw5mypq8u15ycqjjG8PY+9Qpp0STC2cQmEGRSQrB5f3eEqF
	iCM/gk7ggtWes5VODyNCFbesGv8VZJ6HGwZFHHZt+FJPc5R/eLWJ/1aimuCkx2eK7PO4Ek2DyyY
	ObHyxvVqyGZ7slIpkGuNFgZGXveg/C9aoyTYHtlf2hYDA1vYO5ve+vT+liGKky6I21SMo6WRVW6
	7tjcvzJ4SbYpAr/d6fDh+3MSlEOy8yyJDOubM6F0+HxWMHik2nlCGdDnfYG0SWpQ0Rqzaoou0ul
	dJpqUm9924KVj5mNCrMaXhwPgf8iJsb9WAFz5uYpKsYi
X-Received: by 2002:a05:600c:8b0a:b0:4a2:e0c:2b0a with SMTP id 5b1f17b1804b1-4ac1709a200mr101686865e9.16.1793430323735;
        Sat, 31 Oct 2026 00:05:23 -0700 (PDT)
Received: from localhost.localdomain ([2a06:c701:4773:6f00:c8d4:ec29:293e:f39])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4ac09cc3e9asm46827155e9.3.2026.10.31.00.05.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2026 00:05:23 -0700 (PDT)
From: Avi Weiss <thnkslprpt@gmail.com>
To: Matthew Wilcox <willy@infradead.org>,
	Jan Kara <jack@suse.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Joanne Koong <joannelkoong@gmail.com>,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Avi Weiss <thnkslprpt@gmail.com>
Subject: [PATCH] mm/page-writeback: avoid unnecessary strictlimit background wakeups
Date: Sat, 31 Oct 2026 09:05:15 +0200
Message-ID: <20261031070515.3042848-2-thnkslprpt@gmail.com>
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
Signed-off-by: Avi Weiss <thnkslprpt@gmail.com>
---
 mm/page-writeback.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index 499a35473e4f..cb0c58715b93 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -1826,7 +1826,8 @@ static int balance_dirty_pages(struct bdi_writeback *wb,
 
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

