Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8565A34753A
	for <linux-fsdevel@vger.kernel.org>; Fri,  3 Apr 2026 09:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775208456; cv=none; b=NCgNHP97JpHTGVCinSVjuzLxgKCXSXbZ1hEWMti+n6RBG7n1UwhPjZBruASX6pC7ohFz93CcXOpXnN59WThCBd7r8Z1dOgGaybATd3uJIvo9vj3963zRbp5eENTd6R+knpLrdzHsY4GPukFastmoVKui2Z4tzSrrCqh491JAMJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775208456; c=relaxed/simple;
	bh=5oxNwW+wEZpX5fOkU8eBX5+mmXvt1zb30mUnXQj4Go4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mgH7r1dg3DkEcr1K3zVdAHnZVleYmodXCGBovsha0mXrMfFzPeLOrsN84SnSnYED+u6MmfZl4YHCO5rmi+4YDHlg9W/N87pLbzxo2nKvS0F89uFtRDjZC6Tn/eOzmsNgmqNrcEic4mly6WRcRkGmGPjWkTf1W2v2WEn/600+Rvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HDJhcRSl; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HDJhcRSl"
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-7d77b179b52so1358634a34.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 03 Apr 2026 02:27:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775208454; x=1775813254; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kQ3PIjA+gTG31lVIuXgl+8pyi/g/oAQ5T9CUQiRyFyI=;
        b=HDJhcRSlCwSQ2zh7lKk/h3hzrL6dpXuO5Awo3DqXNi/bP+JWyQKpDal/3fmbNx07wd
         h0E5tTfTDk55ok9NX0CSJ4ewro6ygfy/csPbLVVmG+vceoravJ7Cb2tUSf3nsDL1JAVd
         rC8knmnTWQ28mKE75fwvqMNiTB4M4uGQyZBfuRlDhPrsUUgTyApVeB3QzJAVK0+7GIWN
         95uB/2+pIjrcd+GmN6I4STXS9Kp0aI36frdoDI5iVRBj9wPFhZw/AsyHGvR5Kbb3sdXA
         +p1+EVL7QhEmWr4h/sfC47MH++uxV9rsvLUokrxZQlXBH1BwDuZOFg9vL/eGxX1doXj0
         9bOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775208454; x=1775813254;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kQ3PIjA+gTG31lVIuXgl+8pyi/g/oAQ5T9CUQiRyFyI=;
        b=a+eeQ1ZEBJHl7Og8qzAZhM2EXHUezvAMcgfauueaJYymkWdr6x9XqV0n/MQw8fv0YF
         tKL7qOvS0pbkVUXTy2FNYtUkyU6Eufjzz71mxnY5+ssJ9XkQ4a+5L5CA1qMbsnMQ7J0v
         nvF04Jf4rKlqGj6gcsbpkNBMATZiZyN/hn2Xot9OJfDeJWSLHTVrmbzjB58Edn27yJjr
         98NU5TFYdOIGbLYM6P2jaAOQVnGWbbrSdStFJ6XFq9H6YCHIgqoPZfg6TXPJ+o609341
         pTAoyeQto0ITTFUl74nYsLiFRvI0sFyRz1DjIIZRVZBTCkcqNh0wkHfhfynS2986WdU1
         jATw==
X-Forwarded-Encrypted: i=1; AJvYcCXZNtkYSTuK4oZwGtmsPJ/ajnXmnwvLzwZsqcmGkqVV1SHb2zOSqLWEhkmcLv4e91eOshZMbBVKueoO9hYT@vger.kernel.org
X-Gm-Message-State: AOJu0Yxll6nOSUv+3dJRIpXtndOOo53Cn3RGD6XWdL3ydBrvyAFIbFI4
	pTC3PLR8IyKZEoUPSiXRUEbGF/v6r8VHbIO3cWweCtkXgjd+JVHsaX2wGnafCQFh
X-Gm-Gg: ATEYQzwRAOAeSYkluubrVyW0uay0V0wdiAF5NlVN/qqQj0gVm1sleyza5od8JJufUEj
	yF5eCFBN6Na4m/Jqi/kXt4oKWah5jDCSd+rSryb53aBAxLn/9kUZPJrzjGUSYSsK74IfoPxPItB
	sAQ9FicU3JLyd6IsnADY+Ntb6BgzoymKKb79zqV03ul6/O8saUZ1mSH8nK3gv6iUtWsoAu+YlSz
	lVxXPiN7+K36rut+mPiQfPIopmIMkY5FMA3RyNyELYdZ9CFV1U9rBw/LP9ZQcFK/ryt8zop3+3S
	W90ayXhzqSuPm9yWxK4MiVjiVUCcwRjbqpi5p6Y5AVHLYY0ForSzk9sGjDAAfDwJ2m5965HKrZc
	h5s70GBzkBSz1adr4pygwoXVjjfiBkVs/qnAxNWAVVnonT3XcYPxX904fMqqb8E4agsZomxBr34
	6UzmbEj91yRN61wdFUz9p9JjrCIXKKcqvdCVZG1jcQNXIr/KGN27A=
X-Received: by 2002:a05:6830:82e9:b0:7d7:ecf8:6b with SMTP id 46e09a7af769-7dbb732b1a0mr1480965a34.2.1775208454448;
        Fri, 03 Apr 2026 02:27:34 -0700 (PDT)
Received: from Linux-Ub241.fyre.ibm.com ([170.225.223.17])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7dba715bd95sm3898409a34.8.2026.04.03.02.27.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2026 02:27:32 -0700 (PDT)
From: Chelsy Ratnawat <chelsyratnawat2001@gmail.com>
To: jack@suse.cz
Cc: brauner@kernel.org,
	linux-fsdevel@vger.kernel.org,
	Chelsy Ratnawat <chelsyratnawat2001@gmail.com>
Subject: [PATCH] fs: attr: fix comment formatting and spelling issues
Date: Fri,  3 Apr 2026 02:27:09 -0700
Message-ID: <20260403092709.83458-1-chelsyratnawat2001@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Fix minor comment issues in fs/attr.c reported by checkpatch:
- Wrap long comment lines to comply with the 75-character limit
- Correct spelling of “overriden” to “overridden”

No functional changes.

Signed-off-by: Chelsy Ratnawat <chelsyratnawat2001@gmail.com>
---
 fs/attr.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/attr.c b/fs/attr.c
index e7d7c6d19fe9..ded221defae6 100644
--- a/fs/attr.c
+++ b/fs/attr.c
@@ -46,8 +46,8 @@ int setattr_should_drop_sgid(struct mnt_idmap *idmap,
 EXPORT_SYMBOL(setattr_should_drop_sgid);
 
 /**
- * setattr_should_drop_suidgid - determine whether the set{g,u}id bit needs to
- *                               be dropped
+ * setattr_should_drop_suidgid - determine whether the set{g,u}id bit
+ *                               needs to be dropped
  * @idmap:	idmap of the mount @inode was found from
  * @inode:	inode to check
  *
@@ -165,7 +165,7 @@ int setattr_prepare(struct mnt_idmap *idmap, struct dentry *dentry,
 	unsigned int ia_valid = attr->ia_valid;
 
 	/*
-	 * First check size constraints.  These can't be overriden using
+	 * First check size constraints.  These can't be overridden using
 	 * ATTR_FORCE.
 	 */
 	if (ia_valid & ATTR_SIZE) {
-- 
2.43.0

