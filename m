Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D8B4433BD9
	for <linux-fsdevel@vger.kernel.org>; Thu,  6 Aug 2026 16:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786035554; cv=none; b=OSM/ddaXRWeAEh6WI+09D4jrn5yqcq4GzTnkSslCv8ObGknuyH1Cp1zQzwk+1l0blaes0lqwi9AUeC/qNmAlsCLIe04qE3rvC+8ICWBIFlEqZIvx31TweRUt9CMac9ssyGGo4DGWZkdvp5AvTMpfo9d6/N6CqsxAPXXrBiPz0M0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786035554; c=relaxed/simple;
	bh=nXfjVTs2WwI7r48njT1474MNwTWULNnJflHmHfHsQpo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XFnSVjgGEpseYjjyGn+A02yfsSEIgUkhBhNp5eE7Aov5dLJ68/iBm30cjqsMsEV68GEraBfQJF3xWDZ0U5Gt0i2TxcfgbwUce8DZM8CXJzSkMcPgzZDJOWB6PSQDhG7VWjMx+8BLfYbpgcTDsdB3KQk8mWo53pziAaHJS2ZDuTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rCjwZ9ZH; arc=none smtp.client-ip=209.85.222.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rCjwZ9ZH"
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-977cf5cae50so546916241.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 06 Aug 2026 09:59:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786035551; x=1786640351; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/lKy66WaG7+TnlzmHpXjsimPtvzEbNlkmMtBXzg/7M8=;
        b=rCjwZ9ZHWX41u7MfJ+MryPhCI8vGY/L8sYpgkXPgIfdNOuJ357cyBStukNEZ+WPC8x
         pKvE1d5mqR9qjiUoJ28Djmysne+CaumKECJBG1EXqQctXaCyGT6voAWXZ0y5Jrtytqha
         LhG3ndoxi4p32VUIJPd1zRasy5YjXlVop2LKrJr8LAoYUVE36vunoOZ2tmqylhpIQ0Wn
         +osJFGgG2OWfKyETBj7A+zIP+OLgNlIArcYpTGrtQTfFn1MFg2o7UJNtdMJXJnx9gG0d
         fEi0+4jSKrpxlc+cagh2eEGliYPxweH1BRLN/nyRwlWiYJ5VebD3a52EhtEdRPTlzK2e
         QhrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786035551; x=1786640351;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/lKy66WaG7+TnlzmHpXjsimPtvzEbNlkmMtBXzg/7M8=;
        b=e6dd8YVtHcqH3NmZ6PMh/H+sF23ifFwvhpl5vmX1VMNlbe0mV/L44iNR6+f7Wm8YXS
         OoqebLeYE8nf2r0PU+p1Hyqm8OjDb4JztfweFSqbdaiP9uHdVKM91amvlmIMi770v70W
         plG6YbvNaGNsTYIUqVnBv0LvNWyThsyFlSoWtD1iacCtP/u+IkRIdpcpkp1m5dJsHbZM
         oy9Rj1ut/w5iT72GWg+G/s0IuMQEyPv8FV5oE2HJWmcg8Ycf0rIrNGpg8/LDf9af7q6Y
         wir8Ht5OqUG9/lKGLHiNHKNuHEJScZ1BYs6G79CEG31edhVpzlBISu55pJWhmgFKMP4M
         2t/A==
X-Forwarded-Encrypted: i=1; AHgh+Rq3fjZYYlRcpK7OZONOwUnQIBPqdPY+Czuu+ITiQHhHoez0Ge4NNL1nXjxdIS0/J/UIoF1wqD+af685cnYy@vger.kernel.org
X-Gm-Message-State: AOJu0YwgRwAD4uSb50caEQuxZ2aiwT1wWCHa6crY0z2D05kqxqOsUzYf
	rCPtAc5SGZ5DcrynTylw7sQ0BoNofbPHdcfG5QfdyAuS/Pzw1hcO6ai9
X-Gm-Gg: AR+sD11kYi+ssBs2x1JOKjQXjr2A1s4jEhw0PL0evkBc/Ztjz1V7H6Sps70T21Z7fwg
	ZvTODS0aueXnUHIAv4uDq8sd72zH2Q4rOxFegjrwvouc+qXsCQ64A7onxClEMC3EomtBd5YNGR1
	5hxvIJEnwvxDiuDYA+c7Vh76yp0gRwDLfKHpEJcZxNxZlwaL4iGODKQEikIc1OaYQSyrTeNkAGc
	0y5HIcq8f7mecT3mfg2bA1eBywXMGhuDaoY2ZH1LGytY9Nb80j5yYyBqdW+qHdxkeJgr0gBntyE
	oLOjkrdqfXQH8c75z6xKY+SuXRawXcK9RmfM1pkPhp6BwaAqyglv24eYLy//paa7LJQX5DIMDNe
	SAryynLOzF89VPNcI+a8JexKkKLQqrYn/HFBi/HGRUJbujpanBqmXuALhEnXI8fnrtpDniERjml
	VXbFXYlLZ0rJh70x0euheFz4MUfVUOZ57vooxsSdR2LIfUI981RDIQSZyZnz5n1DGpuL8l7fcw+
	GYS8Xo=
X-Received: by 2002:a05:6102:f09:b0:6f0:3ba3:7d84 with SMTP id ada2fe7eead31-760e77f0ff5mr4020392137.5.1786035551228;
        Thu, 06 Aug 2026 09:59:11 -0700 (PDT)
Received: from syssplab.cs.fiu.edu (nat1.cs.fiu.edu. [131.94.134.89])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5c3d05c594fsm3706321e0c.8.2026.08.06.09.59.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 09:59:10 -0700 (PDT)
From: Chao Shi <coshi036@gmail.com>
To: Jan Kara <jack@suse.cz>,
	Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Matthew Wilcox <willy@infradead.org>,
	linux-fsdevel@vger.kernel.org
Cc: Theodore Ts'o <tytso@mit.edu>,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	Baokun Li <libaokun@linux.alibaba.com>,
	Ojaswin Mujoo <ojaswin@linux.ibm.com>,
	Ritesh Harjani <ritesh.list@gmail.com>,
	Zhang Yi <yi.zhang@huawei.com>,
	Zhang Yi <yi.zhang@huaweicloud.com>,
	Bob Copeland <me@bobcopeland.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Sungjong Seo <sj1557.seo@samsung.com>,
	Yuezhang Mo <yuezhang.mo@sony.com>,
	OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
	Mark Fasheh <mark@fasheh.com>,
	Joel Becker <jlbec@evilplan.org>,
	Joseph Qi <joseph.qi@linux.alibaba.com>,
	Andreas Gruenbacher <agruenba@redhat.com>,
	linux-ext4@vger.kernel.org,
	ocfs2-devel@lists.linux.dev,
	gfs2@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Chao Shi <coshi036@gmail.com>,
	Weidong Zhu <weizhu@fiu.edu>
Subject: [PATCH v2 04/21] buffer: read the folio's mapping directly in buffer_set_crypto_ctx()
Date: Thu,  6 Aug 2026 12:58:27 -0400
Message-ID: <3fe72ec37bf8491a69031db5f3ba1319da935b97.1785951556.git.coshi036@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1785951556.git.coshi036@gmail.com>
References: <cover.1785951556.git.coshi036@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

folio_mapping() was doing two jobs here.  One was to turn a slab folio into
NULL, which is what made this safe for jbd2's shadow buffers; the previous
patch removed the need for that by giving those buffers no folio at all.

The other is a hazard.  folio_mapping() maps a folio in the swap cache to
its swap_address_space, so if a buffer_head were ever attached to such a
folio this would hand fscrypt a swap mapping and dereference ->host on it.
There is no reason to want that here: this path wants the file's mapping or
nothing.

Read ->mapping directly.  Buffers with no folio are already handled above.

Suggested-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Acked-by: Weidong Zhu <weizhu@fiu.edu>
Signed-off-by: Chao Shi <coshi036@gmail.com>
---
 fs/buffer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index 04fcc34e4fa6..2851830995d8 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -1108,7 +1108,7 @@ static void buffer_set_crypto_ctx(struct bio *bio, const struct buffer_head *bh,
 	 */
 	if (!bh->b_folio)
 		return;
-	mapping = folio_mapping(bh->b_folio);
+	mapping = bh->b_folio->mapping;
 	if (!mapping)
 		return;
 	fscrypt_set_bio_crypt_ctx(bio, mapping->host,
-- 
2.43.0

