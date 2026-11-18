Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794987066;
	b=28tzn83uxdkLB0ErEZVRTfyvRRB+YDeSSZUvOyKPnSy6z6OkXk+cYCgygMQQ9SrdDXVJ
	 ZialNveHogoGw02OKHJ88jTu1yTj+zgGNIzG7x/jJCbuCZcwZ9UvVWwCE91BZZHXTRzgZ
	 tS/RW3wk4qk4EWR+7f6fGasFOJjvp5KmPCYK/90phCrVlf/7+tRQIazyENp8GKqSEK0vY
	 yEnPNoarFTt2gVC60Dcn7dY7PtvvAfVHEj9EKHX5v7LXB2OVRNB4eTd29/nc1ImJx6/X/
	 a5d98TJZENTfUyb4yKv6u1nKifSbMll7zWGp2fmZfIuurO30Xs6pv6ZCmtV7TR3yPKQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794987066;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=hrFB2xZ4uuzix/ci88TgH2/bUivuDdMzcB4EtRfyy94=;
	b=oR/BV8H8dHxxrfc7ayDZ8i7SmnLy0jn+PycV4JRHI5gVzxHlsZ0gnCElmw3zCXIh6sZm
	 /NNKBUfEpo7EfRcCS9ze3M/BJtaVdkMWHLPNONQkVAW2kfQ4r0obaXGQduw3/J80RvnIx
	 3NlaFe4/9LQMKRul8IlG1Dv6SStkbCxSqwEGS7yEzaDiTTpKUNHCzEe/fL6tYKXj30ljx
	 01Xh0qvqEoRfjrfdGEVkk/kJfmsLXuZMeEPovGPDISIonFy3M8dzr2uGAFukod9OBm/3Z
	 AWK9RZ4UTx03zN+yfTCSx0yHzmvb59eWX9Bwpptif1soexiAdTIRKyb5fuhu2r/W2Qg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0AznghE3;
	arc=none smtp.remote-ip=209.85.208.42
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B87E606A332
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Nov 2026 07:31:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7B87E606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0AznghE3
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6b887ca9f5cso833628a12.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Nov 2026 23:31:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794987065; x=1795591865; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hrFB2xZ4uuzix/ci88TgH2/bUivuDdMzcB4EtRfyy94=;
        b=0AznghE31q2J2d4m4f9VN1APtK4HiYCff0Ds2DS5NHQQJQIPBnZxH6NAWJRR7XwVtx
         US+FARmcaJm3ilA726ncQmRvCFlA+uspoe+hp1uVGPdmNaQBNqKMByCPEx/RtU/S6JkV
         EpicP2aB0x+sz1c8T4VdOppZyUkiJAXVBYRUZjsuoU5rLA9OtV0+Eib8aOSB5YalnnMa
         Qjian0w3tOvwfsComdh3xECmx6sEQE9aqbDW+jbBIjMvZMCv2wFt9w07OMrKoMuLp4g6
         SbDN+D96pLFLF4Vj5Orc/WuDpu6DxDl/BZIK/dOFV1uCsRdUy4nUlj+ZW1hNhHA/Uiyc
         OMnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794987065; x=1795591865;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=hrFB2xZ4uuzix/ci88TgH2/bUivuDdMzcB4EtRfyy94=;
        b=uGy1ohAS65T31rnT2Wy5MXUnlWHy9AZS54MGOEl38+8mjv5C8n3m0ZnAId7KagX/be
         gy+2Y7liQHSyJ8duyeKJ7mMyd38VRFXNV70ngSZrGaOIkV3JPk8ZH+oYatfk7292AUd7
         q6F83NnfR73HiUD5pcnLY+Z4kT/KC+1GzEl6EZNoQ6hYWQOenK/8KGyFp1vIGFn5oASI
         ++0aL33HYTym7+SNV5Que5sCsxdk6v6B7gm6A8Qx5m3osubTqnwk8o1xhs683yrYAwr6
         QbRkSwr43r/FW56chZNZsb8APMkd8PN2/kq5EJbGNi4bdQNFVyfBNBvKS1MHh/fblIB1
         Qn4Q==
X-Gm-Message-State: APuU4Z/Z6xdyPN04t41FRuXI+IUSJ+woIcShwrGI7aNfYzLiEzWCClrN
	i0vmcFT2vo7pGzggu9WRP7jTIT529HjGfHi6AG4AR5Jlz18wBz3WiHyp
X-Gm-Gg: AYBFou11SfwUL2MfkZDDLr2grRQUfdZecivW3pVGMneX3dMmADRhDmRRcXwMRKAQ5eL
	NR4UQWkkLqEKWVxJLZ6UWPqDI6PYvihROMM1l3rQAvywLr0fRSGquCAqtR9D1u4Ws2dBGsl1lxF
	WjEuxtTPu7rlaRp0nC+PjusnbHjRW1evA2pJtd0LDoXbIFENU/TNOiEDBDMnmJdVoVk3RvN2aHO
	KNl/36qOzFLIMy3/e6VBQ5vFMA1nISVgDvbZt4Cpjj8hxwTk0SqUmLEvENQoZW338iSumdy0PGG
	7mGunBVU9Xn9kdwgwn4IkAwe0ILKRPudC9nmAKJQT5XUSG84G9n0zACjw7xNOQlzsy6AYlGDdD8
	DkmWfWmSZ/wYBEld2I1rrHjZ0uZgGSds2Bda1ubs2SAgTfPaxiY6hdvMMY25oJ8QBJJjP0rQTUk
	9NXVvbM/99QJoFOuQai5m8uo6kpscjk4CewD+XDwosoFWM6DknrCnBwjVCFL88gZ2fEwmF1lJrf
	S7A+QO8RqMzir7euUmMV5hFXE1qw0ySr1K6fHoeLXNzjy8CSZMSeo2/CiXHi5++g6nGxImc/3gP
	0ruwFL/aNR1UoXNta4Hpo9hPzHaL91SJuRoePb8sOqPqyzrbwrLJXmIrH33+kDv92/I+iYrQOlt
	ihytIp7EnXTM=
X-Received: by 2002:a05:6402:42d4:b0:6b8:6f17:5a44 with SMTP id 4fb4d7f45d1cf-6b887f13cc0mr1134817a12.24.1794987064472;
        Tue, 17 Nov 2026 23:31:04 -0800 (PST)
Received: from localhost (178-84-201-199.dynamic.upc.nl. [178.84.201.199])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b88a225b12sm683262a12.28.2026.11.17.23.31.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 23:31:04 -0800 (PST)
From: Amir Goldstein <amir73il@gmail.com>
To: Christian Brauner <brauner@kernel.org>,
	Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-fsdevel@vger.kernel.org,
	linux-unionfs@vger.kernel.org
Subject: [PATCH 1/6] ovl: do not change redirect_dir=follow to on in a non-upper mount
Date: Wed, 18 Nov 2026 08:30:57 +0100
Message-ID: <20261118073102.1216568-2-amir73il@gmail.com>
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

In a non-upper mount, redirect_dir=follow was changed to redirect_dir=on
to simplify the metacopy -> redirect_dir dependency check.

The two modes behave the same in a non-upper mount, because redirects
are only created in upper, but the resulting mode is visible to users
in mount options and to ovl_allow_offline_changes(), which treats
redirect_dir=on as one of the features that do not allow offline changes
to the lower layers.

Drop the conversion and let the metacopy dependency check accept
redirect_dir=follow in a non-upper mount, where metacopy only needs to
follow redirects.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/overlayfs/params.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/fs/overlayfs/params.c b/fs/overlayfs/params.c
index d1ca4a9094f28..0c7bfff7f06dc 100644
--- a/fs/overlayfs/params.c
+++ b/fs/overlayfs/params.c
@@ -936,14 +936,12 @@ int ovl_fs_params_verify(const struct ovl_fs_context *ctx,
 		config->redirect_mode = follow_mode;
 
 	/*
-	 * This is to make the logic below simpler.  It doesn't make any other
-	 * difference, since redirect_dir=on is only used for upper.
+	 * metacopy -> redirect_dir dependency.
+	 * metacopy needs to create redirects in upper and to follow redirects
+	 * in a non-upper mount.
 	 */
-	if (!config->upperdir && config->redirect_mode == OVL_REDIRECT_FOLLOW)
-		config->redirect_mode = OVL_REDIRECT_ON;
-
-	/* metacopy -> redirect_dir dependency */
-	if (config->metacopy && config->redirect_mode != OVL_REDIRECT_ON) {
+	if (config->metacopy && config->redirect_mode != OVL_REDIRECT_ON &&
+	    (config->upperdir || config->redirect_mode != OVL_REDIRECT_FOLLOW)) {
 		if (set.metacopy && set.redirect) {
 			pr_err("conflicting options: metacopy=on,redirect_dir=%s\n",
 			       ovl_redirect_mode_name(redirect_opt));
@@ -959,7 +957,9 @@ int ovl_fs_params_verify(const struct ovl_fs_context *ctx,
 			config->metacopy = false;
 		} else {
 			/* Automatically enable redirect otherwise. */
-			config->redirect_mode = OVL_REDIRECT_ON;
+			config->redirect_mode = config->upperdir ?
+						OVL_REDIRECT_ON :
+						OVL_REDIRECT_FOLLOW;
 		}
 	}
 
-- 
2.56.1

