Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09AE13DDDA3;
	Tue, 31 Mar 2026 09:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774948350; cv=none; b=qEXkr8p7Ui0nqBijOexqe07m7YLDPT4Bu1yvA/J1pE8CGnmoUl2oYej55ZWc68hTRQZ56Y2MX5WG9FXHPbsS5uXupwjbEo4PaMvJl8qpH6Xv6f7HBBuZqThqWzQmDfCi7ogERpYIEjImQdgOqrJFO4nRHWwI9WfU/ID4lGNqp20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774948350; c=relaxed/simple;
	bh=F/CDL8VyW0CX692DhFTu9Yr6yXj1cBGRo9UaLvxTghQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eeaZy7TDLifz8FlB+IVA4vyeVDhKow9vmxcOLJVFon2PQAKmTPyvz+fEKjWpLXd8MFBanwtOnVrlMSPb+9r0f83ne47gVsrmBa1Lnlx+tOnBLiAHltCEGAMi1Tikmt3hcmaYTztM6qNN3KXgwd4lMzjxNIumrzaTojyYLNeGz/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=ZRlH9eFL; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="ZRlH9eFL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=x0
	ZM9XluUnOwhkGJ9K+nXa5Rb6HeAXFfDwK1fCdCig0=; b=ZRlH9eFL5rXsamFQBQ
	/fBySuGRKVsB/YHK2+PTsZk3Qcx1OLC/Kq1PDuUz+hogtZjEW8Eu1q/0QkUqdWUA
	1Op8qy1O+Uvgp1sbO3+GZiPT9cqPiW8nFN78Vf60z4rtXKiHwpIhMbJtsjwJc+XC
	96AcEP1XhvHLGDxwE0BmDIHj4=
Received: from czl-ubuntu-pc.. (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wDXetTUj8tpdt0MCg--.18595S3;
	Tue, 31 Mar 2026 17:11:55 +0800 (CST)
From: Chi Zhiling <chizhiling@163.com>
To: Namjae Jeon <linkinjeon@kernel.org>,
	Sungjong Seo <sj1557.seo@samsung.com>,
	Yuezhang Mo <yuezhang.mo@sony.com>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chi Zhiling <chizhiling@kylinos.cn>
Subject: [PATCH v1 1/6] exfat: fix incorrect directory checksum after rename to shorter name
Date: Tue, 31 Mar 2026 17:11:08 +0800
Message-ID: <20260331091113.20882-2-chizhiling@163.com>
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
X-CM-TRANSID:_____wDXetTUj8tpdt0MCg--.18595S3
X-Coremail-Antispam: 1Uf129KBjvdXoW7Xr1DKF15uF15Ww13CF47twb_yoWkurX_ua
	yrtr1DKryYyFn8JwsxKF1rGr1Sga18ur15JrnYvFnxWas3tF9xXw1DCrnFv3W7tw4rKr98
	CrykWr1qka1rtjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU8EtC7UUUUU==
X-CM-SenderInfo: hfkl6xxlol0wi6rwjhhfrp/xtbC+BtnBWnLj9vSXwAA36

From: Chi Zhiling <chizhiling@kylinos.cn>

When renaming a file in-place to a shorter name, exfat_remove_entries
marks excess entries as DELETED, but es->num_entries is not updated
accordingly. As a result, exfat_update_dir_chksum iterates over the
deleted entries and computes an incorrect checksum.

This does not lead to persistent corruption because mark_inode_dirty()
is called afterward, and __exfat_write_inode later recomputes the
checksum using the correct num_entries value.

Fix by setting es->num_entries = num_entries in exfat_init_ext_entry.

Signed-off-by: Chi Zhiling <chizhiling@kylinos.cn>
---
 fs/exfat/dir.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/exfat/dir.c b/fs/exfat/dir.c
index a2c2b998808c..7619410d668e 100644
--- a/fs/exfat/dir.c
+++ b/fs/exfat/dir.c
@@ -490,6 +490,7 @@ void exfat_init_ext_entry(struct exfat_entry_set_cache *es, int num_entries,
 	unsigned short *uniname = p_uniname->name;
 	struct exfat_dentry *ep;
 
+	es->num_entries = num_entries;
 	ep = exfat_get_dentry_cached(es, ES_IDX_FILE);
 	ep->dentry.file.num_ext = (unsigned char)(num_entries - 1);
 
-- 
2.43.0

