Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E5D13F86E1
	for <linux-fsdevel@vger.kernel.org>; Tue, 26 May 2026 11:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779796729; cv=none; b=qNDSjPUINrsDajtzp39D6nylfQkS0oiCPlzhpm1al5n3SKeasY3Rln1d7gUnAmz60EHfUakr+qGKo8bMvzC/h/c8VZhazFRi5XsQhG81MK9hoq0AN5fYrCWa+Ap/oT7p9PQdovevq0MG2Uja1tfH0eX3xqg8oIKMIGPiclDkfrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779796729; c=relaxed/simple;
	bh=D/IrO9+XnOtD8l1zgvNvw3o4LAAN6+IcmTzqMfM5I08=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QpzvgP9/w5DOlFQaQQGnunHHRtYuxSoJUKCSackbanllHetApkrshOINQLvamU/Zr/UftNRoKHUu6crE8q+lzSSEOk6yZ6Zr2yUCuXbTw4RT9BSepTNqXnR821yQt/zzGxDYz96+BpZNnuoYwI2CjZBFjvqy1x+VQ8K2OD5NKNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZI5n7vCx; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=PU+ELERd; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZI5n7vCx";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="PU+ELERd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779796721;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c8InDZeEQH/9HBeQRvyUgXxDbI86LGatUfZo1HBEXB0=;
	b=ZI5n7vCxNAoBLZjGAuoxTTrMEaW9o38NVJP8b3A9HGqVJYjgYOHnaquK/e/tdpQAEYq56a
	d20QWf63RnJo4xk2H1LP2SNNEataNpmQUnVHhOuyZ7kgg3Z6i340NgydEd7D41cthZngLt
	qwubqjLtTjP158sfYlQ/TOfuFhpSG2o=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-151-u7asjlADN02fk5AMHWlTDw-1; Tue, 26 May 2026 07:58:37 -0400
X-MC-Unique: u7asjlADN02fk5AMHWlTDw-1
X-Mimecast-MFC-AGG-ID: u7asjlADN02fk5AMHWlTDw_1779796715
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4904bbc6094so24333975e9.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 26 May 2026 04:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1779796715; x=1780401515; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c8InDZeEQH/9HBeQRvyUgXxDbI86LGatUfZo1HBEXB0=;
        b=PU+ELERd5hmb2xVsGKd/MBB8D1e49qZQTvQGik/Vl8jT1mnW5s0WSD1ehBI6QvTHVI
         /xOh1D/fXDEuBoy3YMFvVXEdAoh1S6iOjkmVKyf5eBG4ul50yeYn7Mfu/tWng1axCPTd
         JLgKRh+Bzhq+cCZZ02eBfEqr1yXeHZBSbL3cIlsetdwiV3HMWKgd966Y2gP+cemwpo0F
         rh787Q+QUa6+fkCRYl8risKWeYAne6MKgGtboOgTGJIwi+sqYlVqwVGkkv/QvL1aEJom
         H+hgTN5sBPPeYveNVIPhT/MSy5uCSE+Q9tufGS1Fupoij5LVfZ2c4E44mCbZXOtA7NiJ
         wgzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779796715; x=1780401515;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=c8InDZeEQH/9HBeQRvyUgXxDbI86LGatUfZo1HBEXB0=;
        b=RA18wsZuFCLT2N/RgmoE9PYJGBf1h6C6zft7pyaJMU42AUvwl9rflUHfLcufMGIG4h
         w5rRv66ySu2X6rfQv+6qKgFPTarRNYSPUJeNM6XRD9tPR/k1Kei02NAX+S0P73YZK9MX
         TwgEtnJVrem93ifNRFUHztkZzoBr4/97y01RvG0mCfp29ktC8oWiqN/25/1xicpg6WL7
         9eEUxr51At3VBX5O1UTbT+IV6MLg/qUla52bFz41bc1C6n+JO6MkYhzL6QlgAwq9P9oh
         rWyhfC3PZK7kEmGEQNHlm+vQKsJzR38Eflz+X3oKPqGO+q2wHUzLEnYNxhuGQv2GOedR
         /t+w==
X-Gm-Message-State: AOJu0Yy4+MIzqqWtPQx8EOvV48UX16ohs42zbUQHmkZBxH+xQpLnHL9E
	cBKTT02ZYG3+LPWowFN3kxA24NsjlXmv+uu1+MrGvUGv7duUy5pj5jDRHJb/39P6hixIAor6cpl
	YuSJSbDaiOzTMm+6MCKOkZ7VQT6v+3R+xjfUK0cw1OIbPhZztF0AuoiCJj5+xIWEjH5ot00Hzum
	G1mhUXiigcLoQxw4d6QLANpymw59GuYQTSVBbWnmO+lmw2AamLDpk=
X-Gm-Gg: Acq92OEIRVvotLnXs8d/DuP3Hhl1ef1kszHNKiD6SO4AMAsa3EAgDj4KwX0B0qY8pPo
	sODA04e3zoJc7k8woBkNlWoAD8vGMrviI6Z6O6kgjd0eFJBI+hisEl0xGt0EB/Nk0CuUE6rb/AV
	ZYQOdALIDiSfa+YJdqtolIEjqoWUqMDzlPqdkFAnp0Xj745QVd/g9mSfzUr8V2/r2UW1EBZregE
	Ut6CWKI3sQtA/ukJke0vGowGYybwdvOnfCM3KW5lZkbS/J0bbUU/pBtZolxqtE2zYqWYDY2HivK
	Wh4Cxg3f7AjdcLp/bNpMzVaaiUTN0hBm+wzSxSw7ix/Tr4xNq3Q3dAgR05HxOxZsZEpKhjuVBiF
	fUKh/cizN91arc/fIkRyemJs8SHk4EUpf2MxawHbmcNdTa9zV3g50lYEbkwooiP1UX61N7XT/H3
	hQzuKukfm6u2s=
X-Received: by 2002:a05:600c:4510:b0:48f:d5d7:df63 with SMTP id 5b1f17b1804b1-490428dfd36mr290533295e9.27.1779796715334;
        Tue, 26 May 2026 04:58:35 -0700 (PDT)
X-Received: by 2002:a05:600c:4510:b0:48f:d5d7:df63 with SMTP id 5b1f17b1804b1-490428dfd36mr290532915e9.27.1779796714895;
        Tue, 26 May 2026 04:58:34 -0700 (PDT)
Received: from maszat.piliscsaba.szeredi.hu (78-131-46-194.pool.digikabel.hu. [78.131.46.194])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490428d4d8asm110335325e9.16.2026.05.26.04.58.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 04:58:34 -0700 (PDT)
From: Miklos Szeredi <mszeredi@redhat.com>
To: linux-fsdevel@vger.kernel.org
Cc: linux-mm@kvack.org,
	Christian Brauner <brauner@kernel.org>
Subject: [PATCH 1/2] simpe_xattr: fix rcu'd union in struct simple_xattr
Date: Tue, 26 May 2026 13:58:29 +0200
Message-ID: <20260526115832.1294821-2-mszeredi@redhat.com>
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

'node' can't be in union with 'rcu' because simple_xattr_list() uses 'node'
to walk the list of xattrs with just rcu protection.

call_rcu() on the freed xattr would corrupt the forward chaining that is
used in this situation.

Removing from the union results in a 16 byte increase in the size of
simple_xattr.  New measurements:

v7.0 (no rhashtable):
  File creation: 993.40 bytes/file
  Xattr addition: 79.99 bytes/file

v7.1-rc2 (per-inode rhashtable):
  File creation: 939.73 bytes/file
  Xattr addition: 1296.08 bytes/file

v7.1-rc2 + this patch (per-sb rhashtable)
  File creation: 946.84 bytes/file
  Xattr addition: 111.86 bytes/file

The overhead of a single xattr is reduced to nearly v7.0 levels.  The per
xattr overhead is slightly larger due to the addition of three pointers to
struct simple_xattr.

Fixes: 12e9e3cd03b5 ("simpe_xattr: use per-sb cache")
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 include/linux/xattr.h | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/include/linux/xattr.h b/include/linux/xattr.h
index a75b99eb1f04..7aaaf4f8aff5 100644
--- a/include/linux/xattr.h
+++ b/include/linux/xattr.h
@@ -112,11 +112,9 @@ struct simple_xattr_cache {
 
 struct simple_xattr {
 	struct rhash_head hash_node;
-	union {
-		struct list_head node;
-		struct rcu_head rcu;
-	};
 	struct list_head *parent;
+	struct list_head node;
+	struct rcu_head rcu;
 	char *name;
 	size_t size;
 	char value[] __counted_by(size);
-- 
2.54.0

