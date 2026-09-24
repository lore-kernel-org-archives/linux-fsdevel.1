Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE3744307B0
	for <linux-fsdevel@vger.kernel.org>; Thu, 24 Sep 2026 07:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790235566; cv=none; b=VlpAoumytD4Di2Qn5imxTWy5hmjdciiAO8cf4q6jgheQCHxrXRF5hn9Pn0IT6Stu8YzUtHwC/+H4r1NPLazrAP9tFODZBpSLBUKghqUwmfkcOhM+++/iYXRu55o+78v1E7vid4ZJAZ6manlOOkErpaXuwAdtSR7nnWnJgkPrUKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790235566; c=relaxed/simple;
	bh=Pw+Av91JRHzFJpjZkmQikGFp79b9jMCKqLUOdDMofug=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ai2kjK9HKW9ZcbI9rK6m+idqZklYT4yWOz5R0F/zvpLUHrrtAn4RewqXzCH4jDd3hWpYeKYvOY4R5+O3vFTyAdKKZPblUSlxjrNkchEmdEcKk38/h+xAU8jgrbNJDn9kDPvLrhnMFsiE7mj2zVXZYi2rqnECAJtYfXfeH40qX8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K1bDWVw0; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K1bDWVw0"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-86ec25cf7ecso344500b3a.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 24 Sep 2026 00:39:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790235562; x=1790840362; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=S2buUXXqIEIUcfZHLVUXYEcgHUS9sSJjeV8Phy1za6c=;
        b=K1bDWVw0Z1uEj8/1/iGXfhUuOrREsE8/pewMUUrHzOaGs9U5NtxPXg0EdwI0v+fpH+
         1QvlcaeO8KKfLDVFRqOfcuwtJ7M1F3OgmFCsWvAQNrz4rXdyArcWXa4jt7LaH9ZGQPBD
         9an9BEqqokA5QTid7WGMaMUN95RV+XSKnciUZi0F7mhpV3yywoY7Uvuw1wWLWksMY792
         nF637uDOtfYArt7Cv96xYmTWmi/DiH89vHex8VThSV+2lHCVju2Lz1VUTXI6OuZm7+Fd
         WVCCnc7aE9NuwkHf+cPpkfdRxzPhNSYjXpUaQ4k330wh91kEgWHPJT76pDfguvrVAEw4
         EOXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790235562; x=1790840362;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=S2buUXXqIEIUcfZHLVUXYEcgHUS9sSJjeV8Phy1za6c=;
        b=kbWXqCtn76+5tYQ61nHUbmeiSREU8QZI9RwPCNY8JVK5nofwaqF6cEsTx9Kr0sAHb/
         pC/H+hqx1H+n04M2rEcHxfWLwCF9PARxmopEPS7JckXgyNqeZvTyhmyf+GaMwIX79nFY
         j++1n9vD4Hi0V1HMMKbdEEPNDwOPWNLkP2GkmO8Bri7K5H2RadY3VpMok5krim39xSmU
         +jYaVZCIRqeh+McaO9N/nO6TntRZN4Xtjayv+bCorciNtC9wV3OJZrfzS6BW0M1nUppK
         dG7xWdb2KmdCkeNN1HP9It6A3oNUoclSOiWy7TDxBkLVJxe5a2RHM9V3SfDSDqXqo6+E
         V1QA==
X-Gm-Message-State: AFuF++lnmtnb116F1kNi/gAC+x0nk/By3F9/xCI05EUzmftYDYV8qyiT
	0r3DaXfajgEyeabJr2XaGbpU7pslS7WiS3nQaDSJyKL8K8Q9So4kzp1Wr/ers91I
X-Gm-Gg: AYBFou1mR/43GQGqKMj1XlHBdhxE5i4jKCmsGxiQs9Jo6uFAmwLvRRYYtWsetv/tA0E
	IRVhaIh/HO+vaIY+Y6FuWzX95byJJTNZlsPewgAzeITQp4Yksy/eyhRoF56zC13rQ+2hH0CRIHi
	2eKfyEZgYinnS3x95OwJUj/HplzyBVCX0SsKb6VoMNnp4wZYG7aG8oTkH7RgrlekcLrVZMLqc6p
	A6sCwqk74Jgfc0YjQxBlYD+XZFRyOrrki95m4MhXZyNfl7kopcDy0wgXa5qJgjv20lfHkJ2ylMT
	L9q9qmDWA3/LzVPETFbu1VDIE8ss6EKGRTV0hqOAlp/E17mEwwdVw3718PpTcsOC82MnnJFyW9X
	IfTychptlRb2fJz8cNYJoDza5WjVzn0FjTLVd725zo4iCKQY7oSEwYmngvxgoovzU01hd+B302m
	Ss3u+3hpQO3h+6vdnE7eqBA88G9YN5hNgb/0RqhuaNVyc162j/K3g/r6RCkNGO+ydiVmtOwGqhg
	84vtMNx1xGGDbbebwsuXsiGsjo1akiR2n3v+NKyAo41vf8cjVm1QjNIIV1JJifjlSKVw59OyZ1k
	Zzn66TEqGg==
X-Received: by 2002:a05:6a00:a20a:b0:878:3705:5722 with SMTP id d2e1a72fcca58-87ea1195231mr974546b3a.46.1790235561625;
        Thu, 24 Sep 2026 00:39:21 -0700 (PDT)
Received: from phui-2.c.googlers.com.com (67.51.127.34.bc.googleusercontent.com. [34.127.51.67])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-87d1dad44c6sm2393739b3a.42.2026.09.24.00.39.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 00:39:21 -0700 (PDT)
From: Hui Peng <benquike@gmail.com>
To: al@alarsen.net
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	matthias.goergens@gmail.com,
	Hui Peng <benquike@gmail.com>
Subject: [PATCH v3 0/6] fs/qnx6: fix buffer head leaks, double free, and inode validation
Date: Thu, 24 Sep 2026 07:39:13 +0000
Message-ID: <20260924073920.2782917-1-benquike@gmail.com>
X-Mailer: git-send-email 2.56.0.rc1.310.g51773c2048-goog
In-Reply-To: <20260921042511.1473629-1-benquike@gmail.com>
References: <20260921042511.1473629-1-benquike@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series addresses buffer head leaks, a double brelse(), and bounds-check
failures in the qnx6 filesystem driver:

1. Validate di_filelevels <= QNX6_PTR_MAX_LEVELS in qnx6_iget() before
   accessing inode level pointers to prevent array bounds overflow.
2. Release bh via brelse() on error path in qnx6_block_map().
3. Avoid double brelse(sb_buf) on error path in qnx6_fill_super().
4. Release sb_buf on mmi_fs error path in qnx6_fill_super() when probing
   MMI superblocks.
5. Abort mount on superblock magic mismatch when silent is set.
6. Validate sb_blocksize before dividing in qnx6_mmi_fill_super() to
   prevent divide-by-zero.

Changes in v3:
- Add Tested-by and Reviewed-by tags from Matthias Goergens across all
  patches in the series.

Changes in v2:
- Split into a 6-patch series as requested by maintainer review.

Hui Peng (6):
  qnx6: validate di_filelevels in qnx6_iget() before accessing level pointers
  qnx6: release bh on error path in qnx6_block_map()
  qnx6: avoid double brelse() on error path in qnx6_fill_super()
  qnx6: release sb_buf on mmi_fs error path in qnx6_fill_super()
  qnx6: abort mount on superblock magic mismatch when silent is set
  qnx6: validate sb_blocksize before dividing in qnx6_mmi_fill_super()

 fs/qnx6/inode.c | 26 +++++++++++++++++++++-----
 fs/qnx6/namei.c |  5 ++++-
 2 files changed, 25 insertions(+), 6 deletions(-)

