Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795632479;
	b=l2Xn5/h+XXXxIqDww4LRMWsopCQQkFX4Bo80BFzquAtSfTnqn4t/heGTkQtiUhwG93aK
	 95PFX2moVo6MI0qJMSfYwF5Jogx/1FGmvSKzOjcJddKTzSgAaUE4EEcv7p4nzclGRifh+
	 oV/50s6DyDDQSvqW2FzCTs+9yGtDfS8IQjAXw5pQ+G5iBkPoKOikKxImhyvsFidjAyKlH
	 jCEAhcxYlaT/j+SFYI4Ke383TTIvLKGTtQVHElMvbZxsELXjkIgRFIFabI/XY6jh2v2RX
	 VKYMrNBcKy9h2ohG19kqomPR6g4KzJxShJSEqblb0q9Uom7RPLXCnk+XT8VUyZDatIw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795632479;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=jVGmbTmnUx4mIHZ0AvWPLddmv6SxHuztzi42JWNYOK0=;
	b=ZlNKEwVoW4NpUjiDW+gvfZHPH4HMpCDvS7vjy01KGe31Ozr7XJFTvnfrdkzHfs26Rkht
	 7P5WMCalALgenlT2U528bO8pgMatoaCaRXMyGEX9qWhjwgjGCWlfC20awJspBQ+BKx3hG
	 483LYdahobIb79POp7MKCnI/K5BVM1hdF/sJZ+l5DOWqe6ppC/5dYXRUl2cKpyUZRxEYo
	 O8aAEEaKO9+4F0zQ0BIRYmue6BGgaEKkP6xtRuaFRYOlR/LJduplQB9MB/QDz1k+CcRKz
	 t7CBVBO7MYhjIteMyzStELB+PMUaUXI7A5Li9s2d69ln98CfOSWI+aKqwO5CTO6yw6Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Hu+C+SPm;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 243F9606A31E
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Nov 2026 18:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Hu+C+SPm
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D75A1F000C4;
	Wed, 25 Nov 2026 18:47:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795632478;
	bh=jVGmbTmnUx4mIHZ0AvWPLddmv6SxHuztzi42JWNYOK0=;
	h=From:To:Cc:Subject:Date;
	b=Hu+C+SPmRGoCuEU28a0/hWoPWBc/cq06EbY1wdpsmf2Zj/mYeO/xOtD7pUfaXfIxh
	 2l5/ah3SvkK6xy08PaGUfbe7EQBmsLK5ddg/XjwM0Gk4V3ExxyGCCpheEu4f6cekjJ
	 asvNqNA/IqBPflPU4SB+V0oYLI+o6/SCn1dMq0yadq14ou2JbCCsu/h4Pxg2KSUo3O
	 EdU1mnYufDK/Z3++wIUuat9QxEpVuk04BDQXSayLubLpkWAzRB7rGc6vfYwEad3hFr
	 krlqqwAiJuOTlPAtnG/NXje34kPS0FvXVVvRzVquYfQUAPM/KzOkE80s4Ql2N9kjC3
	 P6/46Zpw7+nVQ==
From: hubcap@kernel.org
To: linux-fsdevel@vger.kernel.org
Cc: Mike Marshall <hubcap@omnibond.com>
Subject: [PATCH] orangefs: do not keep a write range for bytes that were not copied
Date: Wed, 25 Nov 2026 13:47:34 -0500
Message-ID: <20261125184739.430131-1-hubcap@kernel.org>
X-Mailer: git-send-email 2.56.1
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

From: Mike Marshall <hubcap@omnibond.com>

write_begin records the whole request before the copy.
generic_perform_write copies with page faults disabled, and if that
copy moves nothing it still calls write_end. For an extending write
the private range then starts at i_size. The retry is not an extension
of that range, so write_begin launders it and orangefs_writepage_locked
warns. generic/010 hit this while creating its ndbm database. The
retry wrote the real bytes, so the file stayed coherent.

We'll shrink the range to the bytes that were copied. If nothing was copied
and the range is only this write, drop it and do not mark the folio
dirty. Do not move i_size when nothing was copied. The retry records a
new range and does not launder. A range that still starts at i_size on
a later launder or writeback is unchanged.

Signed-off-by: Mike Marshall <hubcap@omnibond.com>
---
 fs/orangefs/inode.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/fs/orangefs/inode.c b/fs/orangefs/inode.c
index b1fed1c81a4d..4ae081330243 100644
--- a/fs/orangefs/inode.c
+++ b/fs/orangefs/inode.c
@@ -384,13 +384,33 @@ static int orangefs_write_end(const struct kiocb *iocb,
 			      struct folio *folio, void *fsdata)
 {
 	struct inode *inode = folio->mapping->host;
+	struct orangefs_write_range *wr = folio_get_private(folio);
 	loff_t last_pos = pos + copied;
 
+	/*
+	 * write_begin records the whole request before any byte is
+	 * copied. Keep only the copied bytes. A copy that moves
+	 * nothing on a new range leaves wr starting at i_size, and
+	 * the retry launders it and warns.
+	 */
+	if (wr && copied < len &&
+	    wr->pos <= pos && wr->pos + wr->len == pos + len) {
+		wr->len -= len - copied;
+		if (wr->len == 0) {
+			kfree(folio_detach_private(folio));
+			folio_cancel_dirty(folio);
+			folio_unlock(folio);
+			folio_put(folio);
+			return 0;
+		}
+	}
+
 	/*
 	 * No need to use i_size_read() here, the i_size
 	 * cannot change under us because we hold the i_mutex.
+	 * A copy that moved nothing must not move i_size either.
 	 */
-	if (last_pos > inode->i_size)
+	if (copied > 0 && last_pos > inode->i_size)
 		i_size_write(inode, last_pos);
 
 	/* zero the stale part of the folio if we did a short copy */
-- 
2.56.1

