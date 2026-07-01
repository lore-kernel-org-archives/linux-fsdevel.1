Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E064921D3E4
	for <linux-fsdevel@vger.kernel.org>; Wed,  1 Jul 2026 00:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782864717; cv=none; b=Hwl4DVkwa87Y3TiWxMxMxJxX8eoR87yMThTOupRHiTBaWqzS1Oiw9EfSUhP3fmunsCbDbnRTeDO5qrjMg43zuUSb4qTbQNMlwEIwVLRxNIS+n9FXzjVz6U36agg1LM5I5zUSdBiYlGWOEuhSr20/qTu8QAW6z3ddQvbzjHzITiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782864717; c=relaxed/simple;
	bh=XfGWwXuootHBZAI3s4NLMg9SyFeRWTCODggpZboQpk4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ludKXnWSwuQo+wBPMhNUnL1Hu/EQIEvh3DR+cd2kqm8/WPjirxYLTKSDCueUMJmGK5B9mqdu34fZUa+1jP+mu36m1I9esiwIKzFCdD3RVk5WRH1aKDqEqhBWeQlIJk9MKTAr2baI2qh0XD++5kvBBrvZ5tFZLLtjwt0N4x63CWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WgvQMzy9; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WgvQMzy9"
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-44865cf3010so18054fac.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 30 Jun 2026 17:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782864715; x=1783469515; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sbb4EcSwF6GBNr0pD5cD8wD0CiX9f1pyxQBHQk0CnX0=;
        b=WgvQMzy9CdJRNRtZBBGkT4Dsu+JkWadQRFZreXjjsvKNjPI6ZGhoOt6zMIBycWZ37E
         QR9aJTRR1iNErK5qjDPNsfCXdqGKOMHLZGyg7jWTxvvkNWH8+U5eizbJOISu9xF7fBUt
         pneVsdqkqi9aHx0X+d7Rtyb13JJAYtIMQ8ZXCplmV8ytbcVs++fQpfQGK0XL9tdwVJPz
         VSf7RrXQ57p/FNPBUAke/OjyK4LsIJqU315Inr73FU7DLwsDL0peo7UdIOXlhJCRe0/T
         DhY4F7re8M4qRyz7rM+o19zJPput2agqdyLlZlJnk4SwTH0pLbtqPAjSFEOoNGHHOViI
         DNxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782864715; x=1783469515;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Sbb4EcSwF6GBNr0pD5cD8wD0CiX9f1pyxQBHQk0CnX0=;
        b=O+25/fXtbJnP40n+O+3U3T83o14on+zWpUmkCRrXNy3iukg7EXP91ewX+Jxe7Go6J7
         w1QhdaJ1+k12QeSCj8xquUEud9W6PtpByrKcQ4d8WFocLQLQ65IMLjOJECFsFta9MUK6
         IL2eELY9gjqUWCGLhfac9S/3odxOD9R9t5lO5fFrXbR93rgOMGsmKksR2KgYSeLotskF
         gfUIqfyqzOKC5BeXNZqCq5ANjejXqSOz2c8zCdCEN0qFauIEs8yokI97IxdaJZTx5Mgp
         nW56cNN78DYiURCjL4k20BFjRk/XdbP+b5jyy2VojVKbUY+/RdZZDTIX01aVjIY5Da/x
         g0Hg==
X-Forwarded-Encrypted: i=1; AHgh+Roi810O/NUeqOF4jJ7qgfI0XXtRPBqkPuX2TUWl7T2z/LDFVElFYda8ZDj9oXMUc22ZqnpysfIAWo4xIUqa@vger.kernel.org
X-Gm-Message-State: AOJu0YwybbzWN4rAjlKnVXNvPDboYNtvU73WXWm7KcS4zaNCBrBI0lyQ
	wkU6c54j9MfKOzWkGmKZjTZzz9jqZjwGWg9wQMRC5hAO5jQuCs3UwCw9
X-Gm-Gg: AfdE7ckANyrksy1DxNlcGAz4oEfvWKitIXI/700TIwZx2jHQzkAJ5YFa27iD+OXD/RL
	ggWR6F5HfywMaf4e4SjvXjoKvKczk2Ndix/55Krcf4HIRQXdgZ168NolxanMx4aO8XKjhrDlUpV
	9UeuBDTseeAte5/NehLDbGwkwPAaVKiLSwareOBG67yuzXczG84VqpkzDplfGWQdDLbssM5O1cn
	1lYs37szQHWhy9fWdAsgrTQ0kIcEf1zKe1UFZqb4B2HMWCGuIZKJVZT5nkRcfeTHfaAmcL1SJbc
	z5t+1KFQWatRwN1CXUQb7Rxm9iQsRXK4kMoioRALAinAM4WHHV99Sr/TM0VsZqTnWUFUILnk4Kr
	8ZTqkR05PWjaUKhr/ZPj5oJu062s2O4QuIwY54fK+O6pUuSw9QXqRIAfr7oPEx0OHxF1bdFZvhx
	+d5X58lsmtS+q7M3ExYg++ikKU0hZVhaWUA6npES0iVas+dWzn5YsjoPN9LdA+VF8=
X-Received: by 2002:a05:6871:7824:b0:43a:c6c1:e40d with SMTP id 586e51a60fabf-448dc4e72acmr4916410fac.16.1782864714787;
        Tue, 30 Jun 2026 17:11:54 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:6::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-44c613c04a9sm328264fac.2.2026.06.30.17.11.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 17:11:54 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: brauner@kernel.org,
	hch@lst.de
Cc: djwong@kernel.org,
	willy@infradead.org,
	hsiangkao@linux.alibaba.com,
	linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org (open list:BLOCK LAYER),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 10/18] block: convert iomap ops to ->iomap_next()
Date: Tue, 30 Jun 2026 17:09:25 -0700
Message-ID: <20260701000949.1666714-11-joannelkoong@gmail.com>
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

Convert block iomap_ops to the new ->iomap_next() callback. This uses the
iomap_process() helper, which finishes the previous mapping if needed
and produces the next one. No functional changes are intended.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 block/fops.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/block/fops.c b/block/fops.c
index 15783a6180de..c2721e2c659b 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -453,8 +453,14 @@ static int blkdev_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
 	return 0;
 }
 
+static int blkdev_iomap_next(const struct iomap_iter *iter, struct iomap *iomap,
+		struct iomap *srcmap)
+{
+	return iomap_process(iter, iomap, srcmap, blkdev_iomap_begin, NULL);
+}
+
 static const struct iomap_ops blkdev_iomap_ops = {
-	.iomap_begin		= blkdev_iomap_begin,
+	.iomap_next		= blkdev_iomap_next,
 };
 
 #ifdef CONFIG_BUFFER_HEAD
-- 
2.52.0

