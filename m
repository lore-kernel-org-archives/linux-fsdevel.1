Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74A91175A72
	for <linux-fsdevel@vger.kernel.org>; Wed,  1 Jul 2026 00:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782864691; cv=none; b=We2p+RaS97qZBDGo/uGVn82U9wfSSnE0dnkNZ2MZOWzk3WHQKPFCippkCpNRLQHI3FQfUjGWbcNQqSjC0SqSBCl67Kwa9lBJyLBcU2mhe5JalZIki0OqbgPgELfhYzaHAHdHWXf/v1nEQ4XjFq7RWVB3uvaAEpkVo4xAl88rUvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782864691; c=relaxed/simple;
	bh=lARvSuawiV3hPRfc+1WuShqKRb08isXcI3sp8qVKngU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OjR79hzLjQ1ArSi7BbCky/R4i93tKoXoRI6r4L2pYtUwPGjHU3QOQpr5mcvpPR03819rNAn626SDwquh4G2bEooy3ioXHqiP7pH8zupgsynKsOFQeHRV9YCFvb+0+7dTcFQkR52NyJ4MQeIR8dgJFMTwBZMMaB0SomrJJwlb8hA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N2XhwIbv; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N2XhwIbv"
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-7ea9c6ea7deso64620a34.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 30 Jun 2026 17:11:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782864689; x=1783469489; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4vqoaRZS+wir94bOkLTsUmkUx9RZ3pvp4I8Lfye5kj8=;
        b=N2XhwIbv5/LkGpvbqeXTFR8WtnPhKbdxxYQPQaJM1wnUGM7gmUrxMXe57L3bYJDxj5
         wRvfAm2xx8JeOaRIEkY5iwMZXF/zdOrFz0YcO7xiJ1FaVHwEUSJLoILUadDEMuLZAObn
         FDXguekBaBg+0xvN/u6JDkWnYVwk+nxziOdqs7pjmaD5WReAcfV+v78NwNkE89duErbO
         5HIRtnIrRG4+UVsB0AgQENiHiiFDT5TAXYBSZ8CCB15FblejW1n6+xHquuv76UvqOlcD
         SmTNkrJUXilkG7d4TePJ9D0oVOk8kN35pKQ2g6DESC+0rAsrr96mQFmUpwvY+x1HIebj
         +wzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782864689; x=1783469489;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4vqoaRZS+wir94bOkLTsUmkUx9RZ3pvp4I8Lfye5kj8=;
        b=K+RArwL5Dz8YpJDAIRj22XW0S+g6LHBB44avI2Gdu2fXL/tEZiutfvteM773OFJ2ux
         JmNL+0erOwoYudSGAkt7Rsx2Km1h3k8sefgqLfDzwMjpxA94QlU749N38kOcOrk9RBEW
         W0RvhvsBt+mqlxUVw4StiooQMSwZLJELUIaHzyc5EFRheU9daS2Lw+nxX+IAWXKNl2lz
         hL1Ll64U92p9+20J8oDYuj55Cz4ffXHbd6VTjoWT6GCb+ZWKRMYokSh82aaZR3sh9/qb
         c7YnZ5JGjVRlYGI4CuWZeAPhkQ6jGPRL821f0mPu1h0VzEcEwC7ISTBRUHsebZhwe3Zi
         v3FQ==
X-Forwarded-Encrypted: i=1; AFNElJ80GrOx27Ghaf6KnVOGpaJT+feea6q2+xXh8TN2Acvqtt2+5WF+k8Ba2nl8K/ZWvf1gXpUliAI3ZGbjAqYG@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3R5RO8PVtft9ed273k4/6rww5Fw1UX4yAHXQEO+vBgerIYlb8
	RhCGeq6QBrjjvPp7bYtj1kqVWU3hYUFqLXcpot5B1okRZDtMkoGDVtTB
X-Gm-Gg: AfdE7cln+pCPOi+JBuhKWeyChBul6rxVGrkjp1ga5J8t2k1V/YiwJZah4KUhlOirxdK
	Zw5Cf7CtTwbhKeqf+rRu2ob1SjgLEovN2m1PHwD7MSD29K3dczzFkNBiJA1vLzzSgak4ln+J3XQ
	CNZ/LWMClmB7pNRfznuSkfrI4ilPlKd+filMjfzTg0beSP9Rcalm7vxoJZBs2gX11SkuoxTZBjm
	xIAf9zsaTYgqKKWtKZdLcKqrgrDiygJdwM+p8YfpSPU3AlEdHvcA6ZuU7BwlRWNhLd3n/HsKqT/
	ujIHQVjYAvHBkqCGX0OkC7uEq1dmUpzkVNz83qR5RWuT1jyzdtl1jWd7lEDQZ6sxXuIsJLpVW2a
	VLMljSKPBugx8FYm+blzrd36bs0R0OQ7/G6ZCoqo4hBuYMYXtKzsgXfOQINqqt71pT4PTiY1J32
	KxouVouBz88j3bgWmNDohrw9am9FzONBX6cQaDLHi2fPeIqaYeE2BtBPE7d8aKBVPh
X-Received: by 2002:a05:6830:4901:b0:7e9:b537:102c with SMTP id 46e09a7af769-7e9ec743f22mr4579267a34.25.1782864689485;
        Tue, 30 Jun 2026 17:11:29 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:4b::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e9f328636dsm2558647a34.9.2026.06.30.17.11.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 17:11:28 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: brauner@kernel.org,
	hch@lst.de
Cc: djwong@kernel.org,
	willy@infradead.org,
	hsiangkao@linux.alibaba.com,
	linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	ntfs3@lists.linux.dev (open list:NTFS3 FILESYSTEM),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 04/18] ntfs3: convert iomap ops to ->iomap_next()
Date: Tue, 30 Jun 2026 17:09:19 -0700
Message-ID: <20260701000949.1666714-5-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260701000949.1666714-1-joannelkoong@gmail.com>
References: <20260701000949.1666714-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert ntfs3 iomap_ops to the new ->iomap_next() callback. This uses the
iomap_process() helper, which finishes the previous mapping if needed
and produces the next one. No functional changes are intended.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 fs/ntfs3/inode.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/fs/ntfs3/inode.c b/fs/ntfs3/inode.c
index c43101cc064d..c5676c51a3a4 100644
--- a/fs/ntfs3/inode.c
+++ b/fs/ntfs3/inode.c
@@ -2101,9 +2101,15 @@ const struct address_space_operations ntfs_aops_cmpr = {
 	.invalidate_folio = iomap_invalidate_folio,
 };
 
+static int ntfs_iomap_next(const struct iomap_iter *iter, struct iomap *iomap,
+			   struct iomap *srcmap)
+{
+	return iomap_process(iter, iomap, srcmap, ntfs_iomap_begin,
+			     ntfs_iomap_end);
+}
+
 const struct iomap_ops ntfs_iomap_ops = {
-	.iomap_begin	= ntfs_iomap_begin,
-	.iomap_end	= ntfs_iomap_end,
+	.iomap_next	= ntfs_iomap_next,
 };
 
 const struct iomap_write_ops ntfs_iomap_folio_ops = {
-- 
2.52.0

