Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793138321;
	b=hgYbzFNq1dgWjo4msSGzXSyzynQGBzknAvPaHbKKWUjFZawk1+Ew1r1bl7hHdHI1eYfK
	 1lRtinLJIet5Biizw+lgmFCZhtdJp6pYQLNWAyWK1yFhfSLIUGsOXA0KbmUrQ/qXfLJ4U
	 srsBwPpWhRK2jDQMrxJoNrNu2vHMMnk/GDk8n4YgQ/Q+zjO/nbQh00AXLNeEWkSWYGLCF
	 kf1j1wHN+XHuagEZrahGoyDzzXtvoF7XGOEtJgLNUVxc5Sqo2R75tatfe3u8IcWOHF3h4
	 Xm/b3sf/E6Olb4QR4gT9IPOIxLHQspt+loIeiOgDuasRS+hiqX9Lfuy6Vg5WkTSbYPg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793138321;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=43G9CXaG7qSF4UFTj5k8Ql+kaR9Fc0A0Kgr5LG/j+HQ=;
	b=GNxhcTxsGNUW1S0vXp4CvB2HUrQytwO2sG2xEzZY6xxLW88LOFS8Gns5hp9fSxbcSm7b
	 NzmKzmkZ07Xqc+RMQiZKFSH+ZTW49sVUHgI/ITce5A22Dh0pA0Lmvj0JEUQCqxhxRutAS
	 W2ChpDsoyx2LLEDry+rNPTg4d5uTeJjP7NP9KKMTU1DJezDQBd3FLJAD5DwHqBAmux956
	 pVYclY93Vw3fK6uurj43IfWl7VofDqVp88+CLpWmwOPxfr0BJ+Qp27Mnz4U+URb9zIYcf
	 SkkAJOc7kImbsbyaUfsXyk/w6sAenvB44M97QVYqbD0pOczmzZucfgGGgxInDMvTctg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0JoWngSl;
	arc=none smtp.remote-ip=209.85.128.182
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AB6A606A32D
	for <linux-fsdevel@vger.kernel.org>; Tue, 27 Oct 2026 21:58:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7AB6A606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0JoWngSl
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-8ab38a051aaso3091407b3.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Oct 2026 14:58:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793138319; x=1793743119; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=43G9CXaG7qSF4UFTj5k8Ql+kaR9Fc0A0Kgr5LG/j+HQ=;
        b=0JoWngSl/7Wd4baloUpWZfgYNcJsVWiereAE7th7R2Ip+sXgtUEhPJO1hjFXHapzbR
         yPAtjz+ezQBhpAMDxbiS6NCatGfpLLaiWx3O1DQmpz0O86H1LD/XTr04UMKmlmbO/Vo9
         4xfaa0gGx4eWPRM/ewD4WBEPFHsEj5k8P9e9oSmnQTcm+8DivDfjUd7A5oR3TGka4RC1
         vJv+hHOEGLK5VpjdEhPVM/J2fOv+egtjbFUGk7eBJREyknkrXfZnUtf7klqTWt0ENeiz
         xUBRXMjgnVeAVE6Dbu/WEYJzXgstdrpDAg+ijV1WUiyayiW32T30xxd0cGoPgh6z5wgq
         Ns4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793138319; x=1793743119;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=43G9CXaG7qSF4UFTj5k8Ql+kaR9Fc0A0Kgr5LG/j+HQ=;
        b=iFlhKRCddCUrqQkt2Tmfw/4XZlINKxNMoq2jz/o4BJY0qStc3RiQztSLtxA1PQjJYF
         pPQMLClEQhWa9ZCuv50ESxrSWwZWxgfZruzBBCTSGqlrPNXCBAhGt6zHfxii7rJknq8i
         PSs7rJq2TOiuP382S/sH7anlKFXUfy5AvsYqbiHo32BkAO76E0JJKUhTwaXFWogJNcpP
         Ite9klElLfFrg+z1HPbOG14oJls2AeAu66wy9FrPdEEi9kG1fVBNaovay8b6srLoVUrA
         jFlGT8YkCSxr9PB5EumZa1Ml+KLw8QvflTbRd3mIS9mTiGXWVGN82x9PguPbaZtQzGQt
         Mnxw==
X-Gm-Message-State: AFq9FYK5RcGd6Hrfi2YXutex5KBwjGMccHXPVfXTqjbzSKZ2tGTbZY8r
	rCFQSrSx6qtnzTF7hs/pX1yveiYb4CWmdU70bAVC3RVpM3eaAvbIMOoe
X-Gm-Gg: AYBFou0cG95/t+AhCK8dvBkG8TRS3Zh+aIbc83HOz2YoLtIh4wF6TmX7Yq9GcTeeNws
	ugE/crwJSN9M3MUNA0DpsR4rcrDCVItLnZqrL7ydcr/zDFDjmjkvNUT4Rh4cYsVb1q2iaPIu86o
	x0NYgimQGmVnSWJWx9yZ9BLYxSQJd6CBGAJ7Fm0gFzlmydvg5XkIf2fDKAfEshyyPg0C6x3+M2E
	5zbN//5x19chKiN/9brjLl08Q2aMbRfi+YmAF8s+96/8oFehUv0gYGATZ8PEnHpehmvPy7vN1uy
	Axsrv0GJ+DFF/rcGROZjnUTQMhayJ9XOs1sQ7SA2mlqBWWhIs8CNT6khA+qT8f0m6boGOuh0jY6
	P0GT0YL9/SfToM032rVAH8zuZdyiAf1OTYpRpqZv2C8ilGqNqa5TZSC7RhxTDEdXMeZ9b11kLi/
	2opi+qK+SSdD/oUKHMFUZLh0jaBqLKHyyHr/K7lF1wBbmx8zhK2qF2Fd8HV7Yy5qK0pTaSTuAuX
	6h8/iCs2y4VLvWYTsQJtUYUji3EovCL2vWuI+QAkyKg0cLERQctoT6TYssl3QFAWAU2TN1ZBXEt
	4gEsalXBUd7ml3Kx85x4ZRseEq0T0jpg
X-Received: by 2002:a05:690c:f89:b0:8ab:485b:9bc8 with SMTP id 00721157ae682-8b1b5a8ceffmr2994117b3.24.1793138319600;
        Tue, 27 Oct 2026 14:58:39 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:73::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b19e5b83b9sm18877967b3.27.2026.10.27.14.58.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 14:58:39 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	"Darrick J . Wong" <djwong@kernel.org>,
	changfengnan@bytedance.com,
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
	linux-xfs@vger.kernel.org,
	Viacheslav Dubeyko <slava@dubeyko.com>,
	Ryusuke Konishi <konishi.ryusuke@gmail.com>,
	linux-nilfs@vger.kernel.org,
	fuse-devel@lists.linux.dev,
	Zhang Yi <yi.zhang@huawei.com>
Subject: [PATCH 3/5] iomap: remove ->iomap_begin()/->iomap_end() legacy path
Date: Tue, 27 Oct 2026 14:53:24 -0700
Message-ID: <20261027215326.2693300-4-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20261027215326.2693300-1-joannelkoong@gmail.com>
References: <20261027215326.2693300-1-joannelkoong@gmail.com>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With all in-tree filesystems implementing ->iomap_next(), drop the
->iomap_begin()/->iomap_end() path.

Reviewed-by: Fengnan Chang <changfengnan@bytedance.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 fs/iomap/iter.c       | 6 +-----
 include/linux/iomap.h | 6 ++----
 2 files changed, 3 insertions(+), 9 deletions(-)

diff --git a/fs/iomap/iter.c b/fs/iomap/iter.c
index fd8791c4963b..8b6da9750a93 100644
--- a/fs/iomap/iter.c
+++ b/fs/iomap/iter.c
@@ -119,11 +119,7 @@ int iomap_iter(struct iomap_iter *iter, const struct iomap_ops *ops)
 
 	trace_iomap_iter(iter, ops, _RET_IP_);
 
-	if (ops->iomap_next)
-		ret = ops->iomap_next(iter, &iter->iomap, &iter->srcmap);
-	else
-		ret = iomap_iter_next(iter, &iter->iomap, &iter->srcmap,
-				ops->iomap_begin, ops->iomap_end);
+	ret = ops->iomap_next(iter, &iter->iomap, &iter->srcmap);
 
 	iter->status = 0;
 	if (ret > 0)
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 59718f73c15a..95d4995a49ca 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -195,7 +195,7 @@ struct iomap_write_ops {
 };
 
 /*
- * Flags for iomap_begin / iomap_end.  No flag implies a read.
+ * Flags for iomap_next.  No flag implies a read.
  */
 #define IOMAP_WRITE		(1 << 0) /* writing, must allocate blocks */
 #define IOMAP_ZERO		(1 << 1) /* zeroing operation, may skip holes */
@@ -240,8 +240,6 @@ typedef int (*iomap_iter_next_fn)(const struct iomap_iter *iter,
 		struct iomap *iomap, struct iomap *srcmap);
 
 struct iomap_ops {
-	iomap_iter_begin_fn iomap_begin;
-	iomap_iter_end_fn iomap_end;
 	iomap_iter_next_fn iomap_next;
 };
 
@@ -256,7 +254,7 @@ struct iomap_ops {
  *	incremental iter advance.
  * @status: Status of the most recent iteration. Zero on success or a negative
  *	errno on error.
- * @flags: Zero or more of the iomap_begin flags above.
+ * @flags: Zero or more of the iomap_next flags above.
  * @iomap: Map describing the I/O iteration
  * @srcmap: Source map for COW operations
  */
-- 
2.52.0

