Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793238753;
	b=s0/NAg+QZ8HIp404Nr8nUxeCxVbH9dC1dU/M4TavCTX0vIY++h5CLgxVlCiJYMUpVsQP
	 DIHk17Wvnbk5siX/fFieFHlaYX5r32WRnlkIgHlqvGzxMPfDRS8jpntA8Ku13Bqq2uxuC
	 1h5E65u3u0t9/JxkplI63/nytWGxEkv5/YwgpTjvZ0bQHCl4EscrweMAl0iiyowbJlh7D
	 38Jo0ffPVANaLbKRVv7v2VrextIJtegJ2lI9ReKQQmn5wrxIERCOidCiERE6tn3lv2ZNG
	 Wct4jyO0fzM9SIp3cM/l3IwfXAaDbptqHaj5FlCON4VfGL8j7oh0rrkfQpWcyx/F79A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793238753;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Vd17fMN2xBVkgvpCKThIisBl5J6tXBx/ZBgfx0p28sI=;
	b=KYTDYnoWivFdsgJVZfif4hlhyOyDG6rP70LLUMcZsgYnDnnyMSbVds/LkbwDmlpDkF7z
	 xGzITZuntJ3RSDD8qRP51vq5lAXy9hMbHtndWsGImCCOw4RKj9PFQaeel7pzNDbqNoAs8
	 j6md7cu+noZHk1ux09DhnquVCoVzdMRjuEwlB74x8ahTX34QQ3WqeI3vd/L7BuH5XTyM8
	 RwXa7OZiKv10rvazO/Mif2oKpDoRQviz4ZX9P/5QFiPQKLwtmyT5EQ3kCxhrcWgfOKcIS
	 UNMPcYKi1MxUlC27R0G7ksVw1hjW8lIUmh3EJUBEQfcvuuCEwEs6Menh8UzKPRMvngA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FAMKuEUP;
	arc=none smtp.remote-ip=209.85.216.42
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3C80606A31A
	for <linux-fsdevel@vger.kernel.org>; Thu, 29 Oct 2026 01:52:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A3C80606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FAMKuEUP
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-3ac78f4c10bso812121a91.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Oct 2026 18:52:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793238752; x=1793843552; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Vd17fMN2xBVkgvpCKThIisBl5J6tXBx/ZBgfx0p28sI=;
        b=FAMKuEUPGE4Q84xqNZnNmDsypOtQKA/Hx3t1J1y6qQG2sH05l52zkubjxLDJrBcXTs
         q0wVsHYkLgbhoukKNOdLee4SkyxDs5YKB4he5f5fYfvOcpuO1JJut2N9j681kpXrU+eR
         oUTbveogp6wXIy38inLQcl5bImwdJcj48Pr2fMDyyrbMNSqG/ChjMyVm8q0yUGPvmR8H
         lOafsVulkwssPeFajQg3E3AO22UaWsPxm4Vedldlua3IliXr1UsTWUPh0ZPO3E90dL5N
         UdCJM5zRC/PLvacm3i9Z4ZPk4hFLxLn4rAncHd1R4C3+hWzc+886flJQDQFtMpqDFhrl
         SXOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793238752; x=1793843552;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Vd17fMN2xBVkgvpCKThIisBl5J6tXBx/ZBgfx0p28sI=;
        b=GnExrBIPM8YJzUvyfp3aBqr2ltof0flsZhCuH+mRkw9KluETDaOI9AA5a5UUMYL3C+
         kKJ5qN8LuPpsopqOzx8tg/CrFZnlNqSu/gl3fQ3UOiWHkooF6ppjwgULC4EnnlTaBM/1
         JjO5dhZ+0r7UD4ZgXQEmXgFDUkJIZycgmb1P+UpNDmIryBUbqQj1ZfsMjsxzwiBCHNS1
         9Nh02IKuXEYeea7QINm1Ot/fbrNDwwhb249+5+jzaFBsUCjhp/LHfLnbnKXGlKwd/71P
         9MU49ESECLMNyZaeH+vVpLUqop+CsnSJBFlvY1v3Yye55yEGuEVU8DA86Tl1OWAyQP7f
         Xv2w==
X-Forwarded-Encrypted: i=1; AKwUvBwOPZlRIqzgMVMF/mOrN993Jb2wzn9Zg3kG//VMnqeNLinGhXFxaPJ+mLPU2RdVwOQS/g4nPtj21Wdl148F@vger.kernel.org
X-Gm-Message-State: AFq9FYLYcT2njWarso/G0H4g1S8XgqL/p1RAkSNvVuR8fPbpCipecRhb
	Lwjeol0pljOT+wcCat2h2sGrmrT9yMPSj4c2Nhte9e7Ufognu0UcN1Ia
X-Gm-Gg: AYBFou2LQhP05ovadulRE8ei2OsknSaNr1GqcOPEdkneyRCQFOMdf1Tqm9E5Fs8fw5V
	yiYb/1dYoaaJ1J1aQwiHDuCfLZ9Vi+ipvuSo0r8lxXmdMsR1oGEin+JhPd+tFYDkCDg6NTTsNlb
	zrzb+9KdoWnJD+CQx+irNNz6VNguiD+hK2yAbEb+pFzvExw1fud88zf76Nv+NNXNy5eYpN1F8fL
	llKjyJLoK3Wf841PehSWHwBC0Abke7elwZb4zMHU84esjWz2U2/HkeZpO5HcxtYyYCJHA0O2s2e
	2r810cS4lu4MaWQdfQMgQQ0DTVWmqHDOCwy+pGREdnC5qQhRAtkTu8NQe+yc+m838sqV0t6TJ5O
	2RWerXMamwMcVgVpV/XXndrUbJWqPwSbav4wnoMQZbSSdSJWypaFND4CYfA9DvYBHxxqUNBE6jg
	9Ome6noW24FsGdSSrij3p76dqb9GtfgS5K7CCusyy8Y6X1INTN6p1QR/DaDoezAvpWUPIaXX/kO
	lxtUocTGJn5/wvSqgCkXWwl4R0WIMq1l5/DBxcnnqwKm4dNRZyz29SrDvn+Yo6wiXvjsSSEyBHc
	qHQSf5kpYG1qGv0n856qnSJmBWZ5bVSdiwOs5k9n3eUQBA==
X-Received: by 2002:a17:90b:4986:b0:3ad:a232:403f with SMTP id 98e67ed59e1d1-3ae58144159mr3099499a91.56.1793238751803;
        Wed, 28 Oct 2026 18:52:31 -0700 (PDT)
Received: from linux ([103.155.143.38])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae6e2a6dc1sm1606230a91.0.2026.10.28.18.52.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 18:52:31 -0700 (PDT)
From: Hongyu Jin <hongyu.jin.cn@gmail.com>
X-Google-Original-From: Hongyu Jin <hongyu.jin@unisoc.com>
To: jack@suse.cz
Cc: brauner@kernel.org,
	hongyu.jin.cn@gmail.com,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v2] writeback: Avoid postponing periodic data writeback indefinitely
Date: Thu, 29 Oct 2026 09:52:17 +0800
Message-ID: <20261029015217.840177-1-hongyu.jin@unisoc.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <azdwnedsaesxdsp6vxjxgzg6ynrszveibmqkpznn3yuqyttlcj@5lz4p2aw5hxk>
References: <azdwnedsaesxdsp6vxjxgzg6ynrszveibmqkpznn3yuqyttlcj@5lz4p2aw5hxk>
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

From: Jan Kara <jack@suse.cz>

f2fs periodically calls sync_inode_metadata() for some inodes. The logic
in writeback_single_inode() thus periodically calls to redirty_tail() and
the inode's dirtied_when timestamp never gets old enough for the inode
to be eligible for periodic data writeback. Thus dirty data from it is
only ever written on explicit request (fsync(2), sync(2), unmount) or
on dirty limit pressure.

The redirty_tail() logic in writeback_single_inode() actually should not
be necessary. Since this function is used only for once-off writeback,
there's no need for any livelock protection among inodes and
writeback_single_inode() is only responsible for demoting inode to "less
dirty" list based on dirty bits cleared as a result of writeback. So
remove the redirty_tail() logic and add a comment explaining the rules.

The redirty_tail() did hide a race though, the one fixed by
commit 846a3351ddfe ("writeback: Avoid skipping inode writeback").
__writeback_single_inode() sets I_DIRTY_PAGES again when the mapping
is still tagged dirty. If the inode had no I_DIRTY bits (e.g.
write_inode_now(inode, 0) or sync_inode_metadata(inode, 0) of an inode
with only I_DIRTY_TIME), the dirty pages come from a racing writer,
whose __mark_inode_dirty() then finds I_DIRTY_PAGES set and does not
queue the inode, leaving it on b_dirty_time or b_attached. Call
__mark_inode_dirty() in that case instead, so that the inode gets queued
on b_dirty.

Fixes: 846a3351ddfe ("writeback: Avoid skipping inode writeback")
Reported-by: Hongyu Jin <hongyu.jin.cn@gmail.com>
Link: https://lore.kernel.org/all/20261023023707.263101-1-hongyu.jin@unisoc.com
Cc: stable@vger.kernel.org
Signed-off-by: Jan Kara <jack@suse.cz>
[hongyu.jin: let __mark_inode_dirty() queue an inode whose pages were
 dirtied while it had no I_DIRTY bits, update comments]
Signed-off-by: Hongyu Jin <hongyu.jin@unisoc.com>
---
 fs/fs-writeback.c | 60 +++++++++++++++++++++++++++++++++--------------
 1 file changed, 43 insertions(+), 17 deletions(-)

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index 58a6403780aa..c7979b0cd375 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -1780,7 +1780,9 @@ bool sync_lazytime(struct inode *inode)
  *
  * This doesn't remove the inode from the writeback list it is on, except
  * potentially to move it from b_dirty_time to b_dirty due to timestamp
- * expiration.  The caller is otherwise responsible for writeback list handling.
+ * expiration, or to queue it on b_dirty via __mark_inode_dirty() when its
+ * pages were dirtied while it had no I_DIRTY bits.  The caller is otherwise
+ * responsible for writeback list handling.
  *
  * The caller is also responsible for setting the I_SYNC flag beforehand and
  * calling inode_sync_complete() to clear it afterwards.
@@ -1790,6 +1792,7 @@ __writeback_single_inode(struct inode *inode, struct writeback_control *wbc)
 {
 	struct address_space *mapping = inode->i_mapping;
 	long nr_to_write = wbc->nr_to_write;
+	bool mark_pages = false;
 	unsigned dirty;
 	int ret;
 
@@ -1843,12 +1846,23 @@ __writeback_single_inode(struct inode *inode, struct writeback_control *wbc)
 	 * still has dirty pages.  The flag is reinstated after smp_mb() if
 	 * necessary.  This guarantees that either __mark_inode_dirty()
 	 * sees clear I_DIRTY_PAGES or we see PAGECACHE_TAG_DIRTY.
+	 *
+	 * If the inode had any I_DIRTY bits, __mark_inode_dirty() has already
+	 * queued it (if it is to be queued at all) and we can just reinstate
+	 * I_DIRTY_PAGES.  Otherwise the pages were dirtied by a racing writer
+	 * and the inode may sit on b_dirty_time or b_attached.  Setting the
+	 * flag here would make the writer's __mark_inode_dirty() bail out
+	 * without queueing the inode, so let __mark_inode_dirty() set it and
+	 * queue the inode instead.
 	 */
 	smp_mb();
 
-	if (mapping_tagged(mapping, PAGECACHE_TAG_DIRTY))
-		inode_state_set(inode, I_DIRTY_PAGES);
-	else if (unlikely(inode_state_read(inode) & I_PINNING_NETFS_WB)) {
+	if (mapping_tagged(mapping, PAGECACHE_TAG_DIRTY)) {
+		if (dirty)
+			inode_state_set(inode, I_DIRTY_PAGES);
+		else
+			mark_pages = true;
+	} else if (unlikely(inode_state_read(inode) & I_PINNING_NETFS_WB)) {
 		if (!(inode_state_read(inode) & I_DIRTY_PAGES)) {
 			inode_state_clear(inode, I_PINNING_NETFS_WB);
 			wbc->unpinned_netfs_wb = true;
@@ -1858,6 +1872,9 @@ __writeback_single_inode(struct inode *inode, struct writeback_control *wbc)
 
 	spin_unlock(&inode->i_lock);
 
+	if (mark_pages)
+		__mark_inode_dirty(inode, I_DIRTY_PAGES);
+
 	/* Don't write the inode if only I_DIRTY_PAGES was set */
 	if (dirty & ~I_DIRTY_PAGES) {
 		int err = write_inode(inode, wbc);
@@ -1946,22 +1963,31 @@ static int writeback_single_inode(struct inode *inode,
 	 * as it can be finally deleted at this moment.
 	 */
 	if (!(inode_state_read(inode) & I_FREEING)) {
+		enum inode_state_flags_enum istate = inode_state_read(inode);
+
 		/*
-		 * If the inode is now fully clean, then it can be safely
-		 * removed from its writeback list (if any). Otherwise the
-		 * flusher threads are responsible for the writeback lists.
+		 * __mark_inode_dirty() is responsible for promoting inode to
+		 * the proper list (b_attached -> b_dirty_time -> b_dirty).
+		 * Here we are responsible for demoting inode after some dirty
+		 * bits were cleared.
+		 *
+		 * If the inode is now fully clean, then it can be safely moved
+		 * to b_attached list. If the inode is dirty, we don't want to
+		 * touch it - it should be already put to the dirty list by
+		 * __mark_inode_dirty() and we'd just unnecessarily clobber the
+		 * dirtied_when stamp (which is particularly problematic when
+		 * we were called from sync_inode_metadata()). We also cannot
+		 * touch the dirty list association when I_SYNC_QUEUED is set
+		 * and flush worker is responsible for it. Otherwise move the
+		 * inode to b_dirty_time list as that's the only remaining
+		 * possibility.
 		 */
-		if (!(inode_state_read(inode) & I_DIRTY_ALL))
+		if (!(istate & I_DIRTY_ALL))
 			inode_cgwb_move_to_attached(inode, wb);
-		else if (!(inode_state_read(inode) & I_SYNC_QUEUED)) {
-			if ((inode_state_read(inode) & I_DIRTY))
-				redirty_tail_locked(inode, wb);
-			else if (inode_state_read(inode) & I_DIRTY_TIME) {
-				inode->dirtied_when = jiffies;
-				inode_io_list_move_locked(inode,
-							  wb,
-							  &wb->b_dirty_time);
-			}
+		else if (!(istate & I_SYNC_QUEUED) && !(istate & I_DIRTY)) {
+			WARN_ON_ONCE(!(istate & I_DIRTY_TIME));
+			inode->dirtied_when = jiffies;
+			inode_io_list_move_locked(inode, wb, &wb->b_dirty_time);
 		}
 	}
 
-- 
2.53.0

