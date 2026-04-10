Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17FE53254A5
	for <linux-fsdevel@vger.kernel.org>; Fri, 10 Apr 2026 06:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775803653; cv=none; b=CSa9EOgGiaJg/OUVeh5D9ZcqcTRe33WhIQW9TsZSvHl6tuwiXmxsUGrkSuWQenIgKsDU4IycfY90yoTi6VxFwijztbirGimMUvxr7AZmAqrQ+rlpEHlShGt6u3QukPioaa97Zniuq0SYQSLnTmR7s7jWkfdwVHrbcJhmOpKFVbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775803653; c=relaxed/simple;
	bh=/L3Yr3WtdME08eFDokOvv+OIuRTq1D8alGBG+OpvfnQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=BdM0ds6aKrC9Cb+HxE2VCvHwFaQ30ajj6x5CUm5wWCV9qmGNmcTwRcxWNGdoGuiWCKHUov/IsTJfodpxBg1aGei941m9/yuYzlgR2SAzBEJ2LThkVovhupZSjf+geLPKrR6ia7NoQZC8Dp0/6pQcMkTBgNLtLBjsKxyEpNEHqVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P5KTtNff; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P5KTtNff"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4889e045bc6so17970895e9.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 09 Apr 2026 23:47:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775803649; x=1776408449; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/ve11CbLQNCMgBVMcN6nptiQt0ephw118wuU0HiKP0c=;
        b=P5KTtNffHCMcU2TUMhLKiULQJOrqn8bOtQ0vAzcEXIdW0s0+BYzLvjf0weBOOnPSBp
         H1/rPEAsB1qIPSCbzS0ceAfXwsidqYLhzO4qGv8d5Xv7O05YAV5berTEJnxZkLlBUCEg
         yev16pOz9IBEomRpttp+ypx05P3dif9urqlstk266JHiT6/sYN/ZfFkJ59+PeRHbUoAm
         tRTX38uQvDUtAeoA0IuBW2Lm6/lKt0qKlHOkzv4GpRuoqg6DMlWtXlMShBex59VflLAA
         Hb4cJacRntLyctb5yvEJXRBli28khLIfKJfaJzxPN8THMSKnJRbmjXeWvHsvEVnaZszv
         lTJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775803649; x=1776408449;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/ve11CbLQNCMgBVMcN6nptiQt0ephw118wuU0HiKP0c=;
        b=qBj+avoSy+dH3gd6dvyqdiiPy+GWH70+g3/BFbSb6l1wWa0yzrkkItxil227+d488h
         UmEzErPC+oQt3niroSlnFWFPQKmEaRpLj2MMsQCMYXiJ+JwI4F4eSuUqgThCQr8Gb8v8
         ENiwm3Slw49jT9hRbmDeaKFo0QiSJvdVCoeLupshvbwnl61reH0TyQYSEikBXNsYmGpF
         yd3KEdK7o6Amt+C/8y34LbftZNwXEH9fViWgouRZnMFNlnFBYmVlP0NNxV9On0gMKuUo
         X5OOKhUfH2FPy593rhMXUfx3xVuZx5AiWJgA15C5OFaQpkvgO2ePlSMg9ubUa2x+Ilc8
         ah0A==
X-Forwarded-Encrypted: i=1; AJvYcCUwSbNxbqvhW/edJXmb2p+TE63KQOHXCVF070cMK36Tkt6dOQaMQuOBkDYX6rhOPvM1MgU4rSUstgRbp2ge@vger.kernel.org
X-Gm-Message-State: AOJu0YxnGVYFqW3AFcLZJHXtZY3NALK1c9y/8IrIjc/n12L3+kZl6dvz
	mlGgmvPcBLf2bZj9EF7ea26eLQKY7mT4FQCLQM9j7KHh5t8D74DFrUNJ
X-Gm-Gg: AeBDiesVIc9hXpRkqxqLAQJ+ZGLbI/ombeS2bP23OhiXJtbNkgQH3NkSxCWQwZ3RnIQ
	1B4XNdFoTaZVNtd8C6KXhdzh/Kf4/ZqSUe8t2GLQOTEx48rrvG9v4zrgtFmcvkXeiBSdEkwXeGq
	JGmJHxJXuHPKuUo7GugOXP9lizKjarQoj6CLwemqx/dV9s24BF6mD4v8QdTVsWjFiRsvr5CneSU
	nBOBL+9dTgivpNwfBmcJkt047pACvOEc/NL74e4yxn867ZDhdCg105T2G57pd2eTpuVdiphMwEx
	D0oQ1cKNsc+k52F0oM7aC6GNaHFi2ksA/M5RbuF1r4knnwWdpV8JaF1ag/aH6qHVqZnus7eF9wx
	JnpaKaZ+oJkH2NwfOhEO0mpOCgBfw8ZvVcjWwwoXuB/2uD+HVcCALyaQ3LilYo1X+zdvUNf8MFr
	OMbHnsiVS/aGa1GbCRChY=
X-Received: by 2002:a05:600c:4715:b0:488:9e54:94c0 with SMTP id 5b1f17b1804b1-488d67e7dd4mr23459715e9.8.1775803649478;
        Thu, 09 Apr 2026 23:47:29 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d63dec295sm4781790f8f.14.2026.04.09.23.47.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2026 23:47:28 -0700 (PDT)
Date: Fri, 10 Apr 2026 09:47:25 +0300
From: Dan Carpenter <error27@gmail.com>
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: Hyunchul Lee <hyc.lee@gmail.com>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH next] ntfs: add missing error code in ntfs_mft_record_alloc()
Message-ID: <adic_St-SP3UONMV@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

Return -ENOMEM if the kmalloc() fails.  Don't return success.

Fixes: 115380f9a2f9 ("ntfs: update mft operations")
Signed-off-by: Dan Carpenter <error27@gmail.com>
---
This email is a free service from the Smatch-CI project [smatch.sf.net].

I have wanted to avoid sending patches but it was easier to fix it than
explain the warning.  :P

    fs/ntfs/namei.c:677 __ntfs_create() error: uninitialized symbol 'ni_mrec'.

 fs/ntfs/mft.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/ntfs/mft.c b/fs/ntfs/mft.c
index bf028c1aea26..0c545fd08b66 100644
--- a/fs/ntfs/mft.c
+++ b/fs/ntfs/mft.c
@@ -2503,6 +2503,7 @@ int ntfs_mft_record_alloc(struct ntfs_volume *vol, const int mode,
 			folio_unlock(folio);
 			kunmap_local(m);
 			folio_put(folio);
+			err = -ENOMEM;
 			goto undo_mftbmp_alloc;
 		}
 
-- 
2.53.0

