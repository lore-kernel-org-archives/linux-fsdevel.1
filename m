Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBF123D4101;
	Fri,  9 Oct 2026 17:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.157.23.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791566252; cv=none; b=dvN6vtTuY7Xe+AJdP5sqcBcvJ7RSe7ytB9+lpo4uo7+DGSk5TXLb++unNZE5o6ad8XhQ1+T7aEQz9bH+iPr6a9+xNoPE7z0xZcytMvqOiPNmp8uyWEy74ZJ6w3jaSKtuGAkkpetg0MRye3Lorx7n82g4e/U0nX0W3c7M3Re3LdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791566252; c=relaxed/simple;
	bh=j7OqI0tAAgYfBjOyaHlYMYdT28B8LDXr3DOYyRtvjrw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SYFL3voUAoHeaBAJnuoU0zyuWtbC4hvMPaJZjk2eEo+zsqFf8Hx1XXuocWduy5WzC0eQBXBa3yCR00VQj69io45RpUCjMLqgZdN8ycruAL6+5apt+YzVIfBeheDEMdFJjjSq/Vh9sHuf5BhuJJecwk0bDiFC+ZGeHYQ2UrSmRg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com; spf=pass smtp.mailfrom=paragon-software.com; dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b=hcgLSpvJ; arc=none smtp.client-ip=35.157.23.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paragon-software.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b="hcgLSpvJ"
Received: from relayfre-01.paragon-software.com (relayfre-01.paragon-software.com [176.12.100.13])
	by relayaws-01.paragon-software.com (Postfix) with ESMTPS id 4811D1D60;
	Fri,  9 Oct 2026 17:18:20 +0000 (UTC)
Authentication-Results: relayaws-01.paragon-software.com;
	dkim=pass (1024-bit key; unprotected) header.d=paragon-software.com header.i=@paragon-software.com header.b=hcgLSpvJ;
	dkim-atps=neutral
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
	by relayfre-01.paragon-software.com (Postfix) with ESMTPS id 12BB121AD;
	Fri,  9 Oct 2026 17:17:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=paragon-software.com; s=mail; t=1791566249;
	bh=8/ePbVCVz9yz4FVpMgvSWt3IiUbIvuUm1vRAa//hOqA=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=hcgLSpvJUbBYDTENQbWO/0uKT2JKR2MP4QyA7oU9KOs3mj7pDYjIcDiOHs8+t3Bh2
	 +Z9osr+IgdCW4wyE1EqJwtilUN+DYIL7wGZCoWq27guwihAsq9PpWnMlzOQvYUneQ4
	 geOXcBfSte+WMFB6YoTXaVUZR7Ipur1OEc5vj6H4=
Received: from localhost.localdomain (172.30.20.199) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Fri, 9 Oct 2026 20:17:27 +0300
From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To: <ntfs3@lists.linux.dev>
CC: <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Subject: [PATCH 05/11] fs/ntfs3: do not force allocation for IOMAP_ZERO on a partial cluster
Date: Fri, 9 Oct 2026 19:16:58 +0200
Message-ID: <20261009171704.11379-6-almaz.alexandrovich@paragon-software.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261009171704.11379-1-almaz.alexandrovich@paragon-software.com>
References: <20261009171704.11379-1-almaz.alexandrovich@paragon-software.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: vobn-exch-01.paragon-software.com (172.30.72.13) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)

ntfs_iomap_begin() set 'rw' for IOMAP_ZERO whenever the end of the
range fell inside a cluster, forcing the sparse path to allocate
clusters in order to zero them.

Drop the IOMAP_ZERO case and only clamp clen_max when 'rw' is already
set.

Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
---
 fs/ntfs3/inode.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/fs/ntfs3/inode.c b/fs/ntfs3/inode.c
index 1f1b2e5897e1..a3b2daaecb4d 100644
--- a/fs/ntfs3/inode.c
+++ b/fs/ntfs3/inode.c
@@ -968,9 +968,7 @@ static int ntfs_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
 		}
 	}
 
-	if (IOMAP_ZERO == flags && (endbyte & sbi->cluster_mask)) {
-		rw = true;
-	} else if (rw) {
+	if (rw) {
 		clen_max = bytes_to_cluster(sbi, endbyte) - vcn;
 	}
 
@@ -978,7 +976,7 @@ static int ntfs_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
 	 * Force to allocate clusters if directIO(write) or writeback_range.
 	 * NOTE: attr_data_get_block allocates clusters only for sparse file.
 	 * Normal file allocates clusters in attr_set_size.
-	*/
+	 */
 	no_da = flags == (IOMAP_DIRECT | IOMAP_WRITE) || srcmap == WB_NO_DA;
 
 	err = attr_data_get_block(ni, vcn, clen_max, &lcn, &clen,
@@ -987,8 +985,12 @@ static int ntfs_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
 	if (err) {
 		return err;
 	}
-	if (!clen)
+	if (!clen) {
+		/* Looks like file is broken.
+		 * It is marked as bad via _ntfs_bad_inode 
+		 */
 		return -EINVAL;
+	}
 
 	if (lcn == EOF_LCN) {
 		/* request out of file. */
-- 
2.43.0

