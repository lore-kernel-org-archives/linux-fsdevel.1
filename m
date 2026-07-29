Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 748FD3A545E
	for <linux-fsdevel@vger.kernel.org>; Wed, 29 Jul 2026 19:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785353394; cv=none; b=OdLKfMTggreWw75VmtcJXF55ourZYf9MHFVcZ8yd/8Nj028VQuhEihCV60GYR7sv7DfsNycj67lfiA6eUxp4441YpaG7ONq60dZ99gO6hcei8ap5NCYBSrLOLlN948oy6U9+gUST1jGZO6+yDHven5SPYXAvNDOcKXXlw18GO08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785353394; c=relaxed/simple;
	bh=Vp11QT/0XbYaCBpKeV6yIhKanTWoDvDmVvwl/BDJxK4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j3PF5trnBEpW06mdVjiru9Bm61JXXgxXpC/YIGGK9uy6liGhpv5mLrmCGECX+YXv/xSyBEfBqSDsPT0QbK7TXkTzT9pSORcrIMe6LDb4OEZCIW7S3eTAQRg2uCaUIPhjgF48+jz57evKgWAVlw6jIaCG3wd68hiB8SVc9FoVv4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VAwL+yC0; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VAwL+yC0"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2ced3386430so13763125ad.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Jul 2026 12:29:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785353384; x=1785958184; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cmSJR2GgSO3TGzDFe0h5lMf1baXvMm5mznLJAPlA6WE=;
        b=VAwL+yC0Ued8kqFGT4RC3I6wmsQ2jkVi3Ck0RZdurA3JRvbocqjhecMiYUdLeDBj4s
         tgxnFF6CILfsBIg/fuKVzCOwKO+H6/6IcIiS7GhF+6FSrGDQqOFwS6FhUZ14S74fgDbi
         gYK1jF+EVtzFg32rIzJZBD269CR141PdV+BF8rUG7oIU14/Q+xMWErQAeoR8k9fTP4LH
         b0tzELOvzKJO5Ymud+8lqEfS0xuc4y/RAUv0LwgUhB5HzlvWnSQ0h5H3hoJXxJQEPfhR
         CAcx0WQPTM6UGd2MigXxUL5JlEAxFUA1/oOlihKQAwi1C+Wk1gn+WigNDlsWFnvMT/Up
         rJSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785353384; x=1785958184;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=cmSJR2GgSO3TGzDFe0h5lMf1baXvMm5mznLJAPlA6WE=;
        b=ntlkbIOM38nCUxj97sy89jPN8sgWywUQFiP1Agj9lr+aDVDWzM2+d3/E9zPxaaBH0H
         TD1V87wxpouhH7iDs1bRJeAMn6J4vzkl0pgrDk+iUwi2qKgKaIAug6dSBf/4GfPoAGus
         +EMjQU3f474XhA5m0yOHZuAA4jKVhS5ki43jT0W4Hm44jC3QEdpY3NI3b6+mOZ3c41Uv
         UoBz4S/8wyFwsKH7b6eR6XGacgYz718Wh41AEBFPYFFAiCWNovWtm6+qadkomVMhVWGf
         Ic5+Vy0uC37F7EnwztDyDttycGxj1VbXn2ZVP4Gl64qImnfnJ1FOwVlefnKi68hu26cq
         Jh7A==
X-Forwarded-Encrypted: i=1; AHgh+RrLVkNlFFBp0sVh1itZgnaLVeF2fub1KEpK99pDHId4GkuRxGpHgqPYkj7eW4O+mb9mfKW8VEmxtAiKZtX3@vger.kernel.org
X-Gm-Message-State: AOJu0YyOmlG8uk28JTC1DgF0TGJkVjcHlPHCPVFWAImuU7Lt4BVS97ZR
	dS3hN4RyNtzPMYVa7ZZN82xH3E90fm1PnsPJycyfDtU+i2lDgDWzq3GJ
X-Gm-Gg: AR+sD12SP+uqwZN3k4sC3ZHj+J+jUnm3UXJEnlkhgj1DPvXK5Lba9mx6dbK9ZMbgpns
	FeYnBuw6wFEgmulAF6lFyvid+CbRqY/IK76DsTdIEmITACLuUKKZ3kT8m5whyLM62A0Jl7Uk2GC
	L636klllhZIsXBKIJcLUkssYDYutqstCS9u6oObPaDPYQsBkHLEffT1Qffpw1GLxp9W9zlCKUdj
	MjPqeT4c3KcBFjeoN/2v/oCaoav0bOPLAdDEWQXmeWM+InVBmtChDZNfTjpaqM1LdhiBVRidFgn
	R32DOFcTYNFZsmL1kqS1WsAwSPdu2Elu0GLfM2SomuxYBNT9O+AwjWdFi/OMz/BhOVdPSL8WntX
	78znvPQXnN8U4nXaNDG2yjbFOjUfr2RUVs+Qa6ASuoZOQW4zWAWNh2V0Vapy+45YpaZYzBYI21I
	WQB3cyTe3tQKRV3dPddeIUzbkGlcakshhden00Btt4lXP5kL70s6aDnkeofqzy03nAsfpg8znAY
	kNKzKoUp8wavaF6olVFY2vJKfvCQDh25Vgbvyw=
X-Received: by 2002:a17:902:e845:b0:2ca:9ab:e725 with SMTP id d9443c01a7336-2d033994b84mr1930845ad.1.1785353383967;
        Wed, 29 Jul 2026 12:29:43 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:6::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d022a18abasm16069385ad.5.2026.07.29.12.29.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 12:29:43 -0700 (PDT)
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
	linux-xfs@vger.kernel.org,
	Sashiko <sashiko-bot@kernel.org>
Subject: [PATCH v5 01/22] iomap: release the folio batch on iomap callback failures
Date: Wed, 29 Jul 2026 12:27:16 -0700
Message-ID: <20260729192737.3190206-2-joannelkoong@gmail.com>
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

From: Brian Foster <bfoster@redhat.com>

A sashiko review of an unrelated patch points out that the folio
batch mechanism used for iomap zero range fails to release the batch
in a couple error scenarios. If either calls to ->iomap_end() or
->iomap_begin() fail, the direct return paths bypass the batch
cleanup.

The ->iomap_end() case is not a practical issue at the moment
because there is no user of the mechanism that returns an error from
this path. The ->iomap_begin() case is theoretically possible
because XFS can invoke the fill helper and error out at various
points thereafter. This subtly complicates things because XFS does
not transfer iomap_flags to the iomap data structure in the error
path.

To deal with both of these issues, first make sure to invoke the
cleanup helper in the error path for either fs callback. Second,
update the helper to clear the flag unconditionally and release the
batch so long as it is populated. This more clearly delineates the
purpose of the flag to control the I/O path and not necessarily the
status of the fbatch, so add a comment around this as well.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Assisted-by: LLM
Fixes: 395ed1ef0012 ("iomap: optional zero range dirty folio processing")
Signed-off-by: Brian Foster <bfoster@redhat.com>
---
 fs/iomap/iter.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/fs/iomap/iter.c b/fs/iomap/iter.c
index e4a29829591a..63617ec48250 100644
--- a/fs/iomap/iter.c
+++ b/fs/iomap/iter.c
@@ -6,12 +6,18 @@
 #include <linux/iomap.h>
 #include "trace.h"
 
+/*
+ * Release the iter folio batch. Note that the iomap flag is meant to control
+ * the I/O path for the mapping and may not be set in error situations.
+ */
 static inline void iomap_iter_clean_fbatch(struct iomap_iter *iter)
 {
-	if (iter->iomap.flags & IOMAP_F_FOLIO_BATCH) {
+	if (!iter->fbatch)
+		return;
+	iter->iomap.flags &= ~IOMAP_F_FOLIO_BATCH;
+	if (folio_batch_count(iter->fbatch)) {
 		folio_batch_release(iter->fbatch);
 		folio_batch_reinit(iter->fbatch);
-		iter->iomap.flags &= ~IOMAP_F_FOLIO_BATCH;
 	}
 }
 
@@ -79,7 +85,7 @@ int iomap_iter(struct iomap_iter *iter, const struct iomap_ops *ops)
 						  olen),
 				advanced, iter->flags, &iter->iomap);
 		if (ret < 0 && !advanced)
-			return ret;
+			goto error;
 	}
 
 	/* detect old return semantics where this would advance */
@@ -110,7 +116,11 @@ int iomap_iter(struct iomap_iter *iter, const struct iomap_ops *ops)
 	ret = ops->iomap_begin(iter->inode, iter->pos, iter->len, iter->flags,
 			       &iter->iomap, &iter->srcmap);
 	if (ret < 0)
-		return ret;
+		goto error;
 	iomap_iter_done(iter);
 	return 1;
+
+error:
+	iomap_iter_clean_fbatch(iter);
+	return ret;
 }
-- 
2.52.0

