Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 186414D37CB;
	Fri,  9 Oct 2026 17:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.157.23.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791566257; cv=none; b=H6pBc0SkvJukbnF2Dj/FAKDF9auA8YfOUrr9kqEn1FOHKDJUkvrfRRPiQ4VN6afQGs/LKZdoALLWY25TIG/ldut9r6qDEvEcco6yECIoCqfmnlQYZzgdYJx5pcewfsh9y/9nE46rcpXMsq8vXMrpooQPvUfT1ZQTJPZGsTc5yiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791566257; c=relaxed/simple;
	bh=YjaMT3OPgFH+qHuo1tAPPVwRb/PdxtIA49xzTbf1JN8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NuEnGnBfbvw1ZxlE8PGLIxxF48QZolyQhsCUPGfD2nPwwXndtiFAhFBczcZbMJmbXa48gF/gz5bhtQ/6oksYx73QPKIczOzWqz29RdghfHahFeaMvzxEh7QYOPP76A5pw9eCtSgUUphXOZIgEYKIG22J5Xl37aonXyvd+Sy1apg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com; spf=pass smtp.mailfrom=paragon-software.com; dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b=pLMj8G6K; arc=none smtp.client-ip=35.157.23.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paragon-software.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b="pLMj8G6K"
Received: from relayfre-01.paragon-software.com (relayfre-01.paragon-software.com [176.12.100.13])
	by relayaws-01.paragon-software.com (Postfix) with ESMTPS id 6E8611D60;
	Fri,  9 Oct 2026 17:18:25 +0000 (UTC)
Authentication-Results: relayaws-01.paragon-software.com;
	dkim=pass (1024-bit key; unprotected) header.d=paragon-software.com header.i=@paragon-software.com header.b=pLMj8G6K;
	dkim-atps=neutral
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
	by relayfre-01.paragon-software.com (Postfix) with ESMTPS id 3A65221AD;
	Fri,  9 Oct 2026 17:17:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=paragon-software.com; s=mail; t=1791566254;
	bh=Q7amg81RcIuZNMKWEzMEECcWC7mA3QoEq36jZRiyDzk=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=pLMj8G6Kh7E3JSbmAy3MpRNHqBXysd/mbx/wKnTpJmFB/3jOjW0qOijqHRAxsQcfX
	 ZEcWFswUc83rVg47auVWcixFoQezwqStXnMSpDnjKqr6n5bt9KOf3TUuLn4FDA7OOq
	 RQMUvkdGwG8XQVpAL05ks0iHmpa7ysOb0rgiDBeQ=
Received: from localhost.localdomain (172.30.20.199) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Fri, 9 Oct 2026 20:17:33 +0300
From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To: <ntfs3@lists.linux.dev>
CC: <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Subject: [PATCH 07/11] fs/ntfs3: allow a zero cluster count for resident attributes
Date: Fri, 9 Oct 2026 19:17:00 +0200
Message-ID: <20261009171704.11379-8-almaz.alexandrovich@paragon-software.com>
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

ntfs_iomap_begin() rejected a zero cluster count from
attr_data_get_block() as corruption. For a resident attribute this is
a normal result: the data lives in the MFT record, so no clusters are
mapped, and the resident case is handled further down and returns
before the cluster count is used.

Move the check below the RESIDENT_LCN and EOF_LCN handling, so it only
applies to the mapped case where a zero count really does indicate a
broken record.

Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
---
 fs/ntfs3/inode.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/fs/ntfs3/inode.c b/fs/ntfs3/inode.c
index 7593a93466d9..4ec12d0184da 100644
--- a/fs/ntfs3/inode.c
+++ b/fs/ntfs3/inode.c
@@ -985,12 +985,6 @@ static int ntfs_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
 	if (err) {
 		return err;
 	}
-	if (!clen) {
-		/* Looks like file is broken.
-		 * It is marked as bad via _ntfs_bad_inode 
-		 */
-		return -EINVAL;
-	}
 
 	if (lcn == EOF_LCN) {
 		/* request out of file. */
@@ -1026,6 +1020,11 @@ static int ntfs_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
 		return 0;
 	}
 
+	if (!clen) {
+		/* Looks like file is broken.*/
+		return -EINVAL;
+	}
+
 	iomap->bdev = inode->i_sb->s_bdev;
 	iomap->offset = offset;
 	iomap->length = ((loff_t)clen << cluster_bits) - off;
-- 
2.43.0

