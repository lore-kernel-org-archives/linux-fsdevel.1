Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 837323F65E6
	for <linux-fsdevel@vger.kernel.org>; Tue, 26 May 2026 11:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779796730; cv=none; b=ho/TXOppsSVPTxCgTY6AqdyN8zT7InkPHE2vH+Ky1Q+/JwlAgYKfs7lBmxG3iEj4I/KqlFTn9rD9FgGYqYiyz4crUEn1exPNfGi3z2dngv/y+Ina4pTQC/57JHy/fBCvlqZ8rw4lI/K3lROTfXyzwao5rXTQnIfj72mYlrEUH5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779796730; c=relaxed/simple;
	bh=sagYG7HCKmDWdXyOwgBMQSIxsNXt6EcO2gexZ0qYdBY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HTjk2sSr5bu+qsLhdeevXcvwyUtc5hQYslYvz//5BqKqq5ayYyZW5cUxnVMYUKlwP3gj4IVlJSZYMt7aD1GUN0ZTUg41IfRmpbFHrhNd0UHnNzxBwTFRfHzI3G9y8c1yvnfVffWDhoBOkFOVSsTCAVxUQvicLCN//D/XLNabMaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IXJwD1x8; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=SCJ28AqH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IXJwD1x8";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="SCJ28AqH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779796720;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NPyeI3WYcfjl4yRl3ac7XFI0MNmn5AdhMMlnH8UitZQ=;
	b=IXJwD1x8TQWWJrv0TnPqdxWk47INI1SwWBojwidWb9StCws7aPquARtHxUIvgNnjKWdXoC
	pjfaqa8rYG4hoP2ALaM3u45CqyhZi7mob1dbZreta0mWCOQw3hgvm5hQM2kSi2VnonoIMX
	+CDCNOZ5s3oXAvlRVX71nK1H21uFrDA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-587-AOV5tf5vNW-g9TXZ0gGhFg-1; Tue, 26 May 2026 07:58:37 -0400
X-MC-Unique: AOV5tf5vNW-g9TXZ0gGhFg-1
X-Mimecast-MFC-AGG-ID: AOV5tf5vNW-g9TXZ0gGhFg_1779796716
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-48e79219704so72972835e9.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 26 May 2026 04:58:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1779796716; x=1780401516; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NPyeI3WYcfjl4yRl3ac7XFI0MNmn5AdhMMlnH8UitZQ=;
        b=SCJ28AqHp6wmCoY7x53QFeMCgXKZqx0mvEvIHz9jHA/RS1um015zbSCPSWDKy9o22k
         APleeEtmS0zqyuUQRRIXjw6W0OFEriDK94toC60tqTm5hsIr7M2UpKB1jCy+7hnlzk2Z
         wUi3pTQat6Il32V2KAOHKEta6LgBdrfigs21EX6jO3a9aJX6tyLWxvyY+G9EfR9bbMeO
         uAwSbi7iUsUTSY1GULMDOhWUL96tMsO6Fl7nOVtzW6+zPK0eNXbmMNT15jVO8/erDDeI
         SRfIcvvHzX4N7sgyTXqABBYwAPTPaAOkWb8bjUtqx5Ex1D/cOe5qPu+v7sgZr77u4Mjp
         GIKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779796716; x=1780401516;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NPyeI3WYcfjl4yRl3ac7XFI0MNmn5AdhMMlnH8UitZQ=;
        b=o3j5kHz4EZNHD9h6YUdm2P2KfQqLoZHF1CMm8TS+6IgomvQm+213T8/CwY1GlM4OJG
         u27LUdj+NUfp5aehFRg9qF/JLhIFvOiLCBBwt8ophhypYzB6kynObpVsxBzZDmmqEDIP
         kO9xtnl12H/BKHxfivrN+//kPLLu3QZpSBFBEU7jKBbz4YWL8SgzVIp7qAdTpU5h4gtq
         6SNOBqshU3AgeoGihDtDUKUQskQFEstVjY0am8Pgw3jdoG7K1uvuxxYWxBxLzjzEpR5r
         M3pj9cFE95Wz4ab+hqq+LdhWjUBzkZMNyUvxFuBJCedK6YXssFHggUfSPiwrN5LDvB69
         QAow==
X-Gm-Message-State: AOJu0YxReOlJHCsqVPUTV9iBfyRcsYbBrQQtGJCbV8w1yp3OWXJvLjKy
	VeJMllPc5YR+hYjj5i3QwJbE6Ky9LZMFGDt6BU9izxV7nlTzWOHdPDQYdbAZyPwB5jyT3QZug8Z
	9yzm82kB9qh7MLRBzEXVjSGz3f1ocdYTzo7iggU1VBr+0hXfKbhlzciuAcF9bn2g8rPk9s/qFtF
	tMcmSxd0j+v4gb6CLxgRWVkrbQBwhZwkVlf0aMi1tH0AWHr1+UMGg=
X-Gm-Gg: Acq92OHBCnHrLtJS6bkg95UWNgrHhvohvmoKoNYIEW3S9tmmfFlMTltYDNf/R0i1soB
	uH6UJjewLsLSqp2S1OMXeT8vAZovivwclBQybC00h1jwBUW8VVRVUI50tTDJwEp02i0rVOZbVFI
	mMcJkzyDZJgrN4ERt7LhLjfiakZ+6UGt2ZAGtuMidaOO0yxI8zdqP5qESb+Aw6kRqdBaCCQReJ2
	rq1FL0BEQhfkqgob4qU54Uq7+4DnIUk9S+B8SjeFONGgEKLVmWx1QV0pIGW1oSuFh717HIRTh9N
	QWefYU0KO02ZkxN701OXE8ZJcgSn+cugI02Q9F2aw1CGuEx3/keJrqv1ym5Y9trM6neb/NhYiE6
	f7ykr8L/PbFuCl1HAochlVodgepCWeMyYi78RYGakWewCXR/lTYA9wmE7Y5+NNSNcTElT2DjLJX
	CP
X-Received: by 2002:a05:600c:4e0d:b0:490:58ef:ce9b with SMTP id 5b1f17b1804b1-49058efcfbfmr209948615e9.16.1779796716371;
        Tue, 26 May 2026 04:58:36 -0700 (PDT)
X-Received: by 2002:a05:600c:4e0d:b0:490:58ef:ce9b with SMTP id 5b1f17b1804b1-49058efcfbfmr209948105e9.16.1779796715935;
        Tue, 26 May 2026 04:58:35 -0700 (PDT)
Received: from maszat.piliscsaba.szeredi.hu (78-131-46-194.pool.digikabel.hu. [78.131.46.194])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490428d4d8asm110335325e9.16.2026.05.26.04.58.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 04:58:35 -0700 (PDT)
From: Miklos Szeredi <mszeredi@redhat.com>
To: linux-fsdevel@vger.kernel.org
Cc: linux-mm@kvack.org,
	Christian Brauner <brauner@kernel.org>
Subject: [PATCH 2/2] simpe_xattr: fix racing lazy allocation
Date: Tue, 26 May 2026 13:58:30 +0200
Message-ID: <20260526115832.1294821-3-mszeredi@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260526115832.1294821-1-mszeredi@redhat.com>
References: <20260526115832.1294821-1-mszeredi@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Before being made per-sb, lazy allocation was protected by inode lock.  Now
inode lock no longer provides sufficient exclusion, so use cmpxchg() to
ensure atomicity.

Though I haven't found a description of this pattern, after some research
it seems that cmpxchg_release() and READ_ONCE() should provide the
necessary memory barriers.

Fixes: 12e9e3cd03b5 ("simpe_xattr: use per-sb cache")
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/xattr.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/fs/xattr.c b/fs/xattr.c
index 31cae48e11a4..57e117ab85da 100644
--- a/fs/xattr.c
+++ b/fs/xattr.c
@@ -1332,8 +1332,7 @@ int simple_xattr_get(struct simple_xattr_cache *cache, struct list_head *xattrs,
 {
 	struct simple_xattr *xattr;
 	struct sx_key key = { .parent = xattrs, .name = name };
-	/* cache->ht is stored set once from NULL to non-NULL */
-	struct rhashtable *ht = smp_load_acquire(&cache->ht);
+	struct rhashtable *ht = READ_ONCE(cache->ht);
 	int ret = -ENODATA;
 
 	if (!ht)
@@ -1356,7 +1355,7 @@ int simple_xattr_get(struct simple_xattr_cache *cache, struct list_head *xattrs,
 static struct rhashtable *simple_xattrs_lazy_alloc(struct simple_xattr_cache *cache,
 						   const void *value, int flags)
 {
-	struct rhashtable *ht = cache->ht;
+	struct rhashtable *oldht, *ht = READ_ONCE(cache->ht);
 	int err;
 
 	if (unlikely(!ht)) {
@@ -1373,8 +1372,18 @@ static struct rhashtable *simple_xattrs_lazy_alloc(struct simple_xattr_cache *ca
 			return ERR_PTR(err);
 		}
 
-		/* Paris with smp_load_acquire() in simple_xattr_get() */
-		smp_store_release(&cache->ht, ht);
+		/*
+		 * Provides release semantics on success, so that use of a
+		 * non-NULL READ_ONCE(cache->ht) will be ordered relative to the
+		 * above initialization, due to implicit address dependency.
+		 */
+		oldht = cmpxchg_release(&cache->ht, NULL, ht);
+		if (oldht) {
+			/* Race lost */
+			rhashtable_destroy(ht);
+			kfree(ht);
+			ht = oldht;
+		}
 	}
 	return ht;
 }
-- 
2.54.0

