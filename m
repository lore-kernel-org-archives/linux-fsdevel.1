Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 593953C1981
	for <linux-fsdevel@vger.kernel.org>; Tue,  5 May 2026 05:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777960441; cv=none; b=H8a2FQ9IiP2GzTg9O0FtWIi6O8NotPfQx82Coj+DqWdubW88vd7pzQkQ40UNYP4Gvt4VMZ8ebdXIDw/YpaqWpJybhG45OL+cVMFqqSPKnHfRljMLqYXjHNCiFT1NUOHrL4gUhdT5g3N8sJtHaMOdSlnFGa1odVu7J4sCut7HqbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777960441; c=relaxed/simple;
	bh=oRt2AVlCvnZFfvglstvjLg9ADjUJNEEUIlZkHSuIZKc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LMA55yYc3cL0b8zExotOISsL/huD7EL5604xfx5joo71UHp9V4whhogmrEbY7qZwdLhW+MNlrcF8/rdiG/UOEUu5YK231PmZkOzPuFwuqFkKtV3fdLb9Z6l9Iy/xawB3bdnTGPvE5SeKGA6x0D3ZYq5U+jx6t95iUgfRVw0HtzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=tbEdJGmh; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="tbEdJGmh"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=N430wpvhl30mLC6ZG6X0A3UR7h8OsC3dVeBMgeoIMts=; b=tbEdJGmhU1deFFKGGkKbJapRah
	PEcBBvNdLZ8Okc73EREx3blStXclLJjw/3NXzi4clz2Zs93kImDB42rHi02t0B+qw15VkTAUd33pP
	iC+DKKPtMJ4tAziLXn/q+ak3eYnyZchu9/mfzBTGB5Cpc35Sfx/DPaX4YwpI/hWcQ/0UAK1wyxzig
	7EDtnxKX1mLmuDyV8kkYUgkZgBENuNwf5Owo3z2ZA9jixVg57Ov/arsW6bCSyFg7VijL7BrvY8guG
	owSXvADx92EZBQ0DReSHBiN+VAAHaHPR5Vn0QaZx4Ia73bdFmJvXue52DAEVQ+8RiHZiwAv6NS+EY
	AkkszU7w==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wK8jX-00000005I5j-1Z0f;
	Tue, 05 May 2026 05:54:15 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	NeilBrown <neil@brown.name>
Subject: [RFC PATCH 06/25] make to_shrink_list() return whether it has moved dentry to list
Date: Tue,  5 May 2026 06:53:53 +0100
Message-ID: <20260505055412.1261144-7-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260505055412.1261144-1-viro@zeniv.linux.org.uk>
References: <20260505055412.1261144-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

... and make it check the refcount for being zero in addition to
dentry not being on a shrink list already.  Simplifies the callers...

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/dcache.c | 23 +++++++++--------------
 1 file changed, 9 insertions(+), 14 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index f3e909c7aaad..dc91cbb568f2 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -988,14 +988,17 @@ void d_make_discardable(struct dentry *dentry)
 }
 EXPORT_SYMBOL(d_make_discardable);
 
-static void to_shrink_list(struct dentry *dentry, struct list_head *list)
+static bool to_shrink_list(struct dentry *dentry, struct list_head *list)
 __must_hold(&dentry->d_lock)
 {
-	if (!(dentry->d_flags & DCACHE_SHRINK_LIST)) {
+	if (likely(!dentry->d_lockref.count &&
+	    !(dentry->d_flags & DCACHE_SHRINK_LIST))) {
 		if (dentry->d_flags & DCACHE_LRU_LIST)
 			d_lru_del(dentry);
 		d_shrink_add(dentry, list);
+		return true;
 	}
+	return false;
 }
 
 void dput_to_list(struct dentry *dentry, struct list_head *list)
@@ -1180,8 +1183,7 @@ struct dentry *d_find_alias_rcu(struct inode *inode)
 void d_dispose_if_unused(struct dentry *dentry, struct list_head *dispose)
 {
 	spin_lock(&dentry->d_lock);
-	if (!dentry->d_lockref.count)
-		to_shrink_list(dentry, dispose);
+	to_shrink_list(dentry, dispose);
 	spin_unlock(&dentry->d_lock);
 }
 EXPORT_SYMBOL(d_dispose_if_unused);
@@ -1589,11 +1591,9 @@ static enum d_walk_ret select_collect(void *_data, struct dentry *dentry)
 	if (data->start == dentry)
 		goto out;
 
-	if (!dentry->d_lockref.count) {
+	if (dentry->d_lockref.count <= 0) {
 		to_shrink_list(dentry, &data->dispose);
 		data->found++;
-	} else if (dentry->d_lockref.count < 0) {
-		data->found++;
 	}
 	/*
 	 * We can return to the caller if we have found some (this
@@ -1623,17 +1623,12 @@ static enum d_walk_ret select_collect2(void *_data, struct dentry *dentry)
 	if (data->start == dentry)
 		goto out;
 
-	if (!dentry->d_lockref.count) {
-		if (dentry->d_flags & DCACHE_SHRINK_LIST) {
+	if (dentry->d_lockref.count <= 0) {
+		if (!to_shrink_list(dentry, &data->dispose)) {
 			rcu_read_lock();
 			data->victim = dentry;
 			return D_WALK_QUIT;
 		}
-		to_shrink_list(dentry, &data->dispose);
-	} else if (dentry->d_lockref.count < 0) {
-		rcu_read_lock();
-		data->victim = dentry;
-		return D_WALK_QUIT;
 	}
 	/*
 	 * We can return to the caller if we have found some (this
-- 
2.47.3

