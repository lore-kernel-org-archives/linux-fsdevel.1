Received: from cvsmtppost08.nm.naver.com (cvsmtppost08.nm.naver.com [114.111.35.230])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB6A43AA4E8
	for <linux-fsdevel@vger.kernel.org>; Fri, 31 Jul 2026 09:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.111.35.230
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785490262; cv=none; b=Pn3MfaS+T0kI75vb3y2hcUOwvcd9yYpRHoW24fMei21MENLEBFqCRcU3gtHW/sol21hM7s1pDHckHKhjvinobyZ6RpvA+Hr7YGQHc57sYxD0veC+aB+u6TZTnWabPtuA6sv7lP7I57MqWIFvgxsYPZoRDpFLvL4IeCIUBy2IvNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785490262; c=relaxed/simple;
	bh=ia3z9V4IzPm+2LM5OKC607Bs7iZ3t4+hJ4i9tLyzjHg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oQqQ/VoOn2UPictfvV1AJnAFSJ9DmEzZrAJ7bJlwCJ1NKR0kDMg3YI5RGSxOwv9gsUWopy0oirUPMyAvajPBP4DWO9xXfBKOpihMV2sjhhZIamzQP/vTUzdLLqmUEg13HfBpzlXUGmO4pO39zI7yNQPs7rwr88uDMydMFXCzrkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=naver.com; spf=pass smtp.mailfrom=naver.com; dkim=pass (2048-bit key) header.d=naver.com header.i=@naver.com header.b=TC7IO8aM; arc=none smtp.client-ip=114.111.35.230
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=naver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=naver.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=naver.com header.i=@naver.com header.b="TC7IO8aM"
Received: from cvsendbo026.nm ([10.112.20.48])
  by cvsmtppost08.nm.naver.com with ESMTP id Ni62QN6qRlySZ29bjLD8tw
  for <linux-fsdevel@vger.kernel.org>;
  Fri, 31 Jul 2026 09:10:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=naver.com; s=s20171208;
	t=1785489043; bh=ia3z9V4IzPm+2LM5OKC607Bs7iZ3t4+hJ4i9tLyzjHg=;
	h=From:To:Subject:Date:Message-ID:From:Subject:Feedback-ID:
	 X-Works-Security;
	b=TC7IO8aMxbkit/wJyRgJIebQNBucn/OZPoVOyY6tPyXEmXbdnq16yGokx+YbmNDg6
	 hzig04jsv/353RDa2hkjRLiTtUWRLFX519ENK/nRGPDK7RU30OdW6fF6I2szwRiP6h
	 widwcGvurUsvUI35phRanYtLD6gUphi/0nJ16pDI2NxdkXv09iZXsttiGXgu7wxr4X
	 aQqRnwC/2KxzKztIa75WSqODOZr+EpVcHCYfc89FzlaLufLEe7RCguDy47tLuz+QOj
	 h1n+b2WV9clGLwoJeS3Bt4lMZ3GGpukUj/ZoN4YbGI9DkdI7LSvdO4Z+4abesCTG4G
	 bGV6VqpNhldkw==
X-Session-ID: vgz81iXISzmEnTZCIAH5og
X-Works-Send-Opt: rP+8W4eXjHwYKBm9FAF9FNmwKo2mKqErKqb/jJIFjAJYKg==
X-Works-Smtp-Source: Qqn9FAE/FqJZ+HmZFAMr+6E=
Received: from bl4ckhyun.localdomain ([211.41.193.194])
  by cvnsmtp009.nm.naver.com with ESMTP id vgz81iXISzmEnTZCIAH5og
  for <multiple recipients>
  (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
  Fri, 31 Jul 2026 09:10:42 -0000
From: Hyeontae Lee <wonju345@naver.com>
To: linkinjeon@kernel.org,
	hyc.lee@gmail.com
Cc: zzzccc427@gmail.com,
	baijiaju1990@gmail.com,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hyeontae Lee <wonju345@naver.com>
Subject: [PATCH] ntfs: serialize the resident read iomap path with mrec_lock
Date: Fri, 31 Jul 2026 18:10:35 +0900
Message-ID: <20260731091035.28929-1-wonju345@naver.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CANFS6bbReuJMapSmtQSY+jASmY_di+X28rMFQuYtscBwjCie8g@mail.gmail.com>
References: <CANFS6bbReuJMapSmtQSY+jASmY_di+X28rMFQuYtscBwjCie8g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ntfs_read_iomap_begin_resident() walks the MFT record through
ntfs_attr_lookup() -> ntfs_attr_find() without taking ni->mrec_lock,
while ntfs_attr_record_resize(), ntfs_make_room_for_attr() and
ntfs_resident_attr_record_add() memmove() the same base_ni->mrec buffer
under that lock. map_mft_record() only takes a reference and does not
serialize, so the reader can observe torn attribute length and offset
fields while a writer is relocating the records.

KCSAN reports the race between the mmap read fault path and both link()
and unlink():

  BUG: KCSAN: data-race in ntfs_attr_find / ntfs_attr_record_resize

  write to 0xffff888100af1018 of 4 bytes by task 96 on cpu 1:
   ntfs_attr_record_resize+0xd2/0x130
   ntfs_attr_record_rm+0xad/0x530
   ntfs_delete+0x224/0x640
   ntfs_unlink+0x14d/0x280
   vfs_unlink+0x157/0x520

  read to 0xffff888100af1018 of 4 bytes by task 95 on cpu 0:
   ntfs_attr_find+0x104/0x5b0
   ntfs_attr_lookup+0x39c/0x10c0
   ntfs_read_iomap_begin_resident+0xc6/0x230
   ntfs_read_iomap_begin+0x5d/0xa0
   iomap_iter+0x2e2/0x6e0
   iomap_read_folio+0x147/0x2a0
   ntfs_read_folio+0x108/0x170
   filemap_read_folio+0x35/0x100
   filemap_fault+0x993/0x1000

  value changed: 0x00000250 -> 0x000001f0

The address is mrec + 0x18, i.e. mft_record.bytes_in_use, and the change
is the 96 bytes of one $FILE_NAME attribute being removed.

Take base_ni->mrec_lock around the lookup in
ntfs_read_iomap_begin_resident(). The non-resident path is left alone:
ntfs_lookup() already holds the directory inode's mrec_lock when it reads
an index folio through read_mapping_folio(), and taking the lock in the
shared wrapper deadlocks there with recursive locking on mrec_lock. The
comment above the read_mapping_folio() call in fs/ntfs/dir.c notes the
same hazard.

Tested with a reproducer that faults in a 16-byte resident file while
another thread runs link()/unlink() on it. Before: 40 KCSAN reports in
about one second. After: no reports in 180 seconds over 206,090 read
iterations and 423,540 link/unlink cycles. A PROVE_LOCKING build shows no
lockdep splat with the same reproducer running for 60 seconds.

Fixes: b041ca562526 ("ntfs: update iomap and address space operations")
Link: https://lore.kernel.org/all/20260725042421.109599-1-wonju345@naver.com/
Suggested-by: Hyunchul Lee <hyc.lee@gmail.com>
Signed-off-by: Hyeontae Lee <wonju345@naver.com>
---
 fs/ntfs/iomap.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/ntfs/iomap.c b/fs/ntfs/iomap.c
index 52eecf5cb2..f9fdceeeb3 100644
--- a/fs/ntfs/iomap.c
+++ b/fs/ntfs/iomap.c
@@ -95,6 +95,8 @@ static int ntfs_read_iomap_begin_resident(struct inode *inode, loff_t offset, lo
 	else
 		base_ni = ni;
 
+	mutex_lock(&base_ni->mrec_lock);
+
 	ctx = ntfs_attr_get_search_ctx(base_ni, NULL);
 	if (!ctx) {
 		err = -ENOMEM;
@@ -138,6 +140,8 @@ static int ntfs_read_iomap_begin_resident(struct inode *inode, loff_t offset, lo
 	if (ctx)
 		ntfs_attr_put_search_ctx(ctx);
 
+	mutex_unlock(&base_ni->mrec_lock);
+
 	return err;
 }
 
-- 
2.43.0

