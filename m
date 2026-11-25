Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795632543;
	b=GsEwczkW7YVsm/1lbvZI7VTEDMi9ZCLi8wkhN3pF+vfRxiDT+7KC71QEgi61iZGc/DBt
	 SdI/P1MUtPOFOFySQqBgD9PmcX2MwqYPQlQ1T7rf9nmcYBDLBAvm//RKrVcwso5gCYN3+
	 cZ7og+XXGi3DVO2cvHHbQ3K6EjxEXhjXeUGQkQLrAjeGDS5JK5zSPK3976mxXx/vumjEj
	 Zc37VMpo/ttKXXZO7gdWgp4B/leKxT6bHoPAudDlzXvrkbpWgIPq7wXM+OJaJgUdkX+uj
	 0Dm9q8ciTAdOiTKU53D1jZcObXrbmYLEdRL3+ckbJQXpQkosGzRhdOpKDHYsPRguN9A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795632543;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=dpOXkIdGlv07F5o7sQeY1F2q4rzTLPpuuPmBM8fkrhM=;
	b=IjpemEqN8NIGP8C1I84g0sxapVwDCqy3t4TTOI+1mX/XbTHLvmrMZQYhz8xAmWxf3P9S
	 nTWOacI0HdIaX3kLr5T0Z+M/Odre+m8TfMCxfgxn6idYPPPqeYTwBHpQ9Olo5MK21JHhx
	 3lnjEcCCRonVUuqS3rHK1b5ZtE1uhPNiu8Ff46ulT74WPTeg9HDT2J6DLbRGZusIynUD/
	 BK/Owvfm1vnk0pZjxDWU6f/nca0bnmPV29USgRSt/T0/Qg0754D43vGXo07/qEjapjUOk
	 tbHDO1hBhLuhT6pg+zdFmnpRgGLuqXI+1hgunb3GAJs+iwBnbF96Dd/DjbRkJVrYB7w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VwWZb59D;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DD11606A321
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Nov 2026 18:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VwWZb59D
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09CD11F000C4;
	Wed, 25 Nov 2026 18:49:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795632542;
	bh=dpOXkIdGlv07F5o7sQeY1F2q4rzTLPpuuPmBM8fkrhM=;
	h=From:To:Cc:Subject:Date;
	b=VwWZb59DVj6jRlepZTTtPDQ+IjwTM2L9dumzhXNnAgwUAD5/R0OZcm8VE9/TEHh4t
	 Qx1h6pMmZZosUMyGjX5l9vZaAD6pFTOg5EbH/ywRPsVs1w1KmcQFbpELnzSO8NYX4H
	 RlZhfVAnoInYaEF+/kT5xQzz9MsFYNugimeIQ4e/NuT3QGYGHaVplcjmnO4V2idv77
	 dXAvr9I3x9O/RiC+dXuZv9/fysp6Bi2ecIxu7jq7YQWBwFGYtzMivM74k4eNpDTs/w
	 YCZHOh4+zMMVT/CvW134RnS+9Mt3vHIpMJZbsufDopHRkYEQqW3X0EUJLorUm6gDF4
	 nZ6tZ4OsSH8Bg==
From: hubcap@kernel.org
To: linux-fsdevel@vger.kernel.org
Cc: Mike Marshall <hubcap@omnibond.com>
Subject: [PATCH] orangefs: do not post writeback that starts at or past i_size
Date: Wed, 25 Nov 2026 13:48:44 -0500
Message-ID: <20261125184854.430614-1-hubcap@kernel.org>
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

orangefs_write_range can still start at or past i_size when writeback runs,
because of truncation for example. ow->len is a size_t, so a start past
EOF wraps, and a start equal to i_size becomes a 0-byte write. In either
case, don't do the write. The private range still gets detached, writeback
is ended, and the folios are unlocked. A range that starts below i_size
and runs past it is written, but not past EOF.

orangefs_writepage_locked used to put the original length back when
wlen resolved to 0. That writes past EOF and keeps WARN_ON(wlen == 0) from
firing. Leave the length at 0. The missing-private path does the same
when the folio itself starts at or past i_size.

xfstest generic/464 often produces the warning.

Signed-off-by: Mike Marshall <hubcap@omnibond.com>
---
 fs/orangefs/inode.c | 33 +++++++++++++++++++++++++--------
 1 file changed, 25 insertions(+), 8 deletions(-)

diff --git a/fs/orangefs/inode.c b/fs/orangefs/inode.c
index 4ae081330243..04a2c928452e 100644
--- a/fs/orangefs/inode.c
+++ b/fs/orangefs/inode.c
@@ -33,18 +33,24 @@ static int orangefs_writepage_locked(struct folio *folio,
 	if (folio->private) {
 		wr = folio->private;
 		off = wr->pos;
-		if ((off + wr->len > len) && (off <= len))
+		/*
+		 * The private range can start at or past i_size after a
+		 * truncate. Nothing there is written. Restoring wr->len
+		 * would write past EOF.
+		 */
+		if (off >= len)
+			wlen = 0;
+		else if (off + wr->len > len)
 			wlen = len - off;
 		else
 			wlen = wr->len;
-		if (wlen == 0)
-			wlen = wr->len;
 	} else {
 		WARN_ON(1);
 		off = folio_pos(folio);
 		wlen = folio_size(folio);
-
-		if (wlen > len - off)
+		if (off >= len)
+			wlen = 0;
+		else if (wlen > len - off)
 			wlen = len - off;
 	}
 
@@ -97,15 +103,26 @@ static int orangefs_writepages_work(struct orangefs_writepages *ow,
 	}
 	iov_iter_bvec(&iter, ITER_SOURCE, ow->bv, ow->nfolios, ow->len);
 
+	/*
+	 * The packed range can start at or past i_size after a truncate.
+	 * Keep the warning. Do not post: ow->len is a size_t, so a start
+	 * past EOF wraps, and a 0-byte post does not complete on an old
+	 * client. The folios are still cleaned below.
+	 */
 	WARN_ON(ow->off >= len);
-	if (ow->off + ow->len > len)
+	if (ow->off >= len)
+		ow->len = 0;
+	else if (ow->off + ow->len > len)
 		ow->len = len - ow->off;
 
 	off = ow->off;
 	wr.uid = ow->uid;
 	wr.gid = ow->gid;
-	ret = wait_for_direct_io(ORANGEFS_IO_WRITE, inode, &off, &iter, ow->len,
-	    0, &wr, NULL, NULL);
+	if (ow->len)
+		ret = wait_for_direct_io(ORANGEFS_IO_WRITE, inode, &off, &iter,
+		    ow->len, 0, &wr, NULL, NULL);
+	else
+		ret = 0;
 	if (ret < 0)
 		mapping_set_error(ow->mapping, ret);
 	else
-- 
2.56.1

