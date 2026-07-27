Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF8A042CB12
	for <linux-fsdevel@vger.kernel.org>; Mon, 27 Jul 2026 21:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785187498; cv=none; b=X9ac8N//PZPghRBPvtsKWP7VxLtx/ZTOIW6tBpdt8Uniw7xqdNbnKd4fmSxGbQ74SVIeQMEoACLWwjOZ7MxlePj3yWA/hXaI7dEEqMDfU160sJZ1+vVED7L4q/zrjHLpPqfXGjvwSPBSy5q+a7jI3tBgHl6sJy3UoDon3y//6HQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785187498; c=relaxed/simple;
	bh=3Fbl5MaGSEhPrjx9pliGoJqPoQm8nDp7ZS+WKqitgus=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H2+M5WzGEtDzVnIzLTD7lKBpEE8OS/IGOiKz9Wl3DAT+AAkw+C+LtE6VeJbHUsGcJuJ0n1sveKr3lzSGIw/AgU8oY4tuybWNJsGutr6U+Z4/yUEGumLXeKaaiiyt7q3l1mBbSHJgXYcQ2lqznvMiHgb+ml1NGWE5SnC+iJXmP14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EkZ+UVDq; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EkZ+UVDq"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-84861fc51f5so2475813b3a.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Jul 2026 14:24:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785187496; x=1785792296; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jH+TeFe4eS2WsKabb3CNPoYBr5KTegiyeJHR2iqxc70=;
        b=EkZ+UVDq09X6A5c3r9RfwA38QlXAzXsX0Dei3s7Uo1Tnh6zEXehHR8e5+ztXW02D+f
         GqMkRZ5YxhC0XKbfRBPAl0BKTzTxMbS/0KxABPGk5zViByiLA2nyCMfOgKZknIR152PN
         1zzQmSVlqp5As4jStS1kucydy1sHTGZCva3fVcP64AlfrjQZ8XPf1lTLXARxDUtlNQ+a
         zA+uOkxN4kKPu+0XD5kDqSXV5VhLZ4M0+oZ1qBdcD4N5pCo591WXIMI29E4ziLdaQoFm
         z3oMbAwxBEskwO5T60u4K9tCTfMA9HzI6o/jIieYWKBkKxShjJp0JDL0/y63kw+c4hiK
         P2AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785187496; x=1785792296;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=jH+TeFe4eS2WsKabb3CNPoYBr5KTegiyeJHR2iqxc70=;
        b=PQtDum6mZM25ygtK8aIhG2q74iA2pfjCgOfqurAdRvSI5PnIynIBMrXVlqeE8urNpw
         fKF5Bp3MZhfXF7StwDDdVIk3AYgoX2GinTYM8WV5+IeV2jAT8PWkWNlY4nEWq01Hh0/l
         qm3G+d2Upswycb+2hnFnMRRnx6tNQYLhN/gmdpPzRk1UOI3icuEeLP3qo00QpOYJ31rQ
         RXGADH/7oBY5Yo385gh4CYNMoDSMvglcvmAhsgdANnEWxObWBEb4p+Y8yPmGydpoI5Sn
         n7M/OZW7Mb5j2t21hZRQfmfooWvQvzC9I4QaozM+yJMdG6xPkYNeyoDTZf3rmFy3Ex7+
         PAIQ==
X-Forwarded-Encrypted: i=1; AHgh+RrzBbjtcdrARZSzoY3o+QZkU7Gi6X9cOse69TpdYatCedSoLOmsaiqBN+adcoNnOWpeMfh58H5LwpRBJ9DP@vger.kernel.org
X-Gm-Message-State: AOJu0YzYab2/70jOEnBoHQRWmftZrU6ioMQgcJ4JB/bnEi3bqBt86vyA
	WWOLUimTqNoNGB73wH1Tv6N+jro74t6Do1xNBGorAc87jAotQGdZRVZ9
X-Gm-Gg: AR+sD12+o2x0BtgVtgN1CW9PFCRYbOlII1xCA5w6NnfFwlnQgw4c9UZCuHeEyHDc129
	wBm6zk3RMefCXdLI4zq6oAOJYUYopiDR27nlXh/wgWPoQkGLgQL2clNBQpUvJTJZtcA2Tbl91fM
	GL5pPvBMNmmOTQLYb1CNnGhMqT4rLdYCwVlo/udECcCmPuqb5h4jF3tb0aMmup8OrJGUhua2TKz
	uu4metH1oPSWSfasrMcTFmMAdI7X98s39q4Humf8GoFDl2nFbUUQxfRrNbmwOPQb59eDSdePSRe
	rZ3Rgoqy/fJ0w7JMJbdXBkO49FvnIkGfAailObAejo+e2fM1/AqPmv9EFqhISNSxzcp8XtSFSkm
	amZ9mMYNr3Nw3n6KeOk99UBwrHy1SBZk93FkCPNmCNtndNcHMmEQPQ/RJy6zignH375DAqwhQ0z
	3jZkwB//IDjDjpaxcjXYtQZ2U2FKkW0LgEqyET/7y05/XT/OsOifsROUk/K71+hMYjfR6W0U4bf
	y6baGRooQtrIjXmtgFRlHCJ2faZlXGkFYsUmM77
X-Received: by 2002:a05:6a00:1827:b0:848:8027:cac with SMTP id d2e1a72fcca58-84e8d0950f1mr997486b3a.23.1785187496247;
        Mon, 27 Jul 2026 14:24:56 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:4c::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84e5342471dsm3476124b3a.47.2026.07.27.14.24.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 14:24:55 -0700 (PDT)
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
	tytso@mit.edu,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Andreas Gruenbacher <agruenba@redhat.com>,
	Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>,
	Hyunchul Lee <hyc.lee@gmail.com>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	Carlos Maiolino <cem@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>,
	libaokun@linux.alibaba.com,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org
Subject: [PATCH v4 14/21] f2fs: convert iomap ops to ->iomap_next()
Date: Mon, 27 Jul 2026 14:17:51 -0700
Message-ID: <20260727211758.1116539-15-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260727211758.1116539-1-joannelkoong@gmail.com>
References: <20260727211758.1116539-1-joannelkoong@gmail.com>
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

