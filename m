Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792601251;
	b=gTQ6ItFUY2XrxZX7ckazMORVykHuk5qC2fkJ+Y0iTe/fW3gzR+VMaI4JotKaQNIq91KN
	 nFoueWYQjKInHSeht77+mkwahFxfhPuSbYxSlrDxk8b2iwRXmCgC3YEFdYn+s2CNkT5+K
	 F5mfolLnVUsZyX/3NxDFGynkCaropnh66f2rGtbJOMyVV35eFnu3EPm7ge6jnRK/YvHKe
	 1EpAvcem09vcqHRhfQAuyhhsumQ05qz2iFjbwGSV3fO9Mw8z47QWWkVoxc0YedeUDMJZg
	 ch/jPZaZ/9lx447xzui5RmrrPt/LneD9RSsJHqwbdTnQb8Gxkl+SU034lYMaK72GDCA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792601251;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=ddPNju4D25sxiyQq1FcpinjHERbC1yn6z7dI6ktWvqo=;
	b=0lxc+4SGAZU05jMkF3Cy8iNWcjxpdtCHqy+/ELM+/ydnJY+WYhzlKKSeB7KCdgzfUbom
	 zS1fnKG2krSaX4vqr7bZGS9QkwOrv8bjvYb1z1z/L85JTlnox2aFCr2BHjQ2fiBdNO201
	 v6hXXsvKu22LO7ORcpm4CgOXjEfMZXxO94DDXJWmf9fzrGyiL+fw8lZ1vBdMqS7/I1DiZ
	 2bxtQ9ZgRox5YSvsxu0RmbQJhibseqWJITCedXY5zwcZ3yP2pLttAIYiqtjcVrBTMS/X1
	 SFRqY/hqsazZprGo4oF88On7NRaSaROY1mXnokxAJ5nEhUTijPc4GsMAamBFgFuVanA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=ne7Xdxrq;
	arc=none smtp.remote-ip=209.85.160.172
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 004A9606A334
	for <linux-fsdevel@vger.kernel.org>; Wed, 21 Oct 2026 16:47:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 004A9606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=ne7Xdxrq
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-53397554beaso10259581cf.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Oct 2026 09:47:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1792601250; x=1793206050; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ddPNju4D25sxiyQq1FcpinjHERbC1yn6z7dI6ktWvqo=;
        b=ne7Xdxrqqaa/hd2nJek9OLBpjlYrLXEf0C73FwfM0w8Kfvd3EuouwvSNmoAABAWyRg
         Z49ur3LziBi+VW9hdW8d+Aq8YZRsaXl2ReCjYk3iguMlIxV9xh2mE9L5CgBkvLluEylg
         ZbZ3TJy09prJWxwuwdfpT1Jnb5hVxV4s9m79ylyEppDQdioZvp53VEJ7ne0XGZmUZz5Q
         V+n2JDDdrFpucQb0i3bNeFCZ5bMRoiKjOCof/pBNeHXAj/lPTnBzz+Xm2RXAAOCDZbPf
         hhItzm91I2Oyxng9JIjUJX3Z4ET6FvZAWnmC6ejrxNsWSKuF2CiGqEJ0BZuu3Lx7SISz
         Yc2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792601250; x=1793206050;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ddPNju4D25sxiyQq1FcpinjHERbC1yn6z7dI6ktWvqo=;
        b=BunuJ/fJ34L9MZXr/yym9rxnL8Vq+JBEL8kDQbC3/DjwJEhutcz7Jelj0yGblcteom
         uZTFch09ScRDTkV7egGabqHfh1LIuAODYjWH7bQNDPwM3Ul9fjccYXLCLVRjkE1yrxcR
         idMVGI6lASYExQsVZcfGmjoO0InTHG400LgKWSXEzi+n2QIj6o6HA/E1YlWw08mxnv2C
         5bsi03vLeSn3aNlonpXIH0K+N/mYOyxMxRLbu6vTbcKtF0xOMLyjmHhq19eooDKcrpdY
         cNfvwQ2XhHYUG3/LLa7vWckmjrewvYwYpKxq2z/uWypczqwnOdZ2Zt6LRb5YubdhJlhZ
         KKNg==
X-Gm-Message-State: AFq9FYIB6rFRU9gk29m0DIsDl3DWBbKnqV3WcDl6B5r2HYCyELHfY7wO
	2m/4w4IQF8OfE/sxmXqKvYex0+hp9Kdb3SbnCkgN+3aHzEbJe8VnaPovGfXCcUh4rrU=
X-Gm-Gg: AYBFou3X6SRLMTYREMBQptJ+Ag5FrHyr/00hSWZws8BrJzFsEKEanFAs5bt+cP79s2r
	FbFYSoGSGK8yNQ4b2KKJ5vfRSwS7VeKNB7VPeNESxX4abpjFSeMV00eUysdn+trtterVi5RhBdn
	nBCB4/qrCphqpIail2WXUtZ/ztWImgn3coDyupepw96d9cKtPZecinRVpIX7BEqUo2zytjDdyQy
	RjQ4irGMY6UCw/AulxFLwepfFssmnBLKvaF8iM3voFDUgxmmijcp16DwxBLgBPz08SegG42UuBf
	fEvoSnCv8td912lw9XfWhqTkXTCrUGgie5EbsP4CnlieUPuZrBtJ/Gjyq2lpYQwtC7C10ZxpF2i
	QnEJ4TdNeyezItOlpJ5t8n6XpqV2BiOKyJO5TUtaIMXaO9V7qyU1Z0WAtZNcMumINnuovSBZF/g
	KpNdZZ87yQZ/TPZNCDL2zd4KZwIaeg2PVpB12Dnh8dZ+tH6Ll1jevwsQQOYx+qmk6R4YqHhDtcq
	lQav166q3kkuNHjsf7E/CAvdJTy8/qKSsjEdOORttnGpfXEKOuU/9biUjxWZ3JkPqIT7hLE
X-Received: by 2002:ac8:7f07:0:b0:536:6856:f590 with SMTP id d75a77b69052e-5369b617724mr36273901cf.18.1792601249936;
        Wed, 21 Oct 2026 09:47:29 -0700 (PDT)
Received: from toxicpanda.com ([153.61.196.240])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-536ab76a3a2sm3680471cf.22.2026.10.21.09.47.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 09:47:29 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
Date: Wed, 21 Oct 2026 16:47:01 +0000
Subject: [PATCH 5/5] fs: skip unborn superblocks in drop_caches and Q_SYNC
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261021-b4-super-lock-unborn-v1-5-0265eddb6dee@toxicpanda.com>
References: <20261021-b4-super-lock-unborn-v1-0-0265eddb6dee@toxicpanda.com>
In-Reply-To: <20261021-b4-super-lock-unborn-v1-0-0265eddb6dee@toxicpanda.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Josef Bacik <josef@toxicpanda.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1792601235; l=3703;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=zTDWcYWzoDo8/94Xg6nLn0s5owmVnnz+Vo7YSVcNaSY=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QNOcD8om5fSfSdohwSgTPqi3phNz1b9Ldot8kpCZnhlvTh964CkGhXG3XO+vzDcFKQTLgfFmnb4
 M3Jd3us6khAQ=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

Writing to /proc/sys/vm/drop_caches and quotactl(Q_SYNC) without a device
walk all the superblocks with iterate_supers(), and like sync(2) they hang,
unkillably, on one whose mount is stuck before SB_BORN.

Neither gets anything out of the wait.  A filesystem which isn't mounted
yet has no page cache anybody would miss.  It may well have quota turned
on, ext4 and XFS do that while they are being mounted, but nobody has used
it yet.  The only changes to the quota so far are the filesystem's own,
from cleaning up orphans say, and it has to get those to disk whether or
not anybody calls Q_SYNC.

Add iterate_supers_born(), which skips such superblocks, and use it for
the two.

iterate_supers() itself keeps waiting.  Its remaining user needs that:
selinux_complete_init() sets up the superblocks which came before the
policy was loaded.  NFS calls security_sb_set_mnt_opts() from its
->get_tree(), so before SB_BORN, and without a policy SELinux puts the work
off until that walk.  Skipping the superblock there would leave it without
labels for good.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/drop_caches.c |  2 +-
 fs/internal.h    |  1 +
 fs/quota/quota.c |  2 +-
 fs/super.c       | 15 +++++++++++++++
 4 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/fs/drop_caches.c b/fs/drop_caches.c
index 49f56a598ecb..7ba726837075 100644
--- a/fs/drop_caches.c
+++ b/fs/drop_caches.c
@@ -61,7 +61,7 @@ static int drop_caches_sysctl_handler(const struct ctl_table *table, int write,
 
 		if (sysctl_drop_caches & 1) {
 			lru_add_drain_all();
-			iterate_supers(drop_pagecache_sb, NULL);
+			iterate_supers_born(drop_pagecache_sb, NULL);
 			count_vm_event(DROP_PAGECACHE);
 		}
 		if (sysctl_drop_caches & 2) {
diff --git a/fs/internal.h b/fs/internal.h
index 71ab0ae11941..dd29e98e05fb 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -137,6 +137,7 @@ extern int reconfigure_super(struct fs_context *);
 extern bool super_trylock_shared(struct super_block *sb);
 struct super_block *user_get_super(dev_t, bool excl);
 void put_super(struct super_block *sb);
+void iterate_supers_born(void (*f)(struct super_block *, void *), void *arg);
 int iterate_supers_sync(void (*f)(struct super_block *, void *), void *arg);
 void __init super_dev_init(void);
 extern bool mount_capable(struct fs_context *);
diff --git a/fs/quota/quota.c b/fs/quota/quota.c
index 33bacd707580..713e66e4d00f 100644
--- a/fs/quota/quota.c
+++ b/fs/quota/quota.c
@@ -66,7 +66,7 @@ static int quota_sync_all(int type)
 
 	ret = security_quotactl(Q_SYNC, type, 0, NULL);
 	if (!ret)
-		iterate_supers(quota_sync_one, &type);
+		iterate_supers_born(quota_sync_one, &type);
 	return ret;
 }
 
diff --git a/fs/super.c b/fs/super.c
index b8d6f1c969ce..1cfacd71a0d8 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -1110,6 +1110,21 @@ void iterate_supers(void (*f)(struct super_block *, void *), void *arg)
 	__iterate_supers(f, arg, 0);
 }
 
+/**
+ * iterate_supers_born - iterate_supers() without the wait
+ * @f: function to call
+ * @arg: argument to pass to it
+ *
+ * Doesn't wait for superblocks which are still being set up, they are not
+ * passed to @f.  For callers which are after what has piled up in a filesystem
+ * in use.  Not for callers which have to get at every superblock there is: one
+ * which is skipped may be in use a moment later.
+ */
+void iterate_supers_born(void (*f)(struct super_block *, void *), void *arg)
+{
+	__iterate_supers(f, arg, SUPER_ITER_SKIP_UNBORN);
+}
+
 /**
  * iterate_supers_sync - iterate_supers() for syncing all filesystems
  * @f: function to call

-- 
2.55.0

