Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 775D33D4114;
	Tue, 31 Mar 2026 09:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774948348; cv=none; b=Zd+8n5A3VJv9eIuKCqn7nwYHuwQ4OD0rlwWihyFtrUYilnWpxjFjJwLu04Vez1CQYcuSZjP6kTSrCvY+EyEAF+vcM0wIeZ49LaCMIXlINCax9thylkXEB69kQbXMKSKfynzNcRjRKuU7LfRQzHQOh7Vk/2DhFqYu71cJP31jycE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774948348; c=relaxed/simple;
	bh=QKKo27ZmgmLu5jnNNTZnZdUMEXscxJeDRMykZoctq/c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hmkdFKCoxdCzRvuDllT+/G+UxaCRaN6JW9ht+VN44KQjv9ayZDnbljVN/k7j0x4JKJaTsFy5rD0CTzmMVBMr5wYR0aKhy5gw4dFt8wmnvvj0tP8Z9OcNefiuw4ZLc9KCJX7rgtZP2dWKR8xWbCLYMTSVmtGNPyPkIZWeWvQ2ToE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=BQPIOPkO; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="BQPIOPkO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=FP
	+Ida2roPJagNqHaJVzBkQt9/HGb12AMTnzKtErRe0=; b=BQPIOPkOGDgul6YY9k
	EGvziHdRQ9x7CNPNGVWoHUb7X/zw1PmREyfVAQVqNh2OvenThmjBYiB4Qzz4eWXA
	VJsxCksL9ED4Sv7+SNXi5gS4Q0dzQ7qg7uz9YjU1Lk7pLqvymPjAhIt3jdP9b01B
	Ct/8Ap82nh2rHBEk8mrkv3uC4=
Received: from czl-ubuntu-pc.. (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wDXetTUj8tpdt0MCg--.18595S7;
	Tue, 31 Mar 2026 17:11:56 +0800 (CST)
From: Chi Zhiling <chizhiling@163.com>
To: Namjae Jeon <linkinjeon@kernel.org>,
	Sungjong Seo <sj1557.seo@samsung.com>,
	Yuezhang Mo <yuezhang.mo@sony.com>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chi Zhiling <chizhiling@kylinos.cn>
Subject: [PATCH v1 5/6] exfat: introduce exfat_chain_advance helper
Date: Tue, 31 Mar 2026 17:11:12 +0800
Message-ID: <20260331091113.20882-6-chizhiling@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260331091113.20882-1-chizhiling@163.com>
References: <20260331091113.20882-1-chizhiling@163.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDXetTUj8tpdt0MCg--.18595S7
X-Coremail-Antispam: 1Uf129KBjvJXoW7WryxXw1Duw17JryxtrW5KFg_yoW8XF47pF
	47Gw45J3ykXayfu3WfJw4rXa4Y9rs2gFW8JrWxAw1Yyrn0qrn5uFyrK347tFyrJ348K3W2
	vwn0gr1YgrsxGF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07URVb9UUUUU=
X-CM-SenderInfo: hfkl6xxlol0wi6rwjhhfrp/xtbC9xxoBmnLj9zKaAAA3W

From: Chi Zhiling <chizhiling@kylinos.cn>

Introduce exfat_chain_advance() to walk a exfat_chain structure by a
given step, updating both ->dir and ->size fields atomically. This
helper handles both ALLOC_NO_FAT_CHAIN and ALLOC_FAT_CHAIN modes with
proper boundary checking.

Signed-off-by: Chi Zhiling <chizhiling@kylinos.cn>
---
 fs/exfat/exfat_fs.h | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/fs/exfat/exfat_fs.h b/fs/exfat/exfat_fs.h
index 530459ab9acc..d7f88a326cf0 100644
--- a/fs/exfat/exfat_fs.h
+++ b/fs/exfat/exfat_fs.h
@@ -552,6 +552,32 @@ int exfat_read_volume_label(struct super_block *sb,
 int exfat_write_volume_label(struct super_block *sb,
 			     struct exfat_uni_name *label);
 
+static inline int exfat_chain_advance(struct super_block *sb,
+		struct exfat_chain *chain, unsigned int step)
+{
+	if (chain->flags == ALLOC_NO_FAT_CHAIN) {
+		if (chain->size > step) {
+			chain->dir += step;
+			chain->size -= step;
+		} else if (chain->size == step) {
+			chain->dir = EXFAT_EOF_CLUSTER;
+			chain->size = 0;
+		} else {
+			return -EIO;
+		}
+	} else {
+		if (exfat_fat_walk(sb, &chain->dir, step, ALLOC_FAT_CHAIN))
+			return -EIO;
+		if (chain->size > step) {
+			chain->size -= step;
+		} else {
+			chain->size = 0;
+			WARN_ON_ONCE(chain->dir != EXFAT_EOF_CLUSTER);
+		}
+	}
+	return 0;
+}
+
 /* inode.c */
 extern const struct inode_operations exfat_file_inode_operations;
 void exfat_sync_inode(struct inode *inode);
-- 
2.43.0

