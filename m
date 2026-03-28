Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BB9F340A51
	for <linux-fsdevel@vger.kernel.org>; Sat, 28 Mar 2026 15:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774711925; cv=none; b=TqgJa/ABNcP0R1X5Rm2tfm1KCcmuhFkkwKDuD6H0E8PZ998xOPoDBIuC41EMPPzNkDgbWROxgQ4C26IsG/2aU6v0RAUBsiDexq+yajZLhZcmBMrthPPYResFfTEDiMM81v+QrdY97Ukym+bT91pkDWvmpWN/wVYIexVXPqkXkMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774711925; c=relaxed/simple;
	bh=s/8IlebDzkbVB0x3ZPq6jRzAdKw0+tljoRl8W93Mw2o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NStsCHIDvSxxEeZmhD0ksBVG8UqhEQpj9rZ4RGPoSaqD8PI4cPqKn5D1aUfga7aAf011xFM6WaCweEAqppMqMObD8/2CD7eAZ1YbWILelG6EbYhKTvkwuMRNHDEoGZ5ide35urk+cRiJBgTaRsjp2OvnwaxuMtr1GIl7aboQAII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kQ9DhyGR; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kQ9DhyGR"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-43b41b545d9so3298573f8f.2
        for <linux-fsdevel@vger.kernel.org>; Sat, 28 Mar 2026 08:32:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774711922; x=1775316722; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cm/8dTd6WxBttMkVbYS0e9e3tXxe/ZGmXHRFHym+rA8=;
        b=kQ9DhyGR/H6HWDYXR4grXvLtF4yEj6LB4icExNiReYwFPzU8e/kP6Q2jVKjGZx/AL7
         7HTa+hBJvpCEzfNVMcCA1tZeoRSMN+jDJOQKs4DzWHJevIi6clIeRDNUDnd8Y/fPKkLW
         4NTh0mUJTukoik6xCAFANIHmOAQMp9VNw/zyrFYVRWEc3KpkburNrvkhk0pkntEUjv6B
         F9eh2EhALicSjv5dtHL1qU56IKJsPMWs9mt8MU0n74srj9E3KbNLFXI8KUM0+mmJsU/S
         ycfcw8LIfECSO6kYVPio7ShSuBD2TJb/OzxTN7izpehZ6Ai3M5QKVNggizfs2Bo9jtuR
         4Dlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774711922; x=1775316722;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cm/8dTd6WxBttMkVbYS0e9e3tXxe/ZGmXHRFHym+rA8=;
        b=jQ78Dr4BTvuvCmF8NlbhP4FSixupPI1Bo4O4inItc6kq99hYEhQsJp6u1Dt5qCQkjq
         tfxijm1jM4foLkcW4lLCLtf4B7ynYfmzeJk0fnau+TNqDIZc5Az7KslUtjKCTSkGF4g6
         XKtqrzNKSJwR7Uj6mJKL0SyroDzv1tXU2mchqtkgQXCBAzAunmNcNcQbGGA3wMzoQwPQ
         3VZsd+Z/gfMafl1brWiAmZgrAR2a5496TioQ4+4vG7Z9JYZJafUq8jqpC2DopqZfvIRu
         LtHdqOYr3B6qvWOyrLr4kDNANDhB4JV/1D5Q7aiAHC+XW15Drwv0Cy3H4cTo7iwfImgj
         1B+Q==
X-Forwarded-Encrypted: i=1; AJvYcCXxVpCK8DpV/meGGttcdW6szs8PvHF0E+3agrD9FhyvZ+Dh95kD/4l/yxXXGMQxwks1TKlCup+hngzLLD+U@vger.kernel.org
X-Gm-Message-State: AOJu0YyAjL2pjj+0805ZlvpScOqDgBhq7OjvYYT3yQ1pnJFMIllEnVp5
	Pezthnn9PiBdV102PWfEsprfGdOJfSEB2DAn2y6LOUZUNzii2KfZHKrt
X-Gm-Gg: ATEYQzz3BsnD6acO91QU0RumX7z5kaFxlSr8MNwQ4RU2dJcYy/6YrdOtcNVoq3T/cNu
	YjvYq/3LQAPBVDt6WozFE9RnZKn61c81SQd6zZp+WAsYIm/ZeotNYwq7yeWOaiyRm57jgD21EEN
	g9KmGND2UB7g7VjOPEPvR3rie3gIzivjdOuerJRfcqCqJBrpC97rqI9eAbp7ug6saS/qttSmuQp
	SfHey5JyvlZLAoMEkAdWxr5GPfBfMfSaGJOJ5ZGz1A3c20bp84KCQYuUGQiZg23PlsL3CAxd0sY
	My8dFNfuR9KpZE+CkdtoXdS2TRPN/Gb5LMRXY33BhRGIEeqAqeQb+4+yetBRJocgoLaT9gkx9I3
	U6oaPZ5L23m7Gd+AItdcTiJykb8ExpqQK+EMLoA2DAR6qjIkjXOxLEm2VqcDiqAguAnp6DQgENk
	EqitLEphNwAfZlVkByE9gTi8qE+7wj/5+7EifLZQvEbzDs/jLxybZQ4juYH8EesysnspiuFYe8m
	bcUAJyZv2FU
X-Received: by 2002:a05:6000:238a:b0:439:ccd7:cdb6 with SMTP id ffacd0b85a97d-43b9e9ea0f9mr11085170f8f.14.1774711921583;
        Sat, 28 Mar 2026 08:32:01 -0700 (PDT)
Received: from f.. (cst-prg-89-171.cust.vodafone.cz. [46.135.89.171])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43cf245f8a3sm6725310f8f.24.2026.03.28.08.31.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Mar 2026 08:32:01 -0700 (PDT)
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org
Cc: viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>,
	"Lai, Yi" <yi1.lai@linux.intel.com>
Subject: [PATCH] fs: revert insert_inode_locked() eviction wait change and explain why
Date: Sat, 28 Mar 2026 16:31:42 +0100
Message-ID: <20260328153146.3368470-3-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260328153146.3368470-1-mjguzik@gmail.com>
References: <20260328153146.3368470-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It causes a deadlock, reproducer can be found here:
https://lore.kernel.org/linux-fsdevel/abNvb2PcrKj1FBeC@ly-workstation/

The real bug is in ext4, but I'm not digging into it and a working order
needs to be restored.

Commentary is added as a warning sign for another sucker^Wdeveloper.

Fixes: 88ec797c468097a8 ("fs: make insert_inode_locked() wait for inode destruction")
Reported-by: "Lai, Yi" <yi1.lai@linux.intel.com>
Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---
 fs/inode.c | 53 +++++++++++++++++++++++++++++------------------------
 1 file changed, 29 insertions(+), 24 deletions(-)

diff --git a/fs/inode.c b/fs/inode.c
index cc12b68e021b..5f7e76c9fb53 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -1037,20 +1037,19 @@ long prune_icache_sb(struct super_block *sb, struct shrink_control *sc)
 	return freed;
 }
 
-static void __wait_on_freeing_inode(struct inode *inode, bool hash_locked, bool rcu_locked);
-
+static void __wait_on_freeing_inode(struct inode *inode, bool is_inode_hash_locked);
 /*
  * Called with the inode lock held.
  */
 static struct inode *find_inode(struct super_block *sb,
 				struct hlist_head *head,
 				int (*test)(struct inode *, void *),
-				void *data, bool hash_locked,
+				void *data, bool is_inode_hash_locked,
 				bool *isnew)
 {
 	struct inode *inode = NULL;
 
-	if (hash_locked)
+	if (is_inode_hash_locked)
 		lockdep_assert_held(&inode_hash_lock);
 	else
 		lockdep_assert_not_held(&inode_hash_lock);
@@ -1064,7 +1063,7 @@ static struct inode *find_inode(struct super_block *sb,
 			continue;
 		spin_lock(&inode->i_lock);
 		if (inode_state_read(inode) & (I_FREEING | I_WILL_FREE)) {
-			__wait_on_freeing_inode(inode, hash_locked, true);
+			__wait_on_freeing_inode(inode, is_inode_hash_locked);
 			goto repeat;
 		}
 		if (unlikely(inode_state_read(inode) & I_CREATING)) {
@@ -1088,11 +1087,11 @@ static struct inode *find_inode(struct super_block *sb,
  */
 static struct inode *find_inode_fast(struct super_block *sb,
 				struct hlist_head *head, unsigned long ino,
-				bool hash_locked, bool *isnew)
+				bool is_inode_hash_locked, bool *isnew)
 {
 	struct inode *inode = NULL;
 
-	if (hash_locked)
+	if (is_inode_hash_locked)
 		lockdep_assert_held(&inode_hash_lock);
 	else
 		lockdep_assert_not_held(&inode_hash_lock);
@@ -1106,7 +1105,7 @@ static struct inode *find_inode_fast(struct super_block *sb,
 			continue;
 		spin_lock(&inode->i_lock);
 		if (inode_state_read(inode) & (I_FREEING | I_WILL_FREE)) {
-			__wait_on_freeing_inode(inode, hash_locked, true);
+			__wait_on_freeing_inode(inode, is_inode_hash_locked);
 			goto repeat;
 		}
 		if (unlikely(inode_state_read(inode) & I_CREATING)) {
@@ -1842,13 +1841,28 @@ int insert_inode_locked(struct inode *inode)
 	while (1) {
 		struct inode *old = NULL;
 		spin_lock(&inode_hash_lock);
-repeat:
 		hlist_for_each_entry(old, head, i_hash) {
 			if (old->i_ino != ino)
 				continue;
 			if (old->i_sb != sb)
 				continue;
 			spin_lock(&old->i_lock);
+			/*
+			 * FIXME: inodes awaiting eviction don't get waited for
+			 *
+			 * This is a bug because the hash can temporarily end up with duplicate inodes.
+			 * It happens to work becuase new inodes are inserted at the beginning of the
+			 * chain, meaning they will be found first should anyone do a lookup.
+			 *
+			 * Fixing the above results in deadlocks in ext4 due to journal handling during
+			 * inode creation and eviction -- the eviction side waits for creation side to
+			 * finish. Adding __wait_on_freeing_inode results in both sides waiting on each
+			 * other.
+			 */
+			if (inode_state_read(old) & (I_FREEING | I_WILL_FREE)) {
+				spin_unlock(&old->i_lock);
+				continue;
+			}
 			break;
 		}
 		if (likely(!old)) {
@@ -1859,11 +1873,6 @@ int insert_inode_locked(struct inode *inode)
 			spin_unlock(&inode_hash_lock);
 			return 0;
 		}
-		if (inode_state_read(old) & (I_FREEING | I_WILL_FREE)) {
-			__wait_on_freeing_inode(old, true, false);
-			old = NULL;
-			goto repeat;
-		}
 		if (unlikely(inode_state_read(old) & I_CREATING)) {
 			spin_unlock(&old->i_lock);
 			spin_unlock(&inode_hash_lock);
@@ -2534,18 +2543,16 @@ EXPORT_SYMBOL(inode_needs_sync);
  * wake_up_bit(&inode->i_state, __I_NEW) after removing from the hash list
  * will DTRT.
  */
-static void __wait_on_freeing_inode(struct inode *inode, bool hash_locked, bool rcu_locked)
+static void __wait_on_freeing_inode(struct inode *inode, bool is_inode_hash_locked)
 {
 	struct wait_bit_queue_entry wqe;
 	struct wait_queue_head *wq_head;
 
-	VFS_BUG_ON(!hash_locked && !rcu_locked);
-
 	/*
 	 * Handle racing against evict(), see that routine for more details.
 	 */
 	if (unlikely(inode_unhashed(inode))) {
-		WARN_ON(hash_locked);
+		WARN_ON(is_inode_hash_locked);
 		spin_unlock(&inode->i_lock);
 		return;
 	}
@@ -2553,16 +2560,14 @@ static void __wait_on_freeing_inode(struct inode *inode, bool hash_locked, bool
 	wq_head = inode_bit_waitqueue(&wqe, inode, __I_NEW);
 	prepare_to_wait_event(wq_head, &wqe.wq_entry, TASK_UNINTERRUPTIBLE);
 	spin_unlock(&inode->i_lock);
-	if (rcu_locked)
-		rcu_read_unlock();
-	if (hash_locked)
+	rcu_read_unlock();
+	if (is_inode_hash_locked)
 		spin_unlock(&inode_hash_lock);
 	schedule();
 	finish_wait(wq_head, &wqe.wq_entry);
-	if (hash_locked)
+	if (is_inode_hash_locked)
 		spin_lock(&inode_hash_lock);
-	if (rcu_locked)
-		rcu_read_lock();
+	rcu_read_lock();
 }
 
 static __initdata unsigned long ihash_entries;
-- 
2.48.1

