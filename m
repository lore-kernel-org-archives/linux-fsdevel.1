Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 553114D8DAE
	for <linux-fsdevel@vger.kernel.org>; Wed, 29 Jul 2026 19:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785353427; cv=none; b=d78xJOZvRKUT393G01S9SnNGeZxdcZ6QzDhR2oUU3Yw3wTfO1G7o9wAcDRZjRL9j0C/YgtFYpbLZ5JYfkw291bexV974tkf55IpIQVlIq0XTDJWn8g9/8KjCtd2ftyaqaGRMNu7QDbhrhv0lPY5129VBBb4qOv6P8EcD3URTQAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785353427; c=relaxed/simple;
	bh=mjtFePw905Ih8lZM0jTOp001M3VsZYjlem3tQ4B9G6o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UjmIEckyK74RPfF7ixCSOZD8UHTYLHLamJzLA5XmcahLxHClGU34kjvKtSnJVrn2a2nSbwGiWFiIOqO9c0Lr3EoIVNugk3cS+WOL7HlJfv5vL1oJhV+pNfGF0LuKi3Mrvm/eDeqh3sujGkcQ9gk97zGqwplwFUr6jZdTn4a4rKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZaTGMMzL; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZaTGMMzL"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-8453427d3f4so1440312b3a.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Jul 2026 12:30:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785353418; x=1785958218; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=t0HucSFNwCrhhqVsgsZLRy5u6x5BGWTlUoNlDXYASAs=;
        b=ZaTGMMzL0y7gj1mhiwNikYREV2yRDps3jAibpTH0klMMs7NxfSdlkT2PG6RsWrvMDb
         4+07TF/n9G3jWNhIJErhILiYEvIvrFa5/+YiQa/a56mtIayLBpaIwkZhOkWUVLMyDr+t
         XdRxaP9YhX14o10k6iGq1yUE42w0VvhWdm9H+vYSq+9gZ+4bMVUzZ7yL+yQku+xa0Qwz
         UlVujzrB/7u3BF7mhR0Ez3Plrkquaz0n7v+eRxGA51Q+lZsmoWEofprJGi0X3vO7eXvo
         xTAgjowexqWopGOiOKzivQCKlZYftyYYQJovLUAf7TGwhSCu3COwe5vITBd3PzLiFY7O
         o+0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785353418; x=1785958218;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=t0HucSFNwCrhhqVsgsZLRy5u6x5BGWTlUoNlDXYASAs=;
        b=DldviveN7lBIXH3OaFVuwMHP7XGTFhCMtX4cvd0pmuXxWtSfP4zVucsJOrDfiQCRL9
         328YIPsYB5lCNQLejO/MKiWxneNY/PJZqTWEUVH+JP/ONF5PbkvpyPjbfIkeqy1WJVC4
         5VB3FRG69PyGrKFBmljGK8R9a9WPuwigak6Grdcl09ic56DGapMfjXPPd7v4j2pVMfWg
         iEc08JCHWgnsV6RFFrU2t7pCFDDYQh8lL/BrZdIPFHKEZwDi4pp5S/LOfBOLYGjrqIzD
         /+rQ1XMD1Jv61F5A+1DEWjmSZ2aBZhmoMLAfNtcP4TK2KJNs+1XFtsVcT8kpqs5sMyNT
         mGmA==
X-Forwarded-Encrypted: i=1; AHgh+Roqfdn8x/WwjUO7O/OcRQoMQnRthLlllQODiNuKvwEc5DdwWvvf5b/h7Ynb2XdK62ONyU5+QWSp9gIReH4s@vger.kernel.org
X-Gm-Message-State: AOJu0YylSBFoym3Abqr7+NWickP+zhJvHOJ4eZAk/kwwsPoFo1HNyQO6
	ldxrX1t8rWzicsz71peeuYfV33fp6+iArvXzQj2dyPpmDjds1Cw8XIpm
X-Gm-Gg: AR+sD12y2y9g89pXFE4qklg4g6VPBAeM7iu++109JX61QYv8pZXUYlxOXDP6rbvDDb3
	CQgnBME+FJx9QtyZfME/UZcZqgloNvjA1OVZe6kwj7AOY22Ol0OCvlZbeltul84bA8Q4xV5DuGY
	+UHQAWPKShXHwqPDYjyJHj4UrKcgWn+ptdhTmd2qS0vxYsjWeTlejJDO0PYBI9+QRUJidfYNeY9
	P+c0eYfKLcXon3Mb3EMtv57al+3Oe5RUR5bdLL0H2KShD6wwULpIZttJ390WK8oqHv3F9DDY3oV
	iqkLnUJpiktaN8DDE7Ci6CVhVKoVBwhxm8ZESVvaMmuHIeupBsJsnqb8mHIWZtX1CijfHop8Gtz
	IQL9u9axpwCtdJdVoPOBDHv+MQKoSeupR3suGK6z4TWNOHTVU4vMdhrQ5xWKXIYBxuLiiYDLc2u
	YiNLN7+eN7NDlOlJAnPne8sf9yEvmO/YNHvL3jab4b8IxQ8RdFvzwfFSFMfUT7TUmbqkqiBPkfj
	Sya37cKz6ZMyhikzcvgPTX0covBE0tIlatKpUI=
X-Received: by 2002:a05:6a00:a02:b0:84e:24f:2677 with SMTP id d2e1a72fcca58-84eb9e82597mr91426b3a.4.1785353417595;
        Wed, 29 Jul 2026 12:30:17 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:2::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cbdb55c5b7bsm1288273a12.0.2026.07.29.12.30.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 12:30:16 -0700 (PDT)
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
Subject: [PATCH v5 12/22] zonefs: convert iomap ops to ->iomap_next()
Date: Wed, 29 Jul 2026 12:27:27 -0700
Message-ID: <20260729192737.3190206-13-joannelkoong@gmail.com>
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

Convert zonefs iomap_ops to the new ->iomap_next() callback. Each
callback is generated with the DEFINE_IOMAP_ITER_NEXT() macro, which
wraps the iomap_iter_next() helper to finish the previous mapping if
needed and produce the next one. No functional changes are intended.

Acked-by: Damien Le Moal <dlemoal@kernel.org>
Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 fs/zonefs/file.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/fs/zonefs/file.c b/fs/zonefs/file.c
index 5ada33f70bb4..5b34849be7a2 100644
--- a/fs/zonefs/file.c
+++ b/fs/zonefs/file.c
@@ -57,8 +57,10 @@ static int zonefs_read_iomap_begin(struct inode *inode, loff_t offset,
 	return 0;
 }
 
+static DEFINE_IOMAP_ITER_NEXT(zonefs_read_iomap_next, zonefs_read_iomap_begin);
+
 static const struct iomap_ops zonefs_read_iomap_ops = {
-	.iomap_begin	= zonefs_read_iomap_begin,
+	.iomap_next	= zonefs_read_iomap_next,
 };
 
 static int zonefs_write_iomap_begin(struct inode *inode, loff_t offset,
@@ -106,8 +108,11 @@ static int zonefs_write_iomap_begin(struct inode *inode, loff_t offset,
 	return 0;
 }
 
+static DEFINE_IOMAP_ITER_NEXT(zonefs_write_iomap_next,
+			      zonefs_write_iomap_begin);
+
 static const struct iomap_ops zonefs_write_iomap_ops = {
-	.iomap_begin	= zonefs_write_iomap_begin,
+	.iomap_next	= zonefs_write_iomap_next,
 };
 
 static int zonefs_read_folio(struct file *unused, struct folio *folio)
-- 
2.52.0

