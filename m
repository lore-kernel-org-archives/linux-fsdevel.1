Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.2
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794809724;
	b=MqmODa4wh9FtZZJz1Yj8QNVOhNPn1tA6IMZB11IoV/4PqG8C/a5bjLJgftq5GMcP88Ey
	 t+LL9e1JhvoW5paVDAfPl25AQVwhl/k0Z0ECzkdNA6Cbk3kl/7uBdg0myrHk3voqk3V+t
	 an4xeaZnx454wk8pjZWbdntd4SF69sALlvwVW6fb5ERryqEgcxaTvS/OAxKdTjPC+Dugf
	 QKOox0uq9AJv7opvGpi/1/p5PZ4ZiKTHZsz4bKCR97Tp/BKtfrZLT4CFdP+KsU12EvCmt
	 y0yExKa5zw6K5jpTKPsA0PclO+V2A0nKg2qODUYXCPvR2nf0ekDW9VfKSoygPFBOPLw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794809724;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=ZKs8AYk2ncyKZCHDH0zdBH97wh5SQAhH9BYRDgLCL+U=;
	b=2+NByAL5p525t+iexQNzjzGziPnpJXsFKLIKodAXQfvcfKqimzDndCQ4N9kHL/4BnAak
	 stFVU8TX9QJvXvhd+/pgoE4tb8vY+Jq6PMuroNtb0tOc210s6MkChPksZaNUHz23L0tU1
	 uKFWpUknM7Db6JL65dl5qcnbnlRkeY37TgwmT4Zt+pqiB1NNOMxeSskryawWQelky10zU
	 cOERPErGR8UTvNRr2b1J2voxhdQjTmXXTY6axbyLIXvqvHVFM3zJqOsbx76rV9HOR9rz2
	 aZGcCkItGQ09xS5HwGnExr9KnTjuZ68SSzNWy6cbOgH8oq0i3gwzxJ7O4N4FsfRR+8Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=S3yXXuag;
	arc=none smtp.remote-ip=74.125.229.2
Received: from mail-dy2-f2.google.com (mail-dy2-f2.google.com [74.125.229.2])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8952606A323
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Nov 2026 06:15:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A8952606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=S3yXXuag
Received: by mail-dy2-f2.google.com with SMTP id 5a478bee46e88-327b1d5824fso2344963eec.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 15 Nov 2026 22:15:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794809723; x=1795414523; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZKs8AYk2ncyKZCHDH0zdBH97wh5SQAhH9BYRDgLCL+U=;
        b=S3yXXuagMj6jEH5ZKvtjSUvjgVweC7YQStIf6hraBxJqb33PLJSAQL4qG67G9gw3su
         ET28LlWxi2FaBWcwrkRF32Ga44FVlKjFxsyKim3k5PrfYb00R0DdhrpHMwt50QM5oUY0
         me1KrXWZLjMQ2SDOT8+o1IGByNNPgL+zKLTdT0YmvBjgJ9Z0OJDQk9hpEhiBKxhSM1QR
         Wwm9IXRWXTCWmNUeSd0PRYZC6sx9gP4rhKBXLSCU+xzQKgAPccderjYOnggzULl5jr80
         +HFiRrSEPJs7ACLlgHm+oXAWfPBIGUkGASG6zy5QuZ9f8ljpxke5tu6NyBD7F2vVLQtj
         fTWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794809723; x=1795414523;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZKs8AYk2ncyKZCHDH0zdBH97wh5SQAhH9BYRDgLCL+U=;
        b=r1qkVeVtn35BYJ7XAXyRLJqupvErGIZw3Eci5obrfsYoE59EXewCzJMERr/uvlb5mN
         Ckjv9+gqFIY7mpWNTD5NwuQTlUzFNGIJKTHN+bfi6X1SsiNNbGEx9lxO/U9R1gBskTSy
         oeAYa4piTi1/Im6Wv28yawwkFvP+bBTO37F7GHr+IbtjT7JFhywEnS6kW+GKWJ9KWY68
         eZ/LyeXesuneQV9nsV83fojubVyVWlyVe6dx3m22x4DYlsJDYKVIBOlajg5xxIPcQR3F
         Mq5ISu/vU0IHIkls5KFXwmf5G2wek1xthnRqFIybvcGgqfrR63I3cq7XPmkutu0kdKGl
         tn9g==
X-Forwarded-Encrypted: i=1; AL+hErGyAlLcBjfJaUI3PyjK05D3i1MJqjJe3zXYYUZSl17kTLhDOe15yZ5xSFM8bBTpvT+Kf60U1Z9T2ax5IiV6@vger.kernel.org
X-Gm-Message-State: APuU4Z84QsXYHxKDaKGCCKEV2fBUZ6aeeIig1WxJfvrG2e05aP3grtJi
	Yic+lXQFKMWPVuZtpA+vZWgvA3aqCyf+5SMkAvUv8ZXltTFW9wEsEqKWHw+2lBcgZ3ER3A==
X-Gm-Gg: AYBFou3bGrkzxE7MV4XW3fDISRU+1cA44pOmhNBEghLenbiDKisEbZgNe8I/u75n0fd
	vYWFc00Prp4UZuqd9IWhV/D+J2olpXAw0KgjETn+uNgIrpkA22W6k+dvIt8EfDAHuRmZHbK9Zlx
	QZCcotTECO3LAtWwuR63ewSqFH90bcG9DG3Gp58dMcM869MFsCavpEocVU/JEIeSF7qcAGwO/Zl
	m0r0FdrGI2gQZ/4kRhmkKQdqxf8/KtOZ8DYC0es1l4lwuTlU2tv7bkt1QAom0fT9qpujdFyVyP9
	h5q9pXCS9S2Iwf1/YuphGpyqh03YhgFxJTN3CMRmbIz8FLbVI/9F76tDLpLjQypj2JCByUVd9gQ
	j844H5+mS3up2fAXrwZv1Czp4NiA4I8bn9gXjCjoJEGM5cwszKlCMuZFUquNew/QtjU7QmUuw8/
	Ocb1QVP3vVg+DRrfu88YjNqZL1XprXsuW+w57SiF9osg81XHu8VaNcwnnFSfrWlb/DA8sjGPpmc
	LbcCcgjga1MzTP2Tk5il+5OmptCjj8c2cXht5c/6PMa/Cw3RD9fxUBYep3KFkWgaSUUJp55SkUX
	R//XwICIKdZSv7ogqTPc101e2SygloGf8OHfCPnqof/kmJnLi5x6nMxxKigvvnHkV5guRq06kz+
	tuTnLZiwT40BMimg2RAY+loC6Z8vF3Rv49RA+QOo=
X-Received: by 2002:a05:7301:4604:b0:376:703c:8819 with SMTP id 5a478bee46e88-379681c6998mr11095176eec.38.1794809722597;
        Sun, 15 Nov 2026 22:15:22 -0800 (PST)
Received: from localhost.localdomain ([98.148.34.5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-37956bb0c40sm32767289eec.28.2026.11.15.22.15.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Nov 2026 22:15:22 -0800 (PST)
From: Hungyu Lin <dennylin0707@gmail.com>
To: jlayton@kernel.org
Cc: cel@kernel.org,
	alex.aring@gmail.com,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	dai.ngo@oracle.com,
	mjguzik@gmail.com,
	zhaogongyi@bytedance.com,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dennylin0707@gmail.com
Subject: [PATCH] filelock: don't hand out a delegation that is being recalled
Date: Mon, 16 Nov 2026 06:15:02 +0000
Message-ID: <20261116061502.44674-1-dennylin0707@gmail.com>
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

An operation that finds a conflicting delegation gets -EWOULDBLOCK from
try_break_deleg(), drops its locks, waits in break_deleg_wait() and then
retries. Nothing stops a new delegation from being set on the inode in
the meantime.

With F_SETDELEG the owner of a file can do that from userspace: remove
the delegation when it is recalled and request it again right away. The
waiter in __break_lease() then finds a delegation that was never asked
to be returned. It has no break time, so it never times out and its
holder is not signalled again, and the waiter keeps waiting for it.

As a result unlink(), rename(), chmod() and chown() of the file hang
until they are interrupted, no matter who calls them and what
lease-break-time is set to. A delegation on a directory does the same
to a create in that directory.

Record in the lock context that a delegation is being recalled and
refuse to hand out a new userland delegation with -EAGAIN while that is
the case. The block is lifted as soon as an operation gets past its
delegation check with nothing left to break, so a delegation can be
requested again once the conflicting operation went through. If the
breaker gives up instead, the block expires after twice the lease break
time. nfsd already keeps track of recalled delegations by itself and is
left alone.

Fixes: 1602bad16d7d ("vfs: expose delegation support to userland")
Cc: stable@vger.kernel.org
Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>
---
 fs/locks.c               | 24 +++++++++++++++++++++++-
 include/linux/filelock.h |  5 +++++
 2 files changed, 28 insertions(+), 1 deletion(-)

diff --git a/fs/locks.c b/fs/locks.c
index 6e4ff7fcec05..f7d1a376da5c 100644
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -190,6 +190,7 @@ locks_get_lock_context(struct inode *inode, int type)
 	INIT_LIST_HEAD(&ctx->flc_flock);
 	INIT_LIST_HEAD(&ctx->flc_posix);
 	INIT_LIST_HEAD(&ctx->flc_lease);
+	ctx->flc_deleg_blocked_until = 0;
 
 	/*
 	 * Assign the pointer if it's not already assigned. If it is, then
@@ -1705,8 +1706,11 @@ int __break_lease(struct inode *inode, unsigned int flags)
 
 	time_out_leases(inode, &dispose);
 
-	if (!first_visible_lease(inode, new_fl, flags))
+	if (!first_visible_lease(inode, new_fl, flags)) {
+		if (type == FL_DELEG && (flags & LEASE_BREAK_NONBLOCK))
+			ctx->flc_deleg_blocked_until = 0;
 		goto out;
+	}
 
 	break_time = 0;
 	if (lease_break_time > 0) {
@@ -1739,6 +1743,10 @@ int __break_lease(struct inode *inode, unsigned int flags)
 	if (!fl)
 		goto out;
 
+	if (type == FL_DELEG && lease_break_time > 0)
+		ctx->flc_deleg_blocked_until = get_jiffies_64() +
+					       2 * (u64)lease_break_time * HZ;
+
 	if (flags & LEASE_BREAK_NONBLOCK) {
 		trace_break_lease_noblock(inode, new_fl);
 		error = -EWOULDBLOCK;
@@ -1791,6 +1799,15 @@ int __break_lease(struct inode *inode, unsigned int flags)
 }
 EXPORT_SYMBOL(__break_lease);
 
+void locks_unblock_deleg(struct file_lock_context *ctx)
+{
+	spin_lock(&ctx->flc_lock);
+	if (list_empty(&ctx->flc_lease))
+		ctx->flc_deleg_blocked_until = 0;
+	spin_unlock(&ctx->flc_lock);
+}
+EXPORT_SYMBOL(locks_unblock_deleg);
+
 /**
  *	lease_get_mtime - update modified time of an inode with exclusive lease
  *	@inode: the inode
@@ -1968,6 +1985,11 @@ generic_add_lease(struct file *filp, int arg, struct file_lease **flp, void **pr
 	if (!leases_enable)
 		goto out;
 
+	error = -EAGAIN;
+	if (is_deleg && lease->fl_lmops == &lease_manager_ops &&
+	    time_before64(get_jiffies_64(), ctx->flc_deleg_blocked_until))
+		goto out;
+
 	locks_insert_lock_ctx(&lease->c, &ctx->flc_lease);
 	/*
 	 * The check in break_lease() is lockless. It's possible for another
diff --git a/include/linux/filelock.h b/include/linux/filelock.h
index e909db319067..1a48c5550fa9 100644
--- a/include/linux/filelock.h
+++ b/include/linux/filelock.h
@@ -158,6 +158,7 @@ struct file_lock_context {
 	struct list_head	flc_flock;
 	struct list_head	flc_posix;
 	struct list_head	flc_lease;
+	u64			flc_deleg_blocked_until;
 };
 
 #ifdef CONFIG_FILE_LOCKING
@@ -229,6 +230,7 @@ void locks_init_lease(struct file_lease *);
 void locks_free_lease(struct file_lease *fl);
 struct file_lease *locks_alloc_lease(void);
 int __break_lease(struct inode *inode, unsigned int flags);
+void locks_unblock_deleg(struct file_lock_context *ctx);
 void lease_get_mtime(struct inode *, struct timespec64 *time);
 int generic_setlease(struct file *, int, struct file_lease **, void **priv);
 int kernel_setlease(struct file *, int, struct file_lease **, void **);
@@ -510,6 +512,9 @@ static inline int break_deleg(struct inode *inode, unsigned int flags)
 		flags |= LEASE_BREAK_DELEG;
 		return __break_lease(inode, flags);
 	}
+	if ((flags & LEASE_BREAK_NONBLOCK) &&
+	    READ_ONCE(flctx->flc_deleg_blocked_until))
+		locks_unblock_deleg(flctx);
 	return 0;
 }
 
-- 
2.43.0
