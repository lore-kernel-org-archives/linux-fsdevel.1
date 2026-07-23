Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 087334749DE
	for <linux-fsdevel@vger.kernel.org>; Thu, 23 Jul 2026 11:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784807351; cv=none; b=uSScEuwglMpmMEaqs/Ee+IZJqvKMzZ7EZUHwXiogZMPKf26jf3+D4ddjWzCF2TTWm9iwPtc1Dyv2c1WcQsnRorohs1K1TJ6HYtHQmwrSK3dZoj+zVqgfOvwMMILxe6NrEPjo4Winifri/WcQOBxmVYRfb64lDDox95Ob++64rYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784807351; c=relaxed/simple;
	bh=yw8TD+KZcKEy1gNKvBPU8Ftjuxo08mQRXLrdb9CLtPo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q432pf7jFuxqaJr4AFMIY6vYYNzCEFvV/ZHFx4ebYr/I74eXYE+QFzjnQo/rBSHPhKvHrKVYEyP+TvCr2DQA9PKbynNNp1dQ5dqsuslW1HPXi+am2FaD84t43tQy3KUeMv4Ed2JSgVAkG/y7Q9IxZeevGqNVwgcVnTGtF9W6Zmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YsPN0Paf; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YsPN0Paf"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-c1670dad7a8so90091666b.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Jul 2026 04:48:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784807336; x=1785412136; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Xz/m+fX2i+fUWdXbPZIahRwxObYoI0qXtVZ2x9IsBFs=;
        b=YsPN0Paf6OslhnbtX0x7P368FtTVape1a0mrk8sAl/ubN2izCplTOeYD9e/FHY9Vf+
         Yu78x3IbM4zJguVjVIrBg1TTJlib6XKMyU9n8iSe0Y720MTL0BsdX8ET2vXoBToEremf
         00+d/xn7A2AV49Qktd7XqoUgZ6Bwus3goaBGQ1Pk4EOjPgjYQDoFkvyC2rNDsN2esaNh
         x+hY2C4UlkeSKZ6zypvXS2rfhh3KP0RzWsWP7gtoUgAgys50BufpDOA1ehNXDYRDhQcL
         4YLTlQmWCOQvc9vVtHq1XKGFZTokFCiFdzgWDwF3OilwxpON+DAwLymWrF8pnNMG1DYP
         QWNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784807336; x=1785412136;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Xz/m+fX2i+fUWdXbPZIahRwxObYoI0qXtVZ2x9IsBFs=;
        b=e5BNAOq+m7IwmPjWlPrCiTaiDb7HfwwsjbrBNccMi+MxBLJS0WGYMi0tZ9RotDyanM
         IaWtEzGp5WWB0gmlGlQlQ/08MirqfhU05qwwCUf27BKKmYksk+fAqqgysrV9MKC0aXct
         fG2qx3k3PXA6mt7yF6eTVT9clpaMbU5HJsuUZ7tEXcEQty3FhEmdS0B1Qzu/ZwCLNcI1
         og6FhwUW7ZbZJraTDZdUiNwGBhj39LaVvByFd+ViYfcEB10VUPEPfsQeq/Mn7OzGcVa3
         ri8kvCRdAvr9bK76lfsY3SPKs/yDCrsNOnezrR3S5odeWioatBVBdw8ekitXwHX3sJ+4
         9NYA==
X-Forwarded-Encrypted: i=1; AHgh+RrGvHtPxREe3x2r52EpdEeY8bpTSMaARWYKwZgD+37XXL5bz2XSqDDAKfq2OFfJweMJQChAmLjvAFjcP0U6@vger.kernel.org
X-Gm-Message-State: AOJu0YyMrhpUGe6IBywNz7Vmcm4HOMzkg7ZcKxi3JG5N+dScB95vSUWq
	PQ8dLmqXDloMxgLb15RWk7PWGB+pfIV5vSKxpBgoGwBudrI2k0/NTqrm
X-Gm-Gg: AR+sD12HZW1izCkn1Mp9jDl+eN9QDszCgB/UHpKiZAqupF7r/rnr7mNvwb+68r5Q+Ff
	9OM5WDGDB0pDZtkXAVq6RQOO87PLFnoiovWBJDY8nG3gyCfhbrdbXQboJDPiB7ZN9mDWRtYaSR9
	1VaoqtmORQLUAcFrDcTStR8X29LtNQ/xtaQfDBEb2Qa4rvoeEfw4j6jpBBUrWyN3hFQNnLnsUui
	g289hHjCGkSxd6KC9EsXm3YFKeo0wwEjQXd00ylVA8+PkVuN5WPG4DvyJDGAM7xt2Q/i75hPv8I
	pp1gfq2SoncjgDPvtlsO+wzU6Eqr3pA1XqlmQFsX1Dh4zCGkgCHUvE2Xm80dWbsM2FSe1m2F7Hz
	Ur0I18nRiFm5bNjmQL/w2c/u7SHTkVg2VKJ8icvxfrbrccJmAne4V6O0ArS2/KI3n7U9hzX1FY/
	c1OuFTEoZwdYYxSdrNW8A7jsWFpXI=
X-Received: by 2002:a17:907:72c6:b0:c12:6c88:bb33 with SMTP id a640c23a62f3a-c1c50d05f13mr144470866b.65.1784807335514;
        Thu, 23 Jul 2026 04:48:55 -0700 (PDT)
Received: from localhost (178-84-201-199.dynamic.upc.nl. [178.84.201.199])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1c32f13cb4sm226388066b.61.2026.07.23.04.48.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 04:48:54 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>,
	Daan De Meyer <daan.j.demeyer@gmail.com>,
	linux-unionfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [RFC][PATCH 5/5] ovl: add support for copy file range to another fs
Date: Thu, 23 Jul 2026 13:48:48 +0200
Message-ID: <20260723114848.1212429-6-amir73il@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260723114848.1212429-1-amir73il@gmail.com>
References: <20260723114848.1212429-1-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It is technically possible for overlayfs to copy_file_range() to
the base fs of the real layer.

Implementation of copy to other fs is a bit more subtle, because
we must not take the other fs locks in overlayfs code.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/overlayfs/file.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
index 169a48de565e9..cc52ccc35961f 100644
--- a/fs/overlayfs/file.c
+++ b/fs/overlayfs/file.c
@@ -535,10 +535,23 @@ static loff_t ovl_copyfile(struct file *file_in, loff_t pos_in,
 
 	/*
 	 * Overlayfs may be able to copy to a non overlayfs dst which is on the
-	 * same sb or same fs type as real file_in fs, but not implemented yet.
+	 * same sb or same fs type as real file_in fs, but we must avoid taking
+	 * the locks on the foreign fs.
 	 */
-	if (WARN_ON_ONCE(!is_ovl_fs(inode_out->i_sb)))
-		return -EXDEV;
+	if (unlikely(!is_ovl_fs(inode_out->i_sb))) {
+		if (WARN_ON_ONCE(op != OVL_COPY) ||
+		    WARN_ON_ONCE(!is_ovl_fs(file_inode(file_in)->i_sb)))
+			return -EXDEV;
+
+		realfile_in = ovl_real_file(file_in);
+		if (IS_ERR(realfile_in))
+			return PTR_ERR(realfile_in);
+
+		with_ovl_creds(file_inode(file_in)->i_sb)
+			return vfs_copy_file_range(realfile_in, pos_in,
+						   file_out, pos_out, len,
+						   flags);
+	}
 
 	inode_lock(inode_out);
 	if (op != OVL_DEDUPE) {
-- 
2.54.0

