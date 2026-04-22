Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 944C73603D1
	for <linux-fsdevel@vger.kernel.org>; Wed, 22 Apr 2026 03:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776827162; cv=none; b=oOINHeuKXtgd0D6bBlsaHOg+I9bYEPxlrb7J7V8jfPcSqy4fiOBLFbNP1XZsquNbP0Oa6Qp7S03i4ePq7Q9rNzCbi5VW0pPEXxjM3znNWzRYHepfBHrFgM/1QFXKdugVGIS9OLoUhR/x1c8njClBQDekhaxrRsSBdBXIgvMMpRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776827162; c=relaxed/simple;
	bh=79buZRqMWZQxv5cCvNuYA6Q6naOk+CqWVTsVrBS+fAo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GgnaMK4Xpbtco5Xm5kJQmzol1uUhMPNCLevbayTyCv9CgIsue5uLjR0fkrpwibcWIuIWXUm/V1EbEEpU0mL+skaV1ISAK6XwbeIXw8dyTFKMQGBVqyJiRfQdPt+/ug75WXztlOCczJot5uLpkNK5qk0z5w5XeJpC0Gn444e2huk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AWIeeam5; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AWIeeam5"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2b0afa0210bso22921465ad.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Apr 2026 20:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776827155; x=1777431955; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yEay/Zix8z7BU3wldFSztch+sq0SYs1KDcG9UwWstzc=;
        b=AWIeeam5DrqfuFYwC57ysmx8LMb3W7DzhrXT8bzaB30z+0Lhgz4+UUZBDXImmnWqQY
         fJCBYiD04O6fzufSlsYwsILo4ckbu294mkjKN0lH3ON9DcFPA60gY0rZ+h0K+5q0vC9R
         44Z89LPhxjH6zdq+Wbm1IGc3Mr+HcD4ZTD+EXuvcW3xnY1G9XpnFqZH8unrSgYKbA0fs
         4nMOHGWpYQaRSYfxD1Eyik2qS0r1y7khwfnWL/ySeh9tSgnRSssr2XNmXhYUdu9zhJz9
         BRJJTgJxDOfkZy/IIomEYD5OohP6DpMOKzUKIBeHo5tVIshnlaZD5tjXMV6dr6Q1xTJl
         YbsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776827155; x=1777431955;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yEay/Zix8z7BU3wldFSztch+sq0SYs1KDcG9UwWstzc=;
        b=ZWyr/t2d5lHh9Gw3rVjKvIPPdr29L7tioD5MLug7rLKizyh6VIXqe/c8QFT5Xd/53p
         EVdVwly7Pgg4zBxlPLq+zHFliGi1J31ngd88qk03ibSHzl53gagTcjd7Z1ALRHLLBntk
         WWhUGbBV5n5j1YhpGGTY+7pYaL1jVjE68Tux4tJOhxepzHqkDucKsB1jGecIoRWArXtw
         nT5SQDnm4+TRxEirtkvCRbEsS9gkan8ToYAHXYDXQQyMgghliCz4vJojLD/P2FXmQ8WN
         zh50BBFtLuB5oFeot8PNjDP+gN1nBs9HsaNoWODmemJbyG7xxHZzYkTaPw/4gvRwyav0
         SuSQ==
X-Gm-Message-State: AOJu0YwCtwskXORDc3dPq1YJUizEEu5fPbzP1TEFVDiyUU5BHK4P7wYt
	0i7PGGvEJqP6278KheT5JlW6ZOM05bBdv1m1zNhnrlSvFGEX4gONg6Ew
X-Gm-Gg: AeBDieu71j8oKNs7RwcaQldb6m95lpogUmNXLr4o62fsx47DIBRykiaHn1DyHtfXaMk
	lFKnBWhbpChdX+cx29CxED/sVfV55H7wYWSGkmp5iABMWZTXVhlnkXcwXJZNdmKmF97P8Lx0cfg
	cAcIfr0SAUHdW9PAe0Av3D8ZzTMV9L0C0AhIFB6dgy39XbDmFKaYiDyctu/GzaVR0kQAAcu4SNJ
	lPol8pBYEbC9ccey7rvZo7qKvMt3IU3OQqlYR++jPm6LaeqRPCh10U7YlkNmKp9w0pfCDHnJ3i7
	ygjmIlDEBHSqiF7JpHC7mDKHP0m1eFCRvQdGzYLf368XmHPjxqKZzJQwJEgjfUNrcVqkA3iogl7
	arVBD387VOBcihK+oOlCCIRm0eqvzW420g8Gb07f75lK5Pu6pfl4CAOXip4lRrytjw+jL8mQRTu
	Bni1UFEAJbjvCUyX6MZjlEzc7/RfW0hZyrrV1tGor2Jo7bJxob0Ue908oRyg==
X-Received: by 2002:a17:903:983:b0:2b2:5256:9ce7 with SMTP id d9443c01a7336-2b5f9fa0f47mr224245075ad.36.1776827155409;
        Tue, 21 Apr 2026 20:05:55 -0700 (PDT)
Received: from DESKTOP-MOQC9AF.mioffice.cn ([43.224.245.246])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b5fab3a929sm143792445ad.72.2026.04.21.20.05.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 20:05:54 -0700 (PDT)
From: Zhan Xusheng <zhanxusheng1024@gmail.com>
X-Google-Original-From: Zhan Xusheng <zhanxusheng@xiaomi.com>
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zhan Xusheng <zhanxusheng@xiaomi.com>
Subject: [PATCH] ntfs: fix s64 overflow in ntfs_mapping_pairs_decompress()
Date: Wed, 22 Apr 2026 11:05:43 +0800
Message-ID: <20260422030543.125743-1-zhanxusheng@xiaomi.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In ntfs_mapping_pairs_decompress(), deltaxcn is decoded from the
on-disk mapping pairs array and negative values are rejected, but
large positive values up to S64_MAX pass through unchecked.  The
subsequent `vcn += deltaxcn` can then wrap the s64 accumulator to a
negative value, breaking the monotonically-increasing VCN invariant
that ntfs_rl_vcn_to_lcn() and related helpers rely on.

A crafted NTFS image with a single 8-byte run-length of S64_MAX
triggers this when lowest_vcn > 0, leading to incorrect LCN lookups
and potential reads/writes to wrong disk sectors.

Add an overflow check before the addition and treat the on-disk data
as corrupt (-EIO) when the result would exceed S64_MAX.

Signed-off-by: Zhan Xusheng <zhanxusheng@xiaomi.com>
---
 fs/ntfs/runlist.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/fs/ntfs/runlist.c b/fs/ntfs/runlist.c
index b213b4976d2b..a32affb57d29 100644
--- a/fs/ntfs/runlist.c
+++ b/fs/ntfs/runlist.c
@@ -823,7 +823,16 @@ struct runlist_element *ntfs_mapping_pairs_decompress(const struct ntfs_volume *
 		 * element.
 		 */
 		rl[rlpos].length = deltaxcn;
-		/* Increment the current vcn by the current run length. */
+		/*
+		 * Increment the current vcn by the current run length.
+		 * Both are non-negative here; guard against s64 overflow
+		 * from a crafted mapping pairs array to preserve the
+		 * monotonically-increasing vcn invariant.
+		 */
+		if (unlikely(deltaxcn > S64_MAX - vcn)) {
+			ntfs_error(vol->sb, "VCN overflow in mapping pairs array.");
+			goto err_out;
+		}
 		vcn += deltaxcn;
 		/*
 		 * There might be no lcn change at all, as is the case for
-- 
2.43.0

