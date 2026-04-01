Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 812DE366DA5;
	Wed,  1 Apr 2026 07:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775027573; cv=none; b=EMIjB1LSWSeEL1zgaj1WrtLmORQGXtHcYHF91GVMxZf9OHaGM7vgv6mYLoVo5QS4TeSs/BWzkvYfAWKP9YWTlW09AbRFfjyroAwm5zRi5o780qHVkIbn/tHQcpHyRkA3sNU2dRLmqKhyjU88nkQafnudinzTMR6MO90lS9DZgA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775027573; c=relaxed/simple;
	bh=yhxzjwKwSBaUZ4FGxUPes9C3AlHWL6XJeneeeIBMtkM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bvEWPmMp6nFYhHy00IvZIdipm8xhKDoZKnnxSuHAtaZpD/arrL+NS8VIP385XHSkmwUr/JavlTrK2U5huVCoaPVoSvEk19GWpXIId+wHJ1+f2ghwtuslonbJS9JbphvD0OVEIVRbvv9ltC1C4WnFF2Psfpu4e5Bcb39yyXOMjxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=g2XLFOOQ; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="g2XLFOOQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=KD
	I8bPw2++XDAb25MPconhLJtAP5fqOp0wl4eaVRJMA=; b=g2XLFOOQ/GWAKgzKw1
	DVXSgk1+GO+w6iRThg7TQnQpnIWssVyE7fkYO/IY7ldZzlf+DgTksZpM9TOxa9dI
	va2LbGExgQu3NXbFtB31Rnh8lSxLGX9KJtbI2sZgdNRS/v4PfKg43PdrY5br0J8V
	l25aWfFN4e6Kw9/k2ddx2odhM=
Received: from czl-ubuntu-pc.. (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wD3v9ZFxcxpADvDCg--.24371S7;
	Wed, 01 Apr 2026 15:12:09 +0800 (CST)
From: Chi Zhiling <chizhiling@163.com>
To: Namjae Jeon <linkinjeon@kernel.org>,
	Sungjong Seo <sj1557.seo@samsung.com>,
	Yuezhang Mo <yuezhang.mo@sony.com>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chi Zhiling <chizhiling@kylinos.cn>,
	syzbot@syzkaller.appspotmail.com
Subject: [PATCH v2 5/6] exfat: introduce exfat_chain_advance helper
Date: Wed,  1 Apr 2026 15:11:37 +0800
Message-ID: <20260401071138.114836-6-chizhiling@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260401071138.114836-1-chizhiling@163.com>
References: <20260401071138.114836-1-chizhiling@163.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3v9ZFxcxpADvDCg--.24371S7
X-Coremail-Antispam: 1Uf129KBjvJXoW7WryxXw1Duw1rKw1ftr1kXwb_yoW8Gr4DpF
	47Ga15J3yjqayxuw1xJr4rXa4Y9ws7WFWkJrWxAw1Yyrn0qryvkF93Kry29Fyrtw18K3W2
	va1Ygr1Y9rsxGFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07URVb9UUUUU=
X-CM-SenderInfo: hfkl6xxlol0wi6rwjhhfrp/xtbC2wkRrmnMxUk0jgAA3+

From: Chi Zhiling <chizhiling@kylinos.cn>

Introduce exfat_chain_advance() to walk a exfat_chain structure by a
given step, updating both ->dir and ->size fields atomically. This
helper handles both ALLOC_NO_FAT_CHAIN and ALLOC_FAT_CHAIN modes with
proper boundary checking.

Signed-off-by: Chi Zhiling <chizhiling@kylinos.cn>
Tested-by: syzbot@syzkaller.appspotmail.com

---
 fs/exfat/exfat_fs.h | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/fs/exfat/exfat_fs.h b/fs/exfat/exfat_fs.h
index 530459ab9acc..1035d20ba563 100644
--- a/fs/exfat/exfat_fs.h
+++ b/fs/exfat/exfat_fs.h
@@ -552,6 +552,23 @@ int exfat_read_volume_label(struct super_block *sb,
 int exfat_write_volume_label(struct super_block *sb,
 			     struct exfat_uni_name *label);
 
+static inline int exfat_chain_advance(struct super_block *sb,
+		struct exfat_chain *chain, unsigned int step)
+{
+	if (chain->size >= step)
+		chain->size -= step;
+	else
+		return -EIO;
+
+	if (exfat_fat_walk(sb, &chain->dir, step, chain->flags))
+		return -EIO;
+
+	if (chain->size == 0 && chain->flags == ALLOC_NO_FAT_CHAIN)
+		chain->dir = EXFAT_EOF_CLUSTER;
+
+	return 0;
+}
+
 /* inode.c */
 extern const struct inode_operations exfat_file_inode_operations;
 void exfat_sync_inode(struct inode *inode);
-- 
2.43.0

