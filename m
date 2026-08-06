Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4DD1483828
	for <linux-fsdevel@vger.kernel.org>; Thu,  6 Aug 2026 16:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786035572; cv=none; b=JvGHp3321IGlR6m2nS5nODvTZm6Bb1EJ7tFix8b9Kmfvi9DAFgKVC7u4KMjRyY+rW23c1F67qfXlEXUWH1xR8+C5E+l6M1s992z3mlUfh1GEveTPU2doMdDLGug47i/qX7NJm01vA884ct7HRQyuM7oDhQBew9LHGxibqMgMaoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786035572; c=relaxed/simple;
	bh=XCQvARYs03Jg6cCkHO2H308pJ7dd7LthVfdbsY3TGbk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jrjv7jsXMbK9zHS65qlgtTwSoP672hdP4LKqyTrMm08knp5XTuZLnW/PQ+v+KPjvlcLzNS+8Ixg7yLLnM3MzoL9kaC/jlxRu4pp0c3Xcnm9XqY0YrM1Zf8uK+x3Kc7olJbPTxez2zJu3Vug3fmN0Te+XwWGJL2AWL5TR1AaT694=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=p3w7NRw3; arc=none smtp.client-ip=209.85.221.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p3w7NRw3"
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-5c2dbaf828eso857925e0c.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 06 Aug 2026 09:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786035570; x=1786640370; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=W/UkvZ9btqQ9UcKZM3gfiOG/tPkCxSDzu5UxeQemPOo=;
        b=p3w7NRw3KIrR80GcScsOy40s/lALyhTKudwesZMfKknNR8x1gXe5vHuVU9hYF1ivv2
         602Siw/IvGzD55HABAY9E5VZdSrcuK9FRtmtf5zQn5vJIPR1ly4rUvKrjhQ4Ahp5wIqj
         j2gLgFQgAMDgCS7dwgC70Mua1Ykq8G3ffD/IyyMXXcDfkD91iYLNUdltKI2kDlX2Oy8S
         NB83SAxhmYB+KCu79bFrerlpRiN/gNyVoHYpub+SIX+s7wgVgnmF68y4lbGEs320s0yk
         AaAjsSOEbkWaOuDjYG9AsM6JUBT6L1kNvppiOafOzx8encGz0caVWk2TOT9W187BhzwJ
         xZxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786035570; x=1786640370;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=W/UkvZ9btqQ9UcKZM3gfiOG/tPkCxSDzu5UxeQemPOo=;
        b=DEnQf4e0bgJHycGsoCsVLUm8MPviHNeDG8jpYz+xn6Vo0KVNecYTPkyWiga+F5mDMr
         26PBl3nfSQYTUmoYt5aDHpPljErp6wFA1tjxZqm5n5h+b06RAVxwgtOD48O9j0Vxru7R
         JGOiqgMhYHc00eQW5hTvEYKqJqPBSzWN07e3AlCFEJVaBpYV7j4fswM9tRX9fAXH9jA9
         ncCDfTSU6/BKDHyfQPpMi6wOBDKrqxstugz/n1WctCDPpnDkuO6p3Cax86xCBVYYt9Bh
         k9tDoYneHKP2H5UKwnEkdEG5pLOAo1CfL7gRojCasRiM3lPynOKvd+bKV40hZvZS+Umq
         CQUQ==
X-Forwarded-Encrypted: i=1; AHgh+Ro2N2Hlq4cfxffmM8+RIMk4Ue0YWJ8edmZfBHSXSYMuWucIRewhOWRCXIQ0pGVF0J5NcqWXTVdMjgg0ogM9@vger.kernel.org
X-Gm-Message-State: AOJu0YzK7w/crz75R5yCoTHMRSuCz08i1Vddfk+QqFmxXvOlP9WnykBD
	ltd2La0AYFF4w8z0i8VW9mw7GDoj1uAy5HtNQS61Fy1au61Xe5tSZAPs
X-Gm-Gg: AR+sD13YukNzVUEa81U5IS/E4gCYnqR7FvPOP45zYJRBfOV/2oBjHcbDvZ66GNDK9cO
	ZYTd/x9D4QTAPc8QTvCKjBJ94TByg6yNxl7PvYIKUqXcL+TkDdJn9Pomwt/bmJwZ57qkvBaZ+GE
	FoZqXveYaolfgzB2bWEJ90Srh7u2HdegI7j3Vp9lh8Emu3CPb6wlLhgB6uNiYSeVPBUPQfgTV5t
	eDm8Fl+ErRJzGN3QedNe1H7jG42jc+/sSYyGst7rcpky5xI1PX7RHFMxuyTStaetUPPkxLlTCUw
	mAb8VbwFdYoXoBhZzDdvABZFcH/OOUs/teRvFuSqFj6thEmscdZkuIGl7czOmMggYZsjMwTFeGL
	m+naLhajZ6e7Yw6+OcnldNwKKYULPJUer81aO1dyJmEnL8oA6T+eRbF0o2aq8zXzB2ktplV/bji
	GD9pOKtX3D2MjTvTyM8tf2b872M+6aQ4emswl0AjrMkiLnm8b4H+YRg/fS7Fqx39wiuog1bQgJK
	59pZq+VlpnEbPA/HQ==
X-Received: by 2002:a05:6122:e248:b0:5bf:9bd1:791 with SMTP id 71dfb90a1353d-5c3d912095cmr2047468e0c.1.1786035569648;
        Thu, 06 Aug 2026 09:59:29 -0700 (PDT)
Received: from syssplab.cs.fiu.edu (nat1.cs.fiu.edu. [131.94.134.89])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5c3d05c594fsm3706321e0c.8.2026.08.06.09.59.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 09:59:29 -0700 (PDT)
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
Subject: [PATCH v2 08/21] adfs: check for a directory write error with buffer_write_io_error()
Date: Thu,  6 Aug 2026 12:58:31 -0400
Message-ID: <05cf8ad911ad7a6eb68f42e38f1eea39c38e246b.1785951556.git.coshi036@gmail.com>
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

adfs_dir_sync() spots a failed write by testing BH_Req together with
!BH_Uptodate.  That relies on the write completion handler clearing
BH_Uptodate on error, which this series removes: a buffer whose write
failed still holds the data the filesystem asked to be written, so
declaring it not up to date is wrong and makes callers re-read it.

BH_Write_EIO says exactly what this code wants to know, and it implies
BH_Req, so the pair collapses into one test.

No behaviour change today - a failed write sets BH_Write_EIO and clears
BH_Uptodate together.  It stops being a no-op at the end of the series,
where the new test is the one that still works.

Acked-by: Weidong Zhu <weizhu@fiu.edu>
Signed-off-by: Chao Shi <coshi036@gmail.com>
---
 fs/adfs/dir.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/adfs/dir.c b/fs/adfs/dir.c
index 11afa9e157aa..b8cc6a697a05 100644
--- a/fs/adfs/dir.c
+++ b/fs/adfs/dir.c
@@ -191,7 +191,7 @@ static int adfs_dir_sync(struct adfs_dir *dir)
 	for (i = dir->nr_buffers - 1; i >= 0; i--) {
 		struct buffer_head *bh = dir->bhs[i];
 		sync_dirty_buffer(bh);
-		if (buffer_req(bh) && !buffer_uptodate(bh))
+		if (buffer_write_io_error(bh))
 			err = -EIO;
 	}
 
-- 
2.43.0

