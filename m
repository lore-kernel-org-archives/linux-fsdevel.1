Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793135747;
	b=bI4NIzXvyaQ28eSEnXb3essFREDLwUw//bKHJXIpUH5D2jGgA2ZJ4tifIoKyc9x8LskB
	 szNWoNnW33Nt7qrri65Z4Rjc2PO7+XN+01hqK8LZanKryRG/wq1q3oTXJo1HCX4Q+uwn1
	 k2qOXS/T2FcFaSYErhwhZ2OEXFM+gt5xOmEY63T8VrvAtzI9UKQk2dW77iD7CWEQZZ5AF
	 Pi9fgrun/HkZ3dGpfvfdaIYjzPOaa5yf5OSRWqnzmYh86FoEiIdmIkq6qE61k/b53VYdf
	 gExIsppx/dUEqk9tfuTfyZNIljDl4XKWdHsuIzGjQciN/xLorJ7zpkfZNPUxwoayguw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793135747;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=sa7iGCeELZtURXOiW2lc5z/VEpz0Jw9PHYIzUSekpgQ=;
	b=Hi6krLby60zpP/vEQZXxqjvfGgFSa9VI93Xw22+YaDJ+2ohJ2LWJlL9hng8KqvUImopP
	 Lxp55BNDZJNhLlXYU+y6b8aCitRFwbWvDxoQWmrSAD/jfMsa0l9+VY0oMOOOumX9coz//
	 c/tf7DnmCBmp2nplQLYEdJ79u+LIQC5Wqv5KXPpKZ2Ay98amYQ9szc9LkWCWa2MqrRetB
	 /Jd3WFvrB45m1bNtCLv8aVxXEQrhslfxwCHRmfEQFBD4EaL4JTuFQFGQk2QCgfyuJnKlj
	 6fnCQ7UDPIu2YQ64djLyhF9zPm4ATXp3CvN45IPOOhWnze+YljnW/y0x/ejqRUCeNeA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=n23xO46Y;
	arc=none smtp.remote-ip=74.125.229.9
Received: from mail-dy2-f9.google.com (mail-dy2-f9.google.com [74.125.229.9])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85A36606A31A
	for <linux-fsdevel@vger.kernel.org>; Tue, 27 Oct 2026 21:15:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 85A36606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=n23xO46Y
Received: by mail-dy2-f9.google.com with SMTP id 5a478bee46e88-35fad13ca97so18187eec.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Oct 2026 14:15:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793135746; x=1793740546; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=sa7iGCeELZtURXOiW2lc5z/VEpz0Jw9PHYIzUSekpgQ=;
        b=n23xO46Yt4EHxY0+IBxA0vHRUMAiv3D4fk44zG6+9GofzQJnaku2ZNYtUUzfDhVq5Z
         czPYLesXClPMmy+Wvas4jcM49FCRNN0eH37iR3cx54B8HbSkyjrORVNpodzT2DzGI4TA
         NR+O3vm1/jWsp6gkJ4/wE7jNyRWwMbAE71E0X0AHCa3r0BZWwALPNk9gIJ8YPLL6St5J
         3mSzcZ4q/U5xdblS0sOOxdsgfnLwrhkC5w4v7vy13eRDI+nFhj45pquM2GTyfxPwt80L
         XO75/a2rgp35u6EdsXJiW6wLpdQRvZ/L7xqP7o5ouJmd8fAwt8f/IYpEJVPJyUt7vQ9L
         /7Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793135746; x=1793740546;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sa7iGCeELZtURXOiW2lc5z/VEpz0Jw9PHYIzUSekpgQ=;
        b=Gpg4bC/QMXl9V8qy8VG1KWOQ1qVr2osxnkT4G9OKnVC3IxpyerCmvWwn1wD5kw8S/0
         cX9ABRNd7n7Jpcmr7qOSLJ1y4ahpRFHgDQTzB/w3Su9N7V+WXPkMqN6SO5vOxx8ohKfr
         V3E4AHDOilb0F2fsT6sMmdccwfidL4puTNe5AlJw87/PJ2cd8YA5irGSvv2YO/Wkwvgq
         3saaIrvfO+xx5DDL5b0IO4h9sur4hzq1bFRYdJtuWcMlAtvQ8y1KFh/t3vYl/jK/pLZG
         G/OGeMTESKBG4qGYyq2Kv5TtIgaJSTeTF02VRKaZYKwIYRIIlbqjI0WXuDSPtfFWumyz
         c9HQ==
X-Forwarded-Encrypted: i=1; AKwUvByw+QKZYJt1RnLHohpemUSzRGzv18elZy3a0UhU/3xVVdkPhCBQDQ1zEhMuSX01PR2MFEcrF9FVOWXkPbUh@vger.kernel.org
X-Gm-Message-State: AFq9FYLgsRaIEaifvJpPEYWhJf3KX0HlR7WIlZmzCVaupVjYIzyCwSj4
	9pasnty6zbf3MZMiW+8EN1bn7WIAg3V8VyanRNseUt2EfqWrLqZ3aFHP
X-Gm-Gg: AYBFou3Zy+UQDUrBOYJoThSkJdkEKlYsN/QIm4Zw0XYutMUHYxO0HkZL2S8uTR1qdDM
	4AUBpSWCHogwALXmg2rmLHJ6SHgNGyW6FdxwmLdXU4jwjbI+RJilrlsX5bT5hS8o7nZWTgy2MXp
	rggyruVs6GfHam9QidfdmL1uyxUh7ygSNVEFDfrX4KCg5sX6sgvwIj/SZdcep8e8tun1poJCO6L
	vKQ37jTo4VkXVp1YyUDYLYRrAdiY34nZ866m6EtauiKBHu7YBV3UVuTOzZAsjg8OEdKSJlzSJMb
	OOh7EXs7zr+bqktR4JcOBM1XtMf6bvoVNtFc92nGjNfdTlM1VypPBr6vWowsYVdaACUERAz6Ytv
	Pdj3JOET8rRMKnyo0JSEcmhzHFr7p5WLKo+nEYN4zmEFEF3sLZw526Bx+rmqaEPDmAPQ1hGiC9K
	PcbjF/3xvkYZrNUeH3T9O9GonAy9+QlL8SdAt7yQxabMzlFWGXmVIXt1VLniOCNIRLNlr/xpBh6
	L1ysiOdRhFFPmsIwkk6LaL6Dw3ApBOXFI2HSG1SXiWeU0wJ8DFHoDPZRnjgWKRN1xEEWTLXD7E8
	uDHdx70=
X-Received: by 2002:a05:693c:2a17:b0:36a:1bac:6bf4 with SMTP id 5a478bee46e88-36a2039cb09mr845127eec.18.1793135746335;
        Tue, 27 Oct 2026 14:15:46 -0700 (PDT)
Received: from localhost.localdomain ([98.148.34.5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-369e8c576ebsm35750827eec.3.2026.10.27.14.15.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 14:15:45 -0700 (PDT)
From: Hungyu Lin <dennylin0707@gmail.com>
To: willy@infradead.org
Cc: jack@suse.cz,
	akpm@linux-foundation.org,
	lczerner@redhat.com,
	tytso@mit.edu,
	hughd@google.com,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	dennylin0707@gmail.com
Subject: [PATCH] mm: skip empty finite ranges in truncate_pagecache_range
Date: Tue, 27 Oct 2026 21:15:05 +0000
Message-ID: <20261027211505.22044-1-dennylin0707@gmail.com>
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

For a finite range ending before the first page boundary,
truncate_pagecache_range() calculates unmap_end as -1. The unsigned
comparison then treats the empty full-page interval as nonempty.

For example, lstart == 0 and lend == 0 cause unmap_mapping_range() to be
called with a zero length, meaning unmap to EOF. Punching one byte at
offset zero in a mapped FUSE file can therefore remove mappings outside
the hole, causing unnecessary page-table work and subsequent faults.

Compare the exclusive rounded end against the rounded start, while
explicitly preserving lend == -1 as the EOF sentinel. Perform the
addition after converting to u64 so the largest inclusive end does not
introduce a signed overflow in the comparison.

Fixes: 5a7203947a1d ("mm: teach truncate_inode_pages_range() to handle non page aligned ranges")
Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>
---
 mm/truncate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/truncate.c b/mm/truncate.c
index b58ba940be47..43c6cf99027f 100644
--- a/mm/truncate.c
+++ b/mm/truncate.c
@@ -919,7 +919,7 @@ void truncate_pagecache_range(struct inode *inode, loff_t lstart, loff_t lend)
 	 * once (before truncating pagecache), and without "even_cows" flag:
 	 * hole-punching should not remove private COWed pages from the hole.
 	 */
-	if ((u64)unmap_end > (u64)unmap_start)
+	if (lend == -1 || (u64)unmap_end + 1 > (u64)unmap_start)
 		unmap_mapping_range(mapping, unmap_start,
 				    1 + unmap_end - unmap_start, 0);
 	truncate_inode_pages_range(mapping, lstart, lend);
-- 
2.43.0

