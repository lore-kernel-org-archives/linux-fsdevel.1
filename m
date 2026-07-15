Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF12F44B687
	for <linux-fsdevel@vger.kernel.org>; Wed, 15 Jul 2026 11:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784116359; cv=none; b=Z3WwQoTVtcEEEFbcpCPWPoKyF+COotMu/cAtdSoGDe7JMUH0y7qLROpywwrPFPkubpvpX6Xk1ofD/8I9gBYANUGuGOvtr0YQbTZ1zzh5UkHL8Z20xOGZxR20+5cJxgeOEwBei6P+ZZtQEnC50nyGfjOfY0ld4QtQe8QwuSLsC54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784116359; c=relaxed/simple;
	bh=W0KKEQjvprOowhhqzNy5pT4VFCUxCqk/sF/W6pg6t4E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=krlTe+n59fQg6jH0GlzRiHq8cedjBzC9f9cmBpC02JnzTZPDco5AzN5VYFkAoRqJKNL3s/0Nvll+7TsouDWdgZS83C65zZEpvqYM1rLL8xYN4nm7Xv93/tHb3ykpDdnvYP+JWMzycHIOs0VqdhwAT2ZzOlINCAxskgfM5x8ZNnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qkcrOCCA; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qkcrOCCA"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2cace91f112so48858355ad.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Jul 2026 04:52:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784116357; x=1784721157; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=LsuD+p/a7jppz5lNGczD7IlYV2q0inMB+mXZMgQrGAc=;
        b=qkcrOCCAaLaOrLj4Az06mjuDLhdKwFi9ZIFRf8XAZQF1l9SX+ywo4aZFPmlDYn1P/j
         Vhee+aRQT8K7Klb8/gASLwjGNrWvR5o5aA1UHGXR1DXZRuNQs0O/kCWeTxUmvY/Kv3Nr
         1m/vQWXRMetLqCEuzqoG4iyRH13tI7vVRxTceC8D6q3p6HA+WKlMce98D2XlX5YmdCcb
         QMRZEyAdZKxHbd66QIWyctuY86suDqXwOPPXbJpauzb6vYtL9dXuQyfFabQj7qlI4yMh
         0R3gkClGM77R86YOMo+VgbVPnuA4kw+9RjMMnv8W/1Hiu8/t7gLZhpwLQHZPMZCCqZR9
         og7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784116357; x=1784721157;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LsuD+p/a7jppz5lNGczD7IlYV2q0inMB+mXZMgQrGAc=;
        b=S7asU/mJpaNFC910+ryQfHkCPAYiwSDZXWOYgJIWkKDAI02qfVsqh6+CzHSMWL3bri
         G2IIR1CxsoRwcnFv7MpMGpVlQuc1dD3X0Px94gL0NcQyUEb91H1OI5sKAp/Ux8Hd4SNO
         b4qb3DyHLrnT08rcWYpzraMTCLUvJBZxXR0ka1yAa53bbSCeaPmVfqPhxwTP1oV4f5Wq
         ytbapyPQ4UPFOPyKwR5yUWGRBhMdcYTNGU7DWpPnoR5ebWdX15aw9CP2vi7TaBdDjuy8
         HnMm4RQiaXnea0AAEi5HzRjYjbTARbZwSbf51Jgw/bkaVNnYb8U3irOxYstFcfyH5HNi
         622Q==
X-Forwarded-Encrypted: i=1; AHgh+Rp2HQTNewnuRv4DuW25cRn3eB+8/izwMfIZYb5DTMAuJzQTXHzmmD5BBL+PVVyEjBB0u63fBLjbjaS12AqQ@vger.kernel.org
X-Gm-Message-State: AOJu0YwqVJsPSvyS5bDfWQPqIycnJmVcmmtFI/evudsspFzJ3VE9NBNw
	qgB4Znd92HQteRnA/9bE+w8pRAmXeJQIvj+YeFjIncT+oKG83UcUhzYi
X-Gm-Gg: AfdE7cn1hSKjbPXhak5Z4XB90Yyir3M/uQQbVjj4z7Z0OXYYi5gZeDf+J308f8nIgZU
	DiZi3Pl/1CAQWrzxEF1HxDkSaTAKVfldNrGEykU4Xq2t1+YCOr+La0cQxUNcYwiKGLI8RrvkA/N
	KI+ZQfLiExvAYK9PL4SuCox3FnSvcf3ArPp9xaDMVzW8x8QEyXVAaZpgckxB1H9fWyCviWBy2pa
	FPV3S098YE8umCmAmOMt7trp3Z7M+zQmKdQKMuqn628bP7+XRiCx1K3GXQqvMSgypDl5OeMXKsi
	zrgezQdPlFfydQ8FRkRZ591+4D95HRglriyCBBZ3NdV5WYcuZ77sLeIsBoCH0u8jXldEV4/Ut5s
	4ee3f3dORz2too2bAHik0oVFHUB69SDngctjL6npr9klf2R7OS72Dllxe7SVy5CCOkvp94MZNHm
	6C2EMBCNj4rGp9mClJ8dt2GpwKGGc+uibLeLQQUgiwwRGm/a3qygl63tCtP6XB/BUGDIjWJB6mA
	2kn1w==
X-Received: by 2002:a17:902:ec81:b0:2c7:ebfb:618f with SMTP id d9443c01a7336-2cf03cac9d5mr21793895ad.14.1784116356954;
        Wed, 15 Jul 2026 04:52:36 -0700 (PDT)
Received: from nugod-NUC15CRHU5.tail9f095a.ts.net ([218.237.104.87])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf106b271asm1001305ad.64.2026.07.15.04.52.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 04:52:36 -0700 (PDT)
From: HyeongJun An <sammiee5311@gmail.com>
To: Russell King <rmk+kernel@armlinux.org.uk>
Cc: Hyungjung Joo <jhj140711@gmail.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	HyeongJun An <sammiee5311@gmail.com>
Subject: [PATCH] fs/adfs: bound directory entry name length in adfs_fplus_getnext()
Date: Wed, 15 Jul 2026 20:52:31 +0900
Message-ID: <20260715115231.1585166-1-sammiee5311@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

adfs_fplus_getnext() reads the per-entry name length bigdirobnamelen
straight from the on-disk big directory and passes it to
adfs_dir_copyfrom() as the copy length into obj->name[], a fixed
ADFS_MAX_NAME_LEN (260) byte buffer.  adfs_dir_copyfrom() only bounds
the copy against the number of directory buffers, not the size of the
destination, so a crafted image with bigdirobnamelen larger than the
buffer overflows the stack-allocated object_info::name that
adfs_fplus_iterate() passes in.

adfs_object_fixup() may additionally append a four byte ",xyz" filetype
suffix, so the accepted length must also leave room for that.

The old-style directory parser (dir_f.c) already clamps names to
ADFS_F_NAME_LEN, and adfs_fplus_validate_header() validates the header
name fields, but the per-entry name length in the big directory format
was never checked.  Reject over-long entries, using -EIO as elsewhere
in this file for a corrupt big directory.

Reported-by: Hyungjung Joo <jhj140711@gmail.com>
Closes: https://lore.kernel.org/all/CAP_j_b9BqyQrk3D5nj6RSa=eGcs2HkRYsWc3WdXeXp9O3=z4nQ@mail.gmail.com/
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: HyeongJun An <sammiee5311@gmail.com>
Assisted-by: Claude:claude-opus-4-8
---
 fs/adfs/dir_fplus.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/adfs/dir_fplus.c b/fs/adfs/dir_fplus.c
index 4a15924014da..c68c301d8903 100644
--- a/fs/adfs/dir_fplus.c
+++ b/fs/adfs/dir_fplus.c
@@ -192,6 +192,8 @@ adfs_fplus_getnext(struct adfs_dir *dir, struct object_info *obj)
 	obj->indaddr  = le32_to_cpu(bde.bigdirindaddr);
 	obj->attr     = le32_to_cpu(bde.bigdirattr);
 	obj->name_len = le32_to_cpu(bde.bigdirobnamelen);
+	if (obj->name_len > ADFS_MAX_NAME_LEN - 4)	/* leave room for ,xyz suffix */
+		return -EIO;
 
 	offset = adfs_fplus_offset(h, le32_to_cpu(h->bigdirentries));
 	offset += le32_to_cpu(bde.bigdirobnameptr);
-- 
2.43.0

