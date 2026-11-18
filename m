Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794987069;
	b=kor7n18KtGLLLxaIxehnOWlkUxHvPxmtZJgLeUX8rafVXaFdBz9fe+PGf4kIFt22Fu10
	 gbU1focgase0/l6xq0+4OibKr0SKwWG0fHbyYmp8tvfy2HwMoAoMsK1VkwhXYf6S+rW4v
	 XaE3RuVXBKgZVOgy6m61gxZwYzRXT6q0KBEK9G0LeS/2dzO50FfwA0Jn1E1k94nykh4um
	 K9MKjENQEvf5LKTEx9CV3hmF1zKNQ0c0D+F8gLd0LYyZi5udj+QM5/A/pGKUTvcIx1Str
	 jIje6l7LFqfX2J/JpLjE6dKuPeyQlMMFd7cClRvJCRrapYOh/jRzlBeWXNY+694hnbg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794987069;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=XtmHI7XcbDeAaNo5IizU4KTkmxZv1I16DRko/T8lGmE=;
	b=yMh1419q15O90iqSLyhluqniW/tH+I4XLpobgXKu7jSXwarl5W3Tnd+QGOCUEc6/YjQJ
	 CeQqBBjDdW6tJ621PvnmLLNKqEJ2ZSYMfxn8vQGjPzyB1X0ZlAFZbAIf1h0k0HswfIqfG
	 JYHJiDkQ3mFdh9tREZiW1FDTD++9IDzoNRismOaQTP+7B4lRJmipZRNjgoXbu5Cm/lHn9
	 +VU0gTXoiLNeXDY6TxBGZU3xeyJSHAD+q9436aGWVWcSki/FvSkPK1Uso2R1MsZLqBQQF
	 C7kri8YwesrlWgwrOFPIu3CENq0qTEAJiruLJxcdUMtogQ4DU+J0uQDV35BVolg+hdg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Q5RSy3wE;
	arc=none smtp.remote-ip=209.85.208.54
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C01E8606A338
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Nov 2026 07:31:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C01E8606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Q5RSy3wE
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6b88b74e54eso528474a12.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Nov 2026 23:31:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794987067; x=1795591867; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XtmHI7XcbDeAaNo5IizU4KTkmxZv1I16DRko/T8lGmE=;
        b=Q5RSy3wEr9UpCOLyrTn4GEXVppUv02yUqLn7GM7ryQi83Q2g626PRJjkGNBsEypVg0
         rgZV9/ZComsFO1f3HSAzKiNLImt/h3BGwbn4ATI6Lc8QZVhMQXR4h+yFaswdF0Uxyjzz
         B26XGCOh5i2KcfyLFTk9yBImwy9K2IfJRd/VZf931ff20+wkW1pEsk4xd56sNLlqvOFY
         4LlQYYka0QAcbYEioSthCk7+Ld0iEgHNy00Wk0PUB9cH+b2AC0420Iv4Qc4VHLwegKN4
         n9yB0LJGnMg3/NwYjy4lzcBC6vPstcvzjhtzgv2vvYvKTkqz+JLSffLawEIF1YnWcNGR
         buMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794987067; x=1795591867;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=XtmHI7XcbDeAaNo5IizU4KTkmxZv1I16DRko/T8lGmE=;
        b=tbtj6KsR6UnpwZNrIf8ujAl/jAF8dqGwfMDwrrIOes6A1zvEZA3Ys433l26eV23FQF
         cVh8XmPQi4BzN0JRv12bspD8soouJFjiGwqmPC1TjjfjOLhH9V0luTIWVO5Qf2RmtFXz
         D0neB9kQUowVm5jBibcQPJhRbQyKHwBwGdq+g5lEWh6SXW8qpHUdjDIcGZR8F5gga3R4
         1xP0Fd+ys2vU0GH+M8G8SgwQ5nOrBdVILkGGbej7LhddPT/m8nFfdpfLiEaGHsIZmXcM
         aisVP4y5pOCRs/NZquuDPFg0WFf/KrLR9ypAgEcpJ8B3dnFjTmvI2e/qb/iKsKJIGhR4
         rFfQ==
X-Gm-Message-State: APuU4Z8Hx++u+H1aXasyoe2FMeaWRr2srjbimT1XqBTJg7mKOtWcej/k
	D6teRQUQ6OBITHLkAtgySrajSEJZXHYgASwtS15upgNXp/6EIMKWTYHvcEWGvm/k
X-Gm-Gg: AYBFou3z/OBHvy1Zx0KnduZqeyik2gSIb+EydvGTuKVInn+Tr95FBQ+GgK1ZoRgYQlV
	7V/Y0bJY92licVeHVNOlMQlsdzueWOmTxQ18Tg+YbC0OaRou9TsHsxFXxN+3Nl4sFnv5ejqZuAy
	tNYG09QdNTNKcdIAmJ7C/msBLuBRo3qwSebic1GbNv7bhdXA1ov0cKQWk9XLMZ+LaY6CwGD0lba
	4O7j0rqNjc6ROdOU2IHiwTaQfCEqphXGSBhHOhA0nWTMHkOVBqmavROFcb4YM9oA/v5c4MWoK8z
	E2So2pdRg5MKny0Uzb4Z4dmfa9LUyyW9JDzQlC9qgCPnYDRmSugaB/lNJiPuVPmCsJM+rDrtBrW
	ScteccNnfvfdmEZcDBe9+l0LUbZgzbHSgWvdNKro1Xu8AxWb+TYmccDjMrdGPWYRlZblcdhb85/
	9mDjCR1dlUo/xPAAW7Oxmha5mE+tAeiTNoYhbffmftLwOr+YELSFc1QHzR2ksWYzs3gz03+gv5u
	SbB70JcqMBCxGClqFvO9foHleeMhsqJVo7Jg7Vvd6wd6OrFaeu7T/enxIA5zpTn8dvFGDliR88G
	bU5z6dYRSRMVDDA2Dti2CQetHgpvLR70rRuFp+NsgjIq5GnL6KV+ejykNet8Jsi+B8yKao4Y8gt
	XQPO5eacDU3Q=
X-Received: by 2002:a17:907:802:b0:c49:cfcd:69e5 with SMTP id a640c23a62f3a-c510e2f11afmr132556866b.32.1794987067013;
        Tue, 17 Nov 2026 23:31:07 -0800 (PST)
Received: from localhost (178-84-201-199.dynamic.upc.nl. [178.84.201.199])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c510c83f31csm65407966b.10.2026.11.17.23.31.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 23:31:06 -0800 (PST)
From: Amir Goldstein <amir73il@gmail.com>
To: Christian Brauner <brauner@kernel.org>,
	Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-fsdevel@vger.kernel.org,
	linux-unionfs@vger.kernel.org
Subject: [PATCH 4/6] ovl: refuse pseudo lower layers unless offline lower changes are allowed
Date: Wed, 18 Nov 2026 08:31:00 +0100
Message-ID: <20261118073102.1216568-5-amir73il@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261118073102.1216568-1-amir73il@gmail.com>
References: <20261118073102.1216568-1-amir73il@gmail.com>
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

The content of pseudo filesystems is unstable by nature, so pseudo
filesystems cannot be expected to behave as stable lower layers.

Overlayfs features such as metacopy, index, redirect_dir=on, xino=on and
data-only layers do not allow offline changes to the lower layers.

Allow pseudo filesystems as lower layers only in legacy setups, where
offline changes to the lower layers are allowed, to avoid regressions
in existing setups, and refuse them along with any of the new features.

This generalizes the refusal of pseudo lower layers as data-only layers.

Link: https://lore.kernel.org/all/CAOQ4uxgPerkkG4ie0SyHVXaBD9VZN2wYfQpEAEi4hytn=ara3A@mail.gmail.com/
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 Documentation/filesystems/overlayfs.rst | 3 +++
 fs/overlayfs/super.c                    | 6 +++---
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/Documentation/filesystems/overlayfs.rst b/Documentation/filesystems/overlayfs.rst
index 688ab108f7478..235dc06c83a3c 100644
--- a/Documentation/filesystems/overlayfs.rst
+++ b/Documentation/filesystems/overlayfs.rst
@@ -684,6 +684,9 @@ features have not been used.  If the lower tree is modified and any of these
 features has been used, the behavior of the overlay is undefined,
 though it will not result in a crash or deadlock.
 
+When offline changes to the lower tree are not allowed, the lower tree
+is also not allowed to be a pseudo kernel filesystem (e.g. sysfs).
+
 When the overlay NFS export feature is enabled, overlay filesystems
 behavior on offline changes of the underlying lower layer is different
 than the behavior when NFS export is disabled.
diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index 58e4cc22d4de2..cd4ad88ecaa06 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -1261,10 +1261,10 @@ static struct ovl_entry *ovl_get_lowerstack(struct super_block *sb,
 	for (i = 0; i < ctx->nr; i++) {
 		l = &ctx->lower[i];
 
-		/* Pseudo filesystems don't hold data for metacopy files. */
-		if (i >= ctx->nr - ctx->nr_data &&
+		/* Pseudo filesystems don't mix with new overlayfs features */
+		if (!ovl_allow_offline_changes(ofs) &&
 		    (l->path.dentry->d_sb->s_iflags & SB_I_PSEUDO)) {
-			pr_err("filesystem on %s not supported as data-only layer\n",
+			pr_err("pseudo filesystem on %s not supported with metacopy, index, redirect_dir=on, xino=on or data-only layers\n",
 			       l->name);
 			return ERR_PTR(-EINVAL);
 		}
-- 
2.56.1

