Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04E3A37E5CD
	for <linux-fsdevel@vger.kernel.org>; Mon, 20 Jul 2026 21:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784581353; cv=none; b=YbFZztkE+ZfH5Y0noHancKVSBAqzwgY4Vkk0g6sxoGFhV7bvIQuQMH+OtM4UfUVv8q74iU/wARh4gMR2Uv8kgZhXFV+QIANJgAyyVCmGvo6FjUEPo+MFtanppZ7+ndeTPXs/1tiSEdBQE9ttrfzj4ZCAIjF31F9bGnCFWk0QTpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784581353; c=relaxed/simple;
	bh=rUAOU3IydJmQYweh2Ff4mzFaQjYgFYXBQUGY5Kg74Z8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LN3LJTsWyuop73O7eYmrAmdV2OcF8uzncHc7ZrV3b/cNQFN87noDr/8kYSUz7OG/5exwlbGte57jt5O9ntYAGPrcOgXHN7NaY05hpnFHTVsDyEBqwNzyIG4d+w49OEiJXVLAIikVEaH9O9xC12jsxQiESc7c8dVpBJDHA8gvgBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ao5JGXz8; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ao5JGXz8"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-8453427d3f4so9785628b3a.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Jul 2026 14:02:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784581351; x=1785186151; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4S5rDCc1of8MfqKGvH0/SP90Wdz9xuZW0t7RbrAbJlA=;
        b=Ao5JGXz8fdHCs+7eJOc5+OFyUqyZk0HBxxTx0j3dXdBfI0SNUnvD5/pDbhPUVEWT0a
         8U6KIAyU8S37EAA6ZLYx87Rznusq62uMzqpYPzQ11erggYiojoloMlCMcJxfcl1of+6Z
         Z2gqC0FwjLo/52B1q8cFd/g4rAl+CHmeST+6ueflwSEGwEbvpXgxZZDNAB2QrZf2owtF
         q3AA90stYY5MqcYbip/uCXWdf0rPkL3v5BEYDu5R0W4f6xlayDRtzSJWckek1DJP7IAk
         PXVl6d0ma29pGHTdNiiYM2f42WYMKvVY+zaAbuplGd98dEmcDenW8EHr6O6ONK5ZWle3
         Dd6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784581351; x=1785186151;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=4S5rDCc1of8MfqKGvH0/SP90Wdz9xuZW0t7RbrAbJlA=;
        b=DZ5CFjjVg6lve+76BIcoJTM3zJITQRMee+IPyHXCvbttul+dW6qh8bfAbWLts/SeT2
         nKr5yyWaTzIT+Ri8JzFlhlLWBKhklmMHqSStmCIbYgAUlwZAaPzfF2OSlV5yeq6XvRvY
         orIPCVLdxVKNN+N9ngoW96hpy8CUPPRTFP07IGIH1cPl+aoTjbV13F4rmkgchKx2MscI
         W6PhxMjLDL1BiJ733OQg3A2Kp1xo2QZ2APnyait7roiNPWwIf+X8G60CU0J7E41TrMyc
         8gMF1/p+Yj/DcummADQBi3QUPjvizBT5NCyzuDNnXdM5pxVZUYQjqjg13jnNIEfFCMTu
         RdTw==
X-Forwarded-Encrypted: i=1; AHgh+RpZnM4d5WVAPWjgnIlyHb3B8iL+6zmqeCkMaLysEUWLjOAmPYCP88iNUwPUkYg2FWtvZX8hJkgtceqwh6El@vger.kernel.org
X-Gm-Message-State: AOJu0YxEQ9x6a7tRS7vCPMkBv++uFEqvY/X4g+dHgL/x2Hv/BJuiNDRD
	PXdr70OGvnvUS6CpHTtAhyoCmlnyVqR+gZGN6vmxyo75KG9yJwjxxpFp
X-Gm-Gg: AfdE7cmqZmiUEQpjTNAI/6MN+7cTpxp+gA+2fVjC5pvAm6Z7eZ4Ok+vQr4nrbWmFZw/
	7Ca0jyjYkqa7PeDmT80j5yefgvdr4slH3rNmHB5dYWeVFSO0b+spFYvW2tyfT42IHjJDNKcUANS
	gTna51jaLpndr0s1m7+N7mJ2Dv8qiP5fBk7ejTLYigzKpqn0m21QQlQEQfZmwRv6S/zsGqOq4DE
	mKrMtlvwd2UfRyso7M9Ir4p2+YIag2LBD08TSRv3k46gNfxwGW2QuMJ2C3PkHfMb3vA+413Fk8x
	T1HVDTd+LNLGu+/N0IJ29/i2H9cS+s/tmCfzF0WwTvvqdkeojNjdxNOtysla4pgiLksUH4pMmI5
	ub72kgRAo1wGFcdbKlujUtBfHdni8yGBs2v7+oP5Hm2hlQfy/SFQkNM9DL1YUby0M72B9Aalk/H
	P7tc+GnRjZeakeovI1N1GGkvuG1lPpuJD7+lfu26EG+DO/JCD9FqyFKA==
X-Received: by 2002:a05:6a00:17a0:b0:842:706e:ad43 with SMTP id d2e1a72fcca58-84c292ef527mr15686608b3a.33.1784581351200;
        Mon, 20 Jul 2026 14:02:31 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:47::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84c2abe3e23sm6215424b3a.0.2026.07.20.14.02.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 14:02:30 -0700 (PDT)
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
	Damien Le Moal <dlemoal@kernel.org>,
	Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH v3 09/20] erofs: convert iomap ops to ->iomap_next()
Date: Mon, 20 Jul 2026 14:01:51 -0700
Message-ID: <20260720210202.1163861-10-joannelkoong@gmail.com>
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

Convert erofs iomap_ops to the new ->iomap_next() callback. Each
callback is generated with the DEFINE_IOMAP_ITER_NEXT() and
DEFINE_IOMAP_ITER_NEXT_END() macros, which wrap the iomap_iter_next()
helper to finish the previous mapping if needed and produce the next
one. No functional changes are intended.

Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>
Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 fs/erofs/data.c | 6 ++++--
 fs/erofs/zmap.c | 5 ++++-
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/fs/erofs/data.c b/fs/erofs/data.c
index 9aa48c8d67d1..d2f01245ee79 100644
--- a/fs/erofs/data.c
+++ b/fs/erofs/data.c
@@ -380,9 +380,11 @@ static int erofs_iomap_end(struct inode *inode, loff_t pos, loff_t length,
 	return written;
 }
 
+static DEFINE_IOMAP_ITER_NEXT_END(erofs_iomap_next, erofs_iomap_begin,
+				  erofs_iomap_end);
+
 static const struct iomap_ops erofs_iomap_ops = {
-	.iomap_begin = erofs_iomap_begin,
-	.iomap_end = erofs_iomap_end,
+	.iomap_next = erofs_iomap_next,
 };
 
 int erofs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
diff --git a/fs/erofs/zmap.c b/fs/erofs/zmap.c
index bab521613552..3966b62a7051 100644
--- a/fs/erofs/zmap.c
+++ b/fs/erofs/zmap.c
@@ -821,6 +821,9 @@ static int z_erofs_iomap_begin_report(struct inode *inode, loff_t offset,
 	return 0;
 }
 
+static DEFINE_IOMAP_ITER_NEXT(z_erofs_iomap_next_report,
+			      z_erofs_iomap_begin_report);
+
 const struct iomap_ops z_erofs_iomap_report_ops = {
-	.iomap_begin = z_erofs_iomap_begin_report,
+	.iomap_next = z_erofs_iomap_next_report,
 };
-- 
2.52.0

