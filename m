Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2BD43F39C7;
	Mon, 18 May 2026 11:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779104929; cv=none; b=qkOLH0jTUTWnqjJfjndT521G7hJ2bY8M8K6Y2wVQZXGQYJ1Giv1CBOlRxpYCDOvaCZg7CpJ60HiSPFVuYksd8ej36Mtm1hQPPh7P6/pfWH1VZz691Mdud+DU3ynv6s0Z1AGfCRT1sGEkv73au0GRbPS66dnsv0HufpFtnLaNI3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779104929; c=relaxed/simple;
	bh=t4+ZhTxjSol8437hYmjv+2tCSfNJXDixTSxLSc+KpA8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=q1quw/oVXSEPjdmT0RWBkbgTULkvEbK0VIdlqBAFeSQpM9TIJrX42c4iqxzCopvpmTy29JaNdMlFK6L27lMrPIsknO+jMywgIpcDvumSB5ZVzindE97wOfEV/BJKQUX7khDbEtN+r2l4kby+VbbqG2iyR5WxNAf3dcLpRQ82z2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rf6MH5uD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rf6MH5uD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35387C2BCB7;
	Mon, 18 May 2026 11:48:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779104929;
	bh=t4+ZhTxjSol8437hYmjv+2tCSfNJXDixTSxLSc+KpA8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rf6MH5uDZZlQTWjsvtDnUyAuW5zdVyZ8Shut9rveIQVMtHaKW9+uccKncSJ3yJDY7
	 giosaVwPcN43QTefdVuyb4ZdUB66CPlHzOerheRr0IrUArp6D/8K7wHfL0fXS+5jzG
	 BZBMc2dBebrlGrUhY88y3bDzZWsKPuXjQ34CZdJ3u3PbcYb1hmouAj+sjdbf1Qa+EF
	 cqQNX/SrznkjjxclwQNb0LxKmT45MEYfDjjERiaxyRnB9IYqGIMiXvyhhxaQS7ie4j
	 FngODPX8CCYzccr74l4Tbkn4kMNf/ySKywncpM97mQJpwDN/bxq3jvVWQVPNxFF3gn
	 xhIidnUP8wqSg==
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
	charsyam@gmail.com,
	Namjae Jeon <linkinjeon@kernel.org>
Subject: [PATCH v4 04/11] exfat: add exfat_file_open()
Date: Mon, 18 May 2026 20:46:58 +0900
Message-Id: <20260518114705.9601-5-linkinjeon@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260518114705.9601-1-linkinjeon@kernel.org>
References: <20260518114705.9601-1-linkinjeon@kernel.org>
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

Acked-by: Christoph Hellwig <hch@lst.de>
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

