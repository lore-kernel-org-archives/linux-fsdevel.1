Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=182.48.54.220
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795618469;
	b=LUlJk/keob1sBpeFCD2/jt+XkcOm1SovudPqxugcSxjGzOKDFV0iE9GYp2zCbtZMLr/k
	 cOPZ8NUY3bfw/gf0WVDygL7lsyNYVc0qzLajVYjJ4S1P1Oy2VZpAZG9mZSAq1XOnPy9Ih
	 TGCbme7kYoiTHkcf/mjdRQn/sDGTmnm6XlSO2ryfMImg1dLbIjlN0bjtQ66PyXEwL5kB0
	 U/s1Ymanpw19PhsaLUSIHXAGmtnWO5apktU6pzy/0UB1LmNQaaUoSyaojmgqo/d6966K/
	 GTkfvHgZ3aUgCpUjXe1FXVgeo0JEGAh2OPPA2F/MRo5MLOhy1TVXF3LQW51R1xE2Mew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795618469;
	h=DMARC-Filter:Received:From:Date:To:Cc:Subject:Message-ID;
	bh=lfide8guD1BuFQ5XcKrEgTrUEbu96f6/o/X5z2yJ0gc=;
	b=0I8+3fAto55rJruslpmBNPtHr2YUShINAc5hinY8A0wySKJiOwSSImQQ6WW9V/fv5G4N
	 p/Gjvz/qPC8NMvCC2ufrqJW56ggHwSRvZy3TBNzQxsHVcPx4YXIKOVk2uDDPT/fO2+Djn
	 wuTuqH3IgN27/bI70WL+ZEfL9QdSIQ2pCObl5l2/hTyXv32NOUp2XPyfzrN77pacJegc5
	 abJV+yudtqy9agYdi/h3m2muQrSoVnVQeu+rrh9STSzigHvOuGPUFzRbyNH3FVPqKR9/s
	 fX0VH4a5SU+N2GZdr4IPKC46E/N5V29Ib+eTcf5CHqswLHrAAjxs3kcsB2nwnTI9cPA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=snowrabbit.org;
	spf=pass smtp.mailfrom=snowrabbit.org;
	arc=none smtp.remote-ip=182.48.54.220
Received: from bambi.snowrabbit.org (bambi.snowrabbit.org [182.48.54.220])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9ED4606A327;
	Wed, 25 Nov 2026 14:54:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D9ED4606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=snowrabbit.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=snowrabbit.org
Received: by bambi.snowrabbit.org (Postfix, from userid 3001)
	id 20591C9300; Wed, 25 Nov 2026 23:54:27 +0900 (JST)
From: Showta Ishizaki <zakinko@snowrabbit.org>
Date: Wed, 25 Nov 2026 23:54:14 +0900
To: Alexander Viro <viro@zeniv.linux.org.uk>,
    Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>,
    linux-fsdevel@vger.kernel.org,
    linux-kernel@vger.kernel.org,
    Showta Ishizaki <zakinko@snowrabbit.org>
Subject: [PATCH] ufs: write out moved buffers past i_size
Message-ID: <20261126-ufs-15-v1@snowrabbit.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list

When ufs_new_fragments() has to move a file's tail, ufs_change_blocknr()
gives the buffers in the page cache their new block numbers and marks
them dirty, and leaves them to writeback.  This happens inside a write
that has not moved i_size yet.  If writeback gets to a folio which is
wholly past i_size first, block_write_full_folio() drops it and nothing
is written at the new place.  The folio is clean afterwards with its
buffers still dirty, so later writes to it do not reach the device
either, and the file shows what the device held there before.  In a
folio which straddles i_size the buffers past it can be skipped too.

Write such buffers out when they are moved.  The folio being written
stays locked until i_size has moved, so it does not need it.

I ran fsstress with eight processes on UFS2 images made on NetBSD and
on FreeBSD, 16 seeds each, and compared the files before umount and
after mounting again.  In 5 of the 32 runs a file had changed, all
of them on the image from NetBSD, with 1K fragments.  With this patch
none did.

Signed-off-by: Showta Ishizaki <zakinko@snowrabbit.org>
---

diff --git a/fs/ufs/balloc.c b/fs/ufs/balloc.c
index 628edfde3..b18a512c9 100644
--- a/fs/ufs/balloc.c
+++ b/fs/ufs/balloc.c
@@ -301,6 +301,24 @@ static void ufs_change_blocknr(struct inode *inode, sector_t beg,
 			bh->b_blocknr = newb + pos;
 			clean_bdev_bh_alias(bh);
 			mark_buffer_dirty(bh);
+			/*
+			 * We are inside a write that has not moved i_size
+			 * yet.  Writeback drops a folio wholly past i_size
+			 * without writing it and leaves it clean with its
+			 * buffers dirty, so that later writes do not reach
+			 * the device either.  It may skip the buffers past
+			 * i_size of one that straddles it, too.  The folio
+			 * being written stays locked until the write has
+			 * moved i_size, so only the others need this.
+			 */
+			if (folio != locked_folio &&
+			    (loff_t)(beg + pos) << inode->i_blkbits >=
+			    i_size_read(inode)) {
+				/* A folio's buffers carry no reference. */
+				get_bh(bh);
+				sync_dirty_buffer(bh);
+				put_bh(bh);
+			}
 			++j;
 			bh = bh->b_this_page;
 		} while (bh != head);

base-commit: 4dce97c6c265544342e716e62fd24bbb232590c5
