Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26A9042A80
	for <linux-fsdevel@vger.kernel.org>; Mon, 20 Jul 2026 21:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784581365; cv=none; b=rafKoYu4fCX918BsZOJ1v9nFkEXPW61s63ScdnIu4FKZUEsMThEEl9iFBwnDNjjrsz3Dqjd04yDmhN6OLUpxiJszkoRrq5oPyy687i9ivI6PX+lSsJOke4NEKr9BqsAc4VlFZdBVKtvrFDzdd/cHJPW8L4vUvJuYhX2XD8ntY+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784581365; c=relaxed/simple;
	bh=HHxOrJYOsxXujbtNOZYiKxqT98cJWgSli6XX9Kw9VZk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AdEu/UNYoDGSoKbvcWUQUMoZckdUvsXPrC40mBruLJWeUh+w4gmi7Q26TyIc7z6R2hLx9TbGDxvnEsP/oUEn1thJ3bNx/nXazczOeIz7TP4e5JVBLiMct2t7/RgiKoSsLjJvgKF4DIfKA88N93JNSM/Bn8IpS9iAZ6wv2T4cM1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gLwBLYNN; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gLwBLYNN"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-84a652535dcso3594082b3a.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Jul 2026 14:02:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784581363; x=1785186163; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=t0Y5kYgnq47GiPzAl5xZ9gQOM4CGwKa3ZKYndZjd3EM=;
        b=gLwBLYNNiNIl031DQ0OCHUG357/F6lWeUBMKtH5GD0UZi/cTcfdOhb/I7siWVqIfg1
         BNT6HgPcYHMAw8k0rzDXFDj5zMgNWn262Cml0CLQhqfG+VrdRR0KJfXetW0BVM7RZiiM
         5dH6pCW+q94xzzFRfeN5FKVyQsMdtjVCN+f0BdxqvBK+G3szgNO40xWwcy/MLUJti1Q8
         oaFS4j3WtCQKCAP+BPJT5CrQz24ij7tWTnO8GM6PeEGwxiKMwSVvQrTLJZIMvhr0Ewl+
         gUEPRdbPzSg5htvoAtrm1Asyp+Anq6lutXcnSpXHlMzz/I9Ae1tJyQX5qaSXcg0XkRnX
         nWyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784581363; x=1785186163;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=t0Y5kYgnq47GiPzAl5xZ9gQOM4CGwKa3ZKYndZjd3EM=;
        b=OIiDoS5b+SamRUAxT7V0nOLYuUfAdjd/TTNZbMPxHZjOau8hiwhUZ/anAdyPjftbQb
         MoZGEFE91U1vgFTpPIBT5cWojXgG88PFCjnvsDTjIe3OkOmJI/2D7q4KtXc/zohH3+7y
         OQsIy2GkoBpA3Q4bn3znDS/UvJ8mAlaIbM+ZPlKulBjNI2EQAxujyIDDOoHEKrmiPK1R
         geLo/ReY0dKeq2lGtTBKgp82huG1BBzeSd1x+shgsC9an5+TQclHS8DCoKJWJW/FaZoC
         UnfL2Bs0mx3TYl+07p1oreCwyFVhM3KNSP+Tj+HxsKRWtL/VIfDiw6QNE/0kvPGqEZZf
         pcRQ==
X-Forwarded-Encrypted: i=1; AHgh+RoPTVcKsd0830NrzUN1gXcVsJqjvCIc0/q9lj7n3AHI+ZjVNOEXmljQS2h8Nd1M0DEZbGKRYJy57PGfjkBb@vger.kernel.org
X-Gm-Message-State: AOJu0YzEvFToV+DTM45WqPxdyLoTCmVgIPZNnFAjKtQUK8us0UGb6Lhc
	oaKvZ9u8yrG2rAX4wNT3ITbKTwSi3q4+/U5Qe4fujgMnsa/Qn2OfWzjP
X-Gm-Gg: AfdE7clicTctq430aJL2Yqj1NnoNgBF1WfOZJrtI9Wg9jwCR8gwoqvVSyfLTDmQvXS+
	Bpj0nKOOk83hATQtl/lWSEympV/CN9OZuV1S77062aiSsb8Wjd01/vBgGBxQw18DfpfGwob2HXV
	quAZk6GAlA+krixaW81fRxeO/RTvgW1ZhOlkuiY+JtlNMPe1R3vcDQwcccu1KisuNQmlG/gbVa0
	CQV7O726RD71BbhpcWjGFSicDR0bqD1G1vOXuknKFps1WBLGM3rvZqJnarux0Keorz9tqLHKem4
	i25Sb+KGWT0fmSq4n2d70+Jy0D/wGL4cci4HtJNwEFAbEMJ3fxPq38dTaIYFRFq+JQTvpJiWjgf
	4xy8X1aUGDFY0iLCs443BIAWxYJ2HSFbRO4o61tUhIWPaBLQrTTOz55tq2hV2DYoSBwDqFsgC/I
	YBfFaQ/PeZkeHGqM0D/DSmLmbiLZkoIHQlhrpMg0sEpDanRj84UYIjRQttBe4ZSxA1
X-Received: by 2002:a05:6a00:800b:b0:848:76af:db37 with SMTP id d2e1a72fcca58-84c2923da76mr17190017b3a.7.1784581363524;
        Mon, 20 Jul 2026 14:02:43 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:41::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cb519dded1fsm5055190a12.23.2026.07.20.14.02.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 14:02:41 -0700 (PDT)
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
Subject: [PATCH v3 14/20] gfs2: convert iomap ops to ->iomap_next()
Date: Mon, 20 Jul 2026 14:01:56 -0700
Message-ID: <20260720210202.1163861-15-joannelkoong@gmail.com>
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

Convert gfs2 iomap_ops to the new ->iomap_next() callback. The callback is
generated with the DEFINE_IOMAP_ITER_NEXT_END() macro, which wraps the
iomap_iter_next() helper to finish the previous mapping if needed and
produce the next one. No functional changes are intended.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 fs/gfs2/bmap.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/gfs2/bmap.c b/fs/gfs2/bmap.c
index 51ac1fd44f78..73c626971163 100644
--- a/fs/gfs2/bmap.c
+++ b/fs/gfs2/bmap.c
@@ -1200,9 +1200,11 @@ static int gfs2_iomap_end(struct inode *inode, loff_t pos, loff_t length,
 	return 0;
 }
 
+static DEFINE_IOMAP_ITER_NEXT_END(gfs2_iomap_next, gfs2_iomap_begin,
+				  gfs2_iomap_end);
+
 const struct iomap_ops gfs2_iomap_ops = {
-	.iomap_begin = gfs2_iomap_begin,
-	.iomap_end = gfs2_iomap_end,
+	.iomap_next = gfs2_iomap_next,
 };
 
 /**
-- 
2.52.0

