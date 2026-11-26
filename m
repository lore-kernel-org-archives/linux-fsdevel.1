Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795733039;
	b=s4Sc42ObOxMmd3yshHdPMJAaQ9kxUamLw0HHsKf+Ewosuvfy1oVd2ay/jALiH3Oaydo/
	 Bt9JrcWb49FRvJiCn6jOUmdxYbljkhWGG+JGAeb0tBOdSAR0ogg6DorRIQW6pY+3DF0wD
	 vgNLun7UlqlxIST8YkxpX2XimOUilb8Qixf/BemA9QsWsL4Uu3wmvvj/W4wYU0eYM89Ix
	 yjwaP5y6kiOuZkdi38vHM39wv5f/ZyjtJTuESkxBdveGBX1FAKhQQrhSIaYOah76hFjbH
	 zXw7xaCAF2tkGlhy+jKPNHqzutNkCoU5Q3+453q8bNsmLNYqn4qy5qBAquMBAM0YGaw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795733039;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=cLa+CAwX+D2UaLX+KhLXrVWaDplpvg83zGJVrNeSRbU=;
	b=zdkFVDi0L8MZi5M1Cne+7d8PrSuFX+hxOb5YF/fxxkS9isVReyl8m3ZJYoofJFpK+lTE
	 vqVEP2wKLneR//gPcuI/c4KkhisHZ8HRNDfrn6q0Tzl/l5Dza6xtWzq8iAQbaavWwnKZp
	 NGO2d/hY9BabLM+0MEIO3T0aA492r9TcjHedC6KM7SoEY8nQMYYcPH/5k3LpBmbcMZJi4
	 769LdNk3PnYcVmqGsKI1RvKoFG9rt8sORBoMs5i16emxmpvvjSZYJW9p6ri75bhc534LM
	 UF2SeSkExvYQ2lgFjJHALc7t97Fvp0N+9oVhzjt603AAuNhUgI1q0XI++qBvIz/2Yrw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Nxh9Cl5y;
	arc=none smtp.remote-ip=209.85.215.171
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAE72606A31C
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Nov 2026 22:43:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DAE72606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Nxh9Cl5y
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-cdb2893531bso3915089a12.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 26 Nov 2026 14:43:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795733038; x=1796337838; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=cLa+CAwX+D2UaLX+KhLXrVWaDplpvg83zGJVrNeSRbU=;
        b=Nxh9Cl5yfsEvyxwPii+x2gA8Em9TuQY3w1Yc5Haj1KghoOG2Z4czmQvTmaJ8dvaIeU
         sZ7WpqmRYUfc1vaeoyWphtWjIGfsa/NHLLP/8Nb1GfZ1Mi2ik9HEVSSHeSEsQ5hDVJbj
         pQXsO4ZyLDbXL10fykYGqgd5TTRynNjWypHGlozvgIA6kfP+cuLBVuW12KxxwO70l8//
         kmB0n+BOPDvRnk2eZfs9hFDHWMKg425EjmKWecdvCMwf+3rElfO+WlfV8Ytrk8FY/pwa
         9qikW+0IHEXneMg5Jmmwf0mj+RqbU/nb4mhClFnlt/op5O0vEwzMg25pU6GrGqz1+rrU
         sKCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795733038; x=1796337838;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cLa+CAwX+D2UaLX+KhLXrVWaDplpvg83zGJVrNeSRbU=;
        b=yeT39RhumLressGbtGrOYyWDorGL3356A+Ei4nJVDS/oz/sJa/Vig/9KV/xM2wCCUG
         ifX5EPpHqW2ZSqE4YqEyXWcOCR0TBAg766Y/fnw7njXvT/xU3hQ+fByWWHHsElNZ9tyM
         QDxDwdqgUfP7YY+BncM2fNOC81Ze1uju+1wz4jyoOJF85fzGxTKbIqC4h4nQNZyHV3NR
         poPp3PO6JZYHaHmGcjTLV4sPpS6zj3rv8ZmkGP6M+TzTx50AfeSZSmnK/m0Ytq0n+ivD
         a+GGTD5KvswySZvaNvzUDYVRbu4Xw4cPRYvU0Z+bSo42nZlaWEP/caywnyUVgrKiSrck
         Uw6w==
X-Forwarded-Encrypted: i=1; AL+hErFYTnwy+4dwdpKugYQlyz7V5t5iHZ7DoMP4jiRbeV6H9lbMD7KYr18kglj835mb8pjufdWhT03czOX54Udo@vger.kernel.org
X-Gm-Message-State: APuU4Z88zOunZrb4xEC/5hjwCiNF3Ok+NcCNex4jqSGxj7fpKsQfOHN1
	wZua20mvxjVZhpJbHhpR1nzMJ6nECpP/+yVD1pG1IMOFv3y1dLum51+K
X-Gm-Gg: AZFdTZcPXNQMJM7rYmItXPt3RSuGAT+CKc7y5Rb2P8AbUSPlotLanfoJmds6h5CPctX
	H7rNw4W/xej+03vVFFgslIVqeuGe5+Ox3IhpAoI5MqDGePwfTcCoK1HF05tlWSeBjYm2BIXqOmW
	zqGUlrdbrBXVt9Mj9rYKb85glzbAK/o9ud+5NuGHZUgLQT4OaZDAJMoOsmaZ77e0OY1eBLnPoHd
	WbyRTfMxaX/QzfV2fIOBD6akmcJD063POW1BZHGAeJOqwMdZ60Ok1WqIFSo0SYoDqCnt/gDCJNn
	RzT2arNvjRja0Cob5d/YHTCnJjJaRmHJELcXxNQIEUZU4uFQ83/SOGCVlZ3+rPI2JS2EHRdkqbm
	UPVZHDRoyL8llvUxKAmEoAwop0oKnbzTX4UvEnD2VU/kMhJ5uUWdcLIGpObaR0r4wb8PiGglLqC
	FYe3LCNE+/UW36c0xWAIb7PghZqm2tV+G44xJMvl/XHbxsVDXB/ULtVHzSTmPjHCgGIRv9vueFU
	TnWuhe1QBk6Ot/1MZL9gOn7ZxGqKyAI+zPQd3nxAzO11uV5Z/nuTlhC0yWY+vxZYBBjhCp8cWkA
	ryGqCKjpnGpvl5CuGhl4IEMC1AkD/b0cCq4omPB2LCzSCWy5zg==
X-Received: by 2002:a17:90b:2c86:b0:3b0:a9de:9886 with SMTP id 98e67ed59e1d1-3b41c8d9179mr21639195a91.12.1795733038229;
        Thu, 26 Nov 2026 14:43:58 -0800 (PST)
Received: from localhost.localdomain ([112.170.44.210])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b420e1307csm33755428a91.7.2026.11.26.14.43.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 14:43:57 -0800 (PST)
From: Junyoung Jang <graypanda.inzag@gmail.com>
To: Jan Kara <jack@suse.cz>
Cc: Junyoung Jang <graypanda.inzag@gmail.com>,
	Gwanhyun Lee <gwanhyunlee@gmail.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] udf: check device specification EA size before reading impUseLength
Date: Fri, 27 Nov 2026 07:43:52 +0900
Message-ID: <20261126224353.1552397-1-graypanda.inzag@gmail.com>
X-Mailer: git-send-email 2.43.0
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

udf_get_extendedattr() only verifies that the 12-byte genericFormat
header and the declared attrLength fit within the inode's i_data buffer.
However, udf_device_spec_valid() reads the 4-byte impUseLength field at
offset 12 before checking that attrLength covers struct deviceSpec.

If a crafted UDF image places a truncated device specification EA (with
attrLength shorter than 16 bytes) at the end of i_data, reading
impUseLength triggers a KASAN slab-out-of-bounds read in __udf_iget():

  BUG: KASAN: slab-out-of-bounds in __udf_iget+0x3d41/0x3f20
  Read of size 4 at addr ffff8881025a0f27 by task busybox/51

  Call Trace:
   <TASK>
   __udf_iget+0x3d41/0x3f20
   udf_lookup+0x1b5/0x1d0
   __lookup_slow+0x18f/0x330
   walk_component+0x2b1/0x4e0
   path_lookupat+0x112/0x670
   filename_lookup+0x17b/0x4f0
   vfs_statx+0xd8/0x160
   vfs_fstatat+0x77/0xb0
   __do_sys_newfstatat+0x9f/0x100
   __x64_sys_newfstatat+0x91/0xf0
   x64_sys_call+0x331/0x9f0
   do_syscall_64+0x47/0x110
   entry_SYSCALL_64_after_hwframe+0x67/0x6f
   </TASK>

  Allocated by task 51:
   __kmalloc_noprof+0x13c/0x250
   udf_alloc_i_data+0x19/0x60
   __udf_iget+0x2b03/0x3f20
   udf_lookup+0x1b5/0x1d0
   ...

  The buggy address belongs to the object at ffff8881025a0000
   which belongs to the cache kmalloc-4k of size 4096
  The buggy address is located 3879 bytes inside of
   allocated 3880-byte region [ffff8881025a0000, ffff8881025a0f28)

Check attrLength against sizeof(*dsea) before reading impUseLength.

Fixes: 9a2390959685 ("udf: validate the device specification EA before using it")
Cc: stable@vger.kernel.org
Co-developed-by: Gwanhyun Lee <gwanhyunlee@gmail.com>
Signed-off-by: Gwanhyun Lee <gwanhyunlee@gmail.com>
Signed-off-by: Junyoung Jang <graypanda.inzag@gmail.com>
---
Tested on 6.12.118 with KASAN; with this patch applied, the malformed
inode is rejected with -EIO and no KASAN report is triggered.

Disclosure: An in-house LLM-based analysis tool developed by the authors
assisted in surfacing this bug candidate and drafting the initial notes.
All root-cause analysis, patch code, and QEMU/KVM reproducer results
were manually reviewed and independently verified by the authors.

 fs/udf/inode.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/fs/udf/inode.c b/fs/udf/inode.c
index 29900065673c..b4e34b345ff8 100644
--- a/fs/udf/inode.c
+++ b/fs/udf/inode.c
@@ -1345,10 +1345,12 @@ static bool udf_device_spec_valid(struct deviceSpec *dsea)
 	u32 attr_length, imp_use_length;
 
 	attr_length = le32_to_cpu(dsea->attrLength);
+	if (attr_length < sizeof(*dsea))
+		return false;
+
 	imp_use_length = le32_to_cpu(dsea->impUseLength);
-	if (attr_length < sizeof(struct deviceSpec) ||
-	    imp_use_length < sizeof(struct regid) ||
-	    imp_use_length > attr_length - sizeof(struct deviceSpec))
+	if (imp_use_length < sizeof(struct regid) ||
+	    imp_use_length > attr_length - sizeof(*dsea))
 		return false;
 
 	return true;

base-commit: 25faec9ce61c01fb45abf812a222c5b43c3cd5c5
-- 
2.43.0

