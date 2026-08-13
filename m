Received: from forwardcorp1b.mail.yandex.net (forwardcorp1b.mail.yandex.net [178.154.239.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A39B3F7A83;
	Thu, 13 Aug 2026 09:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786614331; cv=none; b=JujXEWIFa4vTNREbpGUTYZWBs86gSbf2dqwbEIuqLVsNAKeCo+0Gl0X21/6jHodF3Nn40BZj3d0DulwNmYDIH09Mz+dX9cVnFEETEmFnz97ISuIz0RbhTqTvnbDOzzXTptDskhn1Y1KVUNINRcxWTjMqZwfnpD8+iwVUWK5dqLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786614331; c=relaxed/simple;
	bh=4fpvAS5MKj34QVtZYyhSUiW5oi4qTKGznK4/SwPY8rY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rOyxGANOizEjV0DKktObbwnlb6NnrSJQn5/Gagz2ByMS8/BMJKOUnM03yFmTc/iC7VQw6n7h3RnkOcGxAQwlh5HnezkpPA/f+45BXHuMjluvTrmJJquDNg1o+DX7iGSjweUUdBLtIjBNXTpwu3Lyfme2tuTq6gMl2wDjAAhOdkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex-team.ru; spf=pass smtp.mailfrom=yandex-team.ru; dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b=VnERNYja; arc=none smtp.client-ip=178.154.239.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex-team.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="VnERNYja"
Received: from mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net (mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net [IPv6:2a02:6b8:c11:43a8:0:640:574d:0])
	by forwardcorp1b.mail.yandex.net (postfix) with ESMTPS id 32200807E0;
	Thu, 13 Aug 2026 12:43:38 +0300 (MSK)
Received: from [127.0.1.1] (unknown [2a02:6bf:8009:1403:13e2:aa39:7988:f1b2])
	by mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net (smtpcorp) with ESMTPSA id YhMvcMH3p0U0-OerpFtHa;
	Thu, 13 Aug 2026 12:43:37 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
	s=default; t=1786614217;
	bh=K/ihBIBMZ1Hst5dkwnXxYKv3w9fi9VrDqvSIq6d1us4=;
	h=Cc:In-Reply-To:Message-Id:To:Date:References:From:Subject;
	b=VnERNYjadtNl8QXc5GaLwZMmte5MxhqXTZ6/nUfxNkYEJHIgpWtCHzXzqfTZQ5CjO
	 vW2Y72KdLUgnhaqoK2D0ZsFaAiiF6r5qr+rtxVoePfKZzzHCMAt3vTSwT4fDGhdtas
	 aIpFce2SRBkobThSw3cU3d3Lp4psOtmvzHkyDtPU=
Authentication-Results: mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net; dkim=pass header.i=@yandex-team.ru
From: Mikhail Rudenko <xyzzy@yandex-team.ru>
Date: Thu, 13 Aug 2026 12:43:30 +0300
Subject: [PATCH RFC 2/2] fs: defer dirtytime iput from PF_MEMALLOC context
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260813-deferred-dirtytime-iput-v1-2-ad2fb3ad6bdb@yandex-team.ru>
References: <20260813-deferred-dirtytime-iput-v1-0-ad2fb3ad6bdb@yandex-team.ru>
In-Reply-To: <20260813-deferred-dirtytime-iput-v1-0-ad2fb3ad6bdb@yandex-team.ru>
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Mikhail Rudenko <xyzzy@yandex-team.ru>
X-Mailer: b4 0.15.2

Both kswapd and direct reclaim run shrinkers with PF_MEMALLOC set.
Dcache reclaim can remove a dentry and drop the final reference to a
linked inode with I_DIRTY_TIME. iput() then calls sync_lazytime(), which
promotes the update to I_DIRTY_SYNC and invokes the filesystem
dirty_inode callback. ext4 can allocate an inode-table buffer with
__GFP_NOFAIL from there, triggering the PF_MEMALLOC allocator warning.

Use the superblock deferred-iput infrastructure to transfer that final
inode reference to an unbound worker instead. Remove the inode from the
inode LRU first so i_lru can serve as the allocation-free queue entry.

This preserves normal dentry eviction policy and only defers work where
iput() would otherwise promote lazytime state from PF_MEMALLOC context.

Signed-off-by: Mikhail Rudenko <xyzzy@yandex-team.ru>
---
 fs/inode.c | 45 ++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 44 insertions(+), 1 deletion(-)

diff --git a/fs/inode.c b/fs/inode.c
index 31c5b9ee3a81..e71750bf7c82 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -18,6 +18,7 @@
 #include <linux/mount.h>
 #include <linux/posix_acl.h>
 #include <linux/ratelimit.h>
+#include <linux/sched.h>
 #include <linux/list_lru.h>
 #include <linux/iversion.h>
 #include <linux/rw_hint.h>
@@ -35,7 +36,7 @@
  * inode->i_lock protects:
  *   inode->i_state, inode->i_hash, __iget(), inode->i_io_list
  * Inode LRU list locks protect:
- *   inode->i_sb->s_inode_lru, inode->i_lru
+ *   inode->i_sb->s_inode_lru, inode->i_lru when on the inode LRU
  * inode->i_sb->s_inode_list_lock protects:
  *   inode->i_sb->s_inodes, inode->i_sb_list
  * bdi->wb.list_lock protects:
@@ -2019,6 +2020,43 @@ static void iput_final(struct inode *inode)
 	evict(inode);
 }
 
+/* Like iput(), but defer sync_lazytime(). Used in reclaim paths. */
+static void iput_memalloc(struct inode *inode)
+{
+	spin_lock(&inode->i_lock);
+	if (unlikely((inode_state_read(inode) & I_DIRTY_TIME) &&
+		     inode->i_nlink)) {
+		int ret;
+
+		if (atomic_add_unless(&inode->i_count, -1, 1)) {
+			spin_unlock(&inode->i_lock);
+			return;
+		}
+
+		inode_lru_list_del(inode);
+		spin_unlock(&inode->i_lock);
+
+		ret = super_defer_iput(inode);
+		if (!ret)
+			return;
+
+		/*
+		 * The superblock is no longer accepting deferred iputs.
+		 * This shouldn't happen.
+		 */
+		WARN_ON_ONCE(ret == -ESHUTDOWN);
+		spin_lock(&inode->i_lock);
+		inode_state_clear(inode, I_DIRTY_TIME);
+	}
+
+	if (!atomic_dec_and_test(&inode->i_count)) {
+		spin_unlock(&inode->i_lock);
+		return;
+	}
+
+	iput_final(inode);
+}
+
 /**
  *	iput	- put an inode
  *	@inode: inode to put
@@ -2047,6 +2085,11 @@ void iput(struct inode *inode)
 	if (atomic_add_unless(&inode->i_count, -1, 1))
 		return;
 
+	if (unlikely(current->flags & PF_MEMALLOC)) {
+		iput_memalloc(inode);
+		return;
+	}
+
 	if (inode->i_nlink && sync_lazytime(inode))
 		goto retry;
 

-- 
2.55.0

