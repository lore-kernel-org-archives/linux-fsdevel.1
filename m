Received: from smtp.inf.ufrgs.br (smtp.inf.ufrgs.br [143.54.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FBD431F989;
	Thu,  8 Oct 2026 02:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=143.54.11.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791425439; cv=none; b=OdDTaDZc3iE344xBYseXKbn/GgVXB0hu78kO6HQmT5HboNu3uRdEXiEa6cev+DPHgCF3kKKYfxa7MjeJZdpNaEzluua24YvBG6s+mTlB8M9YBx3iZ2BQorvRgAzqsqkAko+hLI3ahAXptn1CnVvpT8hmnO/jwj1vRAE0IpsiTwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791425439; c=relaxed/simple;
	bh=bq9n0C2W49WuWQMPx1mq1hu0fQtznO8Qg5MBuoMPNbU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iWN9VcOXFVWcW2kJ03q2bU1ROvGSzcqN8/DOoh5z9a+CSW1k5IeAFQZBzCR/TuJxcOqEprav+wXI/tXMUUig5m3+OPlSP/9oBH9npv3y8ssvn6AreupF2pUS3Edmu9JDuAoVTF3oT6Dg+20Ih/OmYPcf4tz37xbZnbuwLctNOC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inf.ufrgs.br; spf=pass smtp.mailfrom=inf.ufrgs.br; dkim=pass (2048-bit key) header.d=inf.ufrgs.br header.i=@inf.ufrgs.br header.b=vHpvFswH; arc=none smtp.client-ip=143.54.11.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inf.ufrgs.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inf.ufrgs.br
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=inf.ufrgs.br header.i=@inf.ufrgs.br header.b="vHpvFswH"
Received: from LAPTOP-R01LEAQM.localdomain (unknown [189.6.233.4])
	by smtp.inf.ufrgs.br (Postfix) with ESMTPSA id 9590C1210F3;
	Wed,  7 Oct 2026 23:10:19 -0300 (-03)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=inf.ufrgs.br;
	s=dkim2026; t=1791425419;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AekpOn0RQNvYktcb9eJqXpRgLVmePdgHhuHcsjY2Z1A=;
	b=vHpvFswHZiQFjORdu0mym7vLizCSCJKmzlOLzWUGmSZ9YCmqnI6mbeer0n4eCx+6LBOHwZ
	NIhttR+o5eTc4wydW9EMAh6DrBEG9V57mz9WOhqFXwD2ciEbx0cx6GbAuEpjECHtDWZpvH
	Flq6bl6aFaHH+Vohubp7I9Cv46IeITNzaiATusDmSzU/lnTlZp8iTvdIZN3+KRD/2pjLat
	dSXojndKrNsX+NxT4xdv/tCDNDNgm0Kt/VtmFzwgTS9iczUx3mwJLlyEzThSKRIYVjE40z
	gppfZqGb7qBbjS58Wepe7kG87V2yKJsSVCH+Me3bbY/NMgtjn8ZW1LBc9Ie1cQ==
From: Matheus Alves de Almeida <matheus.aalmeida@inf.ufrgs.br>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Matheus Alves de Almeida <matheus.aalmeida@inf.ufrgs.br>
Subject: [PATCH 1/4] fat: remove cluster allocation size limit
Date: Wed,  7 Oct 2026 23:09:37 -0300
Message-ID: <20261008020941.55784-2-matheus.aalmeida@inf.ufrgs.br>
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

fat_alloc_clusters() currently BUG()s when asked to allocate more than
MAX_BUF_PER_PAGE / 2 clusters. This limit comes from the buffer_head
array used to defer syncing and mirroring.

Remove the allocation size limit by doing buffer_head batching like
fat_free_clusters() does.

Signed-off-by: Matheus Alves de Almeida <matheus.aalmeida@inf.ufrgs.br>
---
 fs/fat/fatent.c | 44 +++++++++++++++++++++++++++++++-------------
 1 file changed, 31 insertions(+), 13 deletions(-)

diff --git a/fs/fat/fatent.c b/fs/fat/fatent.c
index f0801d99d..bfab8eab5 100644
--- a/fs/fat/fatent.c
+++ b/fs/fat/fatent.c
@@ -468,6 +468,26 @@ static void fat_collect_bhs(struct buffer_head **bhs, int *nr_bhs,
 	}
 }
 
+static int fat_flush_bhs(struct super_block *sb, struct buffer_head **bhs,
+			 int *nr_bhs, bool sync)
+{
+	int err, i;
+
+	if (sync) {
+		err = fat_sync_bhs(bhs, *nr_bhs);
+		if (err)
+			return err;
+	}
+	err = fat_mirror_bhs(sb, bhs, *nr_bhs);
+	if (err)
+		return err;
+	for (i = 0; i < *nr_bhs; i++)
+		brelse(bhs[i]);
+	*nr_bhs = 0;
+
+	return 0;
+}
+
 int fat_alloc_clusters(struct inode *inode, int *cluster, int nr_cluster)
 {
 	struct super_block *sb = inode->i_sb;
@@ -477,8 +497,6 @@ int fat_alloc_clusters(struct inode *inode, int *cluster, int nr_cluster)
 	struct buffer_head *bhs[MAX_BUF_PER_PAGE];
 	int i, count, err, nr_bhs, idx_clus;
 
-	BUG_ON(nr_cluster > (MAX_BUF_PER_PAGE / 2));	/* fixed limit */
-
 	lock_fat(sbi);
 	if (sbi->free_clusters != -1 && sbi->free_clus_valid &&
 	    sbi->free_clusters < nr_cluster) {
@@ -509,14 +527,21 @@ int fat_alloc_clusters(struct inode *inode, int *cluster, int nr_cluster)
 				if (prev_ent.nr_bhs)
 					ops->ent_put(&prev_ent, entry);
 
-				fat_collect_bhs(bhs, &nr_bhs, &fatent);
-
 				sbi->prev_free = entry;
 				if (sbi->free_clusters != -1)
 					sbi->free_clusters--;
 
 				cluster[idx_clus] = entry;
 				idx_clus++;
+
+				if (nr_bhs + fatent.nr_bhs > MAX_BUF_PER_PAGE) {
+					err = fat_flush_bhs(sb, bhs, &nr_bhs,
+							    inode_needs_sync(inode));
+					if (err)
+						goto out;
+				}
+				fat_collect_bhs(bhs, &nr_bhs, &fatent);
+
 				if (idx_clus == nr_cluster)
 					goto out;
 
@@ -606,17 +631,10 @@ int fat_free_clusters(struct inode *inode, int cluster)
 		}
 
 		if (nr_bhs + fatent.nr_bhs > MAX_BUF_PER_PAGE) {
-			if (sb->s_flags & SB_SYNCHRONOUS) {
-				err = fat_sync_bhs(bhs, nr_bhs);
-				if (err)
-					goto error;
-			}
-			err = fat_mirror_bhs(sb, bhs, nr_bhs);
+			err = fat_flush_bhs(sb, bhs, &nr_bhs,
+					    sb->s_flags & SB_SYNCHRONOUS);
 			if (err)
 				goto error;
-			for (i = 0; i < nr_bhs; i++)
-				brelse(bhs[i]);
-			nr_bhs = 0;
 		}
 		fat_collect_bhs(bhs, &nr_bhs, &fatent);
 	} while (cluster != FAT_ENT_EOF);
-- 
2.43.0

