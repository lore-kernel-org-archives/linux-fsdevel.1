Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44E28396D38
	for <linux-fsdevel@vger.kernel.org>; Mon, 10 Aug 2026 09:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786353872; cv=none; b=WULCpsWhgI6b5vnXrADEyBXERkaKjy5m0KgzohBPnA9IhCHVWvYARL3nA9uPxP+sqrNfxKLAIUv8/xBGlyZewniM1Wgnn70VEdB3eqY7tWth+hvFV2Pfql251avVfql8hcp9ObEWfWs0YkdJOuYe4O5EoUug3EmRSPiHW1SQais=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786353872; c=relaxed/simple;
	bh=/qBC/7mUgpptEqXEahTihgpIWaLMGVOgudQpjF6Pjxk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VSVGwkmNnUXzwUdTRvxrHCt9w2E/LMJiR+uxLZ2D3+mv9QUA8tK46BkjMIl5lO1UuwfLMYVar1uM8GxGbpn1MfnLs/zH0Ot0QihA1EbQMTXMyE1CEXcGmTGfG4pvnssxnFdQXeC09PQrhOValg2PX2MGCqaus3wusIxcpGHRr0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JZMKFcP4; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JZMKFcP4"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-ca766c1c9ccso946189a12.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 10 Aug 2026 02:24:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786353869; x=1786958669; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=k7ldNj0eJUVnWcxlhmWvzp8Wx4neTsZd5jvrWXN9nzg=;
        b=JZMKFcP4qhtrmWDv09CHe9FLSaOmbFRnt4f0g5sK1f8bR1LIxuR4qdPZG6VYTpG2t/
         bJf6bAiic1nBzyEWUEbDoXGm1ln0gkbDzyTxpB/63osh4fc8z5dwQprlNGym6Pno40sq
         ogKTn/ewXJyav48IwxIGr/jmwZpZXDbAxrAs/mHIyKZTslfwkqT9qRCIFOwUgSQ9oEPI
         SL3qDKV1H+9ZWVCTAdWnehTYyP8JPfQe8zVJ/IJUtxLJ4P3d97wluD4vynzKKnPgMuI9
         WV5djVHgmJBE0toKoguuw8YrpinZsM3atVKyPoasUJAhvfiYpRmhqWfqpENcTHnHD5Xr
         Zx3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786353869; x=1786958669;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=k7ldNj0eJUVnWcxlhmWvzp8Wx4neTsZd5jvrWXN9nzg=;
        b=VcADgj1YPcCro0vFrKds+4FaghOj76vkzG4/ZB8d0YoyYNo06okkaIiIy+1IfcFzmk
         tkicoHGB9EoTfPojSlJ5fDH/uacKtafp77XyGHDvD3HvQOlKCGrw8vbA9XkN/jlyqBiZ
         ImmPdLUAvWzpBUN72zeATlZJxZxON+hf+ACMGBm5F7HSn+fY93295i1p3JOHTKnsB29s
         70UxTV90BXr6vULl23F+pzTdsVHDyALQ7MHIIh0c+IykkJqYuZlzKzX/v9oaDV6UjdE/
         6Cn/qOhH/q3HxqkxxIa7iFNMLyfcj1NNSnyFyMXyR6eJ2lPedUrdzZKxVwQZRXBkVe6g
         npLw==
X-Forwarded-Encrypted: i=1; AHgh+Rrunp7mDvafJEivoP8OFn5mwAlA2ZDQm17aPrGbO7+3NOWClC6JqOSWcS1UHisu1YsVTgHzZR5hQ//MKGie@vger.kernel.org
X-Gm-Message-State: AOJu0YyuF59XQpuGRAPmvGETuy0PHIQp0XS5LilrePxk1Zuc1/RbFPXq
	W+iv173qNbPVNi3a5604OBe+l26khofV7nFL5OfH+gJP0tOfl7Nqa/K39A7XL7jP
X-Gm-Gg: AR+sD12tZsNdCk7dgbA5pewnwnmJXdwdfnqqY6qxGa3GBANPmX9tJ67PR76y7LAvOOw
	c4O5mc9sppECEZ10S+i9DnPLremF7RSn4fwZIxss9KGRy5yXqsy6mk2d/mlHonltrz5P+YQ+pSi
	QnbDTEc3j7BSZQhJ07LzENlCYLk+g1QIiqDdU7qYVpPxoWRHXxtbFXlEAg0z4laZm6NYbuuJ57O
	Ll9MZLVwSWI6P76tYDuFOgIjtV24hgoW5SyPlzFHpKZOubAgYQHpkxCklhSvPdi4jAq9JjyYciV
	eTBETyxVKiDN/0WfkGQUSs+1qijhFT8EQdxJ4zDzezAXJ1hhVgeDZkJHRASrzdrZVNjTQvNwhSL
	NT6o1m4FAyMQWVlowhr3EgKWunsDqX/9dKxmENFlpZLt8vCe5O3/MWV6tczcmSN6315QvgO4WmQ
	QagVt3RUY2lR2PPsrMCYIPJLTgG06ujhZHMeVMfqpsmjcrgLyFY5S7+yIVSA8T2OyyJpfzbWE=
X-Received: by 2002:a05:6a00:3992:b0:84c:2e2d:57b with SMTP id d2e1a72fcca58-84f2e05d4b1mr40600740b3a.27.1786353869198;
        Mon, 10 Aug 2026 02:24:29 -0700 (PDT)
Received: from ustb520lab-MS-7E07.. ([115.25.44.221])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cbe8f38b7d9sm3562009a12.32.2026.08.10.02.24.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 02:24:28 -0700 (PDT)
From: Jiaming Zhang <r772577952@gmail.com>
To: slava@dubeyko.com
Cc: frank.li@vivo.com,
	glaubitz@physik.fu-berlin.de,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	r772577952@gmail.com,
	syzkaller@googlegroups.com,
	vdubeyko@coreweave.com
Subject: [PATCH] hfsplus: validate extent record length before writing it back
Date: Mon, 10 Aug 2026 17:24:21 +0800
Message-ID: <20260810092422.1691377-1-r772577952@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <0720c3ba6399c11a0a328e8d8eef99a19e6999c8.camel@dubeyko.com>
References: <0720c3ba6399c11a0a328e8d8eef99a19e6999c8.camel@dubeyko.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

__hfsplus_ext_write_extent() writes the cached extent record back into a
B-tree node using fd->entrylength as the length, and fd->entrylength is
derived in __hfs_brec_find() from two on-disk values:

	fd->entrylength = len - keylen;

A crafted image can keep both len and keylen valid but make fd->entrylength
negative (keylen > len). __hfsplus_ext_write_extent() doesn't check
fd->entrylength before consuming it, and hfs_bnode_write() takes the length
as u32, so the negative value turns into a huge one. The copy then reads
data past the end of hip->cached_extents, which is only
sizeof(hfsplus_extent_rec) bytes long, and leaks kernel memory into the
image.

Reject an fd->entrylength that does not match sizeof(hfsplus_extent_rec) in
__hfsplus_ext_write_extent(), mirroring the check already performed in
__hfsplus_ext_read_extent().

Link: https://lore.kernel.org/lkml/cbd7003314c530d4f910eacf019ff80adad6687e.camel@dubeyko.com/
Signed-off-by: Jiaming Zhang <r772577952@gmail.com>
---
 fs/hfsplus/extents.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/hfsplus/extents.c b/fs/hfsplus/extents.c
index 813e68b8ecd6..eb7c11524d18 100644
--- a/fs/hfsplus/extents.c
+++ b/fs/hfsplus/extents.c
@@ -110,6 +110,8 @@ static int __hfsplus_ext_write_extent(struct inode *inode,
 	} else {
 		if (res)
 			return res;
+		if (fd->entrylength != sizeof(hfsplus_extent_rec))
+			return -EIO;
 		hfs_bnode_write(fd->bnode, hip->cached_extents,
 				fd->entryoffset, fd->entrylength);
 		hip->extent_state &= ~HFSPLUS_EXT_DIRTY;
-- 
2.43.0

