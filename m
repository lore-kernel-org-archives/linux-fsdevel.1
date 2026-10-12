Received: from smtp.inf.ufrgs.br (smtp.inf.ufrgs.br [143.54.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8739B4BC029;
	Mon, 12 Oct 2026 17:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=143.54.11.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791825107; cv=none; b=QErULwy8Lr3bbvB2gXFM9J9iNGjfel+nI5XIc9s5m4ptjdDDM3M4khnix3ygz9NPN3plVrWOVXslg5k9kocYIFKt3fnGY2Dvmf4eOZbDhQVwDTAzIsoAeYECfrYfF6xyNpFr30Fg2kAl4ewRSJ1L22NhFfPL2KSprWHnXzT+2ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791825107; c=relaxed/simple;
	bh=jnR2pEkOYYyZdO+L/BlRNyIeUa+dsDZlxXhd4vuRevA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=APuxwVjSpE6iF0mzowbN488F+diMfZ7cAK4jCtTxRbSA4c/KLw5y2lBKwK7w4B/FVDIUTB9pRnmCocpYMfpLXfiUQyHKUnu/iDY0QjvEcuMR/VY5W8NHblhCRGH6+Hy4t+caGAdoSTCFQbeYY7dTZ0Z5jk0fw+fVfCNn0xfoXuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inf.ufrgs.br; spf=pass smtp.mailfrom=inf.ufrgs.br; dkim=pass (2048-bit key) header.d=inf.ufrgs.br header.i=@inf.ufrgs.br header.b=3/WFlihY; arc=none smtp.client-ip=143.54.11.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inf.ufrgs.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inf.ufrgs.br
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=inf.ufrgs.br header.i=@inf.ufrgs.br header.b="3/WFlihY"
Received: from LAPTOP-R01LEAQM.localdomain (unknown [189.6.233.4])
	by smtp.inf.ufrgs.br (Postfix) with ESMTPSA id 3C137121124;
	Mon, 12 Oct 2026 14:11:18 -0300 (-03)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=inf.ufrgs.br;
	s=dkim2026; t=1791825078;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l1aFztTi4Ls5s4M+ONyD33t/zWSdTU5MhJ9CIOsKwN0=;
	b=3/WFlihYwj0fDXzANjTOkjdhXr/w0fgXg2yr59zmI76a9lgcfQs3eLJFg2qlZHYWNdPJ7I
	5ANhgp3mGXHJU2pP4XieKYOaBIbFRpZnacu/J8D1rKnlaeTWp/w0jQGiByVDmJ22UEwJAu
	U/gUjAh3QnNaf9Db9P6jz/tf68N0S9tpUL3NDa4kL9fPL3bMyYzg6M/2cqPWXigYwEs3o/
	x1rzfX/ePYbq/9DviWQSC3j9q+1sLFNz2ZJO4nlndkfr53sofeZKj0gpLXUYehSm/UnQMM
	iGdyOWbDi0hMW/COnfLsIvGjxuXYssxAbDnAWCo09Eupj3AK8xnidmPeX1xlzA==
From: Matheus Alves de Almeida <matheus.aalmeida@inf.ufrgs.br>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Matheus Alves de Almeida <matheus.aalmeida@inf.ufrgs.br>
Subject: [PATCH v2 3/3] fat: allocate multiple clusters in fallocate
Date: Mon, 12 Oct 2026 14:11:06 -0300
Message-ID: <20261012171106.146243-4-matheus.aalmeida@inf.ufrgs.br>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261012171106.146243-1-matheus.aalmeida@inf.ufrgs.br>
References: <20261012171106.146243-1-matheus.aalmeida@inf.ufrgs.br>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The fat_fallocate() code currently does many 1-cluster allocations when
growing a file in the FALLOC_FL_KEEP_SIZE path. Make it allocate
everything with one call instead.

Benchmarking was done under QEMU/KVM with a virtio-blk device using
cache=none. Each result is the arithmetic mean of the listed samples.

start = now_ns();
for (unsigned int i = 0; i < count; i++)
     fallocate(fds[i], FALLOC_FL_KEEP_SIZE, 0, bytes);
elapsed = now_ns() - start;

FAT32 with 512-byte clusters using count=16 files:
length    mounted sync?    before    after    improvement    samples
256MiB    no               2.328s    0.175s   13.2x          10
16MiB     no               149.659ms 14.036ms 10.7x          10
16MiB     yes              747.993s  3.445s   217.1x         3
1MiB      yes              46.63s    0.333s   140.1x         10

FAT32 with 512-byte clusters using count=128 files:
length    mounted sync?    before    after    improvement    samples
1MiB      no               90.873ms  4.686ms  19.4x          10
16KiB     no               1.287ms   0.241ms  5.3x           10
128KiB    yes              47.284s   0.350s   135x           10
4KiB      yes              1.98s     0.144s   13.7x          10

FAT32 with 4096-byte clusters using count=16 files:
length    mounted sync?    before    after    improvement    samples
256MiB    no               295.392ms 24.733ms 11.9x          10
16MiB     no               20.509ms  1.404ms  14.6x          10
16MiB     yes              92.489s   0.348s   265.4x         10
1MiB      yes              5.837s    0.048s   121.3x         10

The improvement is especially large on synchronous mounts, where the
new code can batch FAT updates instead of synchronously handling each
cluster allocation separately.

Signed-off-by: Matheus Alves de Almeida <matheus.aalmeida@inf.ufrgs.br>
---
 fs/fat/file.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/fs/fat/file.c b/fs/fat/file.c
index 41d49e9de..3aa541c6b 100644
--- a/fs/fat/file.c
+++ b/fs/fat/file.c
@@ -290,12 +290,10 @@ static long fat_fallocate(struct file *file, int mode,
 		nr_cluster = (mm_bytes + (sbi->cluster_size - 1)) >>
 			sbi->cluster_bits;
 
-		/* Start the allocation.We are not zeroing out the clusters */
-		while (nr_cluster-- > 0) {
-			err = fat_add_clusters(inode, 1);
-			if (err)
-				goto error;
-		}
+		/* Allocate the clusters. We are not zeroing them out */
+		err = fat_add_clusters(inode, nr_cluster);
+		if (err)
+			goto error;
 	} else {
 		if ((offset + len) <= i_size_read(inode))
 			goto error;
-- 
2.43.0

