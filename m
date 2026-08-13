Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0A2934B43F
	for <linux-fsdevel@vger.kernel.org>; Thu, 13 Aug 2026 23:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786662926; cv=none; b=qnAtClDpCKZvhgCqEwpL8Ccp2GJ0m8fNkP0p9lWqhWFPdp3/XKVhEtQHKeMRUyUmdLqrevXVgkXHgyv99X/bT8nCxIpji7leROBBZRuIe4b4757Y7tyXWgwZ1tT1ZhlWpUV4gMGKM4cid2iyVLNG6XOq5zOrL6maVKegE4qhT34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786662926; c=relaxed/simple;
	bh=YJ0GctRszvIKIqg19TlIBkvv0FI+SwPONxrk6rpRKLQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ozCsBTtRrhRc90BytK3Qhlo690uaWh1EyK0EKU7QHmRwOgqN1lABzO4BxvFVH2gypr2AuA+gjmEQDkkwTbvYXvcQKmOLJrznMh9XD1o8iH8AXn5pu0vUjBMh0Ors3z2eA5qAvTkqDXgsSs9ooOWAukJo3MP08DY26YCWNR/1Shc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S2H6pwgY; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S2H6pwgY"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-6a17c04563fso522397a12.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Aug 2026 16:15:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786662923; x=1787267723; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=LTD6BtTzhZc+5oE3do9kLwU8Olj7i1/xKAJzBTLYsUs=;
        b=S2H6pwgYGrN1UTYrp2axhqZj7bN2BOZnoa8XWZy18hj0cv9+URtT4YAjFYpxk2kKJ+
         5cMqOaWRb5TdsINMdAKbiB980JcfxqrmIh/jKnzDAqUFfPzL/Ly8MEWktrR8i6FXV2w3
         ZWVGc+P+oBSWTzrrfOW++v1FunukvQor2r1GBGUgwCu+jVFowzWefV2PcZppmURZdUQ8
         byQZmdPZxEXMZ6Gizb0hRZMGy9TjxBoate5C72urA6DW0y0FnL4JLgEpMzyhHAcAjOa8
         yDERlTDG0R4jXfabOE2Y7LuvkpMVoseiSISzltGehIcLAVpBdT72WNTrCnpUTh90CrX3
         wfTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786662923; x=1787267723;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LTD6BtTzhZc+5oE3do9kLwU8Olj7i1/xKAJzBTLYsUs=;
        b=ia3PKdx/Tru4GOjkIShecjIAY989hzqZd3Gelyrgd+knKe/0Kh84ebcY/gTO5sy3IB
         hxlgR5foTJUapABXF3qS2zUvP/1ZFN6jnRD6+gBjBvBN5hioBqsX7sjMcsa0AdnpBPEh
         QpcjY9n9sK5wZYvqMoW0lG/Nwj86P7qw7wwWaajKuAkAaLAq3BxGlPLTA7U46WFUoQnT
         JEj2NhZ7VnCWwBpv4q75eA+ajoLY1I3PHS84DVEn2jDK8vmaW7NmtO65dLzDexcUtolj
         obR3F6uugF0hp61nAFLGou0XCI/06wNjd/JRtx/lHqrHJYVOWfyGs5mnJk3CkCGGR4fk
         U2dw==
X-Forwarded-Encrypted: i=1; AHgh+RrmXIrAXE7VLv8sDqofY1a8PkI15DHsQxSaUr9qrYYRIvcQ0SOEfPCyJnw/iscRRSzwzmndWyGf/IbAm5ol@vger.kernel.org
X-Gm-Message-State: AOJu0YzsqjKwBmz3Wwr1b5Ht8j4BFMYjkfdA51N1EJcJv35YE104JypW
	qtcdg7muLaKzTdszeLqoxhXqKvq+7/QTkI6ed9KWSG+tt0i5exjC6EM=
X-Gm-Gg: AR+sD12u9j7dC8gsaQDNuzW2qgjFGPFb5B/L+sHgkJ7++H7v+o5R3K5U/0z3BYri3ZU
	iQ8/slL6FYSt+g+ZbeFqOgkZiDA5980IMxNJWbQWt71OONbGw+Mby5gXAY0jev5tlcDE4BUmSb7
	IkmzvLEm4JOk2JeHNr6pRzIaczsjObwkG/hX/hZsVaU1s5SxFgkky/XuIHZwd6G/B7ecIk1e9aI
	8C7m0jePfFV1hdcnlollN5j8TJReRgO3i/Loofpqho3CvrHK/93xzGEbbCRVK+w7N9ZqGT9QFFV
	+Q7cyF/guY0QRAQ+12HRZ3+66ElwEp0YbOMGVcQ/rQEZAbOKYh0/a8bkgv0fiVTi+t5TEaLxlZS
	hUcVW+CCAp5BK/WBI25tiQPJ6ss4qi9tzwU7K5ujSvQmvmx96mWr+tyT76ySrgWepOXdBbtBgqb
	7D8WT0RzdkmQwLN1URx04l+/vm6lkc/PUo8kbyW73rcWFT0z8RDtwmIgyKHJsh1IvzZYaDCwrEQ
	+E6r3aaDDHVaq+U5+vP+4RgIwqJkAGR9IjUnw==
X-Received: by 2002:a05:6402:e9b:b0:6a1:28d8:2306 with SMTP id 4fb4d7f45d1cf-6a38a91250cmr847748a12.1.1786662923038;
        Thu, 13 Aug 2026 16:15:23 -0700 (PDT)
Received: from arch.tail2fcf52.ts.net (223-143-146-85.ftth.glasoperator.nl. [85.146.143.223])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a38c9d5573sm122193a12.1.2026.08.13.16.15.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2026 16:15:22 -0700 (PDT)
From: Mark Sercombe <sercombe.joel.mark@gmail.com>
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	bcrl@kvack.org
Cc: jack@suse.cz,
	linux-fsdevel@vger.kernel.org,
	linux-aio@kvack.org,
	linux-kernel@vger.kernel.org,
	Mark Sercombe <sercombe.joel.mark@gmail.com>
Subject: [PATCH] fs/aio: fix comment typos
Date: Fri, 14 Aug 2026 01:14:55 +0200
Message-ID: <20260813231455.558829-1-sercombe.joel.mark@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix two spelling mistakes in code comments. This is a comment only
change with no functional impact.

Signed-off-by: Mark Sercombe <sercombe.joel.mark@gmail.com>
---
 fs/aio.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/aio.c b/fs/aio.c
index f57fa21a2503..fb991c66afdb 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -936,7 +936,7 @@ static int kill_ioctx(struct mm_struct *mm, struct kioctx *ctx,
 
 /*
  * exit_aio: called when the last user of mm goes away.  At this point, there is
- * no way for any new requests to be submited or any of the io_* syscalls to be
+ * no way for any new requests to be submitted or any of the io_* syscalls to be
  * called on the context.
  *
  * There may be outstanding kiocbs, but free_ioctx() will explicitly wait on
@@ -1280,7 +1280,7 @@ static long aio_read_events_ring(struct kioctx *ctx,
 	 * The mutex can block and wake us up and that will cause
 	 * wait_event_interruptible_hrtimeout() to schedule without sleeping
 	 * and repeat. This should be rare enough that it doesn't cause
-	 * peformance issues. See the comment in read_events() for more detail.
+	 * performance issues. See the comment in read_events() for more detail.
 	 */
 	sched_annotate_sleep();
 	mutex_lock(&ctx->ring_lock);
-- 
2.55.0

