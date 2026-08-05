Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B250360751
	for <linux-fsdevel@vger.kernel.org>; Wed,  5 Aug 2026 18:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785954975; cv=none; b=OiVMnE+iMRdJvWiWuhhXLmuH3Yrjv456uSQHmCNA5WEZS8BvumaItR2j2mrsLdapXy4tq/LZG+J20J1AI47iPk3CKz5TIMXUnqPAVGoj7RAIa0WTasLvKDgr7zrVGsktZMZYHMXZmrqH4sytD+Mt85UzyKmMcYpjL82dnJqZTvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785954975; c=relaxed/simple;
	bh=prqmpukwj7MAs2TEzHYbpi5lV4A+T3BMzX6jdh7zaNE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u1LUcJ3YU7yRrkg2lARlooK3wlcj2mCpHHEFp2vuegQImYJAELfrBqJ6LTriVgv+CmhL9nSAeMx/EgRbN8StfiC7mex2vu1+FWY6ZX/t3q+n7P9XzYyeSvsnj3szk1G7xVHvuh45jNvTTjpoUG5cdZtgkb1AdsqUpniVlrFyoq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mjL270aN; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mjL270aN"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-c96b08cdd1cso1014664a12.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 05 Aug 2026 11:36:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785954974; x=1786559774; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1Nn5sTiUfJk4xsJUwHMcr/Wplm60ufC1bmyAw/7EgqA=;
        b=mjL270aN+uOQUd0weWCr0JD33j8Ee0fhXHlGC/4CrZWA0ZwO3ZHTNp4cz/f8l1fksc
         5BVdpemIVwLb7aHOYDQjH/4vK9TlFGy8YTLlYLjtu5EvRIWLhhDaH2HAtYh8LKd+Vq9R
         ERgIkDJeJYC4VhOEpOweKjrj5sZ4lr2y0s9c6nzjPilNa2HC516kljCBqkphE65XOxlI
         1zeoIsT+d2qkFBnBODJRHUflLn3K5ZQu9S1nf8PYYnZQuDkdYyBO8UYLayQOes+JryTE
         slfYaihzqTzPvmGFGTU5ds2noSfh06ToPwWoLIn81iOeDQ03xFU305TPY4rlGNVhpBdB
         8zBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785954974; x=1786559774;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=1Nn5sTiUfJk4xsJUwHMcr/Wplm60ufC1bmyAw/7EgqA=;
        b=F44ky5tgkgwkjIPbBuKjw0LnTvmXF6pBQ7T6dPNh5bUDmGMWbBvQC/o/aLGFwyL5sn
         5kTFPUfXesquzHx07zzluvAoRS+kvkM5YQ6qcfaqwxw/l1lBce0iJ+slbkJBUn0EvXpf
         X6MbDsKMuawmC/yTXfgwZjEUHxcnS8kCmSLhLQkRr344v6Epdov4XXoK4Eyxw/Zyoz99
         vXTnOB5tl206VaZeES6vEfQdBQY9MEx6GoCWMc3rXYQuegnk2aZwBv//G5jMyyO4eGxe
         IW4hPbDER9Q8vj1w+A+pVUqdkstpElI/BdmVZkv9is2v3wwDtvF984OxuRu1nntNSkp4
         NJ9A==
X-Forwarded-Encrypted: i=1; AHgh+Rr9wWFJIHpPRTIlSZDHy6zOvwzAZEzde+xb3s/x2HsK38ER+THTu7Ghh9GeLp63tklWMLcSkgLGI0ChxNGJ@vger.kernel.org
X-Gm-Message-State: AOJu0YzniW5jAxx62yTJINBMpbrWuE4HW67yDQrWl4Pt27O7B6JDw1EQ
	jRM3nGrYD3KWAW7B8pO7c1En8zoAM10Tcta2CNRIjN1ZBKfw1UNDnJys
X-Gm-Gg: AR+sD11St+1um6eoSLGmV6TryvvC8VlhRINj+44N0nma/wHmCr64KqbbYqYI0O6GJvX
	hics88JyXnlhOWdsoZPtJAYz9XLHpzXRBMPZdA36qpsgy65FrPD148kdGHIgeate7V6096fNNmw
	udXbU0Dq7BiekbOIiObogGH9H82K3GHagyLc4iY7c+11MV8iKR7Dk+t1WkMesyl4g6Wbg8Ggzf3
	YzlZOOx5qPDumhL31H0pGaYRKPxux61hW47WoNLLsYiewrybzPvfMA0lIEJdrUBiCsHsu43o5PQ
	mHMhMy+N0GQvHceCjFBoF6nR2jeFFk0gQESyYTFQ9u6M69zbbG3cXItqgMW+iSqPBzErxzo22bm
	tdwq0FN4sdB7inr0TK0/a78qa3HgQEewMKFYvPgSgRvZtAMkfNafxNwoNrJAW+IkJ2SChDGueFl
	0VG+un0/sVdKYyAvD4mgHy3g2r8LDOJSOCThsXloJwLvlk8MHTeoNmXAQDbIxSujBmICk=
X-Received: by 2002:a05:6a21:7a9c:b0:3bf:983d:e9b4 with SMTP id adf61e73a8af0-3cb8603af0dmr10608465637.33.1785954973594;
        Wed, 05 Aug 2026 11:36:13 -0700 (PDT)
Received: from fedora ([2804:1b3:a8c3:8ee5:1c39:64d9:e257:73dc])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3158673be99sm32720249eec.15.2026.08.05.11.36.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 11:36:13 -0700 (PDT)
From: Marcelo Mendes Spessoto Junior <marcelomspessoto@gmail.com>
To: syzbot+608f7f2a86361e18ba0b@syzkaller.appspotmail.com
Cc: a.hindborg@kernel.org,
	leitao@debian.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com,
	Marcelo Mendes Spessoto Junior <marcelomspessoto@gmail.com>
Subject: [PATCH] configfs: fix UAF race between rmdir and symlink
Date: Wed,  5 Aug 2026 15:35:56 -0300
Message-ID: <20260805183556.18283-1-marcelomspessoto@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <6a6d3f0e.f794c993.27aeb.000a.GAE@google.com>
References: <6a6d3f0e.f794c993.27aeb.000a.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To avoid touching a target that is concurrently being removed,
configfs_get_config_item() and create_link() both rely on a hashed
dentry as proof that the config_item/configfs_dirent behind it is
still alive (using locks could lead to deadlocks, as described on
configfs_symlink).

However, configfs_remove_dir drops the last reference without
enforcing proper unhash over the dentry. This enables a possible
race condition where a symlink leads to UAF over a dentry that
has no reference but is still stale on the hash. Therefore, the
dentry removal must also enforce proper unhash, avoiding this
specific UAF scenario.

Verified against syzbot's C reproducer: no longer triggers the
WARN_ON/KASAN panics after this change.

Reported-by: syzbot+608f7f2a86361e18ba0b@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=608f7f2a86361e18ba0b
Signed-off-by: Marcelo Mendes Spessoto Junior <marcelomspessoto@gmail.com>
---
 fs/configfs/dir.c     | 15 +++++++++++++++
 fs/configfs/symlink.c | 30 ++++++++++++++++++++++++++----
 2 files changed, 41 insertions(+), 4 deletions(-)

diff --git a/fs/configfs/dir.c b/fs/configfs/dir.c
index 3c88f13f1ca2..ec6f3550178a 100644
--- a/fs/configfs/dir.c
+++ b/fs/configfs/dir.c
@@ -411,6 +411,21 @@ static void configfs_remove_dir(struct dentry *d)
 {
 	struct dentry * parent = dget(d->d_parent);
 
+	/*
+	 * Unhash before dropping any reference to the dirent/item this
+	 * dentry pins: a concurrent configfs_get_config_item() (e.g. from
+	 * configfs_symlink()'s target resolution, which runs unlocked
+	 * against directories it doesn't otherwise own) only checks
+	 * d_unhashed() under d_lock before pinning the item.  Unhashing
+	 * first ensures that check reliably fails once we're past this
+	 * point, instead of racing the dirent/item's refcount reaching
+	 * zero while the dentry is still (briefly) hashed.
+	 */
+	spin_lock(&d->d_lock);
+	if (simple_positive(d))
+		__d_drop(d);
+	spin_unlock(&d->d_lock);
+
 	configfs_remove_dirent(d);
 
 	if (d_really_is_positive(d)) {
diff --git a/fs/configfs/symlink.c b/fs/configfs/symlink.c
index 31eb28b27309..b8043a6b0b42 100644
--- a/fs/configfs/symlink.c
+++ b/fs/configfs/symlink.c
@@ -78,18 +78,40 @@ static int create_link(struct config_item *parent_item,
 		       struct config_item *item,
 		       struct dentry *dentry)
 {
-	struct configfs_dirent *target_sd = item->ci_dentry->d_fsdata;
+	struct dentry *target_dentry = item->ci_dentry;
+	struct configfs_dirent *target_sd;
 	char *body;
 	int ret;
 
-	if (!configfs_dirent_is_ready(target_sd))
+	/*
+	 * item is pinned by the caller, but that only keeps the config_item
+	 * itself alive.  item->ci_dentry's configfs_dirent (and thus its
+	 * s_count) is a separate refcount that a concurrent rmdir of this
+	 * same directory can drop to zero and free independently -- see the
+	 * matching d_lock/d_unhashed() dance in configfs_get_config_item()
+	 * and the unhash-before-free ordering configfs_remove_dir() now
+	 * guarantees.  Do the same check here instead of trusting
+	 * target_dentry->d_fsdata unconditionally.
+	 */
+	spin_lock(&target_dentry->d_lock);
+	if (d_unhashed(target_dentry)) {
+		spin_unlock(&target_dentry->d_lock);
 		return -ENOENT;
+	}
+	target_sd = configfs_get(target_dentry->d_fsdata);
+	spin_unlock(&target_dentry->d_lock);
+
+	if (!configfs_dirent_is_ready(target_sd)) {
+		configfs_put(target_sd);
+		return -ENOENT;
+	}
 
 	body = kzalloc(PAGE_SIZE, GFP_KERNEL);
-	if (!body)
+	if (!body) {
+		configfs_put(target_sd);
 		return -ENOMEM;
+	}
 
-	configfs_get(target_sd);
 	spin_lock(&configfs_dirent_lock);
 	if (target_sd->s_type & CONFIGFS_USET_DROPPING) {
 		spin_unlock(&configfs_dirent_lock);
-- 
2.55.0

