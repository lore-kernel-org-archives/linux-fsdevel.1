Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 801722874F5
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Mar 2026 15:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774021966; cv=none; b=UMLepxRZlYaQP3TGYsb7Y4MCTgSoMNaOTKBCWX/bcBMQ5H1YK8uKduPwFqowKb4lcDSpX+Ry0gZsMuRs/s8QeGWqXTG5gJ3ix278S8BM4ftDhcT1TSOeUb8835O17ig8G1V7Ego2VreMvfpcR80QpXkBSjdsvoaDnjXpYuAQIDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774021966; c=relaxed/simple;
	bh=sS6PS4PllVmC9sKI7kZjrsMPU548t/KVd5b1vNIuYpw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f6ddVYOT6F+hKdjjgMa7Hs7VCV48I7dAAIRGjwez9GXiCRAVXAJ4/RKjRjiDNJ5xuCPuWceuuMB3YuJ4Fee+sdGMWnhxIdsUgSGtt9+KUCgk4fauT2+nf2ZkVCDEUYFQf1qzfUtgKyG/EC+5O0ibcl4tn+mrcewm+Gvxtz/ak30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HB/4m+xv; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HB/4m+xv"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2ad617d5b80so13960225ad.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 Mar 2026 08:52:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774021965; x=1774626765; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5NqVsX+/LV1zH4kDIO81wh1PQ5RAVeugSioQrUGNJdQ=;
        b=HB/4m+xvKucAGm/jwiNX4Dvc5GOft8tFRPD1/0zpISuOMbSP2TjzftpV0V8y6cQtqV
         XzRdI5oVv0y5Uy773NqHWZFO3YyTH7N/t0+zzCMv5yY4vgxSPpD9srWPE3DmE4Qai737
         D0TtA97aU4Q+5u2mf0yH4SfgQECBv2wgNjH3eGmRbBdTCavPfoBa7tc4fvTImTMV/VPN
         RphqD1nL3b7aNN44qZ+yiz8TbKqAjfyYpSuYldIiP3w3m0Ssa+2Akx7Cgt+yZE+CgUuv
         rI2KXLrCXdDOkZuM0oxbXOxS8mzU5201/Yhbpq8JBv6BVHknP5Adu3M4FlTWTPhgKwLI
         XGiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774021965; x=1774626765;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5NqVsX+/LV1zH4kDIO81wh1PQ5RAVeugSioQrUGNJdQ=;
        b=STgZzTBwYxd81NGMkfNDQ0F/xpmRzWKdTFfzxru7HQXCQmliAmhf4fnGKqVle1VBLY
         i+UX9q6PxgXNl+tXcQ7ZS71txcF8fz/jn+TpiDhAQJGlp0AP/YXEbR338/9YS/tt96rn
         dlroIKsyCsfeKGUNAowRo7sn3znXPpr13ja9V4npAZcPUMoJ9twG1l8C44tPePMjwkp5
         8iHKt1R2D821DZgDM/hkEeKYIArpTnKDJbLViBnxXx0XXA7YsTCp67yjRJnVkHKi4OY5
         C33F2kEKYCDb5Ib6qVBgV1dNLLq61YxP1zrtFyuhDff6agUI1g8tx6uEBCW1Qhbefi1C
         is2g==
X-Gm-Message-State: AOJu0Yz9dCfNSZD1KXIxIDtHfUIZqdGx50QoHs2ZJukxFTNhAGnME7Pm
	9CKCxZXswYyHCWkGWSY9m6Fn3cGOpcl1ECj3nAHY5OelGPiHkGsqcR3v
X-Gm-Gg: ATEYQzxI7w+OOkuH9UgnQ8wpL9e1E6NLa9rxcEXzC4Oy9sd36lkJ76bFQ2+oGZbyvwK
	yjG6cX4EDqwbtihcvBQtg8f27V9guW//JCt1KiqySRqBhB/Q46iFsF7LJ1cWXK2JKmI8Gn7l0g5
	+gy9b1eOqiFxw3vlR1W/kMddQ6F8UH9+SqhXcPhcTeuYpk1AP0zJT8A4VmlSAwLQcBvXDWdre9i
	ASogNxvCPSt6v5J/+QLwB0RwhSZiUhg1CEKlSK2REWvp306Q2l2A8SYOUu2vZbvMHVoQ9dtDKKV
	M3nu2EYSFageE6JQjTP7LaTHe0yEjiPaE9JwZv5zhylmXvKTgqEAVvxVawmBLk9ruTCoMklP01z
	7GWzPb61CpSMnIrgpzZeZr7zujiZ+YrydkDX8YjRcNQV3nKx6IDB38nEQaNmalhYbdb3OG8I2xF
	ceWu4Zi85EUIvNVaWXWKdpb5dF
X-Received: by 2002:a17:902:e84b:b0:2ae:c7dc:95a4 with SMTP id d9443c01a7336-2b0827749f5mr32346035ad.20.1774021964810;
        Fri, 20 Mar 2026 08:52:44 -0700 (PDT)
Received: from paeyz.Davolink ([49.172.60.165])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b083516b96sm35798065ad.7.2026.03.20.08.52.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 08:52:44 -0700 (PDT)
From: paeyz <iwasbaeyz@gmail.com>
To: Russell King <linux@armlinux.org.uk>,
	gregkh@linuxfoundation.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@kernel.org,
	Kees Cook <kees@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH v2] adfs: validate nzones in adfs_validate_bblk()
Date: Sat, 21 Mar 2026 00:52:13 +0900
Message-ID: <20260320155213.2812-1-iwasbaeyz@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2026032039-agility-ferocity-6ee0@gregkh>
References: <2026032039-agility-ferocity-6ee0@gregkh>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bae Yeonju <iwasbaeyz@gmail.com>

Reject ADFS disc records with a zero zone count during boot block
validation, before the disc record is used.

When nzones is 0, adfs_read_map() passes it to kmalloc_array(0, ...)
which returns ZERO_SIZE_PTR, and adfs_map_layout() then writes to
dm[-1], causing an out-of-bounds write before the allocated buffer.

adfs_validate_dr0() already rejects nzones != 1 for old-format
images.  Add the equivalent check to adfs_validate_bblk() for
new-format images so that a crafted image with nzones == 0 is
rejected at probe time.

Found by syzkaller.

Fixes: f6f14a0d71b0 ("fs/adfs: map: move map-specific sb initialisation to map.c")
Tested-by: Bae Yeonju <iwasbaeyz@gmail.com>
Signed-off-by: Bae Yeonju <iwasbaeyz@gmail.com>
---
 fs/adfs/super.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/adfs/super.c b/fs/adfs/super.c
index 4d3015e3a..b5522b862 100644
--- a/fs/adfs/super.c
+++ b/fs/adfs/super.c
@@ -343,6 +343,9 @@ static int adfs_validate_bblk(struct super_block *sb, struct buffer_head *bh,
 	if (adfs_checkdiscrecord(dr))
 		return -EILSEQ;

+	if ((dr->nzones | dr->nzones_high << 8) == 0)
+		return -EILSEQ;
+
 	*drp = dr;
 	return 0;
 }
--
2.43.0
