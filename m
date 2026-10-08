Received: from smtp.inf.ufrgs.br (smtp.inf.ufrgs.br [143.54.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEEC53A1A3F;
	Thu,  8 Oct 2026 02:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=143.54.11.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791425453; cv=none; b=R7THDHwDhmJYTv9KKxh69B4fUuWEhtgMrfYtYOfY2c3cP0cxPPK2DxVgSelmcvDmS1PTcTognS381yrDswsbGJOjezlxYdejiMBZScZNX+V/Nv/uUKI2lnR0Gxj5MFYAgZltC8PN9igkNYPpeNFvjTJjuyN1AlATvA8mUYP+0go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791425453; c=relaxed/simple;
	bh=eRfxjSNoqPATi/6gt02ijQ2GxC8HitsmiXkjpmlFxvw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c4KtwlYaSv549KZvm9lkEEEYv1BLdONEa9qnJeFW5D4tRILTyBmq9/iHns/KRUPberWkC+283DAl2WtNdLYz2w8syks+LDecSkSiK7s6CNMnOpBpfXOWYU3LSnSbBY56l/fYQlQ1GfXrJa/gHwo1Lof+XM6xwRWmv64nL7V+zmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inf.ufrgs.br; spf=pass smtp.mailfrom=inf.ufrgs.br; dkim=pass (2048-bit key) header.d=inf.ufrgs.br header.i=@inf.ufrgs.br header.b=2wHYSqKe; arc=none smtp.client-ip=143.54.11.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inf.ufrgs.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inf.ufrgs.br
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=inf.ufrgs.br header.i=@inf.ufrgs.br header.b="2wHYSqKe"
Received: from LAPTOP-R01LEAQM.localdomain (unknown [189.6.233.4])
	by smtp.inf.ufrgs.br (Postfix) with ESMTPSA id C6D781210F6;
	Wed,  7 Oct 2026 23:10:19 -0300 (-03)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=inf.ufrgs.br;
	s=dkim2026; t=1791425419;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=20xwllMk1d5S46CS4CyKnlx0LEzvyBgbaqQS40o2/pM=;
	b=2wHYSqKef04NZ5fOZoeILDdzJmHT21f5opcmJXwZoq3kGVM88t/75+UINdjF3gwy7qIOpX
	Urs3VDJIXYhDM3VMjlPvav+36yo+prRDmuVoL0ZMIR+f8MuFvwH74hjrH/lRJlVdgcL9nB
	1BI48Fi+P+tUf7H9FUy5/M8MLW0juxjk09gcTAP6IHMpuwSw5C7Dx2Rlm6qxdZssVLHN8l
	9IUk5rPWAaR62Gx6PFyJHb6lU84lpSdVGJzgAS62l4YKb19Ls1rGo3iptHKP53I+c6Q4S6
	GXeesA0AbJ5FdtVcfelgkdRdd10m45vy351d1QeCi7z/U11pP2TUTdzZT3evDw==
From: Matheus Alves de Almeida <matheus.aalmeida@inf.ufrgs.br>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Matheus Alves de Almeida <matheus.aalmeida@inf.ufrgs.br>
Subject: [PATCH 3/4] fat: support adding multiple clusters
Date: Wed,  7 Oct 2026 23:09:39 -0300
Message-ID: <20261008020941.55784-4-matheus.aalmeida@inf.ufrgs.br>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261008020941.55784-1-matheus.aalmeida@inf.ufrgs.br>
References: <20261008020941.55784-1-matheus.aalmeida@inf.ufrgs.br>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

fat_add_cluster() currently adds only 1 cluster to the file's chain.
Implement support for adding more in one call and rename the function
to reflect the new behavior.

Signed-off-by: Matheus Alves de Almeida <matheus.aalmeida@inf.ufrgs.br>
---
 fs/fat/fat.h   | 2 +-
 fs/fat/file.c  | 2 +-
 fs/fat/inode.c | 8 ++++----
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/fat/fat.h b/fs/fat/fat.h
index 75ac0239a..683fb68a7 100644
--- a/fs/fat/fat.h
+++ b/fs/fat/fat.h
@@ -440,7 +440,7 @@ static inline unsigned long fat_dir_hash(int logstart)
 {
 	return hash_32(logstart, FAT_HASH_BITS);
 }
-extern int fat_add_cluster(struct inode *inode);
+extern int fat_add_clusters(struct inode *inode, int nr_cluster);
 
 /* fat/misc.c */
 extern __printf(3, 4) __cold
diff --git a/fs/fat/file.c b/fs/fat/file.c
index 1c835ca5f..41d49e9de 100644
--- a/fs/fat/file.c
+++ b/fs/fat/file.c
@@ -292,7 +292,7 @@ static long fat_fallocate(struct file *file, int mode,
 
 		/* Start the allocation.We are not zeroing out the clusters */
 		while (nr_cluster-- > 0) {
-			err = fat_add_cluster(inode);
+			err = fat_add_clusters(inode, 1);
 			if (err)
 				goto error;
 		}
diff --git a/fs/fat/inode.c b/fs/fat/inode.c
index f775a004c..44fc9b556 100644
--- a/fs/fat/inode.c
+++ b/fs/fat/inode.c
@@ -101,16 +101,16 @@ static struct fat_floppy_defaults {
 },
 };
 
-int fat_add_cluster(struct inode *inode)
+int fat_add_clusters(struct inode *inode, int nr_cluster)
 {
 	int err, cluster;
 
-	err = fat_alloc_clusters(inode, &cluster, 1);
+	err = fat_alloc_clusters(inode, &cluster, nr_cluster);
 	if (err)
 		return err;
 	/* FIXME: this cluster should be added after data of this
 	 * cluster is writed */
-	err = fat_chain_add(inode, cluster, 1);
+	err = fat_chain_add(inode, cluster, nr_cluster);
 	if (err)
 		fat_free_clusters(inode, cluster);
 	return err;
@@ -152,7 +152,7 @@ static inline int __fat_get_block(struct inode *inode, sector_t iblock,
 	 */
 	if (!offset && !(iblock < last_block)) {
 		/* TODO: multiple cluster allocation would be desirable. */
-		err = fat_add_cluster(inode);
+		err = fat_add_clusters(inode, 1);
 		if (err)
 			return err;
 	}
-- 
2.43.0

