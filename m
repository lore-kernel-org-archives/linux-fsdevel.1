Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7495378D7D
	for <linux-fsdevel@vger.kernel.org>; Fri, 22 May 2026 14:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779459730; cv=none; b=fePglGVad6Mi2S1oBYPNQOgj1/GfhTIV1JxwrUV9xFF1IGFUskP/FIeTSx6W7nOSVCxXU11nwU7tYozV3jnBBBULKAEbxdaYEcAfvw/a6w9H6kRpd06tyttzuj9dP/LvUH/iHh3R3VFgPz7Z8vOuvcQax8lthx72yPiP+xy6tgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779459730; c=relaxed/simple;
	bh=4Nx7Hj5DOPPtTI9rHRcSLbxZrHGdi9VRhEeKtNfQvW0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sB21rEiP8RWDuhoztuOLLwh+rqLfCSJmTwVMl4KNWWx7Fwq3eog6qSwzNDVMWwryiQ5cZIYLrq/VQVQNcmau86xiRT4aXJfvVn4nd+hRl/X9ohDYRrSw+DWOp4awbVNiGnrd8+0zZ1YkcBLJFyDqp2x7R2wtFywosR4cxwNd1Gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VeCAM9IJ; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VeCAM9IJ"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4903cbfad68so12474245e9.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 May 2026 07:22:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779459721; x=1780064521; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cLkfG+pkjQSORlh3x9Pq4wFaVOyHcz6e1039orz8fG8=;
        b=VeCAM9IJpHBSJ9fV6dL0eLvIF+TW7XRHX9hpFTda9Fykau6E49ULE8C/CeWWlIvtMC
         BDFqEMd44TglMUGEEsLTJkwory5b6f84u+DA+/7h88T6xsnm0PFdnE3oX6xgbqwdsJlm
         jczErLLOIv6lXXv/h/ir0Je1kcy7nzVEKotA+9gaaOVq+Z7pGEIbUR/4dw75Dgyx12Do
         p4ZdXyk2lqKObigiUuo38VztVz5rLTvNeBGPXROUAfMb4/CEk/bUqfwZn/muYX8Bc/ao
         3v421dHBJeIwWrlEZSbQhsRQjnpgibtgoZrZof0WnLvOnnDbAE4Tt8HglZjtvvchPQzr
         h20A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779459721; x=1780064521;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cLkfG+pkjQSORlh3x9Pq4wFaVOyHcz6e1039orz8fG8=;
        b=O0xkqb764bX/occ8p4X+7zanOpfyf7Xn1guTVy/p6YwDb60Rj+kGTJ5O+7AFY7edSd
         SAt7ts8YW2DWma4S+B0DrpubM4Fru6ZXoxLSzB9UomyV+MFkcfEHryj0ObNE+r/o2JCg
         UEoNzRnMdNz4oLYb5rk95odZeFYfXjOVcMqIiuubDEqbd1VINqLDYvmVdzbUwYIjkC63
         oWegFnDGRLvrR7Tnu5weXSv6MJqZJgVZpvXWeXYeSaCJfQ+zk8rjRR06AkAoyCXikaTK
         f06ZZejhzZQ5sBHuaXczJN8KJ/4cV8sl8jE764ftjSIT4OyXuJeuwqqid89A0h30slJw
         EtTA==
X-Forwarded-Encrypted: i=1; AFNElJ+dp+Lhd6TfzDWNiNWXEuZB5FDW1V+VfkiG/E7D8i/GoBTsmxz6Yjxuz50cp6mfD6hFwUPcSMREk/nY74jo@vger.kernel.org
X-Gm-Message-State: AOJu0YweJK0aWjJEI40Yw+9ujDoYupgV7i51VkjEFjHUbyHC7uFbWmxC
	rmSz5FyPXpgmubLLCEQLT8woLuXFs2PvuAT7tSQhJHvluQUiUP7iP2NU
X-Gm-Gg: Acq92OEju/qVIrbeOOiPrCrMaO5QmqmAPrNGPGM+0a2g5Vu3x0EG9NPAl/loxrsFjgS
	/6EC5unmzpbfasOgFgDbvpPZBfkP9vabgusIS1D11K8YLYhwvaRgepnCLC1lhXYrghjD7pVoVqD
	B2DkiB+T0JNHHlL2pYUU4vtnsmiOfCkuRrUxEQRnp/dFweT1ZE8qriWLJVICMlql2SBRmh0IXkp
	C4rQJdmQ+YBRhAf4U7X2LdFs0Kc2sS19I4Cq39vWEbImjCCZuSHWmubwizkod5SaTOJYgP2UXlt
	Urymky4Qm1xZ1LF2mgaReSMX1oT0/3WbQBpr0KRvk0jrENS3nWxWzTOK0fOdHWuq50MyoidlqL2
	gB+p0rWa1dBnZrqtQfjQ/JYN7DnyqLK47U1o1GPSVOWHBDxALOyo1U+4s28QcP9YYD3KJB0GJkc
	bYHsgSVIJBivd2lasZ+/1HuDv62bBI4CCmsgLQ+xUDa1akpdiXG9Mbg1og1UsfENL3/OCaw2kvk
	A==
X-Received: by 2002:a05:600d:6409:10b0:48e:6be6:168d with SMTP id 5b1f17b1804b1-49035f35beamr81313655e9.8.1779459720455;
        Fri, 22 May 2026 07:22:00 -0700 (PDT)
Received: from f.. (cst-prg-92-135.cust.vodafone.cz. [46.135.92.135])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45eb6d70c51sm4698407f8f.36.2026.05.22.07.21.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2026 07:21:59 -0700 (PDT)
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org
Cc: viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH] fs: retire stale comment in fget_task_next()
Date: Fri, 22 May 2026 16:21:52 +0200
Message-ID: <20260522142152.1515572-1-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The routine originally showed up in e9a53aeb5e0a838f ("file: Implement
task_lookup_next_fd_rcu"), afterwards it got renamed and started
entering RCU on its own in 8fd3395ec9051a52 ("get rid of
...lookup...fdget_rcu() family").

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---
 fs/file.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/file.c b/fs/file.c
index e5c75b22e0c7..628ca07dc4b1 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -1133,7 +1133,6 @@ struct file *fget_task(struct task_struct *task, unsigned int fd)
 
 struct file *fget_task_next(struct task_struct *task, unsigned int *ret_fd)
 {
-	/* Must be called with rcu_read_lock held */
 	struct files_struct *files;
 	unsigned int fd = *ret_fd;
 	struct file *file = NULL;
-- 
2.48.1

