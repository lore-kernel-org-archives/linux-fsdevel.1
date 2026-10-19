Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3917427703
	for <linux-fsdevel@vger.kernel.org>; Mon, 19 Oct 2026 01:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792373816; cv=none; b=FKZlcD/gTGSIQC1iIgvGZI38FE/72+MWg2gqgy2KdDHbJwEYZjBLk6h88bwwUTztP1x2jvCk0hSSXvZbhYD3T56kvYJ8nTE37zSmw+m/rE/85/hPy8R6tJ94ySyKeTm4eDil9uSTnL3E3E5ycxq0fdRlKT26gyBa+EAP/VKj9RM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792373816; c=relaxed/simple;
	bh=gg1Eg3grSOXqtPPw/A55ylEO03zJxiB6MeqK2htP9Ko=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YdkI6OvIfew1lHjigQkOBS2YhQXVRuQ3a4/1lvRluisKi+OEovUnCYuVG4cupAz5SqiNkqHORm6aJLPa2FBco+tuvFVaoy/aWzZp42zsavXseFKi54AJ2EaqcbV3nKAW3szBuSRg+/VNU0kcpulu4IdBdS/dElsTuxhb9g5j1RU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lexfz9BF; arc=none smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lexfz9BF"
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-5eac3bd3fa8so12816e0c.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 18 Oct 2026 18:36:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792373813; x=1792978613; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=iCYDjUky7P1HlkzA/7ybKt6L8LweVSenXoz8RSv4Bks=;
        b=lexfz9BFTOV8OJUA6kZRbEBhJWAUUxLhHvfSohJEIGUnyNIvju6x0Ni/pPjUxpthIZ
         rHykD9eblQUIbSYwfU0PM2YViCtQ1lHreapOD361Hf2Gu5jFp/k434LOm7zCBZGQj5qE
         05hNVifXIObq4kcbg0xPlXgQcikXV4EthOyeBjIhhRSb2wNG2jTmtTvPtLdaMU1TAcRU
         8JyM+Zsw5c/1Pw2whvqIHhBRpQwceC1gV606MpSLYLWTIxJObYc5xVPZdPpnHBU0R/ky
         Eo8VtwDIj10eEOAPlouCJZb6kES0xRHuQfw9MwFRPpjLtlBb5WoNsF+D3JpQ1aH06+jZ
         jeEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792373813; x=1792978613;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iCYDjUky7P1HlkzA/7ybKt6L8LweVSenXoz8RSv4Bks=;
        b=nwU2Cv7vi6Sy0C9I18PQLqUldVUyYIVugNw09a6vaqno6nfBcEfnTjdrLTNY5vZCzT
         CrAmkXk+1Ef5ZK/4UfN638LKtBH4vy80cUahwJNMcG1jrl9I0tDyx9sBA/bb1Q5Mh6M7
         b1z8aM/uZ/lpyUMUZX0YIvPlpnZu+AnaQfaK0NhwG0q7gCS6tyBXDRARlTK3ZDRAMN6J
         BDBagSYoDPVh38PWMny/EtcYkQ3vgRwwWK4tb7ura5K9I+fGoJgFa7aQgbpAz7rj9SDN
         8vvFSnWdAbTR2iBU/6cpvQAaito91sHAWmXhH1MPN8HNBOclEb/i6IwSDfyb7giaAMek
         A3Dg==
X-Forwarded-Encrypted: i=1; AKwUvBwNjJqo7D3K6lLwOqpGAuUtmbbSczyMDbmun9PKnvJhMSrDxqeembA9rWwff+z7l5OkZAmj5+9UCSUiouAc@vger.kernel.org
X-Gm-Message-State: AFq9FYL8EYfQB4+xiBrgXtDvI2ZYHy9ctgindVWh4+PGNP7HI7XW4Ryg
	N2iEdKo6ouQzl1HeyJcDznhdaXdlUG/IidK24TN2SqlB0Hb+pgyUQ7OE
X-Gm-Gg: AYBFou1eXf55zYBGZxmGEPSSxFr/Vo57ccTBi9wS71/WZz1+RvG2VvRz07ZOwBbDU7o
	wGFKwzkin7g/akIrb+IVtAT8a1z2jbanKk8ROU9AvMKfoOj7g/2SfrAiJeNM8LNpWsotHA2f9vb
	nb02mw+hCaygohdbYho5LkdanSBsXVAqgFBZ2V5gosindQ14oPr5e9JGWJy5XAJ2nDEmwbNrHIW
	JnSBvXhuFMLlxgMwXNQlYlEggerKtfKoO4VJZbzFMkSzWyxQdzu3UIsB3AkMN6RjnlUECaWmnhU
	dlva5YiyTh32ecP8qd96+3utnpvsMdWlGZ/TX4H7820VT/tt65JrHv8j+u3cryD135qs+ZDmrnD
	3TPmOX5MtLPFMtnHYRLhgzonP6r7KHERWp+Wbc7wVZu/92jfM2bwLuvq+JgQNBOhT8kolNR3sBC
	30kpbwBypBp02WJu5H85ZscPW5+V3twezW04kSAvmWF7DrqgGGbUmbbh4rD/1c9awM5yC2phpII
	O0YUJGCT+TYrIxzVqdAzZN8+kLW0XfKopA0ScFpxAL2A2cCd2mT/o1ASaRG41fii3r5DFB9Yuep
	nqP99US7cmwGHivfVoY=
X-Received: by 2002:a05:6122:8116:b0:5ea:c3bc:c584 with SMTP id 71dfb90a1353d-5eac3bcc86bmr270069e0c.1.1792373813100;
        Sun, 18 Oct 2026 18:36:53 -0700 (PDT)
Received: from localhost.localdomain ([132.170.205.109])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-9908362f359sm7368186241.10.2026.10.18.18.36.51
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 18 Oct 2026 18:36:52 -0700 (PDT)
From: Sanan Hasanov <sanan.hasanou@gmail.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sanan Hasanov <sanan.hasanov@ucf.edu>,
	syzbot+e353ad4408c4f9fac965@syzkaller.appspotmail.com
Subject: [PATCH] minix: restore uptodate on bitmap buffers before redirtying them
Date: Sun, 18 Oct 2026 21:36:45 -0400
Message-ID: <20261019013645.40834-1-sanan.hasanou@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sanan Hasanov <sanan.hasanov@ucf.edu>

The inode and zone bitmap buffers are read once at mount time and stay
pinned in sbi->s_imap[] and sbi->s_zmap[] until unmount. Their in-memory
contents are the authoritative copy of the allocation state.

If writeback of one of these buffers fails, the buffer write completion
handler marks a write I/O error and clears BH_Uptodate. The next bitmap
update then calls mark_buffer_dirty() on a buffer that is no longer
uptodate and trips:

  WARNING: fs/buffer.c:991 at mark_buffer_dirty+0x299/0x410
  ...
   minix_free_block fs/minix/bitmap.c
   free_data fs/minix/itree_common.c:272 [inline]
   truncate fs/minix/itree_common.c:321 [inline]
   V1_minix_truncate+0x310/0x10c0 fs/minix/itree_v1.c:61
   minix_evict_inode+0x1c9/0x260 fs/minix/inode.c:52
   evict+0x624/0xb50 fs/inode.c:822
   minix_mkdir+0xdc/0x120 fs/minix/namei.c:136

syzbot hits this by shrinking the loop device under a mounted minix
filesystem so that bitmap writeback fails, then letting a failed mkdir
evict the new inode and free its blocks.

Since the buffer data is still valid, do what ext2 and ext4 do for their
long-lived superblock buffers: clear the write I/O error and set the
buffer uptodate again before dirtying it, so the bitmap is written out
again on the next writeback. Do this under the buffer lock so it cannot
interleave with a write that is still in flight and about to fail. The
original failure has already been logged and recorded in the block
device mapping by mark_buffer_write_io_error(), so clearing the per-buffer
flag does not hide it.

Reported-by: syzbot+e353ad4408c4f9fac965@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=e353ad4408c4f9fac965
Signed-off-by: Sanan Hasanov <sanan.hasanov@ucf.edu>
---
 fs/minix/bitmap.c | 26 ++++++++++++++++++++++----
 1 file changed, 22 insertions(+), 4 deletions(-)

diff --git a/fs/minix/bitmap.c b/fs/minix/bitmap.c
index abec43833..0ac96c88e 100644
--- a/fs/minix/bitmap.c
+++ b/fs/minix/bitmap.c
@@ -39,6 +39,24 @@ static __u32 count_free(struct buffer_head *map[], unsigned blocksize, __u32 num
 	return sum;
 }
 
+/*
+ * The bitmap buffers stay pinned for the lifetime of the mount and their
+ * in-memory contents are authoritative.  A failed writeback clears
+ * BH_Uptodate on them, so restore it before redirtying the buffer instead
+ * of tripping the warning in mark_buffer_dirty().  The buffer lock keeps
+ * this from racing with a write that is still in flight.
+ */
+static void minix_mark_bitmap_dirty(struct buffer_head *bh)
+{
+	lock_buffer(bh);
+	if (!buffer_uptodate(bh)) {
+		clear_buffer_write_io_error(bh);
+		set_buffer_uptodate(bh);
+	}
+	mark_buffer_dirty(bh);
+	unlock_buffer(bh);
+}
+
 void minix_free_block(struct inode *inode, unsigned long block)
 {
 	struct super_block *sb = inode->i_sb;
@@ -64,7 +82,7 @@ void minix_free_block(struct inode *inode, unsigned long block)
 		printk("minix_free_block (%s:%lu): bit already cleared\n",
 		       sb->s_id, block);
 	spin_unlock(&bitmap_lock);
-	mark_buffer_dirty(bh);
+	minix_mark_bitmap_dirty(bh);
 	return;
 }
 
@@ -83,7 +101,7 @@ int minix_new_block(struct inode * inode)
 		if (j < bits_per_zone) {
 			minix_set_bit(j, bh->b_data);
 			spin_unlock(&bitmap_lock);
-			mark_buffer_dirty(bh);
+			minix_mark_bitmap_dirty(bh);
 			j += i * bits_per_zone + sbi->s_firstdatazone-1;
 			if (j < sbi->s_firstdatazone || j >= sbi->s_nzones)
 				break;
@@ -207,7 +225,7 @@ void minix_free_inode(struct inode * inode)
 	if (!minix_test_and_clear_bit(bit, bh->b_data))
 		printk("minix_free_inode: bit %lu already cleared\n", bit);
 	spin_unlock(&bitmap_lock);
-	mark_buffer_dirty(bh);
+	minix_mark_bitmap_dirty(bh);
 }
 
 struct inode *minix_new_inode(const struct inode *dir, umode_t mode)
@@ -243,7 +261,7 @@ struct inode *minix_new_inode(const struct inode *dir, umode_t mode)
 		return ERR_PTR(-ENOSPC);
 	}
 	spin_unlock(&bitmap_lock);
-	mark_buffer_dirty(bh);
+	minix_mark_bitmap_dirty(bh);
 	j += i * bits_per_zone;
 	if (!j || j > sbi->s_ninodes) {
 		iput(inode);
-- 
2.48.1

