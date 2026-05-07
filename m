Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D979B3F166D;
	Thu,  7 May 2026 12:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778157888; cv=none; b=TLdPI3Icn97UcXMkgLcebPekcEXIH5SPPhst2DalHwYqkZmf3b8wxFYommuvRJ/APCJpzPSnBuHBC+qlTHrhpwgZOpka0ieFBsuWkBs0nfV0IR0Lxo8TEo0n7OqvZa4XV8YBwehevc1uCXJrwNyg7DQVe0+ScZ+evdo4kexP7KE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778157888; c=relaxed/simple;
	bh=dVYEwiT/vQkj9bceBjC7oEzVsWkx7VDYr7J0MQQAjXw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BNtTV8qdXjmUvFrt4mAUQkPz9axK2AxxY1wjtvCPUcMBoI0Ph/R2kw30II9TRJzXq6HesFWyZS4vkXScNknxkKx1a8Upm97G/76FKoCNjmo58sC8sw7EthvmFA7vZS0t8vJakWe3kp8r+ZlBg0gErHpV25ohCJspN07zMo/tJjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HIuqQJth; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HIuqQJth"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 557C8C2BCB2;
	Thu,  7 May 2026 12:44:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778157887;
	bh=dVYEwiT/vQkj9bceBjC7oEzVsWkx7VDYr7J0MQQAjXw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HIuqQJthR4++uR/BPrpjfDxwXJFbVB1LJEApdW6C5g9BcByrwpdSUNPUop765VlDJ
	 Wlgfq6iSBtkrLxE3VWBcLowUkcRhu1AyK9ZDihytnsGET5junrctSqbGWlY2rKqfPs
	 IEo2m0Ffkg69r7+hoGPFum6RXMmKQyLhAhn3WP+V0gm7DtphjNu5jOlHWfRpcmalEc
	 Chtx4mzXJvL4SY2dwi9Vd9FbS2DZ8ytDjcZEpzhtFmkx+1nRZvJmhrEwmGZd2Fs6M3
	 ImyRIi+99Z3lXW1VSo06w5/NXA8I7JuzcLx3T507x542HYs8gqc4c1xQaMN8ZSx+cf
	 Q07Wxwcinlspw==
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
	linux-kernel@vger.kernel.org,
	Namjae Jeon <linkinjeon@kernel.org>
Subject: [PATCH v2 3/9] exfat: add exfat_file_open()
Date: Thu,  7 May 2026 21:42:32 +0900
Message-Id: <20260507124238.7313-4-linkinjeon@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260507124238.7313-1-linkinjeon@kernel.org>
References: <20260507124238.7313-1-linkinjeon@kernel.org>
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
 fs/exfat/file.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/fs/exfat/file.c b/fs/exfat/file.c
index 29a36a80e29b..b7a4964631a0 100644
--- a/fs/exfat/file.c
+++ b/fs/exfat/file.c
@@ -800,7 +800,22 @@ static ssize_t exfat_splice_read(struct file *in, loff_t *ppos,
 	return filemap_splice_read(in, ppos, pipe, len, flags);
 }
 
+static int exfat_file_open(struct inode *inode, struct file *filp)
+{
+	int err;
+
+	if (unlikely(exfat_forced_shutdown(inode->i_sb)))
+		return -EIO;
+
+	err = generic_file_open(inode, filp);
+	if (err)
+		return err;
+
+	return 0;
+}
+
 const struct file_operations exfat_file_operations = {
+	.open		= exfat_file_open,
 	.llseek		= generic_file_llseek,
 	.read_iter	= exfat_file_read_iter,
 	.write_iter	= exfat_file_write_iter,
-- 
2.25.1

