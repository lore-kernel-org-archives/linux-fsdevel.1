Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793270366;
	b=QLyjsQojBCkBCmsQLsbaeW7Gt8pHvAvtturjjAik8SOo0TwN1aJloxF3FqbL2XzYcTet
	 /2OHsgiQixsgB/rHLgWVTrchu+ab+cWakN1bN6jGrWiqa+OX8TZmCbv3PNEoZdWiDvsQm
	 vSbJktsxl5IQZq3+VgtxtpfvdKNv6mxPCCV704egnxOxNArvG816CtbllW7ZK1kPYYo6Q
	 NNQIbEHXfp4Oh3eF+0UMov5OocbmZ3e+OVxrvWA7WYdWc0+Yj4uOOsTPhk6t3WJan6Cqd
	 c1vcvBw1N+RIZLiaMGqYQTfEH0ccHUk+En59DvknxplU0gRogwYCI1oVE0xZkQmM9HA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793270366;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=xgI79fkxqFLajK7iDGLVXmUc9XmvD6di/dY1FwycFRk=;
	b=IuMVpqwVjfzqRREWKsoviQJRktzrtAbFK9Ta1+ucgY/KLvoNWjTDW+kimUu2iiVNnL2C
	 MdED+lnEzusvR0QJKev+4TiSenm2OpE5Rd7DaRnsroEz2vk9SjjKTpCPb9+ZPSsjOp3cu
	 GYFom++1gtRkSYli5M14C75KK2lIGWFPrmTKn37oSkmdS/kj+WuqVeXBPUnDBAG3fhEpV
	 pMqU8EPuhjgaZ8HKKkYzApQl87cBhfM3H9c1FutK5pVBuZEpE8Y3Qa/wo2yrAqjElA6PO
	 MwoksHKa1i2ZWWlrvKJ6zUrzn3WUvFEGlXI7YoGPDTFf49E2M+ajNZ+OlPx6HTr6s5Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0tsWCG2o;
	arc=none smtp.remote-ip=209.85.218.50
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13FFE60A2619
	for <linux-fsdevel@vger.kernel.org>; Thu, 29 Oct 2026 10:39:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 13FFE60A2619
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0tsWCG2o
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-c418e215671so252189666b.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Oct 2026 03:39:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793270364; x=1793875164; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xgI79fkxqFLajK7iDGLVXmUc9XmvD6di/dY1FwycFRk=;
        b=0tsWCG2oAp4YyD/tVOlTufIkez3k959y9Lsw3Z7v642aMAUm7Por3flopgT27Qulbs
         zAKOhC4x11WYsNe1rOKhx9RXf7I0EJneW5FOp1aKhDmCGReVz7vHOKRXr+XsGqrgBHwl
         DajmL0F46MYGvadTfx+XaOYZxHgKjljtNGwpi2+QIXm7KW1SH8xKe+zww3QRVssI5pf+
         Xg5s7mIALZGB87aWX6YhHa0qGlTvuUax8zZQrmlIJ0h1+EhaE0naU1gImSkoNuHbKhPR
         5SVPOYZn5TUdfwAwiWWNsnvrLrvT5TCTM4e7Ef0j/1DMH3PSl2UT7fGbIyvAvkTKH9Uj
         zUyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793270364; x=1793875164;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=xgI79fkxqFLajK7iDGLVXmUc9XmvD6di/dY1FwycFRk=;
        b=VbCcVBMcrOumcq/ec6+lbS7aUXJNbkkLo11eVPGAFGbLNdNxQebInuC39oU0qalkkE
         G4oGZPGINeE/HcB7p7jl0GchaZxe7kADRGevufs0XN7jr216Eue2bni9hc2ZFrU1LYi1
         LsEafT1IQDOOoSvBcXsFNDxvD8EzKunsv7NXG0X5KtZzmin7xuNy3mE47pvw/YF4FGu1
         EU694tUOUTvWEV226Gh3/N8TU+1yZTi7Fae7mGvxCghD2MIqrfAXGkH6eK6KQB7y7ILN
         BcVhsVJ+Ia+vWStQfHWRNX3+wtae5FrYVVgued3Fqjktuch7QaE4ElmTpvaurZLUwUza
         Fgqw==
X-Gm-Message-State: AFq9FYIReLpOZ0Ht8su9Lddf0KH0FBdjohZL4gsuf2ZfZn7LkB78JiUz
	vNfkw1E14kiGrrmP0tsxGTY0QSNeHsTynK2vYyFCnSCCFj5+Ro/3B+UC
X-Gm-Gg: AYBFou0/ktG2M84oiDY87FNXAWi8OnSTrIbXGuC2SosTmvihv2Ph84hGA8CYTfjtOuI
	cIuki1i2paE5J4HukY7eRL5sOoJDqauIayWpTpzBBsV6xqLHl1GHX37g2d4UBhBpfxc+4X0B9rA
	reidSt6nfjBV+ttn8CM8H6rHL8gT8n53a1GnOgEnXmtc4j1YhcrduHwwqqGYBy0gmEV4Ip9AbeT
	QxY0yVLcmOxnF5mG2Ac/n1xLjJgOJPzbkcQ+QFJA5lDyFv97CD2fhmiTKvMptL0q54/dNHpzUg3
	dav9SC5ZO8ALMUlV+T4nVblX/yYbJbjb9tc1T3IGrgBEhjOoqh848iZJpgoVkPlg09JTdUTRUd4
	JTvR6tERBTInELofwU1DZmbtGHVtvdwFf04852JGouRoGGAYhlD+nanWNoAPQUUEI8WMbIUqpKw
	iwM6QTPyRfsPWxUy5CXBxnCS94l3+5lYHw/oT6Ae3gpjDiAj9kWX92IyTkM2VBj+Yx9MGHXT+0J
	0SotAJVw1zNtdvyv41j1ROYOkUvNDWTVdudimxvdc3py+VZpxmbgvFSzw0LSNCDgmZPskTmjnfF
	oOFOeSDYy3CUTVCRW6I817V8qaq9WafT3jVABXh0l3ee00EdbJzIIJ/5iiQhi6g+pOHDR34sKWW
	9SjYoPzuKr5O5Bbw89DGNBrFIH6V1qDWMug==
X-Received: by 2002:a17:907:86a0:b0:c41:b94c:4538 with SMTP id a640c23a62f3a-c49bdf84407mr432048766b.47.1793270364216;
        Thu, 29 Oct 2026 03:39:24 -0700 (PDT)
Received: from localhost (178-84-201-199.dynamic.upc.nl. [178.84.201.199])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c46bd4e995dsm711863366b.25.2026.10.29.03.39.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 03:39:23 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
To: Christian Brauner <brauner@kernel.org>,
	Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-fsdevel@vger.kernel.org,
	fuse-devel@lists.linux.dev,
	Chris Mason <mason@kernel.org>,
	stable@vger.kernel.org,
	Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH 08/16] ovl: do not take a name snapshot in RCU walk
Date: Thu, 29 Oct 2026 11:39:12 +0100
Message-ID: <20261029103913.2785828-9-amir73il@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261029103913.2785828-1-amir73il@gmail.com>
References: <20261029103913.2785828-1-amir73il@gmail.com>
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

A path lookup on an overlay over FUSE loops in the kernel for ever and
stalls RCU.

take_dentry_name_snapshot() needs a dentry that the caller keeps alive,
because for a dead dentry the refcount of an external name stays at
zero and the function retries without end. In RCU walk
ovl_revalidate_real() holds no reference on the real dentry, and the
eviction of the overlay inode on another CPU can drop the last one.

With a delay in ovl_revalidate_real(), a stat() loop on a 48 byte name
in an overlay over FUSE, raced with drop_caches, spun for ever in
take_dentry_name_snapshot() and stalled RCU.

Fix this by using try_take_dentry_name_snapshot() in RCU walk, and by
returning -ECHILD when it fails.

Fixes: 5be1fa8abd7b ("Pass parent directory inode and expected name to ->d_revalidate()")
Cc: stable@vger.kernel.org
Signed-off-by: Chris Mason <mason@kernel.org>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
[amir: use try_take_dentry_name_snapshot() instead of open coded snapshot]
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/overlayfs/super.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index 18f56d463572a..cc4b0959faf61 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -100,11 +100,17 @@ static int ovl_revalidate_real(struct dentry *d, unsigned int flags, bool weak)
 			dir = d_inode_rcu(parent);
 			if (!dir)
 				return -ECHILD;
+			/*
+			 * Nothing pins d in RCU walk: eviction of the overlay
+			 * inode may drop the last reference at any time.
+			 */
+			if (!try_take_dentry_name_snapshot(&n, d))
+				return -ECHILD;
 		} else {
 			parent = dget_parent(d);
 			dir = d_inode(parent);
+			take_dentry_name_snapshot(&n, d);
 		}
-		take_dentry_name_snapshot(&n, d);
 		ret = d->d_op->d_revalidate(dir, &n.name, d, flags);
 		release_dentry_name_snapshot(&n);
 		if (!(flags & LOOKUP_RCU))
-- 
2.55.0

