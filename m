Received: from embla.dev.snart.me (embla.dev.snart.me [54.252.183.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D810D391E7C
	for <linux-fsdevel@vger.kernel.org>; Tue, 28 Apr 2026 23:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.252.183.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777420576; cv=none; b=k9iE1/LwfA5171oPmPeZDyT5ZMJjCRwlkZCBxF5K/1Y9TuQuprE10yoMhj9S8Gcj52TY6RXtOYh/mTtSCGRYwfwQybU2t+kae5pOEi5TyNoVyl5YBvvnNFBly7oiG8GkIg6WbnUnMeSPnH7EIgfu6imMBuNC7F6c3IsteHzISoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777420576; c=relaxed/simple;
	bh=LFol2IVp515CJ84UHcILYiKS1Y/wQmM1gs0nUT63S34=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ifpCKG6AdWWFthmie7GSzLPBK3/3zt3orQapgXbp0WG4TxCX0xJAEh5VSEmuoTlLA7i88qA+Ro+PmQ0EMal/GFkFMnKZfVXbEifryY3UCJRtk4HPfKerNQM6p41lkXOCovhtej0WtY3PJ8EIOkuXk/u+L07igLZO6mE4YifPB7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dev.snart.me; spf=pass smtp.mailfrom=dev.snart.me; arc=none smtp.client-ip=54.252.183.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dev.snart.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dev.snart.me
Received: from embla.dev.snart.me (localhost [IPv6:::1])
	by embla.dev.snart.me (Postfix) with ESMTP id B5B771CBDF;
	Tue, 28 Apr 2026 23:51:04 +0000 (UTC)
Received: from maya.d.snart.me ([182.226.25.243])
	by embla.dev.snart.me with ESMTPSA
	id i9TZBuRH8WmjWgUA8KYfjw:T4
	(envelope-from <dxdt@dev.snart.me>); Tue, 28 Apr 2026 23:51:04 +0000
From: David Timber <dxdt@dev.snart.me>
To: Namjae Jeon <linkinjeon@kernel.org>,
	Sungjong Seo <sj1557.seo@samsung.com>,
	Yuezhang Mo <yuezhang.mo@sony.com>
Cc: linux-fsdevel@vger.kernel.org,
	David Timber <dxdt@dev.snart.me>
Subject: [PATCH v1 3/4] exfat: add default_upcase option (read-only)
Date: Wed, 29 Apr 2026 08:50:36 +0900
Message-ID: <20260428235038.93816-4-dxdt@dev.snart.me>
X-Mailer: git-send-email 2.53.0.1.ga224b40d3f.dirty
In-Reply-To: <20260428235038.93816-1-dxdt@dev.snart.me>
References: <20260428235038.93816-1-dxdt@dev.snart.me>
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
index 200d93bd5abd..7da6fcf8b41d 100644
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

