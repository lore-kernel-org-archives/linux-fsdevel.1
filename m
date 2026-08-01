Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACC393859C2
	for <linux-fsdevel@vger.kernel.org>; Sat,  1 Aug 2026 22:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785621692; cv=none; b=ZNxh1tqQRx+GOIV3GoYld1jy3YY2pEyqS4srKyJjtcfd8ooPnF9c2zNeSly8mhaay2ifses1bxybfNm0ZTfG3TEd/dtqgkjaK+wnLo1SIt3FppJY1zFp1gKpZc6XZuBm1o0N/T18aFsx2aocVa4LjUBuFpnLGLeG8yQYgWwiVy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785621692; c=relaxed/simple;
	bh=8eaNHjlxdd2m/7vaM8HHzpWZ1ndxEHRbTTCO2KCwplQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LdcVUth1IcC3R2c6CXjQ7nuAo8SiGniwbxeJGV8W4t/80LEDKQlm/P27wmP/J2jK0CA9nd/t7qayyCwJTQ5P3h7IGThMn3v38NTVA/kAO8tgs5oHOQpoCltTGOwIkdYWlj+c+uFU29MoetHO/IgbyOUExtkcx3IPApEZ1+rgY2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yun8d6rU; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yun8d6rU"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-80dc4a68e4aso24229477b3.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 01 Aug 2026 15:01:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785621686; x=1786226486; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3pK8MlUvCqFzPv9m7RxaKBOJ8dELfs23G8cRNXDTowI=;
        b=Yun8d6rU0GoHZQcKyHCKysFS1cmF1+vOzb36IhO1iprimsJcB5E5iDw8v63y5vqL9b
         etNPkdTEm2nZfFCgJ9AIc+/vVJxP8roJGK9j2AXQilPM/2Cw2gDL2XdmBQtOUaV0sftj
         +rM0JHXCUz0P8wP2syNvzwrhjLipikksShz8Fo1f1Il703+AjjJAlQE8Dceo91k6cxbO
         QwKMnPaHb6dyxYmHOQVBOp2pwUEhHARdJroXbUAQ8UWKSSnj6IJihONCyXuBWozTaAxg
         bNWrQZjA+C+eEaOxdxtb8D8Aj+zV+DseLbs8obh7rIc6EsdLqJjFjnVQP8t583vhk8OZ
         Yx2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785621686; x=1786226486;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=3pK8MlUvCqFzPv9m7RxaKBOJ8dELfs23G8cRNXDTowI=;
        b=ewZt1/3zHb03Jo72cJ3Gsqlyv6ArHLpKIJWAdLczNHM+p8opApPFH6fnEz5P8Gz0os
         8TGsmshrPI3b2Jwp1gpmWO+52cBgSzyEv6JFAkx6sA9pF4yDdmmcxD7vEw3ya+dVaups
         xrnf+EzK1UsacjslpIIG5IIO8i7VZvV0H0ye61agmP6XDbYUG5/GfbU2larKrarNIRq1
         nI8Yfra8glmiz38NRDYE56R1tPg4wPljpg+ZHg2uUtdPssDwvSA8L2KoCndyabqC57O8
         sBKQPmNAB31ZraSTD04snSL5H/JmHGr6MT1Rw8JE2PfepeS23IDJTRkL6KUCYEFxy/PY
         112g==
X-Forwarded-Encrypted: i=1; AHgh+RoyByeUULu6Qz77afYIF4sid28gfPeCfR8Rkns5+2pckKjkwxlMTWPdjNlEaSBh73G27xFh2N23szY2Cza3@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2adlPppmZZq5tLyZjqagwW8L5CLUD2gfbvtZ0/oJBFn4QjcvL
	Tq88g/FFQS1lr8hmzWIn1DUVww3vekL6f51UpPK+paiyRbPn2+q74hxq
X-Gm-Gg: AR+sD12WweBzTUcSDmLe5/Ixu41e6klBTM1EeMrvdNSDbyuXuf+qlq8XM3s6eu5t5wS
	1V1RD7wcfRRnGvKZ4RDANA4mgLVKb2WIAKr7kfqzZ9Vg8vOEiDp6UsDA3pH9PNMmcydfO4+PIa4
	4pEcHZdYKhN+ZqqoJvuABsPrmY3oIIrlF28U+MjZgk032MuB85n0C6PAnm6vf9WsWs052lf0WfG
	cacXgN1CBelPZbzSvGArErJa4uynG9PcLYfTjExFAZi5J1nT5hzo2liCpVWJu21h1CQdzvq5Q1V
	Nce69IpzU5eVMWKhvZgc/K2QFQnYJhanWJBCyuCm2AkrMTiOXN67AOOBJepojYykIFFOIUAFz+q
	q0WSW6BbD/p1jJ87kYUK15uviG9F2ZPR9757v4I6Yjog2hKtu8Ak992YhLehw6uq3QwNDmt26tk
	5cfejbBEBa6uQDY5tXzTMbx0MnoRA39H5Td9LexqXGc8toTsV584HSnolv6hk0BXjpZvM7EvJh6
	nXj+j8=
X-Received: by 2002:a05:690c:6f10:b0:80e:5236:b930 with SMTP id 00721157ae682-81fd4c9064cmr74857937b3.36.1785621685651;
        Sat, 01 Aug 2026 15:01:25 -0700 (PDT)
Received: from syssplab.cs.fiu.edu (nat1.cs.fiu.edu. [131.94.134.89])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81fcd0d6fbbsm29903767b3.25.2026.08.01.15.01.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Aug 2026 15:01:24 -0700 (PDT)
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
Subject: [PATCH 11/19] fat: check for a metadata write error with buffer_write_io_error()
Date: Sat,  1 Aug 2026 18:00:55 -0400
Message-ID: <202c109fe73ff6899235aab9dc19ba15eeda0d5d.1785621505.git.coshi036@gmail.com>
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

fat_sync_bhs() waits for the writes it issued and then tests
!buffer_uptodate() to find the ones that failed.  That relies on the write
completion handler clearing BH_Uptodate on error, which this series
removes: a buffer whose write failed still holds the data the filesystem
asked to be written, so declaring it not up to date is wrong and makes
callers re-read it.

Test BH_Write_EIO, which is what the completion handler sets and what this
code actually wants to know.

No behaviour change today - a failed write sets BH_Write_EIO and clears
BH_Uptodate together.  It stops being a no-op at the end of the series,
where the new test is the one that still works.

Signed-off-by: Chao Shi <coshi036@gmail.com>
---
 fs/fat/misc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/fat/misc.c b/fs/fat/misc.c
index be18f6b5819b..4a4cd0111e47 100644
--- a/fs/fat/misc.c
+++ b/fs/fat/misc.c
@@ -356,7 +356,7 @@ int fat_sync_bhs(struct buffer_head **bhs, int nr_bhs)
 
 	for (i = 0; i < nr_bhs; i++) {
 		wait_on_buffer(bhs[i]);
-		if (!err && !buffer_uptodate(bhs[i]))
+		if (!err && buffer_write_io_error(bhs[i]))
 			err = -EIO;
 	}
 	return err;
-- 
2.43.0

