Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECA1C4854F1
	for <linux-fsdevel@vger.kernel.org>; Wed, 29 Jul 2026 19:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785353436; cv=none; b=tDMQoFdC6Z1TUIIhT5WpqVNtDnyB0oxq1U7EAuchSxy7wJImaFXbr3qO3704wHEweRKBRf+aTWFDkQODnOkxvTrR6/o0pCQU7QeWCyMy+sPHba5M1OA24I5it7DAkoTNO0VsCYvYmuYuq4reCXzs457PmEZL3k0mylkdUa6QVBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785353436; c=relaxed/simple;
	bh=Fjw5DSYb9KRQ1xyLxsho1mmISLRJMKjPVMoKEf1qwyw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zdv4NPZQNifVEC7kueanGGjlU3AwQHEOVV2yPYGdE/kWANkZCevihAFNYTv1aea2ZtV1b7lFeXzQ4gfWDl5dwco+MCGDzlbZOpRyURdlCWg1dWkw18q4Z3KkE0JrxkvG4JlmbVGqkbMj4EyNxzgnWXuV+afFNLC/TGbaATGXu4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m33pBlXn; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m33pBlXn"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-c9eefcf9175so1041305a12.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Jul 2026 12:30:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785353424; x=1785958224; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+DsR/dFj2nYHw6/Q7iYssphd45mi2AeTA7D0yo+w0Uw=;
        b=m33pBlXn9JVAQMOzYqZK8DmyRBf2oVJBsTPoEiCzK1MHeRc0nZ5WoZ10PMero8OCJA
         VdkIXqB2ctNyTtde8T+NBieF9aFQfast2Z5PZhwMz69l4eyBSpbC4pnfDnVjFopj/su3
         euAFDKJ2Df0EGcnJ9DR8Xx/N3G11g2DKghxe7K/zBG3/E8Hym5Fi8g+L5YUQ489OHLlN
         bf/VFVZ8kEpz96qLuhd03cJSpuFHbpzeHjsDzcpBLt/MqQSRa/BmuFV2zDcuoxZ7wG89
         7nOWeaTvDQU81HHLjWJLEvBQesbYkzbVTyyxSGRcexKyU8fnTUaRgzkBS+Xxa6nFIDKW
         BUEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785353424; x=1785958224;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+DsR/dFj2nYHw6/Q7iYssphd45mi2AeTA7D0yo+w0Uw=;
        b=qNPiNfuCaOLvuLwkwqIwDnwkEWt4e05yp3peMdydPbh/cS493P2yeeQr9rClcIAuJT
         LybkKQdgZ7y1DOr9+r7lBV3fiF2wTfx3SNBjefeNG74RrxOp/yciBA0iMFgC6J3O7gMp
         9kJkfoT+q1Gv9Lv+jc9QQ7P6Q/0ZLbb5/8RYEyv0tmXSH1ADxLOevAvO+rVo3Ycl8/9Z
         8sW7TQ5ZhWDvM8YJK3h2v9JbdT/fjYT61Q4Srs9HUceNQg0yZH05GO0O1OrFomMDxppM
         CRvlEqZe16dsXEGgMygIN0oWOYxJXWvnCs4kLNMfBaRMyM6tcAqweHBWO1jxPrBrtHZb
         BNhw==
X-Forwarded-Encrypted: i=1; AHgh+RqIYCrTVBMiwrM2jODjUdkT6rskVjxWF7PTySz0MswK7qKlpVl0tf/RmORcm+qrJF1Ap+oSjUlJcdSxKwv8@vger.kernel.org
X-Gm-Message-State: AOJu0YwT3TPxZkDh3ENXq2T/Yq4e82hWB3qpyfNkhDMyibKjaznr8XpK
	lw+4GfHkTL4dIjjlxbHt7jfH6bUnNyZ+Q0nULMKXHajOEc5CTFboz5jJ
X-Gm-Gg: AR+sD10DpbytHAy5QKJg8FuucUygA0P6UAht/ThnR9muiJtXQ7rWZpoiXlOlU5DAdMZ
	sx87OpDgzMGMle5Sv5Y87er24fzw4cKJCcbPF0zDG+coCUrmuzyfPIZF7atuOJ2B/Dy8Y9M2r9l
	YN1qFLnbUlsLXKJebU7aFUmgeZIq9HcmZGdGq8OO+TkPSI7bvZ+YVRgF+LkO2Bht7DbZx7HcchO
	bph7yKmDrgp/q68W/9GxhQZQAKhqYxwU5Fcn27AcNeoaq0+8idooJ1I+Rcbu3dlu6Z7zHnoftd6
	QZnrJVFSMhP+wmsPsKxqTsCJRWwJiVxxtC9WVIzjPfA3mavS4L4bHb/q6d15u8vMlg3iml1ICtf
	qHe3LpVQhMCL1v01udDUItx8B2KUlp8oLHS1R1pEqOSjNXHeGVlOYcnEeZYQXT3OpMVIxXX0psx
	PX6AWRMqisT/pEWBhsHy6a9G6ugegaC1A61dd5CQzHp/V92Z77rO00qsgwMNk/PdSGun2LghPqH
	Y7LblopD3VslMTmTIufIvAG1QXlM5orwrZO+2dH
X-Received: by 2002:a05:6a20:4313:b0:3c4:396d:4a6c with SMTP id adf61e73a8af0-3c8aafc0362mr10655921637.5.1785353423821;
        Wed, 29 Jul 2026 12:30:23 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:70::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cbdba92bb37sm1264179a12.30.2026.07.29.12.30.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 12:30:22 -0700 (PDT)
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
Subject: [PATCH v5 14/22] block: convert iomap ops to ->iomap_next()
Date: Wed, 29 Jul 2026 12:27:29 -0700
Message-ID: <20260729192737.3190206-15-joannelkoong@gmail.com>
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

Convert block iomap_ops to the new ->iomap_next() callback. The callback is
generated with the DEFINE_IOMAP_ITER_NEXT() macro, which wraps the
iomap_iter_next() helper to finish the previous mapping if needed and
produce the next one. No functional changes are intended.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 block/fops.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/block/fops.c b/block/fops.c
index 15783a6180de..4cff76e9eb71 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -453,8 +453,10 @@ static int blkdev_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
 	return 0;
 }
 
+static DEFINE_IOMAP_ITER_NEXT(blkdev_iomap_next, blkdev_iomap_begin);
+
 static const struct iomap_ops blkdev_iomap_ops = {
-	.iomap_begin		= blkdev_iomap_begin,
+	.iomap_next		= blkdev_iomap_next,
 };
 
 #ifdef CONFIG_BUFFER_HEAD
-- 
2.52.0

