Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2020319857
	for <linux-fsdevel@vger.kernel.org>; Mon,  6 Apr 2026 09:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775466596; cv=none; b=AMmy9WQSvTNcB9PnFtZAEUcv1zRpue8CFdO4nEPLN6TylfV0roomm4dIKv0HkKxqSN4bzIXAj6rhvkNdCaTO6/C0NAnOlvzuZJpd/HnSHVqPiOtcoTZxSUZD1IT2agjWH2ic9bJGGuDFlmaBSq5Ip8XEkBNTsmJTnkO54YVq88s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775466596; c=relaxed/simple;
	bh=dHkShzaaB1FzwSSJnCTbci/A1jSN+Xil0HDTvzSXpKM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DnY+YWIDjV5Xqd2sJ07t4KGL8wB3VHhlw7wDhA0vAoDdVG+ixO4n4HLRGaButO34HTQkMDwR1Pg1c/jyKlAbJb5Ehj3zkJkCIy5qSh0cWP9bYDqXmPjTR2/y66Uf4j+tMDtkQ4gp8CsNanCMKFooozpEaWbKqZ3K0r9k4QElLxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pVMcxcwM; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pVMcxcwM"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4889e045bc6so21596575e9.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 06 Apr 2026 02:09:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775466592; x=1776071392; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AXHc8wsb4o8lZNG+myCrfyCC4E7lywwXo4HWR9KJ3SE=;
        b=pVMcxcwMBMiAzARSBYrWqs0H2xcjCl1BO2gTLJSbaDbRcPTFP+N9cJ3xb3MgeJTF6C
         JEpe4UdcW+/iXTgrES9tYl5JpVBe9v6bmINdW6O7QRv+ioUolYCyha8e8VUToW/MXCyg
         +fw29Lc2uOBx/MhvFlX3ec4uecJknieOpACzU37j6o2Zx41oUffTHRrkwQvuKPCR7Pwo
         C7yV8uzg69QheA3lsBQBrwfMtJId4DNP5rjH0EqPYfz+JUAsybOKnUA8b12kjeM26yyH
         f2a2QCH6O8ClGjHfwA2N+0c//DqYswoq8UpX7jv3V7rBD8B3O6cy8OXgdQiRVz0PNHXv
         6pVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775466592; x=1776071392;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AXHc8wsb4o8lZNG+myCrfyCC4E7lywwXo4HWR9KJ3SE=;
        b=O/DPzcBwsTUHGlaBuh+rlqmAygtTFUNNqkkRtYZRMrg5fM2DlCA09RPX2K6qroa2fs
         Ogt7zTv5+F4GhzKeg5H1HPNNMqx/XGDX0urRH0o3ROYlOACjRfARKehZNOGpqsxQ6Chl
         EyLMr9T85gtNoo3Yrt/1SZqVk8PoR9KAgT9A68612Q/YseE2MmhZr9BL24GPeridsgYM
         UIkTM56ztGYD2u7kvWfGrnCRkN8xlRZHlhZ+/YwIhMkL9XkEYOU1XCd4dEKhM4YQWNtA
         +wAgYcFx/8Iq98MXTUdCmgPu9hyEH+C9C2fBuet1SclU3/EKZPDJW70M3VyiU7l0AwQM
         jHYA==
X-Forwarded-Encrypted: i=1; AJvYcCWNeO2nuSF6d/2iujubcJBcDQM9ceWNOEg+utY/7wWY2NfvEjMRz8WEF6ze6TNYlLkIS3Ydi1Q/Hdm2261A@vger.kernel.org
X-Gm-Message-State: AOJu0YzWKu3oBcOXMxxoB3TnaU6gxfOWvOuM78XfkE9ZsQno/zNR15yM
	m/RArEINmV6EFzuP0XpTSSOmLR6M/H1xopuYn7kmoBRM5IDMinie0A5l
X-Gm-Gg: AeBDiesxBCPOmjDJB8+KUIpAMbCGEcRSpilrU/ymfHqgcIkdht6zl0xcC6Ng8rlN/cL
	93UxmHZsTqhsD0EVIjtUBisEMNDNcqBjG35nuVKLM00oE0LZ3KgzUBnrfTa1mUTa/1rJlRA/b/U
	NO5p7SIpdv6hOoHuqI6d4AWKIAs+dbznAuqKHfoESzuM3ZB3Q7JOGUJ3x7RKuzT/eFnPAUi/POK
	imwGlhpe1CivaK7WY21e9QAoQNmcW7hUsvBfXM0HK4P53fTRQ1A+aQO391VCA3tMgr9z2TwLli8
	oWS9OdHMIi9gA6/+1bWOa6MqOB9dyaV5PJe8ZfGNfIh/qH0IBcxhqWGobSPFLh+YeUKlBBfTgf1
	V5pcuRamQPjQ547qip8y7JLOUaXznjEVLo7RuQja1LAFR41/CfU160fHmT831tBL2rBsBzy0jfv
	19Rcb9mbckArfSoDrQ4RA=
X-Received: by 2002:a05:600c:8b84:b0:482:f564:d613 with SMTP id 5b1f17b1804b1-488997b2345mr174598415e9.15.1775466591913;
        Mon, 06 Apr 2026 02:09:51 -0700 (PDT)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4888a7165aasm427753755e9.14.2026.04.06.02.09.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Apr 2026 02:09:51 -0700 (PDT)
From: Askar Safin <safinaskar@gmail.com>
To: linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>
Cc: patches@lists.linux.dev,
	kernel-janitors@vger.kernel.org,
	Randy Dunlap <rdunlap@infradead.org>,
	initramfs@vger.kernel.org,
	David Disseldorp <ddiss@suse.de>
Subject: [PATCH] vfs: init/main.c: change comment: opening /dev/console may fail
Date: Mon,  6 Apr 2026 09:08:15 +0000
Message-ID: <20260406090815.1495095-1-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch is for VFS.

Today comment on console_on_rootfs says that opening /dev/console never
fails. This is false. The opening may fail if /dev/console is not
present in internal initramfs. So let's update the comment.

I tried to fix the problem itself in [1], but the patchset was rejected,
so I will fix the comment instead. :)

Link: https://lore.kernel.org/all/20260219210312.3468980-1-safinaskar@gmail.com/ # [1]
Signed-off-by: Askar Safin <safinaskar@gmail.com>
---
 init/main.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/init/main.c b/init/main.c
index 1cb395dd9..40cfda9aa 100644
--- a/init/main.c
+++ b/init/main.c
@@ -1645,7 +1645,10 @@ static int __ref kernel_init(void *unused)
 	      "See Linux Documentation/admin-guide/init.rst for guidance.");
 }
 
-/* Open /dev/console, for stdin/stdout/stderr, this should never fail */
+/*
+ * Open /dev/console, for stdin/stdout/stderr, this may fail if you supplied
+ * your own internal initramfs without /dev/console
+ */
 void __init console_on_rootfs(void)
 {
 	struct file *file = filp_open("/dev/console", O_RDWR, 0);

base-commit: 591cd656a1bf5ea94a222af5ef2ee76df029c1d2 (mainline)
-- 
2.47.3

