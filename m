Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61C8123BCED
	for <linux-fsdevel@vger.kernel.org>; Wed,  1 Jul 2026 00:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782864726; cv=none; b=HhttoRLQMu4bum0PB90ZRunA3QV0bvKBMFp7dnQvrKQV8iHmqhABnRcjdP3Izx+ZbUfyE56Cnx5/Jc41cdI5nVRdOo+4Cuc0QJLE1UBv8jb9QnE/oAqvhdx3FsScI+TYXuhjPCd7U42ePbL3yoIEssxNqC6t3CH0qgeKZ73UfMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782864726; c=relaxed/simple;
	bh=rZMwAp8AP75tyrP6Z70wspwAjYZTN/vjlM8jMf9jJdI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NOvVwBkKdf35Zan094Bdo4+bLC1A7NV682iiW1EUM3q9T3O6RKe44kN3G1sA7Hese3npbu4M3AJDs4oUW/jziomBmxR5kM9xr0axZezTR9ojBR7KE61RR7XOBUaqEhBFPHcND+61zAsADlg64r6/g3yKqc2KD/d7r7wGJ7XhXYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eZ9f/Q84; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eZ9f/Q84"
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-7e9ecd7216cso51858a34.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 30 Jun 2026 17:12:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782864724; x=1783469524; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v1PYWDER/X9yFiAy2VkcCTuFWmeMhUIUR7JtPj5OqF0=;
        b=eZ9f/Q84EvxqqynV7SFXezS0DXLrV4H3fd0tsCS/Jw4h29gx9lcA0CCZfEiegssnHT
         ZEUbyIazOCNGNPHL+QA4CYY20riGi2M2jrjHop2ySafiI/tuS2hOTZ740p+sZEKZNPKN
         jZRtH2Z7OQ5oOcfVm8OTy3I1HzVSL7utaye8KUbdDOSycY6HuHkPCRDprmGofwqgXu+E
         eqQIbVhzlnskQpxYp+12FL8oOsJsFfZ6aeF4arsKSdkokWpKlRjYCanl6phyQQL9pBVw
         7IYnHlJhfr6ofE3Q0HlCpc/f5wQDfdBFX45dXOhhMpqO22pCTrFroJxea8cj86cYIAZj
         dNRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782864724; x=1783469524;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=v1PYWDER/X9yFiAy2VkcCTuFWmeMhUIUR7JtPj5OqF0=;
        b=cRi4mVyyWnjjcW7NzvvdYLDOkfu3vc/zXB0w5I2ZoCXX7QLgLtzERUtZFUVMufxVd9
         sRNmAodPLseb6Ub7yJiauj0DJRnlC512ACVjTaOEDI8XOfl3JxGFchyCJL9qNrMNQ7An
         hYhXSsD1x6PjgqcG9nv80jUPgeQhoYH7nV0jZZe4cD/UzzSJdI2zUZJua1z/CzRAm0Pp
         Y7hFCkKoultru6fbIoUJlL/XAHFKbRUKDKGbbsu/G1mRPwBAgttDldcp+HcBiJvEpjdA
         6k1wJx+dhrEiJAdibOxyrpO5AskNAg15o8TavoN1nHjlnxbJj4DavesHYt4SgNIAwoAy
         vDQA==
X-Forwarded-Encrypted: i=1; AFNElJ9hTVK7f3+M5HcZ9q7UPotlk/GeyTiVSQTI0UcPMFRwm+Sd3y+F4/0Gq/n1oZbET+QBSa7CxUm1bROwDDEZ@vger.kernel.org
X-Gm-Message-State: AOJu0YyIEXCwCXQiTLYCztrpmsbP0IQBK7s3ik0x4VtHxQ4BrEfFi4sS
	yOt5yRdeipyr0Ua8yaRRZpt3IcEKDajA3ToximxcSWSSYABLL1Q6er9M
X-Gm-Gg: AfdE7cnm90rUow+hziihuRhi4Us4YRmVFaeUxaLadBQOXZU0c2xy5VnRu652Sra5KFh
	+yHOSzRP9DgyhgU5uan0wyhw8dnYWzhZ086jfgZKH1joP8OMB3cD/nvNzqN++Oei9qTHlpxf92z
	xx8BYC6/Od4npTPay1gRDBdIAioL4MJYVKluLHbMUwVmPoLLsG+4/xj9j/hHwm3j+dSPMRoEgQc
	Dy6OUGRlyD0XMlObi+4XfmG1FuWMl+GQXk6dcX1Glv8mz0sSxRh9YKhsD+b8YKH/I6Ghf36XvNj
	ZlfEDskdY1l3Y7vDnUHdiND86jGLxBNf2E6vU3hvfcKJJd2GFevl+bvriIMKb50Jddl5RLzpqWe
	djDr6qgx4bn4HbwQwdZf1/WlxXrWfpGXPTGbOCkNmrYMGCTFK28gHV0jK18GxEdtOKwjnkXXWm3
	vz+rx1U3ewTgHg9h1ShnBE+bKDf2FTOL4cNBN+x1kBGdjkJEvYDysyaNuUMRNPup41zQUPMiCOX
	yc=
X-Received: by 2002:a05:6830:439e:b0:7e6:f2dd:93c3 with SMTP id 46e09a7af769-7e9ec706306mr4755934a34.15.1782864724460;
        Tue, 30 Jun 2026 17:12:04 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:4d::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e9ebf891b8sm3635363a34.6.2026.06.30.17.12.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 17:12:03 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: brauner@kernel.org,
	hch@lst.de
Cc: djwong@kernel.org,
	willy@infradead.org,
	hsiangkao@linux.alibaba.com,
	linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 13/18] hpfs: convert iomap ops to ->iomap_next()
Date: Tue, 30 Jun 2026 17:09:28 -0700
Message-ID: <20260701000949.1666714-14-joannelkoong@gmail.com>
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

Convert hpfs iomap_ops to the new ->iomap_next() callback. This uses the
iomap_process() helper, which finishes the previous mapping if needed
and produces the next one. No functional changes are intended.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 fs/hpfs/file.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/fs/hpfs/file.c b/fs/hpfs/file.c
index 29e876705369..1df9f28fb40b 100644
--- a/fs/hpfs/file.c
+++ b/fs/hpfs/file.c
@@ -156,8 +156,14 @@ static int hpfs_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
 	return 0;
 }
 
+static int hpfs_iomap_next(const struct iomap_iter *iter, struct iomap *iomap,
+			   struct iomap *srcmap)
+{
+	return iomap_process(iter, iomap, srcmap, hpfs_iomap_begin, NULL);
+}
+
 static const struct iomap_ops hpfs_iomap_ops = {
-	.iomap_begin		= hpfs_iomap_begin,
+	.iomap_next		= hpfs_iomap_next,
 };
 
 static int hpfs_read_folio(struct file *file, struct folio *folio)
-- 
2.52.0

