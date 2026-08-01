Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A80330FC03
	for <linux-fsdevel@vger.kernel.org>; Sat,  1 Aug 2026 22:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785621680; cv=none; b=GajUDXHpFFbNNxuyS/pi8lyvEgTfn8uZLHmW8E8Vx4/plf4q+7jxv4eIqhNVCaJ4B6MYSc1c6KT5Lm6ExEcFzEWMCRwECxIW377W3MTbzjTxNEVfVbmZKA4MS5EoqASE/FQNmdnSCoWiWB7Yet4vFpVOtHdU1SAC+trwEj20qcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785621680; c=relaxed/simple;
	bh=0vTXRoH3hdLZk9GtOk2DqiSHrzqM0Eca0oDK4MAlmLs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H4VnKKlqb5p5jkIpKyoN4aV+oWCGZkQnXNBTvetuz+pK3LfDbG7meUMYorPemOtlBqB4CKvGjkkGJqrOuomcIHdCtpCvFDoopUSEKDi7HDxh5nEj1QWHO6y65Ltrj7FdLfaFpM4rz/SP+6J/M4ZENid4gRO6od9vxKvnSz/Ggqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pY4wVshl; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pY4wVshl"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-81ef8255cccso28402997b3.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 01 Aug 2026 15:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785621674; x=1786226474; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TKbaZIzhd+ZroWBcz7LzJbdFmiCbzToVe0S18iQ99Z0=;
        b=pY4wVshlZkkdWFCJqjaJcVP/epbFWkKWUHRSyLSN4aI7i1IyFUJv8sjGg7c6/tPv86
         guMwyMDTwjrkhLZe1bY/StOX4aP2nkbWZEHe4XLU5MbsL5xqaiBx76A/sMlSwEbQldXG
         UX7+7TWBBf65gTlD1T+o1br2ChtsVUtTCuql22cWoyFIhFD5yr2J+4LOenoXvqXVigQ/
         rT8iqYsLovFCn8j4oU9+nyw0gqmxTnBBbFMnDsOM2OSdellEjlNAwWben7kHwxqjrBWz
         G1WHdtfXl2UaU9du7/odkYLaYA40hWc7a8e1gAvieG47ybUuLgs/TaNXXzkC1XJIX7FM
         65yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785621674; x=1786226474;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=TKbaZIzhd+ZroWBcz7LzJbdFmiCbzToVe0S18iQ99Z0=;
        b=R7tRMBJysArDsWpgB+s3XdbV3k31l+LvLVP1+IbaV5eAw8YencNw+imy4pmz26Bo3s
         o6g8qREpYU66Zxs0limZFVlknjg91OleUPoCKv99T8NVtq9kTMBUgurtoq3VFgLn7HFa
         PoO4oB2iWsHLNpXUO1VXaCp2oEGa6uya8zOnv7LWJNaXLB33f9yBexrVfzr6eb5ZX4D0
         sKN32bEpru7UdOS/OKtAPY2mUsX8PCmozgb392HGMrRBfpQLzTCT069OcHfL8f3bJkU0
         knhs4trjHP9pOLLuI5EJXDYnR0NgUaupbNgOAiY/5iiodaxuZAaDnVkEK+uGrl3vGh+7
         wp5Q==
X-Forwarded-Encrypted: i=1; AHgh+RrreuRGZIkkuMKCzthtKCnEuVcyPLdVLXV1s30YZPa4KwHjd2LJc+Y//IY9g+wgP2OeA0qObqM5slgTLyeX@vger.kernel.org
X-Gm-Message-State: AOJu0YwKzIp999yuGcZ1uQoKp6Ykhkm2BcfN80sBHpW3W5B6feFCO+Q4
	c2Ok6Ec03dx1JAd0ht+3L5TYbJm6c4dzq6B76SiJpl9/LJ9gopqWM/4D2Ai1KGyoEwU=
X-Gm-Gg: AR+sD11gXtKwthsUY9TmqY6y762I8AIE5qhdkUvL39k87TZuqGWd7EpmYdv5zKzjG/l
	Dyn79Ft7tc0d6nUODx8T3A2ALuOvX29+L7mqVXXfwrXI4uK565Fxuys0FvwrKE0gUc9op2r6Kfc
	5+7Z+GdSw/3WJyiepUxihfLoVq2DEi1g2FxV+vD1lL6TaI7ibUMqZs6x9vwQ6q1zdLH2i6TafX7
	j3GvRqfPEs9ppNs4bx9qCtNNZ8NNdFa/V/d3xwv3+Sykg/u7K4RBz8ZtsnbgQRlLwHEbwdsg2yH
	mFs5xSKKRnYGC3N+CMOkknJgUlazuQJzjtwjep+7bsV09+PkOokGcVVzCercUBjNxQHK0+P2TxJ
	9HClrAYqmgcPyIYgNZlCkYCmTH05AM/yc4vHQuVn6ImpYjTNicSIMROe87+Cy0wyLOeecSTI+vL
	BUIoXENyF1k8Zmjzur7mKmCEJFRu0fQeLGeOd2bEd8Pwe1N+uNzZAPV8uCPUubOXabs0GnF/uKB
	KT4hO4=
X-Received: by 2002:a05:690c:dc2:b0:81e:c7d2:f26 with SMTP id 00721157ae682-81fd49cae43mr67970467b3.6.1785621673554;
        Sat, 01 Aug 2026 15:01:13 -0700 (PDT)
Received: from syssplab.cs.fiu.edu (nat1.cs.fiu.edu. [131.94.134.89])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81fcd0d6fbbsm29903767b3.25.2026.08.01.15.01.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Aug 2026 15:01:12 -0700 (PDT)
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
Subject: [PATCH 04/19] buffer: clear BH_Write_EIO when a buffer is forgotten
Date: Sat,  1 Aug 2026 18:00:48 -0400
Message-ID: <1bf058fd5867bceeede78d99844b49a26ed6f3c5.1785621505.git.coshi036@gmail.com>
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

BH_Write_EIO records that the last write of this buffer failed.  It is
cleared when the buffer is submitted for write again - see the
test_set_buffer_req() check in __bh_submit() - but a filesystem freeing a
metadata block never submits it again.  It calls bforget() and hands the
block back to the allocator, so the flag outlives the block it refers to.

That does not matter much today, because the write error is also recorded
by clearing BH_Uptodate and the buffer is discarded soon after.  It starts
to matter in the rest of this series, which stops clearing BH_Uptodate on
write error and makes BH_Write_EIO the way a failed metadata write is
reported.

bforget() is where a filesystem says it no longer cares about this
buffer's contents, so clear the error there alongside the dirty flag.

Suggested-by: Jan Kara <jack@suse.cz>
Signed-off-by: Chao Shi <coshi036@gmail.com>
---
 fs/buffer.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/buffer.c b/fs/buffer.c
index 04fcc34e4fa6..7889c30d8715 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -1091,6 +1091,7 @@ EXPORT_SYMBOL(__brelse);
 void __bforget(struct buffer_head *bh)
 {
 	clear_buffer_dirty(bh);
+	clear_buffer_write_io_error(bh);
 	remove_assoc_queue(bh);
 	__brelse(bh);
 }
-- 
2.43.0

