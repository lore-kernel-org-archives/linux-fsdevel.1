Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FF01380FC5
	for <linux-fsdevel@vger.kernel.org>; Wed,  1 Jul 2026 21:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782943027; cv=none; b=gRz4agGdsinDgQt3JNLCWpp8fYlLmHXdqcAbYfcw0x+z0aZ9go+HTCyvGV0HxFC73nfjSheUGLiASbeaXEMNBAkhChxx2BYjTiWm345tEHXEytYewCN4YjNvFSe3nUKpry/6NRKFgfUow2jfoBp89Fb4I3mU0ronnArb+7ZUiBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782943027; c=relaxed/simple;
	bh=KPumDn2GjdQPm0LS5/sSuBsslzZOMkK8+3ZwIlhCdKw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hL4I1nQ6l4GKwqPNAnrl4ijcjyNvdkPHdCVI+V8syHrbqUYy+A/bX1U/pnB/VdfinfJup2nkvHzG6sfKZXAmeaTtqiYdZTzMCDir34kvFwo3x1mwdZ+x2ibTNhxQk36/EUiDPUSrTY0c4fQzD7vRwxrkHsXJP895z64IMz7DMBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g0yo3eQ5; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g0yo3eQ5"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-37d55e8d3e3so862584a91.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 01 Jul 2026 14:57:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782943024; x=1783547824; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KzF4tC59yWjJERniX/8DDZTIMRVB2I0lDsDT4R0DPyM=;
        b=g0yo3eQ5J0xqN3V30t6bQFyOOuyw69VW8yQiumVc8tSRrSjqghlQvlOlZUyRCdHtBx
         3noxxKuv6ucwwaHPTy03B+XA5F+IQqdRyysZcvUY8Jd9EM3kUZHSFwppBGQ0XAQ2ww+C
         Ei6Azn3t9V5Z77sK4eTknoxvF67dI2O+2+hYXFxLShZCzVV/SoXYZEfzqqE+f14Udhp0
         xMvhpznbNM5oP1rtjHjkAok7/lRSzISru2bj0Dxb6+UXxWrtpUmJc6qUmnlOB1GyUUt4
         tKm/VhJAYQa9+u0fQdtDSZeMO3PjF8n99IPeJqgNs5lbIfDInOoHXPgJVzReQZEb9v7S
         2Rwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782943024; x=1783547824;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KzF4tC59yWjJERniX/8DDZTIMRVB2I0lDsDT4R0DPyM=;
        b=Stmwb+IkqOjeRf59vamH/BNQCG/VulvzT8Xth9LOt/xYjhP9rZjHgKsSVQ7/CiXu5W
         gIPvY9jRHaK96+ujai99EjVY/5Yi1AOmUVUZqAXRytZp4Wa068Y5xXz8AOo/SS80O6lC
         O7HmscA+aWi/J6cm1r2505ACEPTs3yRQAg0Wz5J2/jZ+3tbK3cn/wDs0hrKZotGLNeUG
         9ScKHMvAc+9LVN4Jw1Qh3zL8foLUPpoNWia3tDP/J90iOVnU2gtDfjZY8c9HHGsN72CP
         UzA84JQlrV7IevZIf3d6U4RmfQD0t/o7OVDfQNCypN8SnXz2h63TgEMd/QZwY2GFRMyl
         JrxQ==
X-Forwarded-Encrypted: i=1; AHgh+Rrb+4JHz/zyvM8bTEqDhdAjk5oX6nozbd0Fm/kBAC69pLJiGbRiEIXD6aV9eCL9LTgBMBSTNJZ+KYlTdjFx@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/cOey4fGn2INxZosSt2zrVVg+XR+R0zUus7UCrTLF/xlFT3c3
	2h2IEBtvFE1gfwEoA9QtYBpE0F7dClU3mRVSitUC7f3arsRWqlxZS+hJ
X-Gm-Gg: AfdE7clTjIqtmq7KRUou5yE5k8FanAju16ofX6bakPzPYHuLJb12eWVVzqf8BYSzwdB
	Ld6XRc2vVZJ7Gn4TyTTlCyVWu08bLiO7EhXw1aiXDd1V5qWPeiLVb4c98mhsOWe9OjHzWdruZ4u
	IdJraBxJr/3hrxnv8XLdBFqrMwtXrF49j52Ms8pHaP9ZmAaGbPe7F16HN3wfJST+wIlNke/zy5f
	OQb8WBqBSvs879x016edhAA8Gq1dDwXXhacfzG01jzELrrOHy1A1euQtC8rZqfAL6QLYOAQwlLY
	Zst+o9JqRnFLZNWNC3MWbdKOC90hD9UH4Isx77Bb5emDRPRcmpcIZeoxRqNAsOgaWnt7IIoHX/i
	5rz4M8MUxXw5EiD/NtfgBER2uhar1Aci0OiBbUFQOgaBzLTBsXWVXdMDgK1RRU0E/u+Bz93zOCM
	OocAX1FCEQ93jriC6kiKMJQvnMS5f9O+0JOMG0ufE5SOMVhgI4Ur8E7bCTdPwiBO0=
X-Received: by 2002:a17:90b:1dcc:b0:37f:c232:f075 with SMTP id 98e67ed59e1d1-380aa1d454cmr2810009a91.12.1782943024451;
        Wed, 01 Jul 2026 14:57:04 -0700 (PDT)
Received: from DESKTOP-L3Q0GIV.localdomain ([203.230.195.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-380de05f20bsm64533a91.7.2026.07.01.14.57.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 14:57:04 -0700 (PDT)
From: =?UTF-8?q?=EC=9D=B4=EC=83=81=ED=98=B8?= <kudo3228@gmail.com>
To: Kees Cook <kees@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>
Cc: =?UTF-8?q?=EC=9D=B4=EC=83=81=ED=98=B8?= <kudo3228@gmail.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ufs: reject malformed cylinder summary geometry
Date: Thu,  2 Jul 2026 06:57:00 +0900
Message-ID: <20260701215700.822003-1-kudo3228@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

ufs_read_cylinder_structures() allocates uspi->s_cssize bytes for the
cylinder summary area, but it calculates the number of fragments to copy
using the on-disk fs_fshift value and then copies a full s_fsize bytes for
every fragment:

	size = uspi->s_cssize;
	blks = (size + uspi->s_fsize - 1) >> uspi->s_fshift;
	base = space = kmalloc(size, GFP_NOFS);
	...
	memcpy(space, bh->b_data, uspi->s_fsize);

ufs_fill_super() validates fs_fsize, but not the sibling fs_fshift and
fs_cssize fields. A crafted writable UFS/FFS image can therefore set an
inconsistent fs_fshift, or set fs_cssize to a value that does not match the
number of cylinder groups, causing the loop to copy past the end of the
allocated cylinder summary buffer.

Reject inconsistent cylinder summary geometry before writable mount. This
preserves the existing read/write paths for valid filesystems and fails
malformed superblocks before ufs_read_cylinder_structures() can overrun the
kmalloc(s_cssize) buffer.

This matches normal producer output: UFS/FFS tools derive fs_fshift from
fs_fsize and round the cylinder summary table size up to a fragment
boundary.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: 이상호 <kudo3228@gmail.com>
---
Notes:
- Public third-party writeup for the same issue:
  https://psn.af/k/17/
- Unpatched CONFIG_UFS_FS_WRITE=y KASAN replay reproduces the
  ufs_read_cylinder_structures slab-out-of-bounds write.
- Patched replay rejects the malformed image with EINVAL before the
  vulnerable copy loop; no UFS KASAN signature appears.
- The same patch applies cleanly with git apply --check to checked
  mainline/stable refs: origin/master, linux-6.18.y, linux-6.12.y,
  linux-6.6.y, linux-6.1.y, linux-5.15.y, and linux-5.10.y.
- A latest-master raw-source patchcheck also reports vulnerable_shape=present
  and patch_status=applies for fs/ufs/super.c.
- Full logs and reproducer image are available privately on request.

 fs/ufs/super.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/fs/ufs/super.c b/fs/ufs/super.c
index c4831a8b9b3f..c295b637920a 100644
--- a/fs/ufs/super.c
+++ b/fs/ufs/super.c
@@ -725,6 +725,7 @@ static int ufs_fill_super(struct super_block *sb, struct fs_context *fc)
 	struct ufs_buffer_head * ubh;	
 	struct inode *inode;
 	unsigned block_size, super_block_size;
+	u64 expected_cssize;
 	unsigned flags;
 	unsigned super_block_offset;
 	unsigned maxsymlen;
@@ -1139,6 +1140,19 @@ static int ufs_fill_super(struct super_block *sb, struct fs_context *fc)
 		uspi->s_csaddr = fs32_to_cpu(sb, usb1->fs_csaddr);
 
 	uspi->s_cssize = fs32_to_cpu(sb, usb1->fs_cssize);
+	if (uspi->s_fshift != ilog2(uspi->s_fsize)) {
+		pr_err("%s(): fragment size/shift mismatch (%u/%u)\n",
+		       __func__, uspi->s_fsize, uspi->s_fshift);
+		goto failed;
+	}
+	expected_cssize = (u64)uspi->s_ncg * sizeof(struct ufs_csum);
+	expected_cssize = (expected_cssize + uspi->s_fsize - 1) &
+		~((u64)uspi->s_fsize - 1);
+	if (!uspi->s_cssize || uspi->s_cssize != expected_cssize) {
+		pr_err("%s(): invalid cylinder summary size %u (expected %llu)\n",
+		       __func__, uspi->s_cssize, expected_cssize);
+		goto failed;
+	}
 	uspi->s_cgsize = fs32_to_cpu(sb, usb1->fs_cgsize);
 	uspi->s_ntrak = fs32_to_cpu(sb, usb1->fs_ntrak);
 	uspi->s_nsect = fs32_to_cpu(sb, usb1->fs_nsect);
-- 
2.43.0
