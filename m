Received: from embla.dev.snart.me (embla.dev.snart.me [54.252.183.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F4383A785E
	for <linux-fsdevel@vger.kernel.org>; Tue,  5 May 2026 12:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.252.183.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777984335; cv=none; b=R7tuT9qNsMbpKrdw7SZyfEeFIisaAHrzAke6E8fNooV6hGIcv8zIX6Sse3LCVwtY+tu1uoGf1zAAmnnX8Uf0DV0cbrNPRTvTREzbV0WfhRIy6lyXq1aCArFpWFjtTuJ4Fk4WRpjXl1epdOKp5p2Rz1aSVoLfkp4qnzjx01hK+8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777984335; c=relaxed/simple;
	bh=MSjehNNSzqH4rdqAlj/j19CqvBrFaEIlM3qvq16Q4Ak=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iFVzyjpzaSqnbdfn4v275ZHglgdobfB3hKSLSK79NSN1qh57l0TdIviS9QgopN/2TBRm/EMF7K8vE336oYVkDQ7jy9rWbjB/mF+HDRkMEULBQrluJFbZjceVM6Y6r5Rq9lgj3WKBWUJse909YUH+BnyHXhghsZpoUVbxXmVEs1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dev.snart.me; spf=pass smtp.mailfrom=dev.snart.me; arc=none smtp.client-ip=54.252.183.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dev.snart.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dev.snart.me
Received: from embla.dev.snart.me (localhost [IPv6:::1])
	by embla.dev.snart.me (Postfix) with ESMTP id F35D71CBDF;
	Tue,  5 May 2026 12:32:11 +0000 (UTC)
Received: from maya.d.snart.me ([182.226.25.243])
	by embla.dev.snart.me with ESMTPSA
	id na7IHUfj+WmAZAEA8KYfjw:T4
	(envelope-from <dxdt@dev.snart.me>); Tue, 05 May 2026 12:32:11 +0000
From: David Timber <dxdt@dev.snart.me>
To: Namjae Jeon <linkinjeon@kernel.org>,
	Sungjong Seo <sj1557.seo@samsung.com>,
	Yuezhang Mo <yuezhang.mo@sony.com>
Cc: linux-fsdevel@vger.kernel.org,
	David Timber <dxdt@dev.snart.me>
Subject: [PATCH v2 3/4] exfat: add default_upcase option (read-only)
Date: Tue,  5 May 2026 21:31:43 +0900
Message-ID: <20260505123144.730782-4-dxdt@dev.snart.me>
X-Mailer: git-send-email 2.53.0.1.ga224b40d3f.dirty
In-Reply-To: <20260505123144.730782-1-dxdt@dev.snart.me>
References: <20260505123144.730782-1-dxdt@dev.snart.me>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Show "default_upcase" in the mount options if the default upcase table
is being used for the volume for diagnostic purposes.

Signed-off-by: David Timber <dxdt@dev.snart.me>
---
 fs/exfat/super.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/exfat/super.c b/fs/exfat/super.c
index 3197263aa1be..c2668524c06a 100644
--- a/fs/exfat/super.c
+++ b/fs/exfat/super.c
@@ -149,6 +149,9 @@ static int exfat_show_options(struct seq_file *m, struct dentry *root)
 		seq_printf(m, ",time_offset=%d", opts->time_offset);
 	if (opts->zero_size_dir)
 		seq_puts(m, ",zero_size_dir");
+	if (sbi->vol_utbl_own == NULL)
+		seq_puts(m, ",default_upcase");
+
 	return 0;
 }
 
-- 
2.53.0.1.ga224b40d3f.dirty

