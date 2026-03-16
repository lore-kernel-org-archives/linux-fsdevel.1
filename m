Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A346716A956
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Mar 2026 10:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773657197; cv=none; b=E/AvAA9EN/2UMMCa5dF25DC63b/vPIE8MY2NXdpJQZda5egDDj06rCI3LXYsDPjhmIDJ4vpm3qhCszqNmjNizX748YexQ/PX6NpwS4Qc+jfcc6vEmTRlVpkBD42EsoRUlFq7bvnI+hRdGBBMjp4k0EDgHNwM6d6DgkM8QXpfehQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773657197; c=relaxed/simple;
	bh=ZBJ+7ABdWfBwJ1kdEpniZFc+VpfNdA2ChzEJcdAKvWA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dvyuB2bFHEkW5svFKqeuxtOAq8iSMuwjbMVjg2tWL3TMdwpfVaMdI/SxV/xsFQgcxqCNEUi3mTfJTQ20jmxsKNMGFWewVIogcoe+hJy20GOgOtgcRUeqh6JWIf9D7jsg2m+mTlee87bkrIN3RHd+ynf7+ALSa+PHjk2WG3DqaX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HGSlAT+0; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HGSlAT+0"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4852a9c6309so35154655e9.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Mar 2026 03:33:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773657194; x=1774261994; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=P+MaXMpggT9LK9ANjrahayvw32XcgfuOHp5LC+zevnU=;
        b=HGSlAT+0Fe5/SMs/fZQmtZV5W17fxA/ndlsZXmAYtCnnL0ZWfiEM64YxMZSHrac2UW
         Z7Pi8cpjDxoWBGRvT3yJKGyiKhaKHTuCnsffrjc9Y5uxKBcqTSCHYqG3EDEYYEr1jvef
         09nVHxfAaE23kNS1RL1ZUmFvbl4Y9qX636iUnvnRPuhxvBGME1d1P7EBUZNgpuQmm4Eb
         q+7jqTE13siY/DayWpVRR0X+deQyg3hFDOdzu7VtCdV2tRq0ZR6KXabdKzlqYXX+tSzN
         C38fAkqNqu9+UHFRv6WmobG0pfcUrHfJl/2z9HG9Z50NVCprUgmgy+M86aO+seye4lJP
         Dynw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773657194; x=1774261994;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P+MaXMpggT9LK9ANjrahayvw32XcgfuOHp5LC+zevnU=;
        b=brIlx+PvW7YbBa5/Snb5muV3gMdHYDI03EMaZAFypAQYkesckyz4NYZuglI+f9qM9O
         1l3iRmosUop56M4u8vnsCQ1xqD/Q/AXkwsRXkDFr3bBVmZFpfWwU89yBwcu0ythrm+0Z
         ewAb5Ltp2WlVMm5uLGMKXyxB3iVnsibnrdvFVEuPt/K3GsHg24vJX/kzmSn2vYVxlzjI
         9CuDIQ4gi2VP/hlVWRSP3EYl2Y4wMHGUJOjm7bkyX+aGEMd9qZneJKakhl5dYy8pEfnA
         soDwXKSa7SSHJR8h0FnT7axWO/2W06lCIVVhvvQi5kn+O31Q1owz7Isjy9rN5fgjSOzI
         csGA==
X-Forwarded-Encrypted: i=1; AJvYcCUr7jwS1Qw1nG2TLLHWQ5d0VV/atKH7J5XeBNnhFsqBDUZ42zKom65Z95hWGxIoMnOPj6+alkiB8AqwaxkN@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0vR9Yok+NuAhvp9cO5J5AQiHU0rYrAlXzkBtCopBLUY5HvwL+
	Cd7ssj0XC856ZUWaHyDtRcNjHwBEdwSv0h2rZdXfDDaJ/RPJPIlvZaC/x1JUNw==
X-Gm-Gg: ATEYQzzyiCIVHIT07+vZIjBrK9etJtWNeNvbU5ng7rcnyGr0t3dU/deqdSpvdz4H+GF
	sU3brH70r3D2fZpcR///A/HtcEhs8ZiCfSN56eRfhqT9FnbYVWRbrpoPe7A/n4P/vW4XtJWkt6N
	1mhkDprZxWWpNZaLekARMuGWPNFFJxCicwUQu4MJOdByj3D23k8Dbkx+sgdY+YWITF+FMkkHU/e
	Myq0Erfzm7sbdBtJ8zp+5Xl5Tv/86VY3mNK0K34eJI548z8mN8H4Nqx2//kUaK1v0DawbUDL6uj
	W057gIXo6JdMvn5qbX31e76E82RvUo1Dp/TDxQfzjHi+oX8W3vFUgVSEi51n75SRvCzncWNV6si
	ei29/twAPVfohD8Wj99NeLRpfLwE/qegn3KGWLFoBu5+hyzDlmQgOqJx9Ul9jA89MFa+jZUKHFk
	ufH9Ha8eII99YgRwvlUp953Nd17YPn9rzaK+qJJjKeLoXSMGRO1tHs6X9eJvOOa3F4Yb2vQ/k=
X-Received: by 2002:a05:600c:c0d1:20b0:485:3abe:ab86 with SMTP id 5b1f17b1804b1-485570ce1cfmr148452185e9.4.1773657193560;
        Mon, 16 Mar 2026 03:33:13 -0700 (PDT)
Received: from f.. (cst-prg-90-18.cust.vodafone.cz. [46.135.90.18])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439fe19aec5sm41389446f8f.4.2026.03.16.03.33.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 03:33:12 -0700 (PDT)
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org
Cc: viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>,
	"Lai, Yi" <yi1.lai@linux.intel.com>
Subject: [PATCH] fs: revert insert_inode_locked() eviction wait change and explain why
Date: Mon, 16 Mar 2026 11:33:05 +0100
Message-ID: <20260316103306.1258289-1-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
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

generated against master

FYI next has a change which has a trivial conflic (ino type change)

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

