Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795715673;
	b=sdEi9zoTfU0KMDQ8hppZjp5kKXlbqbJG44DQH0Mkl+mlizfIgtrZZFBwp05UkTQIsYRi
	 JQ8HXxhmg0ckg+ur7pC1SV+qNCZc8SM1DfmHbuSZv8bRmvCVh5KmuIWF4u16tUKyvz5B0
	 C53CknCC5R6MXp5qeATPu8hiCm9h+LmpKpOofMyaQdniVMZNlVrIaZd5SLqM0/3zMyokI
	 +yxjAhNI3seasvJzIE/GX1WsYQHa8AW1GAff+y0J/yq7NdNG0ikMiHxc1TdfApTJMQmvZ
	 bwZHHWAIX/qgNEXMKipLVgDnnvKoqiUgeHn/AqAovvVDg/E4zm22fH/ultCCS5BNebQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795715673;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=6pT4BOJ1u+pEQkim3pAQgfIOTjhMx/55ctOIhC3tiy4=;
	b=DmCnh20mqETmd5MkhwzPBiwP36TcZdIKmKT1ois8cxdCK00k6O8l7veVgAhA4QL3ApHW
	 i2vGuXBnP9f2c9jrVbwvsj34tD70j+pNwuAMhFjBU6ukpsBjpHAmV0MezNuuPKLdUf96t
	 jm+mHpVszv4KmEDSmn3LCHNfwYSS6Voo8sem2QrKkx6V2dDfWrLCD6fceSYC04MTOxaal
	 dfrhreRWk1aijXNmXs2wfESvjGw36eASas3C+O04OYF797hoiq0DIcYm2CHN+QjQp/04+
	 MbsF6jVaZWv515cG2CJk9lNZMh0R6G5wrUfaBY1JGxeCJr8FS7/vXk/sIk3BNXieQVw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fr1j5NRI;
	arc=none smtp.remote-ip=209.85.128.175
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99E11606A31E
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Nov 2026 17:54:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 99E11606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fr1j5NRI
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-8b4c685c751so63686717b3.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 26 Nov 2026 09:54:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795715671; x=1796320471; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=6pT4BOJ1u+pEQkim3pAQgfIOTjhMx/55ctOIhC3tiy4=;
        b=fr1j5NRIQLgDHbr5rSu8Vulgm/o3PP/Hp2+3/XBrHWa5BEvP3RLRTRiUnvTuocq9ag
         ua1CTGWdOIXrotXj+h09sOBvU3SagDDsEE1z1RFn99takf6jjMchaBxyqBVl9URXcoXM
         K3btSwjENPB2rkHNx0kaRg/gmjAZwtxtPSY7CLT69a6NVocRSsuWySD7XrSUUBBsLLPv
         Rdwv9h82hWiIm8PY47rL1WorkpD/r2fmWm9fwyJ9vFPn1us4XKj+Aw5qYfveiHhMDNgz
         Cni0TBoAoz8dEqH4t+Ke70E9W2j2KXK3y90XYYwDnwfHYVg/Kx1vpRBX9ZdhyZygQg2N
         J0vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795715671; x=1796320471;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6pT4BOJ1u+pEQkim3pAQgfIOTjhMx/55ctOIhC3tiy4=;
        b=A3uEhJ2YSs1cKGk0djYWtwxZBqff1wR6oDi+PGTji7OAD73EVYixE+lnsad0CZE9CR
         BdEMCeEUj09z4/FY4VOTbkj/pCgcXbqtHedPc48OuYh9Y1CRkD/NIfYJaA1v9xs6ubRh
         OiodiQeORN5xs9kE2PExSOpYKHGAwwxnpkfXfxiOjqojuPCm5uPxkcZnbXwc2ln348Zt
         i3yV3Kj0xQHzHgsoKESLqi/2gF7f6lNHit0mQuhyD9J28ITMWD+rSXyZ1HbXL7gjPwKh
         MrN4QHU9LkALMdxxZFZHAWrZr8TxtducEXn+Z7G3Cum+vzwo8Q9LogAfl9NbjjJQZZRH
         3U8Q==
X-Forwarded-Encrypted: i=1; AL+hErEyxsfAiyn+xWM2d1vlsbAE0volpP7o2dNcfjqu3tbnVp5LhSLjERZhgvASEcLlSGa+wfo5Waa7y9iyV7zw@vger.kernel.org
X-Gm-Message-State: APuU4Z/KdAmcUtf6xyjCHtM+58shUzZ4bZ+3KguCR9hMQaeqnx2PrcX+
	IvuBjmkZZjosRUFxeKiOXjoh3xt+wINSqXlS3FOKaIfzAT/MVV9/2p0=
X-Gm-Gg: AZFdTZdrfspPwz1VSOU+ztGeChLPcxhFcvrmI4QZ7uHLOGpjqpfidqJrJJ9VbQw87uH
	Xfq2I0PzclFvc1/0tJX4U4Xi3ImupyIjKEIGTsizOOgdHm/C3XTlH/E8BbTHBZp7ZsNrRr8Eq5j
	f28yj5RfNUp3YqaVzg+LbU/Yv9V4tP9eBHmMfGO+CqJVL5WeE5p0Y2SYVC1/o3B/WN83qbjTD2m
	wzKlCkYaLM8GKwVYv6R5TrD4P6lIhzZCqzNBJyJBVo+2stueuTg6mkTAhJSI60bX9I6lmfUFE70
	wTIKPFWAFN3QrFugXKwycOLNOPb3+G++gE0ggfe6r+hErt3DuV1rOtvpKPtxjYQK5e1LqyLx/v2
	JQDufIcENjYhKUN2+8jC90l4K/7wenL1reiEjcHyFBgvH9OwZtHwLLHZFWJ0qhtBV2Cc4V+a5VL
	4YQgEtDqyeLIrEc9IKoWR5E7j7HdOW8qPLz4clpmcKhDQl2/ts2//TJyvijeEXrB3PYe5oSNLP8
	UK9Qo+0YQ1Ou+mjcoAC+ClADTkTLnY0XHIQ02cps/XlI5Xkf2+krM4KaLjk0ii3Qf8fwIu3rDmW
	EXfLIx7FKOVoSg==
X-Received: by 2002:a05:690c:9b09:b0:8b4:a39e:48a2 with SMTP id 00721157ae682-8b520436896mr80575217b3.21.1795715670603;
        Thu, 26 Nov 2026 09:54:30 -0800 (PST)
Received: from 3511.attlocal.net ([2600:1702:7a3e:17b0::c])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b520354770sm88243017b3.42.2026.11.26.09.54.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 09:54:30 -0800 (PST)
From: Arav Verma <svav2021@gmail.com>
To: brauner@kernel.org,
	viro@zeniv.linux.org.uk
Cc: jack@suse.cz,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Arav Verma <svav2021@gmail.com>
Subject: [PATCH] ramfs: drop unused includes from inode.c
Date: Thu, 26 Nov 2026 11:54:29 -0600
Message-ID: <20261126175429.1035841-1-svav2021@gmail.com>
X-Mailer: git-send-email 2.47.3
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

inode.c includes <linux/highmem.h>, <linux/time.h>,
<linux/backing-dev.h>, <linux/sched.h>, <linux/parser.h> and
<linux/uaccess.h>, but it does not directly use any of the symbols
they provide. Drop them.

Signed-off-by: Arav Verma <svav2021@gmail.com>
---
 fs/ramfs/inode.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/fs/ramfs/inode.c b/fs/ramfs/inode.c
index ef91b933d4e61..a8c14fca06561 100644
--- a/fs/ramfs/inode.c
+++ b/fs/ramfs/inode.c
@@ -25,17 +25,11 @@
 
 #include <linux/fs.h>
 #include <linux/pagemap.h>
-#include <linux/highmem.h>
-#include <linux/time.h>
 #include <linux/init.h>
 #include <linux/string.h>
-#include <linux/backing-dev.h>
 #include <linux/ramfs.h>
-#include <linux/sched.h>
-#include <linux/parser.h>
 #include <linux/magic.h>
 #include <linux/slab.h>
-#include <linux/uaccess.h>
 #include <linux/fs_context.h>
 #include <linux/fs_parser.h>
 #include <linux/seq_file.h>
-- 
2.47.3

