Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793780491;
	b=5hnDaEfA3UKOdd2WI9/NjoY5B8j8jXLZnqIoebDfPqWv/hkRWoC/bMbFYCN8Za8d3YmY
	 EhtQSiN/B8pxiWBUBSlzsx4wsWYDltHFBdvNuAwIIeyzfsiYdijGtwuMRovv0t4T4cfGZ
	 iFY0p8FBz5LGZPTLnf04Jq47u7IUa2tv6vXcnxS6ui0G/wtO06AHmvsMhgDdRkwjsSskI
	 cuZfm33vImQvvHgFRsymRwMsgt8g0OfeFRFJIYpJKq4sBNhGiMmxmdPdXoiLGcjLIHYjU
	 5hwSedJ3lQ4uukGaeQZ3PHjDgK4qVMq6eYRUhfzD8qzk7bR1M1poOQr0b4fQNIm6Agg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793780491;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=2L8Phg4vAm8z6UFJHLXifD8svd0Kk4bbcZZ25kyGs7M=;
	b=nuCXcv5T54TjFv2yraeC0LevOQc3M060D3Oly74TfzH+RdDTps/yDgrEOVDNqFSUtqwy
	 GMpgUoxHmYjAwUU2jcn6oIoL36JwIQ4qGBDmJfUWJ2vBXFOjzz/J9v5Ise5dY2tExKBz4
	 SBXZR/Vsx7K18sjv6b5OaaO18pl37PdzKqmHFAMqs7oRr6tfk/snHsUJVNB55/7+KHd7m
	 gOt+0pGz9F+YU1A6855YLJuMcEl75lbiHX9I5fj5hYFCvKG1dWxuuTC0ehJQaM5wQSMSv
	 unl6O6WXlbgPhx+Egeq78oDf5P7odJSw2FumD5XQ/IjtHjtNaRb2kSj/Dh/eLwzcZ6Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=d8lWT74G;
	arc=none smtp.remote-ip=209.85.128.54
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E5EC606A326
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Nov 2026 08:21:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5E5EC606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=d8lWT74G
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4a5177d78c7so3145735e9.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 04 Nov 2026 00:21:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793780490; x=1794385290; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=2L8Phg4vAm8z6UFJHLXifD8svd0Kk4bbcZZ25kyGs7M=;
        b=d8lWT74G+yXWFlqGK8Bo4Tdcnvx0gGeCOXNOZ9hvAcn9Mnk6EPmrQ2cIwxDsCNRczn
         B8MmhbTG1GF8PnLdup/yJuHZA+v673ZG7cqmCYKELm34vpU7ONvPW/4n9hfSl8n8C9Fx
         24l1fernS6sYW8RQKkQiuEwgOWPgW4dwSkJsp2Xa61RvxLVVrO79WG0irFpzRmXVhAnP
         BYYO+Xmx8yrSRqVMr0LBFCISWGGUmUb7RTfWAXv8gyV9592UIQHQPjFiAVvz9grh37U2
         hokKw3BIWzPcJNNRWESawKpKIKF5nE6j2hzCQ6Kv4TG97G36A/ELCdjQw31mBQ6eRK2p
         zkAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793780490; x=1794385290;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2L8Phg4vAm8z6UFJHLXifD8svd0Kk4bbcZZ25kyGs7M=;
        b=fqCsRuRPLaC72UCy5wqQaeqkTu1ijFiT/qTm8E8xZpcWYAa7trtBlmvfDiWP79BDmZ
         0SSlsNhtRRG0K/KjnFApaS30mScLVTdQ6WxEv1pbo+nCK3CbBqKIihIEZIQjei9tAThA
         J+p+l9lZ72Kdg7uPPI57dU8SqOs6D9w+AApCQmdtG/BboXk5kznP5Qnfe5pXA7UQ6h0f
         WimyGQz5SZIJaPQvyrPNnO3eNtbL8quTO+Pm7B6fT7u07tVL4KbTivPy8BF+k6k//tna
         8PjxREXK6WquO6oux1lrjT4GPgt/yt9DUw2nZR1ZvuiMCwJ7gcEVoPMms/tWYw7+6C+1
         fgeA==
X-Forwarded-Encrypted: i=1; AKwUvBy1CrMTZwK5GL0nkts54N3YgIYRypPq5BaUK4dtPKYQ230RPJuZC0GOWvp/4HIboygb+HfJidVT5rbiD5NX@vger.kernel.org
X-Gm-Message-State: APuU4Z/QryM7W+eKZKyb5rImT9KspFcJMNZKXlRfxpB+SmW2YwDykYPo
	WQ3QtVedhA05kM03PJGjJHh3aLzkIw2VFnAgAQ50YA1YWUuZdb8ztDpb
X-Gm-Gg: AYBFou0e9Xy/BFErhIBQOdwwIZeekHu5EwOMHPhhDPKC9yiEqjo4ZexuVGbSoZcLorq
	2M/CySAHrGnnsj/22oioOks0eBZaBppviKWVOi6oTyiAsXk/ohB6KcShzpiJIrzu9YAKO2whrJU
	OHBtjjSOdWIAzGiXmyuwlt744JtxmwCV01fuADm/JdqLoT82wOievktD3bQHeIau9K0M8dmP5m1
	HPWDtHnWLYXReQQj/Z+cJa3AO08pkuz2hz0XkFb9JHSaurQDMdYdA4hezuxCgvpB4ORKbxthxPc
	y5Dssi/0ZyiSojtm6mtuKFpFqXDtfHn8JRS1kOAe4bkMRO3FrVbQXqgJwcv2AYa2QwywTm3AinG
	TBD2cW34Pe9YrV7tcOPcdFn4gXruHJ/qfuBrs2JximnKF5fCDp9dGVxj6JVlLPvHUrlCFuGvIt/
	KPP+0oJNVbr3m8FGRhrVqLkMdJURAqzziysCXvLUgrlNV76U8a4uMA7uwNZVQn0NdULD71Scf7h
	dK+Yiu1+T7s+YRnVckRYiE3GYEVMEwt9x7DOKoqA3r5jCWRuJ10T+B/QPMu1KS0LMcbzJtJ36M/
	A1zBQWGdU3QzWe5exg5uD+qjCl05GSTeLmKJbybP03+AET2AE+dF8NPRJxFUesLMXtSMyvCsZnU
	uBBvmdCb7qHI=
X-Received: by 2002:a05:600c:4f0f:b0:4b3:ad9d:e21 with SMTP id 5b1f17b1804b1-4b3ad9d0e48mr67987735e9.12.1793780489447;
        Wed, 04 Nov 2026 00:21:29 -0800 (PST)
Received: from localhost (178-84-201-199.dynamic.upc.nl. [178.84.201.199])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b43cff3fcdsm35490905e9.11.2026.11.04.00.21.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 00:21:28 -0800 (PST)
From: Amir Goldstein <amir73il@gmail.com>
To: Paul Moore <paul@paul-moore.com>
Cc: Christian Brauner <brauner@kernel.org>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Chris Mason <mason@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>,
	linux-unionfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] lsm: put the copy up creds when an LSM hook fails
Date: Wed,  4 Nov 2026 09:21:28 +0100
Message-ID: <20261104082128.3573690-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.55.0
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

From: Chris Mason <mason@kernel.org>

security_inode_copy_up() leaks a struct cred when one LSM allocates new
creds for an overlayfs copy up and a later LSM then denies the copy up.
One such pair is SELinux and a BPF LSM program that denies
inode_copy_up. Enabling both LSMs and loading the program requires
root. After that, each denied copy up leaks one struct cred, no matter
which user triggers it.

The hook calls each enabled LSM in turn. SELinux or Smack allocates the
creds and returns them through a pointer argument of the hook. A later
LSM can still return an error, and the hook then returns that error with
the creds still allocated. Its kernel-doc does not say that the caller
owns them on error, and the only caller, overlayfs, does not put them.

Reproduced with SELinux and such a BPF LSM program: 36000 failed opens
and chmods by an unprivileged user on an overlayfs mount left 36000
struct cred objects allocated, which kmemleak reported.

Fix this by putting the creds in security_inode_copy_up() when the hook
fails, so the caller gets either creds that it owns or none.

Fixes: d8ad8b496184 ("security, overlayfs: provide copy up security hook for unioned files")
Cc: stable@vger.kernel.org
Signed-off-by: Chris Mason <mason@kernel.org>
[amir: put the creds in security_inode_copy_up() instead of in overlayfs]
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---

Hi Paul,

I think this LSM hook was introduced with confusing contact for chained
LSMs and this change makes the hook contract more sane in this case.

Thanks,
Amir.

 security/security.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/security/security.c b/security/security.c
index f6583d5073959..ad382afbff271 100644
--- a/security/security.c
+++ b/security/security.c
@@ -2314,18 +2314,26 @@ void security_inode_getlsmprop(struct inode *inode, struct lsm_prop *prop)
 /**
  * security_inode_copy_up() - Create new creds for an overlayfs copy-up op
  * @src: union dentry of copy-up file
- * @new: newly created creds
+ * @new: newly created creds, must point to NULL on entry
  *
  * A file is about to be copied up from lower layer to upper layer of overlay
  * filesystem. Security module can prepare a set of new creds and modify as
  * need be and return new creds. Caller will switch to new creds temporarily to
  * create new file and release newly allocated creds.
  *
- * Return: Returns 0 on success or a negative error code on error.
+ * Return: Returns 0 on success or a negative error code on error, in which
+ *         case @new is left pointing to NULL.
  */
 int security_inode_copy_up(struct dentry *src, struct cred **new)
 {
-	return call_int_hook(inode_copy_up, src, new);
+	int rc = call_int_hook(inode_copy_up, src, new);
+
+	/* An earlier LSM may have prepared creds before a later one failed */
+	if (unlikely(rc < 0) && *new) {
+		put_cred(*new);
+		*new = NULL;
+	}
+	return rc;
 }
 EXPORT_SYMBOL(security_inode_copy_up);
 
-- 
2.55.0

