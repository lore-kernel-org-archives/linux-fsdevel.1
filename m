Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A06E48550E
	for <linux-fsdevel@vger.kernel.org>; Wed, 29 Jul 2026 19:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785353440; cv=none; b=t5q+to3I9kBksnmb9ILnIAmoEp8pqegkmkIx+HqQGMTICEdguO77GkNoVu9h804GI4XHPlD9goIkqOIGfwhu8ZMDd5Rh41AWTz7haegFECxu0rQNisaPYYgdbT2HwU7OUjaJdBOZLx8yw+J3FWoccJQjFikmhAo+eKxcD6izfdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785353440; c=relaxed/simple;
	bh=bAIl0EYJtqhiY+G9Xwxws/qkXqkeERtNBUa0GVKm6tQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OUIH+SAsOLN4i9QMcaJKuVt9OypXkiS46P+qFDjVdJlSdAuIgp2Sk9DcJqabblGsL8h51Jl+UeNvy+7R69EnbcjXzm3HMmS/rt+qyUuqcOLLawq9eU+Z3dtRHKR/Vjkln9SGlCStBGj9T8u+stOZdX6hng7Iq/li2dDH7xQ9IOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FJbF8JiN; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FJbF8JiN"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2ce98cb8165so444795ad.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Jul 2026 12:30:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785353430; x=1785958230; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=N2JkSd7oYJPFcviDB7E5uYmo6tGTEnQPMBBxrAZJVXw=;
        b=FJbF8JiN53OlaZjmgIxbxDQKFi4NzFEzQsFYwDBLYMm8hBKnpMLGx23+AALliOnRDm
         y/7i5If7yUrRtE+hurlTKtxreO4AV2I46ngn4eidmkJq0QRbNOvaMa0hzZbUQ5B1fiWn
         9b5dM6pB2gcs2jEDs0oB1QUWXwO/4JWFnHwu+8nfiQKRJrAHrcs2n7g1BwB8Jp2cvE7p
         DhpsdhvT9gqxFngHaxUQtY83csf814enHyTGclw6BX/xO/B7sfoKAJ9vNR/pcwuk/LHS
         A2CAG7JxiJKnDlHWfrCM0DpVAJl30YPPOWhO/m/g176f4ss07KoDWFUtSj7qTa1JECFH
         ynlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785353430; x=1785958230;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=N2JkSd7oYJPFcviDB7E5uYmo6tGTEnQPMBBxrAZJVXw=;
        b=Rsa3pt1E5r6Mjqsd2sapJDl8fXRzghLsf5HMOGdK0nVjOAdvomRZSfaOuNg3L9SEbR
         v7JHROgjKwbZ7PNYktRR/nk4J6vIUntWZyTdxnkbPUrGIEEPNYN5TexyRoM0v0xI/9PX
         lgLjajcp32JC0QGRTpYZK2TPT726SJ5CBi+noBSY6BgXnG2zK7cU2ARMO1zWskxR3+dq
         WLmifEIBHMw9lHuGgga3LcqRiWkRg++3QBxqnku61rpOGZK94KMUVvkRb51J8ThALpL1
         DHHSrOviFWpelZMtvJ6z8VMupAf5v86zHL8kfF+eTEZKSZPsx5ZDZZc4bHAgTp4Ff8fi
         MWVQ==
X-Forwarded-Encrypted: i=1; AHgh+Rrjm5twr6nOY08pIjpGmO1pdODt3/vkmhqqy638+T6s/KDVc4NF9YR03901+MjPaOEClS3zJ0nTDMuhZ4ZA@vger.kernel.org
X-Gm-Message-State: AOJu0YxbQoS/ZO+Vp8xx6MyOMf+WPLtj2rHMxaYZrVLZhi+5p3o5LlLd
	N587gJsd/srnzJ186U3bM+BjkcAoZvxCfhv0r7tHIVj41jdNmj2aVpyn
X-Gm-Gg: AR+sD11xrqB0mKilTJy+n1UxlWRH3mnc76ACVLXWT46ktamaXGREubsf0L7ADGspI8W
	NVcmy561DS9+y+czqlVSmxx7RR5xyFoyx1okxUyYWbc55n517qqdddNmN5FiJL57OPy/DhlcZzp
	acw17gg3jYd00fGMN4oiI8c0uALwHJhu2aLZLggIj8w0PS82OZfWGu9aeDZdFkb8drq/GCAUWOx
	tTzO2AsKHfwHZYyhxbX7ks4ScCQyJZHA9O+OpCivHhF9Fy5tpKjmhlv+IcCiKqZaFk/pkARstib
	EF9A0SndAVFRDGDEfmdXtX+dLH+ndFvmXLrQEijp11UTKCL7EwE5/h7l7HplgEqQzeNj3CpM3el
	yA4sCmMReJxrjJh8/wXSW9R2dBDFTsaXkUnFY1NCvUIjx+2Nskn7+DcsD6LoRbddDEqw57D97Nr
	LOfcH2J8SN6EfC5Ay0ZaZmnDM8590ZczZCCVRf52oPXVQWpDb4z7o/HoYgQIY2HFfFsCThSES/z
	RLOvOFdC1npwWO8SZZuBZtkeaYA1nUcnUfMtimG
X-Received: by 2002:a17:902:ffcf:b0:2c9:e846:a589 with SMTP id d9443c01a7336-2d0266f9cedmr39156595ad.13.1785353429695;
        Wed, 29 Jul 2026 12:30:29 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:2::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d022a4af04sm16305135ad.31.2026.07.29.12.30.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 12:30:29 -0700 (PDT)
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
	Damien Le Moal <dlemoal@kernel.org>,
	libaokun@linux.alibaba.com,
	bfoster@redhat.com,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org
Subject: [PATCH v5 17/22] hpfs: convert iomap ops to ->iomap_next()
Date: Wed, 29 Jul 2026 12:27:32 -0700
Message-ID: <20260729192737.3190206-18-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260729192737.3190206-1-joannelkoong@gmail.com>
References: <20260729192737.3190206-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert hpfs iomap_ops to the new ->iomap_next() callback. The callback is
generated with the DEFINE_IOMAP_ITER_NEXT() macro, which wraps the
iomap_iter_next() helper to finish the previous mapping if needed and
produce the next one. No functional changes are intended.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 fs/hpfs/file.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/hpfs/file.c b/fs/hpfs/file.c
index 29e876705369..6a629ab956fc 100644
--- a/fs/hpfs/file.c
+++ b/fs/hpfs/file.c
@@ -156,8 +156,10 @@ static int hpfs_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
 	return 0;
 }
 
+static DEFINE_IOMAP_ITER_NEXT(hpfs_iomap_next, hpfs_iomap_begin);
+
 static const struct iomap_ops hpfs_iomap_ops = {
-	.iomap_begin		= hpfs_iomap_begin,
+	.iomap_next		= hpfs_iomap_next,
 };
 
 static int hpfs_read_folio(struct file *file, struct folio *folio)
-- 
2.52.0

