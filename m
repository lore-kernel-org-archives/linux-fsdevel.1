Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793270362;
	b=RRpm8olu1FW75Qhju1b4dvgEPuTGF8gkfX5NfoJLcikEO6kw4xLNA9D/7Kq+SwDQfc66
	 PyCmKmlQFqzq60XQggynp6DiNQKYlFyqFtIWIc7gIkpeVGje37pPi5p5nx9OHCS2FQiph
	 eFkabCQZsdq2dfRHYsX1TLCO30UETm/6pVdiFe7EP7xPYFcLS1YJZ9sQNhojsg6MIs6ch
	 dBnNEjvrV/e1pVx06grSdQYdD9myK1Vs4K4q7BMMIY5Gfd4vh1x2+VVlM05I3rrga8/1g
	 IzyzA2n3LjauO5SPwY19WxSM11/hBFWj9O2Trc/dAqwfX66CtaBd3exmIgbgCZ0ckyw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793270362;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=cmIhezlVC3rHCXHI7CWbXYAAsMg4SBr1TxpHu1OVCHI=;
	b=g0GSw+uDtnwzksEn7naSMYkGF9dUsPVg7v8C3ulsKX63eaoCbZ1BL6xJEB4CG6Eua1n4
	 TVa7Fbf1rrgfnIiphK86Wo15K3YlsQb2fHXa8BXx5WnxfolZjmxUXRwP6tX1YUr70Uein
	 Or2dVled5PWBiVlZxFdq5Lxq3jYXYXpelHiD7JZnhIs8AkM3qNhmQgbHbfY4Fig4V9wKs
	 3lGOIzHJAYV1f3/Cbm22jhuMdkCMuVDjOKeGjI5Muc6ae9mzTZtlxDnwEE+juo9dDHY1R
	 njdBkq4Y5L++JLUw2zsDidSrRcD34934aceA76nki1egH/uUsRv8/io+DqmtWabds+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IriY8IuR;
	arc=none smtp.remote-ip=209.85.208.48
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDEAD60A2611
	for <linux-fsdevel@vger.kernel.org>; Thu, 29 Oct 2026 10:39:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DDEAD60A2611
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IriY8IuR
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-6b486e1d02eso2694647a12.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Oct 2026 03:39:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793270360; x=1793875160; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cmIhezlVC3rHCXHI7CWbXYAAsMg4SBr1TxpHu1OVCHI=;
        b=IriY8IuRx6AxIwVG/XkZDahlazMr4qkqK5sTgsjl+a7rVKEMQzWg5r+9v/pW3O0rXb
         f8zDG6xlFgPlzllnuQFVmkZLo5a+180ciCIYk7o1Whr7OLbpC0oKLPLwNY2WT6YkRe6D
         sfDTP62qVfIeY9i4I+X/H/cT7Fz0wEdY10WwlP273BhdtGW8uBRJZjEHqsPQhDXI8bW9
         CpShWPNbWZPcQIHcYySwAihkTBbEN5Z1LIAAc1IqKzrnQIxZ3cuDuN0JC/1sGVB0Ne0S
         YKn7UWEks9R2jYj6qONok9qOO7f0evINSd7BG7Bbopf1uP+ux89S33NGb5iLKMn1/Zu2
         Tsgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793270360; x=1793875160;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=cmIhezlVC3rHCXHI7CWbXYAAsMg4SBr1TxpHu1OVCHI=;
        b=XjJLoosocdYgFk4iq9zeKo1boXRkwnlMEC8wO9wZA3f9S5lehN61InkIurmBbMPBLA
         IECCPfzM8BoOA/4KKNqR7+a1T7oym4kAZi5E2MewkS/ReOAewHV7BLloHkWtfyneLSAD
         DfsLPnu43jqqjqSGxIUbv8BdOmY11sdUA0Fhv8RA6wWbiDZVN6LvhPEj5GmVO4tENEcU
         OIlX85SgmjkdH4Kz3VyTMO0U2Wea3rlCxgzOUCXZ5ZBAezJLb/zrPZbpk940HZEKAhA9
         Jh4UZaamgZmdgeeYVpc2euCkXqwP3AV1mBllEkIPUuHnRreyKDkHXj7ARk3nvGcbIkUz
         0IkQ==
X-Gm-Message-State: AFq9FYLwkCbA6536dNxOGvM5uGzv10Vukihd+Jf8Ut5unQWQXvMBddB8
	XVMgmm++xUZMUrmlGRaLvdyqKga9omQngugUg+NF1ik4ZKRaN04twTDg
X-Gm-Gg: AYBFou3AlgMCCUXoOrz1+rzVkbiTbAsRZL2Ai1ztjlHt3+tYtWHweSKTeXtMXMaDp5R
	FTR48gZSrDlqvpjKq2w9mFYIq1sqiGTJCmpeYQeg6hiageKY6utYAGmGYaRwT257/c6CBX8J/nY
	25L8DX+8hPUwv5QZNqgQUMDB789ZqCdGCM1QEGSUEhp/IoHFqUHBPP9gVDvFlnKltUZHpkdGphb
	GmwHMhZ8rrnhHEhlrLxvyxBIpidxkXg1VpDAl+X6DnPZDREhdrVMqTjO5uyfMIJxuKfY3IXyeNk
	HyABlAFSJQHht0Loe5ucYymPKF3uJsFkDPsbANjsK4l0/jKH7pEe4KAP0837lyTPf7RneU7yCkx
	OjhkcWgccdptjHAtvGw7b9ObvNrYn1Utzluq2I+Ul2WJf55lRmfu//quOTzKn/u+vVNCvBYDp/g
	OpPCKwXgAeRW3roZSC9PzzoqKyFn46KFcFWAsztVfJEieTgsrgZJL6SD12RNQ3eDd0bgTkJ6CvJ
	vo0Y6i1hPlAffaw7S5PeHThhW9WVxO4JcOobo+Jxd7IKmGOvMyKdrEf+fifVH8fj/jPDas8ByOM
	Jx/ekFM08qH8TFdlP6VKPOHzGFWoEkNiyw3hXZgP1whsxor0Eo2L/dZzlJ6FTpErLOqHFssenrG
	aTh0SMsKSUFNv
X-Received: by 2002:aa7:c957:0:b0:6b4:746a:1dcf with SMTP id 4fb4d7f45d1cf-6b49cc2044fmr2623076a12.43.1793270360146;
        Thu, 29 Oct 2026 03:39:20 -0700 (PDT)
Received: from localhost (178-84-201-199.dynamic.upc.nl. [178.84.201.199])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b49602346esm2535097a12.7.2026.10.29.03.39.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 03:39:19 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
To: Christian Brauner <brauner@kernel.org>,
	Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-fsdevel@vger.kernel.org,
	fuse-devel@lists.linux.dev,
	Nirmoy Das <nirmoyd@nvidia.com>
Subject: [PATCH 04/16] ovl: add assertions in dir cache code
Date: Thu, 29 Oct 2026 11:39:08 +0100
Message-ID: <20261029103913.2785828-5-amir73il@gmail.com>
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

Overlayfs may keep two different types of directory cache
merged (refcounted) and impure (not refcounted) in the inode.

They are mutually exclusive and an overlayfs directory is never
expected to switch between merged and impure modes.

Nevertheless it is hard to prove that races in the code are not
possible, so add assertions to fortify the code accessing the
directory cache to make sure it does not free the unexpected
cache type.

If an assertion fires the code may leak dir cache memory
but it will not access freed cache memory.

Suggested-by: Nirmoy Das <nirmoyd@nvidia.com>
Link: https://lore.kernel.org/r/20260511062057.2365769-1-nirmoyd@nvidia.com/
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/overlayfs/readdir.c | 25 +++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/fs/overlayfs/readdir.c b/fs/overlayfs/readdir.c
index ba542a1920127..b875332107d31 100644
--- a/fs/overlayfs/readdir.c
+++ b/fs/overlayfs/readdir.c
@@ -36,6 +36,7 @@ struct ovl_cache_entry {
 struct ovl_dir_cache {
 	long refcount;
 	u64 version;
+	bool is_refcounted;
 	struct list_head entries;
 	struct rb_root root;
 };
@@ -479,13 +480,31 @@ static void ovl_seek_cursor(struct ovl_dir_file *od, loff_t pos)
 	od->cursor = p;
 }
 
+/*
+ * Merged (refcounted) and impure (not refcounted) caches are never
+ * expected to be mixed. On mismatch, detach the cache from the inode
+ * and leak it rather than misuse it. A merged cache is still freed by
+ * its last ovl_cache_put().
+ */
+static struct ovl_dir_cache *ovl_dir_cache_check(struct inode *inode,
+						 bool is_refcounted)
+{
+	struct ovl_dir_cache *cache = ovl_dir_cache(inode);
+
+	if (cache && WARN_ON(cache->is_refcounted != is_refcounted)) {
+		ovl_set_dir_cache(inode, NULL);
+		return NULL;
+	}
+	return cache;
+}
+
 static struct ovl_dir_cache *ovl_cache_get(struct dentry *dentry)
 {
 	int res;
 	struct ovl_dir_cache *cache;
 	struct inode *inode = d_inode(dentry);
 
-	cache = ovl_dir_cache(inode);
+	cache = ovl_dir_cache_check(inode, true);
 	if (cache && ovl_inode_version_get(inode) == cache->version) {
 		WARN_ON(!cache->refcount);
 		cache->refcount++;
@@ -498,6 +517,7 @@ static struct ovl_dir_cache *ovl_cache_get(struct dentry *dentry)
 		return ERR_PTR(-ENOMEM);
 
 	cache->refcount = 1;
+	cache->is_refcounted = true;
 	INIT_LIST_HEAD(&cache->entries);
 	cache->root = RB_ROOT;
 
@@ -698,7 +718,7 @@ static struct ovl_dir_cache *ovl_cache_get_impure(const struct path *path)
 	struct ovl_fs *ofs = OVL_FS(dentry->d_sb);
 	struct ovl_dir_cache *cache;
 
-	cache = ovl_dir_cache(inode);
+	cache = ovl_dir_cache_check(inode, false);
 	if (cache && ovl_inode_version_get(inode) == cache->version)
 		return cache;
 
@@ -710,6 +730,7 @@ static struct ovl_dir_cache *ovl_cache_get_impure(const struct path *path)
 	if (!cache)
 		return ERR_PTR(-ENOMEM);
 
+	cache->is_refcounted = false;
 	res = ovl_dir_read_impure(path, &cache->entries, &cache->root);
 	if (res) {
 		ovl_cache_free(&cache->entries);
-- 
2.55.0

