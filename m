Received: from mail-43171.protonmail.ch (mail-43171.protonmail.ch [185.70.43.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D6441D5CC9;
	Mon,  1 Jun 2026 18:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780339571; cv=none; b=cKSvUMJ12379wS6SOd8yNGtjm/9ttJMRhRUQdW4wui/mgbf9xiI5iD8cmtHmFvGcixLSIx8B9ahUB00yqRkoWo0im+7WVUwDyEINcIzI0f599N3Orkg6pBdWWboVreiVrNS8IbKVC5M+o8khG5pFaRI+OgIaOz/DWKfATdKUaJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780339571; c=relaxed/simple;
	bh=lDas6F6kvPRWG4nPh21LK0b8IdvMpppxRrDYb3m2Z/8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZHRUgRw7eWuk/jEoFQfr1FtJcVmtkfeJJgD1YxhBsenlq9gva3j/11kXZe4HutujvCUqT6WZoQFUf2oXxI8aWv9LbIIEkBaolKQGRdGomHDvPfdfu+OZTzeOHVy6M9UFsSaY9gQVRpf47Sw0uNPU/Htn9haiJIekZKmete2/A2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=theesfeld.net; spf=pass smtp.mailfrom=theesfeld.net; dkim=pass (2048-bit key) header.d=theesfeld.net header.i=@theesfeld.net header.b=0a8IcOIe; arc=none smtp.client-ip=185.70.43.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=theesfeld.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=theesfeld.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=theesfeld.net header.i=@theesfeld.net header.b="0a8IcOIe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=theesfeld.net;
	s=protonmail2; t=1780339560; x=1780598760;
	bh=iDh8dpiWysFBdoU3PfmRBYK7PIG4v13HkPFuG3Nj7r4=;
	h=From:To:Cc:Subject:Date:Message-ID:From:To:Cc:Date:Subject:
	 Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=0a8IcOIewNo/pNK9r3AiKzx1Q6LsISVF05QHP6M87/zIfi4tsadOgvy0t9EJzyviw
	 CaMfYAihuUfdIFOzOkkHIq1yRuZfPZi7LvEX4385LATNPCE8cXwTL8NScuDDvubpB1
	 TA5EVcvPqWLcxJ1l8Vdvvt+IsXDeMgQXmBL8RvbJ3p/czXioP9Bra215F77jSDop7Q
	 ghchEIFcPkyN/bAiJLaH2iPSSSFqz0ICW3p4asX3KWkdGxqoMbnj1fNTI+HSGmSx0g
	 Zso9N44RUF/Q9E03O4z5EuEcotD6rYQ+nG3ZJTJ+bV2MbEmZPw45I9KDhByISA5ctc
	 mUD/H77aYrPUw==
X-Pm-Submission-Id: 4gTjbB3JVJz2ScPK
From: William Theesfeld <william@theesfeld.net>
To: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+fa88eb476e42878f2844@syzkaller.appspotmail.com
Subject: [PATCH] hpfs: validate in-fnode EA bounds unconditionally
Date: Mon,  1 Jun 2026 14:45:56 -0400
Message-ID: <20260601184557.595889-1-william@theesfeld.net>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The in-fnode extended-attribute region is walked by hpfs_get_ea(),
hpfs_read_ea() and hpfs_set_ea() using fnode_ea() and fnode_end_ea(),
which derive their bounds from on-disk fields (ea_offs, acl_size_s,
ea_size_s).  hpfs_map_fnode() already validates that ea_offs +
acl_size_s + ea_size_s stays within the fnode buffer and that the EA
chain terminates cleanly, but those checks live inside the
sb_chk-gated block, so a user that has disabled the "chk" mount option
loads any image without them.

A crafted image with bogus values for those fields then causes the
walk to escape the 512-byte fnode buffer.  strcmp() on ea->name reads
freed memory, producing a slab use-after-free reported by syzbot:

  hpfs: filesystem error: improperly stopped
  hpfs: You really don't want any checks? You are crazy...
  hpfs: hpfs_map_sector(): read error
  ==================================================================
  BUG: KASAN: use-after-free in strcmp+0x6b/0xc0
  Read of size 1 at addr ffff88804aa888a6 by task syz.0.17/5830
  Call Trace:
   strcmp+0x6b/0xc0
   hpfs_get_ea+0x134/0xee0
   hpfs_read_inode+0x1a6/0x1050
   hpfs_fill_super+0x123d/0x1fa0
   get_tree_bdev_flags+0x431/0x4f0
   vfs_get_tree+0x92/0x2a0
   do_new_mount+0x341/0xd30
   __se_sys_mount+0x31d/0x420
   do_syscall_64+0x15f/0x560

On-disk bounds validation belongs at parse time regardless of the
"chk" option: it is required to keep the kernel from reading past the
fnode buffer, not merely to diagnose unusual images.

Move the EA bounds check and the EA-chain walk out of the sb_chk-gated
block so they run for every fnode load.  The magic and btree
consistency checks are left as before — those diagnose
suspicious-but-not-unsafe images and remain useful only when the user
has asked for them.

Reported-by: syzbot+fa88eb476e42878f2844@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=fa88eb476e42878f2844
Signed-off-by: William Theesfeld <william@theesfeld.net>
---
 fs/hpfs/map.c | 54 ++++++++++++++++++++++++++++++++-------------------
 1 file changed, 34 insertions(+), 20 deletions(-)

diff --git a/fs/hpfs/map.c b/fs/hpfs/map.c
index be7323350..c7388abdd 100644
--- a/fs/hpfs/map.c
+++ b/fs/hpfs/map.c
@@ -168,9 +168,41 @@ struct fnode *hpfs_map_fnode(struct super_block *s, ino_t ino, struct buffer_hea
 		return NULL;
 	}
 	if ((fnode = hpfs_map_sector(s, ino, bhp, FNODE_RD_AHEAD))) {
+		struct extended_attribute *ea;
+		struct extended_attribute *ea_end;
+
+		/*
+		 * The in-fnode EA region is walked by hpfs_get_ea(),
+		 * hpfs_read_ea() and hpfs_set_ea() using fnode_ea() and
+		 * fnode_end_ea(), which derive their bounds from on-disk
+		 * fields.  Validate those bounds unconditionally so that a
+		 * crafted image cannot cause the walk to escape the fnode
+		 * buffer regardless of the "chk" mount option.
+		 */
+		if (le16_to_cpu(fnode->ea_size_s) &&
+		    (le16_to_cpu(fnode->ea_offs) < 0xc4 ||
+		     le16_to_cpu(fnode->ea_offs) +
+		     le16_to_cpu(fnode->acl_size_s) +
+		     le16_to_cpu(fnode->ea_size_s) > 0x200)) {
+			hpfs_error(s,
+				"bad EA info in fnode %08lx: ea_offs == %04x ea_size_s == %04x",
+				(unsigned long)ino,
+				le16_to_cpu(fnode->ea_offs),
+				le16_to_cpu(fnode->ea_size_s));
+			goto bail;
+		}
+		ea = fnode_ea(fnode);
+		ea_end = fnode_end_ea(fnode);
+		while (ea != ea_end) {
+			if (ea > ea_end) {
+				hpfs_error(s, "bad EA in fnode %08lx",
+					(unsigned long)ino);
+				goto bail;
+			}
+			ea = next_ea(ea);
+		}
+
 		if (hpfs_sb(s)->sb_chk) {
-			struct extended_attribute *ea;
-			struct extended_attribute *ea_end;
 			if (le32_to_cpu(fnode->magic) != FNODE_MAGIC) {
 				hpfs_error(s, "bad magic on fnode %08lx",
 					(unsigned long)ino);
@@ -192,24 +224,6 @@ struct fnode *hpfs_map_fnode(struct super_block *s, ino_t ino, struct buffer_hea
 					goto bail;
 				}
 			}
-			if (le16_to_cpu(fnode->ea_size_s) && (le16_to_cpu(fnode->ea_offs) < 0xc4 ||
-			   le16_to_cpu(fnode->ea_offs) + le16_to_cpu(fnode->acl_size_s) + le16_to_cpu(fnode->ea_size_s) > 0x200)) {
-				hpfs_error(s,
-					"bad EA info in fnode %08lx: ea_offs == %04x ea_size_s == %04x",
-					(unsigned long)ino,
-					le16_to_cpu(fnode->ea_offs), le16_to_cpu(fnode->ea_size_s));
-				goto bail;
-			}
-			ea = fnode_ea(fnode);
-			ea_end = fnode_end_ea(fnode);
-			while (ea != ea_end) {
-				if (ea > ea_end) {
-					hpfs_error(s, "bad EA in fnode %08lx",
-						(unsigned long)ino);
-					goto bail;
-				}
-				ea = next_ea(ea);
-			}
 		}
 	}
 	return fnode;
-- 
2.54.0

