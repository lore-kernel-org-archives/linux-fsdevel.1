Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E1BE35201C
	for <linux-fsdevel@vger.kernel.org>; Tue, 19 May 2026 14:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779200986; cv=none; b=kMX/dZSIq7xoDYv0T0BqJHuItdbYrhhmf3LKz7lvsCPS4x61gBkjCcem7JxRaSwnzpq55skcSsO4KveBm5SwCFy/ZILP6syYZZh95HBf1RAHU4QzzdAHf5ub/tPNWIhHcXUrtiNVTJyDBfZ1lCVCG8ZeBKwWHdRDxJunx8nRlig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779200986; c=relaxed/simple;
	bh=aY8s/riUR8NbcTdsHB4cfFhuuDro+tneP/kG5QuD+PA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=t5j1dMTRQsnvvQPIwex7yTAifRltO6HifR3j9WF9F6M0B2asV9zCDWcKV6tjLydQKZipsSmp9/SFvLsdmkmyPjlKgAFZxz6tCtnj3cHFuNME6juIM2/amgUAo5+/mbJdpyY7g4vRmoxWJqUa7eY1uYz/nqv111mcVmIBFaHbBXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YOFXQImG; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YOFXQImG"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-48d1c670255so415e9.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 May 2026 07:29:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779200984; x=1779805784; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VeJGd6S2ia6XrvKCx7CRCdCtEvpWnP4MMITBk+g6Kz0=;
        b=YOFXQImGd6ZUr8W2b8Xotc2aumOl0Zul/oz7Eo9EG/MuUHOQBy7iBWYbHg8PH/8xDs
         /Ae/aMAxfaXC7fuzMI6ecmR0E1noFDDwQJgiXwDi4xT6QXx8PwC5mulY/uk4N+UWNXEt
         DPoDjsGNT21GSr07NZb7w9bzlt5u9RLLijUw05LYuS+pPVoxkWTmi5kS8clvD6xPUrc8
         1+bHRQCs9cMWmJpTp5YsfIP1e2yryODtuK2e0ZAo/Xb5exBRehjUfmVCryHnlMQQs0lf
         af4jsSDl8Lkr4bXpEBxOTpsoJBy6IuoVi+7OzqXI2l3VJID/G2k1ntymRpojLPvIGx3W
         491A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779200984; x=1779805784;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VeJGd6S2ia6XrvKCx7CRCdCtEvpWnP4MMITBk+g6Kz0=;
        b=kz9ItE6R/RNzGZfs6bI/Wd5k4ev3gG2+/SmEFeLakWDqsu26s06VV5iZa2tyLvNC5x
         Dy6h02bRnbtnFVsMSnzXt7UppBnhKMYeQfm1F90wjlJG+xlJ52Lt5PpFxHpF1v8kgOmQ
         5VOEgkN3HnzdlH6716JfMBIsU40oYgLPuww+VP/XKDAf/blJmirWt6VuxUcrPv2KKKt+
         s7aT7Q5kMUZ0VzgGTPUI9hb2QvgCP7zR4nDegASeUfUNtQ53jgmw/v10B1+DWNqA7ZZ9
         aUCIX5gh4dL5b6aTEEBBj1KJ1sRmdzOPyXyNN43SzWevyDNLCSSdTrDQRewqDcT+2x2a
         9wKg==
X-Forwarded-Encrypted: i=1; AFNElJ/8OQPU9+6OimndUQIIlRhNlgQl+Q6aFQn2U/p3pDWbb5gNvrZaGCtz6HrGzqLGeGuncN5Hxh7Qc2hFTr/B@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2VacMsGOBG2nyJoJMFNd1lNKHIrZGeCjNuzkmyPQF3TV49cW2
	j3HEJ4xJdF5yJsMVo+vEULowaGM/yEfeRnHBglx0sAr+AjlLorsrQ2VdCbDriv2h7on2yYXr2aM
	TTvmsLZAH
X-Gm-Gg: Acq92OGp9TdToj6/zKC0QjhLwyKg/3N8ya6yPBaJfOu0B6UOUPukkqRzBJp85aBs7MZ
	c2SErZqiXTeybOt0OU5WAAALvx3nQsrY+rFF3+lEEutbRvuh+8POpluwXojVe+mlOULQzryMID2
	Jl2EDTuEwUfaHp9srbdc+bSKlpmTu7Rfb+9W7KwHavp8rmXamJLm8rh66VUqNzFGzpifNPh5XK4
	KLCkUKixWuu/1x/SN8STPxH28MbqF96bvECOBkWglAzMAA8qcA6xtVwbl/WMjCuBhI//VwZqCE5
	JrjSUdRB9P2JI2z1fa64gCL+F/QIsqxpqSLsgEPazg+zyJdgv+GxPtGvQLg3LvYahNPtEPGiJoC
	KOBTV7W8Mz8FRBxSMV9f76QyyKjEGg4MD5CAvu72ISZYTz0RSOLGpLikA743tpqn6j0932sn/oq
	FGAlDMN3ehtZW4Jd4uljoEkCAG9lJe6JzpDFTNV+/XdJxzzkG24g1SRwTBj8Zbew==
X-Received: by 2002:a05:600c:534b:b0:48f:d634:b18d with SMTP id 5b1f17b1804b1-48ffa5e1260mr2322705e9.8.1779200983078;
        Tue, 19 May 2026 07:29:43 -0700 (PDT)
Received: from localhost ([2a00:79e0:288a:8:c208:c046:d3db:6b00])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48febe6faeasm108628185e9.26.2026.05.19.07.29.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 07:29:41 -0700 (PDT)
From: Jann Horn <jannh@google.com>
Date: Tue, 19 May 2026 16:29:38 +0200
Subject: [PATCH v2] fuse: reject fuse_notify() pagecache ops on directories
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260519-fuse-dir-pagecache-v2-1-5428fa48e175@google.com>
X-B4-Tracking: v=1; b=H4sIANFzDGoC/32NQQrDIBRErxL+uhY1UZKueo+ShejXfGhj0FZag
 nevzQHKrN7AvNkhYyLMcOl2SFgoU1wbyFMHdjFrQEauMUguNVdiYv6VkTlKbDMBrbELsn6URg1
 i0KPU0IZbQk/vQ3qbGy+UnzF9jo8ifu1fXRGsxXPNrVZTz901xBjueLbxAXOt9QurxG9ntQAAA
 A==
X-Change-ID: 20260519-fuse-dir-pagecache-382a54146826
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Jann Horn <jannh@google.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779200979; l=1836;
 i=jannh@google.com; s=20240730; h=from:subject:message-id;
 bh=aY8s/riUR8NbcTdsHB4cfFhuuDro+tneP/kG5QuD+PA=;
 b=1buKvnGP3P5SX8ycYvMxAc4AImC7lHVMZf1DFKNbo8dj6Y1CfP4DCb2dufCQGnMBD01yIA9Cl
 dQDEyzFgY0FAjBje5ihyZnJzNAi2VXN3Ro9I52ngmP3nqpcFwQkPDRo
X-Developer-Key: i=jannh@google.com; a=ed25519;
 pk=AljNtGOzXeF6khBXDJVVvwSEkVDGnnZZYqfWhP1V+C8=

The operations FUSE_NOTIFY_STORE and FUSE_NOTIFY_RETRIEVE allow the
FUSE daemon to actively write/read pagecache contents.

For directories with FOPEN_CACHE_DIR, the pagecache is used as
kernel-internal cache storage, and userspace is not supposed to have
direct access to this cache - in particular, fuse_parse_cache() will hit
WARN_ON() if the cache contains bogus data.

Reject FUSE_NOTIFY_STORE and FUSE_NOTIFY_RETRIEVE on anything other than
regular files with -EINVAL.

Fixes: 5d7bc7e8680c ("fuse: allow using readdir cache")
Cc: stable@vger.kernel.org
Signed-off-by: Jann Horn <jannh@google.com>
---
Changes in v2:
- reject anything other than regular files (Miklos)
- Link to v1: https://lore.kernel.org/r/20260519-fuse-dir-pagecache-v1-1-1f060c65930d@google.com
---
 fs/fuse/dev.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 5dda7080f4a9..f07c97358b36 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -1793,6 +1793,10 @@ static int fuse_notify_store(struct fuse_conn *fc, unsigned int size,
 	inode = fuse_ilookup(fc, nodeid,  NULL);
 	if (!inode)
 		goto out_up_killsb;
+	if (!S_ISREG(inode->i_mode)) {
+		err = -EINVAL;
+		goto out_iput;
+	}
 
 	mapping = inode->i_mapping;
 	file_size = i_size_read(inode);
@@ -1966,7 +1970,10 @@ static int fuse_notify_retrieve(struct fuse_conn *fc, unsigned int size,
 
 	inode = fuse_ilookup(fc, nodeid, &fm);
 	if (inode) {
-		err = fuse_retrieve(fm, inode, &outarg);
+		if (!S_ISREG(inode->i_mode))
+			err = -EINVAL;
+		else
+			err = fuse_retrieve(fm, inode, &outarg);
 		iput(inode);
 	}
 	up_read(&fc->killsb);

---
base-commit: ab5fce87a778cb780a05984a2ca448f2b41aafbf
change-id: 20260519-fuse-dir-pagecache-382a54146826

--  
Jann Horn <jannh@google.com>

