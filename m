Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=188.121.53.33
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794440710;
	b=oUPTk3GSUF87NpOknDvs/4TiWg3TR1Pt+zoGBCyLG9Ke/zWysToFRyo+RQzTGtJ1n+76
	 Kmdt0YK1WdYaINiLUN8asLhmLhK4tB7JJ2TPcWAhfYyZlpYlFf2kBX4AjDxjAJQjcM9bB
	 TtHwl8rj0R5T6On6LDikoeC+BsfzGfm9gjM7dJSYNkWm1tsSUCrxIx//1eZLONU4vo4lT
	 exQqJukLLwXE8jkjeLpjJI6VJiCesMxfYSi+nwN2f6wnxiG2hfDFVqMkhotovMq8SMBio
	 qj20ivlIhMrv98/+xeiLd6CSE3Xbm5E0TNQRHH6zYxZyRAZoDQkUw8bd8VlQ15NZOvw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794440710;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:X-CMAE-Analysis:
	 Feedback-ID:X-SECURESERVER-ACCT:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CMAE-Envelope;
	bh=NouO/FZeoDIdnH7nhMKiD43p006OZz+vFcBeN/P08xc=;
	b=09EMiFg5nvXmLgXvLpKWNPQG4qe/pQk+tqKjNhdqXchgqg05IBeSq0Xge13XtTTPtqbt
	 feHo1gtpCnBfoNDox4ZTvrbDDGc+ILYtnVBYO3FZk8sznCmJlSfgFKIy/rvk5Bfv7pCeD
	 TV8OoW+TwzU9PfvnYPBvccSZcwT9uf4UIarD8lsGuLrLyF55ZXBJclQ8GCw6NW31ZN6ND
	 JwEBx/x7fPvTAKtgZp0vK+JiUzUlLGTH5XmmGdmAapgQtF74TFtMsDFkT8ZfFIEJ8PGAC
	 iPboQgtEdxVDo7IfHC7xumtqtbI+t3CvfdAUwGhnvJhcxd5ffOQR8hLPsEcoWl+VrUg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=squashfs.org.uk;
	spf=pass smtp.mailfrom=squashfs.org.uk;
	dkim=pass header.d=secureserver.net header.i=@secureserver.net header.a=rsa-sha256 header.s=secureserver2 header.b=tMosWvpv;
	dkim=pass header.d=squashfs.org.uk header.i=@squashfs.org.uk header.a=rsa-sha256 header.s=secureserver1 header.b=mt6rvJpL;
	arc=none smtp.remote-ip=188.121.53.33
Received: from sxplsmtpa04-03.prod.sxb1.secureserver.net (sxplsmtpa04-03.prod.sxb1.secureserver.net [188.121.53.33])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAD40606D918
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Nov 2026 23:45:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EAD40606D918
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=squashfs.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=squashfs.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=secureserver.net header.i=@secureserver.net header.a=rsa-sha256 header.s=secureserver2 header.b=tMosWvpv;
	dkim=pass (2048-bit key, unprotected) header.d=squashfs.org.uk header.i=@squashfs.org.uk header.a=rsa-sha256 header.s=secureserver1 header.b=mt6rvJpL
Received: from avalon.fritz.box ([82.69.79.175])
	by :SMTPAUTH: with ESMTPA
	id RHz6xtxIpLwCURHzxxAFZs; Wed, 11 Nov 2026 23:45:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secureserver.net;
	s=secureserver2; t=1794440703;
	bh=NouO/FZeoDIdnH7nhMKiD43p006OZz+vFcBeN/P08xc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=tMosWvpvBxN+a8ugF4SkV4OARv6D0Ngg0DsaKXS8k3r3FG6LmVnEDqmNtyUUAJtkF
	 vrnEhIIFxmnk/3XdaKxxnOKtsaVdyXjCVJLd+sJBIAG4SGr248xOOjDZqIjVGCbfi6
	 GALMrcis2EugOqBVdJBwjU27pk/EcLH9q+2HStRcetpSa34iF4KqEInXejzY2eNC1L
	 7uyvrEk+lV7EG9zxoDdgtTWmIbeN30BhDFsERbm7no3LqqnDI9IA+vXiDVnryb5gAy
	 MRX6EDvYMFYHI4I3CQFTbCpF6WSeiHYNZAAOSdO20izsp4seBBVnw4ax4QDwESN3dD
	 O4fo68V6ihKPw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squashfs.org.uk;
	s=secureserver1; t=1794440703;
	bh=NouO/FZeoDIdnH7nhMKiD43p006OZz+vFcBeN/P08xc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mt6rvJpLZ5uF86mgvvYXPGpAx0r77oEOJrCFLstzi+MGmSqKNAlv32kFeBtmp+8j/
	 xeZ8yFpFtJhmPhW4cr4xrMvhN2BZb3LhDL0/EUwMWKeSW1DU+KhB0b7batMgJyU0hy
	 hjHjjezKRJFedNfVHqpQX66Fbg2TKckCw7tMJH/9Uc0McRJfI+puc5c0BRJhUDKz3p
	 uilOswYj5lAKO3A8cz84MZkAj1QsdoE0Qg6FfWgGJOAU6hOLhHSNgcPJSvzhf5tyPW
	 qT27t5Rv2tAdkFZuY2ssICi3rOufkhr2BXt8KuNSbyVqtcyILDTU+UYetk697ljOFL
	 2d3eEsp9RE4LQ==
X-CMAE-Analysis: v=2.4 cv=XZYcX455 c=1 sm=1 tr=0 ts=6af4fdfe
 a=84ok6UeoqCVsigPHarzEiQ==:117 a=84ok6UeoqCVsigPHarzEiQ==:17 a=FXvPX3liAAAA:8
 a=7Zd2xgau2SnrXiwuqnEA:9 a=UObqyxdv-6Yh2QiB9mM_:22
Feedback-ID: 686876d990a796b861820fc50ea798bc:squashfs.org.uk:ssnet
X-SECURESERVER-ACCT: phillip@squashfs.org.uk
From: Phillip Lougher <phillip@squashfs.org.uk>
To: linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	akpm@linux-foundation.org
Cc: Phillip Lougher <phillip@squashfs.org.uk>
Subject: [PATCH v2 21/22] Squashfs: fix regression in squashfs_copy_cache()
Date: Wed, 11 Nov 2026 23:44:01 +0000
Message-ID: <20261111234402.252354-22-phillip@squashfs.org.uk>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261111234402.252354-1-phillip@squashfs.org.uk>
References: <20261111234402.252354-1-phillip@squashfs.org.uk>
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
X-CMAE-Envelope: MS4xfFW+ttfmDt7I7hpdnZ5nSzVGBzx7/M1cwguOkFFyFfCiV91ZffBmB02QtLUZoq2bye1rt7xaqliC1GDx3/qq5QKQxydhS+WZywrT639+MCjI+HmW/Pe2
 X7DuZLXNpKixUKlGYFZQovkMoHePN+JntkE3PHTMjD03SO0RC56VRX+gH+/I3QrKwdUbhYExIlbf4Rt3PSDIXtIhnWd+AlN4n4JSU46oxRvS/xJwxvTcy5g3
 UeKw/MNIQeSlr75FCBbitZoOhmcSFv4QjjjHb9i+YmCcqupZkvqMuOm1RYuLKKljtq5rBrtwFm1Uw4kbzyseQ0E5W+0vwSYDp1PvgEzcH90=

In a recent commit updating the code to use folios, the bytes variable
was changed from signed to unsigned in squashfs_copy_cache().

The bytes variable is used in a loop where PAGE_SIZE bytes are
subtracted from it each time around the loop, and where the loop
terminates once bytes is less than or equal to zero.

The effect of the change in signedness is bytes no longer becomes
negative when it is not a multiple of PAGE_SIZE, and the loop does not
terminate when it should do, and instead folios are created and filled
after file EOF.

These beyond EOF folios are not visible to user-space and hence this is
a silent regression.

This commit fixes the code to only subtract the minimum of bytes or
PAGE_SIZE, and which ensures the variable does not underflow.

Fixes: 5641371fd0b3 ("squashfs; convert squashfs_copy_cache() to take a folio")
Signed-off-by: Phillip Lougher <phillip@squashfs.org.uk>
---
 fs/squashfs/file.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/fs/squashfs/file.c b/fs/squashfs/file.c
index 6ad9fa8ac967..f94a51391651 100644
--- a/fs/squashfs/file.c
+++ b/fs/squashfs/file.c
@@ -410,6 +410,7 @@ void squashfs_copy_cache(struct folio *folio,
 	struct squashfs_sb_info *msblk = inode->i_sb->s_fs_info;
 	s64 i, mask = (1 << (msblk->block_log - PAGE_SHIFT)) - 1;
 	s64 start_index = folio->index & ~mask, end_index = start_index | mask;
+	size_t avail;
 
 	/*
 	 * Loop copying datablock into pages.  As the datablock likely covers
@@ -417,12 +418,13 @@ void squashfs_copy_cache(struct folio *folio,
 	 * grab the pages from the page cache, except for the page that we've
 	 * been called to fill.
 	 */
-	for (i = start_index; i <= end_index && bytes > 0; i++,
-			bytes -= PAGE_SIZE, offset += PAGE_SIZE) {
+	for (i = start_index; i <= end_index && bytes; i++,
+			bytes -= avail, offset += avail) {
 		struct folio *push_folio;
-		size_t avail = buffer ? min(bytes, PAGE_SIZE) : 0;
 		bool updated = false;
 
+		avail = min(bytes, PAGE_SIZE);
+
 		TRACE("bytes %zu, i %lld, available_bytes %zu\n", bytes, i, avail);
 
 		push_folio = (i == folio->index) ? folio :
@@ -436,7 +438,7 @@ void squashfs_copy_cache(struct folio *folio,
 		if (folio_test_uptodate(push_folio))
 			goto skip_folio;
 
-		updated = squashfs_fill_page(push_folio, buffer, offset, avail);
+		updated = squashfs_fill_page(push_folio, buffer, offset, buffer ? avail : 0);
 skip_folio:
 		folio_end_read(push_folio, updated);
 		if (i != folio->index)
-- 
2.47.3

