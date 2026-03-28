Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 661F5346E7B
	for <linux-fsdevel@vger.kernel.org>; Sat, 28 Mar 2026 15:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774712305; cv=none; b=Kh1reMHHpI8BOglZHr90TSL8Vh+8c8yYkiAoMMHIpaYsPqds9qZgGJHfeNiTFneZX2lvOB6xQ53wWDElNsPIggEkDhwAEf99ul1g88fj5CCWliszO3rCU5EEiJaTLEjS2gEeamIwvJIMBVYQvPV0cL2ab5FOe5L4lAE1FxwA618=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774712305; c=relaxed/simple;
	bh=q6/M4OdZtc+alS1DwnvRyoUObRGRNii9NRUn255hTcA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dlr8SbmoO25WQavOC6xs2CxjBiBONwv+2E35O76JEqRfzrWbWUPgpNC9SoxBb+WHJcmnR7d97s+I55TSuKApFFccjWDfjtP2wcitzdskFs4MTqFnNhdR69WJRIFQqe3UYq6g1+fV1sUYZXe0mf54rsChry3shGRz/pXF9mmzrBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QF/Gbi2q; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QF/Gbi2q"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4852b81c73aso26902115e9.3
        for <linux-fsdevel@vger.kernel.org>; Sat, 28 Mar 2026 08:38:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774712302; x=1775317102; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ALuBtMTHfXISMz1y0xRBvnd5xru82Lmp3xXwNF/dfxA=;
        b=QF/Gbi2q0o/KWwkSr9Ez1TYLC41KIYVclsMtVZO3yyDh273mN2KuPYtb7gnSGRqqSn
         kHX7ddaOSWY7h0R/QFgEL4T75DNvEAdrnYhqh+fknG+4OD74L1f/3UpfNaMResFcaQqh
         1WB6mViLC5T/+as/7PbJ55IZeUjUv0QLBvwOyuJiUmgJHh2Sexf1yV5bEPXt480eramS
         MZiHswyD7+Z7wOY7tp6Ix3CxugswoNWFaTgvdFiYiQ6cM7AvAe4LJQJ0EykWxnJfZ6kK
         HuZz8b8fQln5YHGg9jo/pvi/48D9Dc/bUdtLgphQ/66mbq6TWgPkJW9lQdrwb6Axk6fg
         x5oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774712302; x=1775317102;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ALuBtMTHfXISMz1y0xRBvnd5xru82Lmp3xXwNF/dfxA=;
        b=riTXzMDQHmNCYjL/SYotzmvXiFnpIM6/zCnuFVzllxYSLd1NWD4eE+vk4EVAxhS8ZC
         yJJk/spbENCUv7J9TmiN03Mi9YNeLEcF6Uwc/4ycDmof1DdQyTtGiK7RmRO1cW35DbPx
         3r8gGIR/zhONhtU70+lEsUuULwrU2D9rmBwERsWzEOHjTgWR5LjyN9FLYPbRrdMGlxXA
         hHQaWBd7k1o5n4TJ6DR0uYtOwrrOnBIZDoOB/5XX+/1oo/AnnwXCCV1Q48CNePlaPYLy
         ll+Ol1MR1qI4eEKt+V7yOdXG0/UP8fokLHh+OfO8l7nsFvhAOtAzkcUPELkFpIc6DwKj
         PGkA==
X-Forwarded-Encrypted: i=1; AJvYcCUrNEL788+XLX+WTeIPMBNGL3bYbqiBNdl3vUF/1sqhYaNqvVFdOTy5we7L4/J9hRWfFKmxHVKKr+DVqViO@vger.kernel.org
X-Gm-Message-State: AOJu0YxfvcDkWJ8vv8h2LL0nWtMCouTITNJDLOHlShLNbyJz+JC91JmE
	TyObDEDRCy9IMtXS6CZha8Rc2dgYjcv40v/M0Z/whgVQ2ClBQ5g61x8u
X-Gm-Gg: ATEYQzzRl4kWdi3X41OFrxCsIcQmMrxRJevaeFO/lW4cfCZnafYwKDXlWsE17QhKyOf
	Y2WrLmQiuOoN3q/+RzfXovPPQd2vA1T/mYETiapnjeC2OYC2Wo1sm5tAGw36mzK4OL28VA0lu32
	EuFyiVZyRt/DleVwidDm4U38QhzKMoHbThkK/nOPndFwDGIZcHUNW71PJpVi5V8e3FCsW+PsBsP
	0lWO/peueGvIHRaR3GyD3wXLOPzCeQHWETev6pud5t7oiCfvUS3BcGCUNHIqqHHAJitAti54Li2
	N+wptacAptbNxpqay95BJlWKQ8R64sdatca91z95kLdOKtUmKA0BsDaQVUuvpK9Bm7JgQVy+js6
	gKSVACpSufGPGqv9yeeJOBDhH5G8ACJKpt7r66Fw2LQgbWFXoC/cTXLeP2iDN80oR09TNKyGSMQ
	gDXkc+csmCuk/aLLj3GmGxLNTFUPoeIofRgwmE+PG08z/MBtgzbPma1zaO1oh3KvrhEFxdqLTfH
	/tW8i98brf6
X-Received: by 2002:a05:600c:8215:b0:485:3dfc:569 with SMTP id 5b1f17b1804b1-48727f5fe53mr101847915e9.16.1774712301825;
        Sat, 28 Mar 2026 08:38:21 -0700 (PDT)
Received: from f.. (cst-prg-89-171.cust.vodafone.cz. [46.135.89.171])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43cf247102dsm7196887f8f.27.2026.03.28.08.38.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Mar 2026 08:38:21 -0700 (PDT)
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org
Cc: viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH v2 1/5] fs: add icount_read_once()
Date: Sat, 28 Mar 2026 16:38:03 +0100
Message-ID: <20260328153807.3368975-2-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260328153807.3368975-1-mjguzik@gmail.com>
References: <20260328153807.3368975-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It will be used to denote the caller acknowledges how the count can
change from under them.

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---
 include/linux/fs.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 8afbe2ef2686..0cf27085a579 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2225,6 +2225,11 @@ static inline void mark_inode_dirty_sync(struct inode *inode)
 	__mark_inode_dirty(inode, I_DIRTY_SYNC);
 }
 
+static inline int icount_read_once(const struct inode *inode)
+{
+	return atomic_read(&inode->i_count);
+}
+
 static inline int icount_read(const struct inode *inode)
 {
 	return atomic_read(&inode->i_count);
-- 
2.48.1

