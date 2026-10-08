Received: from smtp.inf.ufrgs.br (smtp.inf.ufrgs.br [143.54.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B6DC1F936;
	Thu,  8 Oct 2026 02:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=143.54.11.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791425458; cv=none; b=NKavNbsmnhYDMcsbf97JLv2ZOIy8ybHFqqsvOOzdd7rNtqGYSFmfTJBtJo3WROQyOhHZN5Q3D+o276b7/ECRtTWBIlmhbxlTnktLGdKF5kNNz/BUpSOpsQIDqQ4K098mBNIk7LKch0OBBkSRsZUloRPvofPO1VUyRzEXZn4UkeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791425458; c=relaxed/simple;
	bh=GisOiVM913hdtt5t0O6qnCjRGOxooesUUUHvdXWQflU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QTNcfAlOjq68z+EH5YM59FCIoZ0y5Rkq9igi/fccEgRZmfYpEG7tjC+QO+m55+xDcwL6xYVn7rIhLFj5NfWS4GO78cVxsn+ckRqFO/cZDuRNkKQltxz2DqlSoIqsrrF3Xw82pv7jJvGMQCIb3VKjOeG9uTWI6OCfy3gT2x2iYQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inf.ufrgs.br; spf=pass smtp.mailfrom=inf.ufrgs.br; dkim=pass (2048-bit key) header.d=inf.ufrgs.br header.i=@inf.ufrgs.br header.b=mvvlPBF6; arc=none smtp.client-ip=143.54.11.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inf.ufrgs.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inf.ufrgs.br
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=inf.ufrgs.br header.i=@inf.ufrgs.br header.b="mvvlPBF6"
Received: from LAPTOP-R01LEAQM.localdomain (unknown [189.6.233.4])
	by smtp.inf.ufrgs.br (Postfix) with ESMTPSA id D89DB1210F7;
	Wed,  7 Oct 2026 23:10:19 -0300 (-03)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=inf.ufrgs.br;
	s=dkim2026; t=1791425419;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=StPuRAIfNgtKsSHBJIAlEfI4HPQSmCDPmCPoieh6dB0=;
	b=mvvlPBF6TMp8A7snIEVm3v1q6ZVPO/VXimhSUabIQBdKWSlSOXzmFiL4lUu0n/ZYiApwdL
	EsfYxxO4dIsVZG/GEKos6bHxjNs29JP0jESAZJFXqHt4imJZHrwU4HaQBRyMKYGfmviN+F
	GplvvLJtN8+UwnGggD54i0c/mVkYfzhGwnS8c8CZ6hZ0cVqa97fG4YV3knJVqt5WFdYA88
	9yif0iZY6l5XaJ9gcOMpwzTWW9JI1nyA+U/1IXED/E61mNhUhLqvso9ilvubGOqhaTZSfv
	veo/L+yHXq4jWwEeG/0s43jpjvre2ZlaBjmYu82FRdp8uI3yfCTMzAcQgbPvSw==
From: Matheus Alves de Almeida <matheus.aalmeida@inf.ufrgs.br>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Matheus Alves de Almeida <matheus.aalmeida@inf.ufrgs.br>
Subject: [PATCH 4/4] fat: allocate multiple clusters in fallocate
Date: Wed,  7 Oct 2026 23:09:40 -0300
Message-ID: <20261008020941.55784-5-matheus.aalmeida@inf.ufrgs.br>
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

The fat_fallocate() code currently does many 1-cluster allocations when
growing a file. Make it allocate everything with one call instead.

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

