Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B4B62C21FD;
	Wed, 13 May 2026 11:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778671342; cv=none; b=MJrX9h5NFq3IaAD0IZP86VMonHCn+sUdsANUc7bityDaOxPTZOFrZVqHzUv80iQibTva5JObsOFmkg3u++8O1fxIla9N/+sUjRODOEqB9o33ne6fnnwDgfekUSITIxZNrsWv8lncY0/5fp+350BESmWD5UGv7FirLceQMxcMSfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778671342; c=relaxed/simple;
	bh=ZSAbrFmW3LCkx122pNqtv4L5RxOn49pWRO7AYEhhoTc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=D54Y6h31Om4888w8lbM3uB10NVN/53stJhDUYYa4Np3LMm5eigstJkqkynkbojKj0rT7fnKFhNzZpPd9ZViqjLNwd9ZAcC56th5eRJla80Gp1jj8qohSfRestNw8gexrJVcxe52VbWtMKGv2hAWCLvJA0PL7iVJdaAnW3kdJeDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r4tztykk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r4tztykk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04338C2BCFB;
	Wed, 13 May 2026 11:22:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778671339;
	bh=ZSAbrFmW3LCkx122pNqtv4L5RxOn49pWRO7AYEhhoTc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=r4tztykkAOJoMj5MVPbGjiiJL4h8ozh9IRrUwIBiZyWUQFgZCd24IP8ci/0cbvGGW
	 vehIsy7DyhpFxJYHTsi+DJg/3dIJl+94B3HcH4JZuiHhDAxosIEU0TMad5j5qZ2bHE
	 whgoSCfOluw0xBZ6GScvqFpVu1gpaRFFdzcz8yWNt23gINIeRFr3MV0ROZckKgzyx3
	 MVpLn/c+p5SRzvA5CkKTaPPPljX66EMXYo0PsYEPrBrI31k+Qk+l1L8d6wEIPE2+KF
	 kZjtsnfKFV3abLxRTV5D6H6lgG0ZQ9BjrKmTNs081YLM4eYE59Mmv95/Z26jU0y9A6
	 g95Edw0qprs2g==
From: Namjae Jeon <linkinjeon@kernel.org>
To: sj1557.seo@samsung.com,
	yuezhang.mo@sony.com,
	brauner@kernel.org,
	djwong@kernel.org,
	hch@lst.de
Cc: linux-fsdevel@vger.kernel.org,
	anmuxixixi@gmail.com,
	dxdt@dev.snart.me,
	chizhiling@kylinos.cn,
	chizhiling@163.com,
	linux-kernel@vger.kernel.org,
	Namjae Jeon <linkinjeon@kernel.org>
Subject: [PATCH v3 04/11] exfat: add exfat_file_open()
Date: Wed, 13 May 2026 20:21:49 +0900
Message-Id: <20260513112156.9122-5-linkinjeon@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260513112156.9122-1-linkinjeon@kernel.org>
References: <20260513112156.9122-1-linkinjeon@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add exfat_file_open() to handle file open operation for exFAT.
This change is a preparation step before introducing iomap-based direct
IO support.

Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
---
 fs/exfat/file.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/fs/exfat/file.c b/fs/exfat/file.c
index 29a36a80e29b..d0ecdcb4bf7a 100644
--- a/fs/exfat/file.c
+++ b/fs/exfat/file.c
@@ -800,7 +800,16 @@ static ssize_t exfat_splice_read(struct file *in, loff_t *ppos,
 	return filemap_splice_read(in, ppos, pipe, len, flags);
 }
 
+static int exfat_file_open(struct inode *inode, struct file *filp)
+{
+	if (unlikely(exfat_forced_shutdown(inode->i_sb)))
+		return -EIO;
+
+	return generic_file_open(inode, filp);
+}
+
 const struct file_operations exfat_file_operations = {
+	.open		= exfat_file_open,
 	.llseek		= generic_file_llseek,
 	.read_iter	= exfat_file_read_iter,
 	.write_iter	= exfat_file_write_iter,
-- 
2.25.1

