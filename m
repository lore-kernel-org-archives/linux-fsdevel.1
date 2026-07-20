Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D224542A80
	for <linux-fsdevel@vger.kernel.org>; Mon, 20 Jul 2026 21:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784581361; cv=none; b=q9OpsYma6l5kPTuMMCvopudZN8k7pSuBk7Pr/gybVP1VHEc/g/4Jp3r3pRvFWaa2xQZGnCXASkZiJuE4EFsojxUeE5IwDKYNLyEALrAzdWLrxgYGhvukE81l1sRBR71Ri4izkDIo91VopuD9IsEHZzwDZ1n6fNkw9k9iVaDsUKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784581361; c=relaxed/simple;
	bh=3Fbl5MaGSEhPrjx9pliGoJqPoQm8nDp7ZS+WKqitgus=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gkKDJfS3jZMVDDsQD0Eabq2c9u5lZcFacdmmfa2eRIb6LhoC8kw4prqVmOOZ9bPEmY09qIsz50ea8jeIdA1wLoS0g05gCXdh0qqGpcaSZ8HCoS62Id5P5IWwaF3BCrMhCS/YtNO9qzx7yOrJlel1dVEqNuxyooLDy6WM2arO40o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NNbEhjRr; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NNbEhjRr"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-84a2dcede83so9846485b3a.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Jul 2026 14:02:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784581360; x=1785186160; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jH+TeFe4eS2WsKabb3CNPoYBr5KTegiyeJHR2iqxc70=;
        b=NNbEhjRraKoeGBm9Hs/7CRyJUJFc/tlPoOhJUcp+vpXG6hleuVrk1ETEkrHX94i1vC
         LnwGiMIdPH2y+UxhCHUlXUYyEKmdWBhD5erLJHhA930Eyo7Pyf3FhE90wAVa/wbBFSEh
         CKdvh348RS9wak/zPsHhMIB46VpPBY3Ipi0SOHMd7WO4E+h2A2A+n5lQACJplBdEHxbD
         uP1cSYfPsQdEmuuhBZMe56AAPqWX4Y+M6ne6Rl2mtFqxCv65+bafuyyXbwy+9qUPc+E5
         KyR9/GQKbM/KvkkKhgr/VXq4wovwvXUKbKTkFi8c/lovdcu9dNyVcScFAywfdrHbl1/s
         DU/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784581360; x=1785186160;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=jH+TeFe4eS2WsKabb3CNPoYBr5KTegiyeJHR2iqxc70=;
        b=jnGBw8N4CVug1H0JslYapd3IQEFfcbwV11YbNBQOqS8btiHCo+0ieSroUHjvzkUNBc
         uiFJXhDO9yWTXDlS7/4pW42y9JdWIa2yc+42TWZ/SBJ3N/KAl38Kw3+nCRnDBzGWRSVW
         D3hO/9scSe97FZLJql8lqW5sAol5QDs0t3dm29QON//C20xj8NUxRRl30tAXOQYFWHOx
         1j8HqcfdomV9fLUCsrcQFdluPTZO7eZEgbypcxskGcxRznIgO5x+9aDmBe0/W8v9G2h0
         NE9f1K0Lw2ZN0GOdbG+yjK9X5qMHSBXrQ5kGltDcM53CD9gaMsVU+AvpbWmgNmYCZYR5
         JUeA==
X-Forwarded-Encrypted: i=1; AHgh+Ro++QqwmDBWSPjY/cD9VZrdH1DJFBohBBV4oUPSSvdMECD/DXWvGJRQw+j/2NOxN2bpgMj+Ih7bwUuwMCOJ@vger.kernel.org
X-Gm-Message-State: AOJu0Yzv1p5dULGXRd5IlfYZnEf2E4e2VX/FiinFyU1VcWvpPaC9g47z
	PeYWdhu9Qtf71hLKsL9QaBf69XC/3GlZXeRlTlb0w1MS7jqx/F+arRqH
X-Gm-Gg: AfdE7clmUdCB/1qp3MvSN7hKHquov7YsXWhJNdr4+KbeuuPltYAqYBJzxdo8lFUyJUg
	CL/NYeuDkVshnbVwJlN8B8Bgw+a0Oia0yVQvagnvXgetNyM79ixgu+ncF2aQmn27nIu2HcFQtaV
	Wppq6LV3rFzWYPwH6Rir5zMEOEoFBcuCb6kZ97rGmxZbKqQW2aj4UGdq58A8Ojxf0v9Qoes11Xv
	l/PhUrnRY3d6Ab1vdTEjxDBpAvRlFz8dShSBiSmBQKPJEgHGIAVFKPPKonNL3MPU3Bll8uB0a0K
	LoEsiybgo4pb1b6ePzXABAa8PiNhG7q0TO4a2LLBvLOKozLAwZdufRGAWgw3SMci6T8Osn8+Gq4
	YipDPHFkYT6NDfCaYRcdJwIeY6PImjH6lReIDdjQeO6m+yAVYO//C+E6sBS0Fx/lPOGnwIeMFA3
	uWrzXMHkmxsDN9O6e3bBrbaetW6ddXIqWMGr5ckxBDjUC2N030/9NG
X-Received: by 2002:a05:6a21:6e4c:b0:3bf:6237:b1b3 with SMTP id adf61e73a8af0-3c3ad8eca92mr16457405637.42.1784581360137;
        Mon, 20 Jul 2026 14:02:40 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:6::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cb519de34d4sm5501694a12.26.2026.07.20.14.02.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 14:02:39 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: Christian Brauner <brauner@kernel.org>,
	hch@lst.de,
	"Darrick J . Wong" <djwong@kernel.org>,
	linux-fsdevel@vger.kernel.org
Cc: changfengnan@bytedance.com,
	kbusch@kernel.org,
	Matthew Wilcox <willy@infradead.org>,
	Jan Kara <jack@suse.cz>,
	Jonathan Corbet <corbet@lwn.net>,
	David Sterba <dsterba@suse.com>,
	Dan Williams <djbw@kernel.org>,
	Gao Xiang <xiang@kernel.org>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Theodore Ts'o <tytso@mit.edu>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Andreas Gruenbacher <agruenba@redhat.com>,
	Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>,
	Hyunchul Lee <hyc.lee@gmail.com>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	Carlos Maiolino <cem@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>
Subject: [PATCH v3 13/20] f2fs: convert iomap ops to ->iomap_next()
Date: Mon, 20 Jul 2026 14:01:55 -0700
Message-ID: <20260720210202.1163861-14-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260720210202.1163861-1-joannelkoong@gmail.com>
References: <20260720210202.1163861-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert f2fs iomap_ops to the new ->iomap_next() callback. The callback is
generated with the DEFINE_IOMAP_ITER_NEXT() macro, which wraps the
iomap_iter_next() helper to finish the previous mapping if needed and
produce the next one. No functional changes are intended.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 fs/f2fs/data.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index a765fda71536..8977ad379f50 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -4653,6 +4653,8 @@ static int f2fs_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
 	return 0;
 }
 
+static DEFINE_IOMAP_ITER_NEXT(f2fs_iomap_next, f2fs_iomap_begin);
+
 const struct iomap_ops f2fs_iomap_ops = {
-	.iomap_begin	= f2fs_iomap_begin,
+	.iomap_next	= f2fs_iomap_next,
 };
-- 
2.52.0

