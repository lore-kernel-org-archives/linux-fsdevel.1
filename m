Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD95C45517D
	for <linux-fsdevel@vger.kernel.org>; Mon, 12 Oct 2026 08:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791793463; cv=none; b=FsylYj7Y62WAZ0fCc6ctWxH78R8+xLuLpH2JyL2HMq4B05pINE/JOM+iVbPN3hvBInA1/GZy/DMhBK8KyBUD4H5n6sRd4K/6bzF9gWACTBjXfboKWf7STrzs+4ZJ/vuU0ICeV01C/4Zrxys4pJHOucSp5BGNQnFPJ3/3y09qtOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791793463; c=relaxed/simple;
	bh=E5x4LLXUVTiIuVjqdCsPtbdXFw5ngWOMyZaNI/eO16c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GyO8G+pCmr4nKll3XWIzWniWfTOkELd4vjPo/5zhP6hFeyAhI/Xj+jXVyfQLc6RDfDvmV4TzIA0+XR5ZRXKK3RcKNVKLXFhSa3owt2deqTf9yCyqKrc1NAx9OpHCT9u9B9HKcQRHGBTL47V/f8McLHzoLfWO/qPNGzMY1aXwQz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 45AF821E5C;
	Mon, 12 Oct 2026 08:24:15 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1F55313794;
	Mon, 12 Oct 2026 08:24:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 8JBtAS+ZzGooHwAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 12 Oct 2026 08:24:15 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 92664A13DA; Mon, 12 Oct 2026 10:24:10 +0200 (CEST)
From: Jan Kara <jack@suse.cz>
To: <linux-fsdevel@vger.kernel.org>
Cc: <linux-mm@kvack.org>,
	Christian Brauner <brauner@kernel.org>,
	Christoph Hellwig <hch@infradead.org>,
	Mikhail Rudenko <xyzzy@yandex-team.ru>,
	Andreas Gruenbacher <agruenba@redhat.com>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH 1/7] writeback: Fix missed lazytime flush
Date: Mon, 12 Oct 2026 10:23:39 +0200
Message-ID: <20261012082356.3121725-8-jack@suse.cz>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20261009133253.20102-1-jack@suse.cz>
References: <20261009133253.20102-1-jack@suse.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1480; i=jack@suse.cz; h=from:subject; bh=E5x4LLXUVTiIuVjqdCsPtbdXFw5ngWOMyZaNI/eO16c=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBqzJkdC6GVFu55LPDESjRn8rfzMStU3HVGXve84 EoyLfs6eXOJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCasyZHQAKCRCcnaoHP2RA 2a1dB/4zZKx6crA9/G+2ui9Y4XyE37woa98Yo4T+xQ46jU0rxLR96g4Ah6Hud0186d9ELVNl5yX dszJ8HFxwG2ZXDZIa6G84Py0LJK6z8qtqUcndiS8+Ito8tAbFNLWjojWcqETQKuoiTzPeN3nqGB 0qfzyMi5QGT0o+3sfg5/tVoMhe/42dOKokvh6rwAeSGDwNla99vkWdIuNWRCxhK51JSZdVADNSS BW2a8ugpsYvryxpPgWthNswzWr8Q96someoE7DBHAsO0O3sFC+Bxu6SOUZVP8Z7aPYFNcAq8a/x c0mU/gLeJeEg0W13SplLALGUpSa9QA7xBzp91k9BE4fKvk84
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 45AF821E5C
X-Spam-Level: 
X-Rspamd-Action: no action
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated

move_expired_inodes() moves to b_io list inodes which were dirtied at
current_time - dirtytime_expire_interval or before.
__writeback_single_inode() however calls sync_lazytime() only if the
inode was dirtied strictly before current_time -
dirtytime_expire_interval. It can thus happen that inode with dirty
timestamps gets queued to b_io list, then fails the check in
__writeback_single_inode() and as a result is just placed back to
b_dirty_time list with a refreshed timestamp and so timestamps aren't
written when they should have been.

This is a very difficult race to hit in practice but changes to how
dirty time expiry is handled on last iput() will make this much easier
to hit.

Fixes: 5fcd57505c00 ("writeback: Drop I_DIRTY_TIME_EXPIRE")
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/fs-writeback.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index ea3eb40bf828..f6fe797a41b4 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -1822,8 +1822,8 @@ __writeback_single_inode(struct inode *inode, struct writeback_control *wbc)
 	 */
 	if ((inode_state_read_once(inode) & I_DIRTY_TIME) &&
 	    (wbc->sync_mode == WB_SYNC_ALL ||
-	     time_after(jiffies, inode->dirtied_time_when +
-			dirtytime_expire_interval * HZ)))
+	     time_after_eq(jiffies, inode->dirtied_time_when +
+			   dirtytime_expire_interval * HZ)))
 		sync_lazytime(inode);
 
 	/*
-- 
2.51.0

