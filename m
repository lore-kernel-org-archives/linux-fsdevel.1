Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFEA1331ED2
	for <linux-fsdevel@vger.kernel.org>; Sat,  1 Aug 2026 22:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785621684; cv=none; b=czJmzGbWqaZRDC79REUcQx912jyH+ozOkeGHRhIkdxafkwiVZ0ZSJgDuG2OcQGwPChcpLgSLPtfu7kKMVUCIkHyrDs0a42hUTtmQrXUUzELceSuRCm98oVi+kHKcdHN/m3eTosOVcwkb2yyK+MOIUgDv9kxObaxI+GE0puZj8LE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785621684; c=relaxed/simple;
	bh=C/EU16/I7KCMlmfQlOxCpDa7gi9I5VwIhNBsZBfHyYA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Di3lMrJ8aURAarFjrdsPeGlbuENEvM+b53weNycYoLCWhbgZRlhz7xBRkQLRcWwSG45FMo+PacnUUEvOMD1sLnhryh9lUMMBFPvZhYxYNk7bWDiaXR0pNYpGUFuJo4XJnXHl/+K02YCjFLmkKJN8weeh4hrAYRxokf2wumzm5yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mVQsNMht; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mVQsNMht"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-81ee41aaec1so29632447b3.3
        for <linux-fsdevel@vger.kernel.org>; Sat, 01 Aug 2026 15:01:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785621676; x=1786226476; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RmlziesBf0p1zLY+SBouFO3AuG9bJkIG3U4FWyI9lx8=;
        b=mVQsNMhtoyDJzr5v3i315Qh382bdVk1jK9+Q30pwlj/dcosHnql6LoueV3JP29yCRE
         YwUbHngWzXnUqkGWq2B+Km/mOooKzR70LjcCelSmVMpyvSIhcQZr6Vb0upleThF5jNH/
         as5oJP5fJuwuYcnXVPHVNgUa5DUc8z2uvhqsTmWTHts9cG87AUX1wHT77hYM3LLEuMKV
         KOj3qT1t2+fiQ2SKDHK9npn0aF3mq7ZD0O8wrQC52tbY3ZexkcLsRWUqRCyrZBuPkNk7
         2e/m43g0/s9wG3bMtzyIX2i2ZP8sCX890VJ3nlaed77ltCGWPoR0HYgbl1pK/Y8hgufs
         IjTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785621676; x=1786226476;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=RmlziesBf0p1zLY+SBouFO3AuG9bJkIG3U4FWyI9lx8=;
        b=qmnN8i5qs3PVHSHihQoJ6Cie1Q6ZG0wAKvA2dPrkZTIP9NdGrKEjffvkkU2+SA9OPD
         KuZuyVFVoJGNo2j4dCiEoNzWzUHPVqOA7loml5JkqB/ovvwVGY4WO57RmYbufVDw+nvQ
         /2eLD+7JCZ5dYeOvtlptM7UzoiEsyNaObG1URDa2HzgxrsR3c6nNPW9jxFKnDRy1DSFN
         myNOdc9jOxclOrMTk9zbPTRNOMUd6UYVlipOj6OA765gLTFb3Nu4BmIgDTOovLwqWfhi
         KNS7l7B7NFhFHMcsBK8f1NR6BoBDrC1mf58PXw+90coQxMvRBhiCOgOvZB7VNbMU3Pgj
         TXWw==
X-Forwarded-Encrypted: i=1; AHgh+RprjAzlxTclzt38mh0hagO4Vt5Ignz/6FsUOENM2mIrqYtlS6WCRKn9RQJt905nBU5+NVqGiaVpZcALFNmY@vger.kernel.org
X-Gm-Message-State: AOJu0YwGOgvbdsIdQ4WEHQZFkTphRC8Z+vPF/cb3v+Pm8Sw1Km+PQxBI
	H1JttCMOmiv7gGFCHFpa6tS/ryx4XIfLhiB2o0Q/cE23+ztLiRq9ctca
X-Gm-Gg: AR+sD12jJ327dS3a71t+ES0YHaiP6B+/i5FB55EnsT9AwSiYtMQ46QKpXV+bbDsn5Q8
	PUSJTaQ80uxQimSAYUTIeZDtfBUsW7DpYyM5KZOGnE9u4VpHWtnKTYw+dccLcVCSdfK2KuSVagz
	OHi2UP6puFDhA3mIzro/lp8Q8zX0TyDOnBga9452eFah0PGKXZtURLl8//ENGkW8kB57GYQar7l
	hkinGoQGAqGx+subcckt7ddEJK9ZgcnxmzfwZbMQRMmrWTsX0zbGsNnOFA88RTMCOV94uPQvj8T
	rUwcqePuC7AFFyIBog4JLaaONJmo443ueNPbDW+GHAeGm1juCQCsqSOAcXRul1c2XOWUKHGa7en
	iPnw1RnaWMG8IkEQ4wnzMjFcPpE/pPgyanQqGQaNQjl45J0UoBlyqw9E6oU/B+yQoGPl8osDFr+
	z0Xsv9GrUu+6jt2PliOYkVzaq6unLJYxpdJaudk8ZUdAy7yIvJPt9ZYrCUmOjW97+UXSrOZ2Gn7
	omif8o=
X-Received: by 2002:a05:690c:6286:b0:80c:8d09:3880 with SMTP id 00721157ae682-81fd4a86754mr73431087b3.15.1785621676098;
        Sat, 01 Aug 2026 15:01:16 -0700 (PDT)
Received: from syssplab.cs.fiu.edu (nat1.cs.fiu.edu. [131.94.134.89])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81fcd0d6fbbsm29903767b3.25.2026.08.01.15.01.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Aug 2026 15:01:15 -0700 (PDT)
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
	linux-karma-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Chao Shi <coshi036@gmail.com>
Subject: [PATCH 05/19] buffer: discard BH_Write_EIO along with the rest of the buffer state
Date: Sat,  1 Aug 2026 18:00:49 -0400
Message-ID: <cc452f95db52e33ec00270b7e3a3dab892261014.1785621505.git.coshi036@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1785621505.git.coshi036@gmail.com>
References: <cover.1785621505.git.coshi036@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

discard_buffer() strips the state that describes where a buffer lives and
what has happened to it, because after an invalidate none of it applies any
more.  BH_Write_EIO belongs in that set for the same reason: it describes a
write of the data that is being thrown away.

Leaving it set means a buffer_head reused for a different block starts life
carrying somebody else's write error.  Like the bforget() change, this is
mostly theoretical today and becomes load bearing once the rest of the
series makes BH_Write_EIO the report of a failed metadata write.

Suggested-by: Jan Kara <jack@suse.cz>
Signed-off-by: Chao Shi <coshi036@gmail.com>
---
 fs/buffer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index 7889c30d8715..50a63d964815 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -1518,7 +1518,7 @@ EXPORT_SYMBOL(folio_set_bh);
 /* Bits that are cleared during an invalidate */
 #define BUFFER_FLAGS_DISCARD \
 	(1 << BH_Mapped | 1 << BH_New | 1 << BH_Req | \
-	 1 << BH_Delay | 1 << BH_Unwritten)
+	 1 << BH_Delay | 1 << BH_Unwritten | 1 << BH_Write_EIO)
 
 static void discard_buffer(struct buffer_head * bh)
 {
-- 
2.43.0

