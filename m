Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0528929D264
	for <linux-fsdevel@vger.kernel.org>; Thu, 25 Jun 2026 02:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782356014; cv=none; b=jc3EF2HLg036f405KQr1MVmQvfAnbCbXQzw6Kg/sQLSASJCrA67+JP42u4XX2X1ssJQss/LO3zeoIpPXymsiWDS0i9yVSya065qOHzdlmxEMJkOz2TgNEq+T4+NGxyf+/ZFeUVJlisbUUbqUKLCUAnqXbzNnsJsJkTv6Mfnyp5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782356014; c=relaxed/simple;
	bh=6dxhHyF91WSlZqBzl9EyOWVa49OuZEaI7GaCTiz/vKQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e3qB4l3BXQ6PHDe0nkueb2v9fkh9tN93pT2Z34UZKLh9kQA+PmfvM1iM9XeevTSmqMljjR0FlOy/6Sfq7KxREl0gLieaoamYU+idtah5timjxBHMn9lPk0JJknlZ2SelEKh7vcjj6pPosxpWovcyHdS1m+jH77qWYbTHQE1n4qY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dkr12fpZ; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dkr12fpZ"
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-7e943356247so1479083a34.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 Jun 2026 19:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782356012; x=1782960812; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yd1pPCkJlR6akp84WzU0lCGb5TteZ3x/UuL8J+rMeu0=;
        b=dkr12fpZEr1qGkYyRtroLqmK8K+oQqYQ0So7XD9Kvz7TYKebhBW8iRvhQqMzd6y22E
         IEI2xNCNv0Xr8XDgmQ0J1JLWcUVP5HxhyNY4q6rDk7ZXx/RAnYMrnFOQ4SfvomgK44pX
         3Y8zapC67eP3CqF2tUx/1LZkEhMtG+eJBu6B198A6bkcAEv7yy5gSSDsjDoX8NGHyb6h
         OeIpqjOif48JVp08JrFp3vpj2PosdKHl8IPeDuA9AVUycrgLdB4SoAjLroKz5F81teyp
         sHVi9NhrV/0RnkjBabD6ooJdqYSELh/3bwlAP5yJnftQPfPK84YE5g6s7FZWDzuV9wax
         VAOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782356012; x=1782960812;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Yd1pPCkJlR6akp84WzU0lCGb5TteZ3x/UuL8J+rMeu0=;
        b=W7ka1tnX1LkwY8HzPi3Qsy7p8VG7hy/Lr1NxagNdeMhogCEgDKznGRv/V2H18/CHIr
         6VbBUdema7Edq2wcmLXShPPerWMDK2s7qXhr/W+fSjUrFjc6vxTTfrolgC9OxDhYM+1t
         ixb7l6bjUhhypVzp3aAH/zWfeTmWOQZAUkMyZ4IDK3BbcpB1p+Wik2fl29Lwrm+3yU31
         MLuBoKIu51tC7sBzz8WvRXYHNpREiYCaEz2tntHDjlkZB1kGhl3IYU5ZNJp47GyNn/rq
         stLUg+0GlasfOFN/ZuchM3DnR6KTPGtiDKjDFbRhKQIinPJtPPiG47ERaocuzyn6a4Lr
         p1rw==
X-Gm-Message-State: AOJu0YzfiIzmlEyi5h/L/UoOWUEGnml/TzA4FXO4AR2sIqWNmowB9cB4
	1TGLJGD1ajE7p35ovMr24Un0rw7LabMWDlBJ8fd4Rqa//EqfBna9QuUD
X-Gm-Gg: AfdE7ckBhDPEiaZoHGQaE9U4CLkeQJoj3R9KptWUxZKqOBSMXPkEoMzP1v8JuWX9MJa
	rqJ/D0QUF4/KtPzWr5c7uu3vRmvZwed9uCa9EjTf8yYVVGgcrCoAf6PC0LTXOYSh1cw1vfv29MX
	VcdbWthfN6rQ6WJK1kkwHGHc4W6x7V2vbMUOaJJqeS8PJ9CkTFHSd5RnZsvLYduFdNbQoAWt9XF
	YhC8keZi6INzWgimqwIMzSgbMS6TmpQdTv9uutMUH982VzDVSHgOmnU/dkENp7BTaCCP5rILQbS
	Ph/Rr/7uYLjh/DFfEQtmpbGBtRk4qusc+CxJbjYNBK5d9tHW2xlBr5mWgMhh5ehPCWKjLe7byd9
	EFZ+8qdX+CkMt80CYk+IKYdW4f4QHxc23ZB8RuaEaRZX8Bn+2Aq/+JMcKATq6zZNp/l26vEszYl
	q4/qM7zQseiMzvDO6TrMvXq1MRgB5uOHGVdwS9lpv+JF/F2cdfWs8lLLn0WhWVOCY=
X-Received: by 2002:a05:6830:8291:b0:7e6:ed97:ce5a with SMTP id 46e09a7af769-7e99c2ec47cmr866758a34.4.1782356011974;
        Wed, 24 Jun 2026 19:53:31 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:6::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e94400903csm13852942a34.4.2026.06.24.19.53.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 19:53:31 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: hch@lst.de,
	willy@infradead.org,
	djwong@kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org
Subject: [RFC PATCH v1 2/3] xfs: convert read and buffered write iomap ops to ->iomap_next()
Date: Wed, 24 Jun 2026 19:47:22 -0700
Message-ID: <20260625024723.1611000-3-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260625024723.1611000-1-joannelkoong@gmail.com>
References: <20260625024723.1611000-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert two xfs iomap_ops to the new ->iomap_next() callback as
examples (xfs_read_iomap_ops (no ->iomap_end()) and
xfs_buffered_write_iomap_ops (with ->iomap_end()). Both use the
iomap_process() helper, which finishes the previous mapping if needed
and produces the next one. No functional changes are intended.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 fs/xfs/xfs_iomap.c | 25 ++++++++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
index f20a02f49ed9..3b212bfe04d7 100644
--- a/fs/xfs/xfs_iomap.c
+++ b/fs/xfs/xfs_iomap.c
@@ -2168,9 +2168,19 @@ xfs_buffered_write_iomap_end(
 	return 0;
 }
 
+static int
+xfs_buffered_write_iomap_next(
+	const struct iomap_iter *iter,
+	struct iomap		*iomap,
+	struct iomap		*srcmap)
+{
+	return iomap_process(iter, iomap, srcmap,
+			xfs_buffered_write_iomap_begin,
+			xfs_buffered_write_iomap_end);
+}
+
 const struct iomap_ops xfs_buffered_write_iomap_ops = {
-	.iomap_begin		= xfs_buffered_write_iomap_begin,
-	.iomap_end		= xfs_buffered_write_iomap_end,
+	.iomap_next		= xfs_buffered_write_iomap_next,
 };
 
 static int
@@ -2214,8 +2224,17 @@ xfs_read_iomap_begin(
 				 shared ? IOMAP_F_SHARED : 0, seq);
 }
 
+static int
+xfs_read_iomap_next(
+	const struct iomap_iter *iter,
+	struct iomap		*iomap,
+	struct iomap		*srcmap)
+{
+	return iomap_process(iter, iomap, srcmap, xfs_read_iomap_begin, NULL);
+}
+
 const struct iomap_ops xfs_read_iomap_ops = {
-	.iomap_begin		= xfs_read_iomap_begin,
+	.iomap_next		= xfs_read_iomap_next,
 };
 
 static int
-- 
2.52.0

