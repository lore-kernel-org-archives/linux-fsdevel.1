Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DE7E14A62B
	for <linux-fsdevel@vger.kernel.org>; Tue, 27 Jan 2026 15:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769527944; cv=none; b=dOnFZcDZwlXkN/+l0ZK7Wwbg9HMJ+ReYyTSIAqcVqr4w3pQ/yBgYrTnVQftSQRrLGLr3CKCDP+r4eIZcmIIk/iqKyymo3mXcLO+OvWvNP1FvxJKWo38Y7Bz/aKJv/dsJ9DnmlhmhNVHxAg/bJHgM2MvAQsdWWYrQ+fsLCWR+SrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769527944; c=relaxed/simple;
	bh=UA/Pj/9ZrqEU7aiap7iWR38OS0qrTdEHmUKlJqZtZmE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jAYMZ3UMRDWfNxLwpPyXFouXJ4D0zTOMdZh8/7VAOKFgeu3gM513CJmmqxaOuYteUHuLz+wHYFTQSvyrHe2NOxYMmEQHJ0BXS7Y17kXH6bkIaxgOp36DfCrglkKaO5dOQjwFoNotWu16BJRtVcjuIwwpeoYBrppPvtlnS+2X6Sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=My7WGaFo; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="My7WGaFo"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-81f39438187so3069313b3a.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Jan 2026 07:32:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769527943; x=1770132743; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=f/d5KvztXzl954ECo1DrNWpBs2JGa4DcABvJH++iUvc=;
        b=My7WGaFotMZACWNkBzL/pyqqUPn9d5fwAM9WjhcP1lSp/diNblkDMvQmXyQhhJ/6Wl
         9SKIv1KGZiII3YtDTBUuo3U4S6KedV7baryVsvPbssCYOX+fsAvFfV8c2NGSdvpQQjK6
         FvC8L4Azzt2exkt6REsRaF43yJHQV7DuDxi0x1Nz5b40CuivoTi1lqzofNWc5dX3qEQs
         62pzEamA52dfrxkLA6dN+5y2ZZChqq8TBaHFudxyfzdlKJWuFHhR/vzMORQjwXNq7ltk
         yEvPCjnl8I0M1A/HeeXRZNsohvPPZSqylET6NMcv9qPmz/ICZzBGCCk+joncExhPF2Pu
         FhmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769527943; x=1770132743;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f/d5KvztXzl954ECo1DrNWpBs2JGa4DcABvJH++iUvc=;
        b=c7t6E6plg/oRZgHTdJrCJMYoQIpsXUFTzaaM3jVXAMVzAxnf+hzP5fRUzCsJknjwux
         p2UOMMWPxi2QqILMiVNBq8wWaUt5orRHvp56TYyrvgclmnZnsRlmKuzoDl6CvBB8pj/x
         hbJKdRMriMEwTbbRsTMWutHJn/GO8IpGnKQElrFyHet+71MbVv1o7IaiSwXqfMy14I47
         WM1JNKHiAwYY2uBnyRnpJQkl36zqOWNNolk9xoBphi2Bodn2RlnrPaiBTUBqcX4Ek6Pv
         YWAMLhArJRL/mEd6yoD3cfYuqTJMdAWDJMl1pGFVhVp0xJMwk5XccOFSAiIM8irGhybt
         dtnw==
X-Gm-Message-State: AOJu0YwkKevernM1JMeEdyRv9IhwKymZDEsTX8S0dNncHH9l0zVm0Kxi
	67REZ0y2atUiwhVKK4m67zXo598rmxzYef/aUL/UKoBBgB1L+FCcsIcf
X-Gm-Gg: AZuq6aIX64nFSwFSNuHVVNzAz2AQj7WixcXUv87xaHZ7uCP4Uevo+MmBD1iVqaGkZi2
	70oCjJSLxEYSUDaHH+EhV8hAhccBAef21DAbF1TaSDFDWBbcsp8RU5YdMaIH+RwD4Tgr4wMmgOr
	pQG9buKZunZzUTKzQUaO23fYNxaCKH4uCQgaZG+UxAx1sW5LiswdleyGabvL95154jDdR1mHUgR
	H4i2hU1trb2B/sGr/XT/yD97tfuSjXnBsFaU2URZxLH92j6UABn2E8Ym+RqS8LepxZ38iQVF7rM
	CayuFYyMsoUoYmA5LZAOcW8NMdXPzRkqpSYe72FuBa7CTxow7s6x0cgF/j3R7kB9uNBgF8CI0OC
	pTgiR+C1VI0AdsZpwheatiwU1xeUWVYtmwq85Lpt7kaY6oU4cC/ePTX41RFSS2zMQ/xoEBW/B3U
	F1IbuUia4uj6XHhzyKiJsovXCgLe2PQA==
X-Received: by 2002:a17:90b:3dcc:b0:32e:5646:d448 with SMTP id 98e67ed59e1d1-353fed70cbdmr1716221a91.21.1769527942596;
        Tue, 27 Jan 2026 07:32:22 -0800 (PST)
Received: from oslab.tail046eca.ts.net ([140.123.97.72])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-353f6128942sm2921231a91.5.2026.01.27.07.32.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jan 2026 07:32:22 -0800 (PST)
From: Wilson Zeng <cheng20011202@gmail.com>
To: willy@infradead.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Wilson Zeng <cheng20011202@gmail.com>
Subject: [PATCH] mm/readahead: fix typo in comment
Date: Tue, 27 Jan 2026 23:25:35 +0800
Message-ID: <20260127152535.321951-1-cheng20011202@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix a typo in a comment: max_readhead -> max_readahead.

Signed-off-by: Wilson Zeng <cheng20011202@gmail.com>
---
 mm/readahead.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/readahead.c b/mm/readahead.c
index b415c9969176..6f231a283f89 100644
--- a/mm/readahead.c
+++ b/mm/readahead.c
@@ -436,7 +436,7 @@ static unsigned long get_next_ra_size(struct file_ra_state *ra,
  * based on I/O request size and the max_readahead.
  *
  * The code ramps up the readahead size aggressively at first, but slow down as
- * it approaches max_readhead.
+ * it approaches max_readahead.
  */
 
 static inline int ra_alloc_folio(struct readahead_control *ractl, pgoff_t index,
-- 
2.43.0

