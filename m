Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3094D32D0CF;
	Fri,  3 Apr 2026 08:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775203631; cv=none; b=kD6FlpxuUHSY76b2Jkn2643Ul+sgpHjJw9XJ+ogBaN6SEQyaDcYxTL450/sZ6oN7NWAdC1s1ayrRICre2ILI1oYwGCseelmhU6/NaDV58LOtJcA833Mgmy6ibVWwXFzcBbyI4zzqFDxsvtMwc9sttC3SxE1mZICMGk8IVP13IQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775203631; c=relaxed/simple;
	bh=tkbRZQimK5gE+e9gmKDANAnzEdWXdVJmz4K7IwG1n0Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k+3beQ1/N3ICJIELZx1NRf2FI2wZqQ1RauNWjAyggk2I4paH5I0H/Dz2YtesvTC0esTiw6NiShYAypiSSgzB/xCSyBWtwYBf0lRoKNPuLUXDIrE6BOy+rWVrUUKvhVO4OCnHAawtaIx9Ve0lOEq4dkjLNRIkieGhfPFxWLAuM+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=cLfft+xv; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="cLfft+xv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=Xy
	fsN/JWMj7HEIjC10PHq0KzFD0yep39q536Og73j8g=; b=cLfft+xvQc8MURzIpR
	P3nV0i94pP/3O+DgwlaLT1WhqiT3RSCAcW3uouRmgJxUoRHaNWRPUxIyflcdUE/H
	eTxZAHfbWdWHjmmppvqLNhUmX2hbkAvU5t44fSay1xcgKyU7+xRQq/lKzxId8CdQ
	+aowyFepWd2DY9/nk72jaj+6A=
Received: from czl-ubuntu-pc.. (unknown [])
	by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id _____wDHW13+dM9pkhS7Cw--.58982S7;
	Fri, 03 Apr 2026 16:06:27 +0800 (CST)
From: Chi Zhiling <chizhiling@163.com>
To: Namjae Jeon <linkinjeon@kernel.org>,
	Sungjong Seo <sj1557.seo@samsung.com>,
	Yuezhang Mo <yuezhang.mo@sony.com>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chi Zhiling <chizhiling@kylinos.cn>,
	syzbot@syzkaller.appspotmail.com,
	Yuezhang Mo <Yuezhang.Mo@sony.com>
Subject: [PATCH v3 5/6] exfat: introduce exfat_chain_advance helper
Date: Fri,  3 Apr 2026 16:05:37 +0800
Message-ID: <20260403080538.361663-6-chizhiling@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260403080538.361663-1-chizhiling@163.com>
References: <20260403080538.361663-1-chizhiling@163.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDHW13+dM9pkhS7Cw--.58982S7
X-Coremail-Antispam: 1Uf129KBjvJXoW7WryxXw18uF4xGFW3GFy8Xwb_yoW8Xr4DpF
	47Ga15J3yjqa4xu3WfJr43Xa4Y9wn7GFWkJrWxZw1Yyrn0qryvkF93Kry29Fyrt3y0k3W2
	v3WYgr1j9wsxGFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UKXd8UUUUU=
X-CM-SenderInfo: hfkl6xxlol0wi6rwjhhfrp/xtbC9wOrSWnPdQOwQgAA30

From: Chi Zhiling <chizhiling@kylinos.cn>

Introduce exfat_chain_advance() to walk a exfat_chain structure by a
given step, updating both ->dir and ->size fields atomically. This
helper handles both ALLOC_NO_FAT_CHAIN and ALLOC_FAT_CHAIN modes with
proper boundary checking.

Tested-by: syzbot@syzkaller.appspotmail.com
Suggested-by: Yuezhang Mo <Yuezhang.Mo@sony.com>
Signed-off-by: Chi Zhiling <chizhiling@kylinos.cn>
---
 fs/exfat/exfat_fs.h | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/fs/exfat/exfat_fs.h b/fs/exfat/exfat_fs.h
index 7f9d0cfa252b..89ef5368277f 100644
--- a/fs/exfat/exfat_fs.h
+++ b/fs/exfat/exfat_fs.h
@@ -552,6 +552,27 @@ int exfat_read_volume_label(struct super_block *sb,
 int exfat_write_volume_label(struct super_block *sb,
 			     struct exfat_uni_name *label);
 
+static inline int exfat_chain_advance(struct super_block *sb,
+		struct exfat_chain *chain, unsigned int step)
+{
+	unsigned int clu = chain->dir;
+
+	if (unlikely(chain->size < step))
+		return -EIO;
+
+	if (exfat_cluster_walk(sb, &clu, step, chain->flags))
+		return -EIO;
+
+	chain->size -= step;
+
+	if (chain->size == 0 && chain->flags == ALLOC_NO_FAT_CHAIN)
+		chain->dir = EXFAT_EOF_CLUSTER;
+	else
+		chain->dir = clu;
+
+	return 0;
+}
+
 /* inode.c */
 extern const struct inode_operations exfat_file_inode_operations;
 void exfat_sync_inode(struct inode *inode);
-- 
2.43.0

