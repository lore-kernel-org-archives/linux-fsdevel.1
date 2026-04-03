Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49B1932BF44;
	Fri,  3 Apr 2026 08:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775203610; cv=none; b=Oq9LGf/qDSMTr8ck8iHnuxoT4qBowHXOCyq0hvl2W6icTgmqy3Lng45+jjsozNF8FOnpzaMX8K7y4fhpRn+MtvptycVPoNHvfxo08VVZaqgS6CN4oRBH11OXgW8Dj27ZeY8HEZksZszrF6Ioxpd5qRyo1FtGtvJHqxcLAqi9uwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775203610; c=relaxed/simple;
	bh=F/CDL8VyW0CX692DhFTu9Yr6yXj1cBGRo9UaLvxTghQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VXA7W3q/c72IdBwffB9QR5aDajGbaqd0vzX3f+dewYjCyBKlDF7szmyqPGVkc6DGMosKNwsXvL4qPqE4LrT4WUDR3jiJROj+jVOoZacSusD3JjUtL1jLREexZdTGHYq3bem7Biil5BdQ7RAH0sTuZdmdtiTbRdS7CtaVRJmdEJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Vo59ozcG; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Vo59ozcG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=x0
	ZM9XluUnOwhkGJ9K+nXa5Rb6HeAXFfDwK1fCdCig0=; b=Vo59ozcGXnjyAV1HRa
	W4LpcP6FITe/FPEVzWH/axos6ZVZZL7WOJQWBzoKmH6eIL/Xb3eBInoQIcmn1N/n
	fQ59gP9u/zOR6L6tp2kgenVf8E3wj2oQ1pRkDYJko4P0Uo7uUzNDQb77GKpbyzm0
	e/REg4ARQr0uRHMlBXcXGs374=
Received: from czl-ubuntu-pc.. (unknown [])
	by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id _____wDHW13+dM9pkhS7Cw--.58982S3;
	Fri, 03 Apr 2026 16:06:26 +0800 (CST)
From: Chi Zhiling <chizhiling@163.com>
To: Namjae Jeon <linkinjeon@kernel.org>,
	Sungjong Seo <sj1557.seo@samsung.com>,
	Yuezhang Mo <yuezhang.mo@sony.com>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chi Zhiling <chizhiling@kylinos.cn>
Subject: [PATCH v3 1/6] exfat: fix incorrect directory checksum after rename to shorter name
Date: Fri,  3 Apr 2026 16:05:33 +0800
Message-ID: <20260403080538.361663-2-chizhiling@163.com>
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
X-CM-TRANSID:_____wDHW13+dM9pkhS7Cw--.58982S3
X-Coremail-Antispam: 1Uf129KBjvdXoW7Xr1DKF15uF15Ww13CF47twb_yoWkurX_ua
	yrtr1DKryYyFn8JwsxKF1rGr1Sga18ur15JrnYvFnxWas3tF9xXw1DCrnFv3W7tw4rKr98
	CrykWr1qka1rtjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU8EtC7UUUUU==
X-CM-SenderInfo: hfkl6xxlol0wi6rwjhhfrp/xtbC3AKrSWnPdQLy0QAA3O

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

