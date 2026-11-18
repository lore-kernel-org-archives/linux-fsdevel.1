Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794987067;
	b=Flcryox4tDePEbDLK1aXwfeDjTL+GimhCIDmQ9bUh8RULY05QCowscEnAS6Inrmxd9OZ
	 NQoFaYuw6jI7MKQP5s3I9h7y+hEaw14GfZPTvP8If8N7fIBK54VhOCaKVHm/651mi3skD
	 UpCnDtVLRgLUeL3gePchTGcKpBfv5ZDL+ADEV+f2/GRiEt7jrpNhmozRwpcyqvIvBjF0Y
	 MPx70WjaCN0pMsWjMpQbxImHUSQA548VTiZkppJDJ1WRSBTMf+KQAFNUMxTIVB2zX17vR
	 pYiaANP+wHLNyDieN68/40j88BE6kDXowUlrHIYTla8n4QDhe0enFJ6MOcMobcyGcRg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794987067;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=R/VgZr4JT1tJlWk2SqtfdJVJtnjSBjwEeU2kVt1/gB8=;
	b=eB88xiMdWuOm56ZEqZ21TZYrdIuJCPWWFUWmSZ3/JfaaQc2T5B06AjHmM+2f2p70Vg18
	 oX0Jk++wXsOdIoprkmOFzy/bsHK4MOxLrBQXsfAeEHqbnT0+nZOtquM/IAq2ugthcYjd1
	 1IzJDJASxrIC5UZ1d4bB+bls310TgMenD1azzg2E7fEvBukdkzylVj5QDFBhiDfQIAt78
	 oDLaimnw+CSw/HcS8Rs+FdHZK8Mxi5DAoClHdqp8L6YojttcywjL0Q4pvKJH1hoZk5fZi
	 4uRnSRpgBQTgpF2cmyKMaFpf5mNFfU7NGr/lACElQMS0qVw0sTqm3si0U+D8L1YORxg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dcAwtWrQ;
	arc=none smtp.remote-ip=209.85.218.41
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24B26606A333
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Nov 2026 07:31:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 24B26606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dcAwtWrQ
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-c4d2b741ed9so90349366b.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Nov 2026 23:31:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794987065; x=1795591865; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=R/VgZr4JT1tJlWk2SqtfdJVJtnjSBjwEeU2kVt1/gB8=;
        b=dcAwtWrQYJGFqfEuuNJAGYjf1h8YZIuGphPGkkBr36zpcVecRjLrimqnEidmFe6OB8
         KdLh92jyQEfKLRCGQljrzarW/isowG+KI/OmrDhcX+IZ70PzGpdbmlvpLTENLI8lAw2b
         41oE3Kp6gwK8D+AA9fB1F2v4XxcaA3K5CiI3fW39NNuZcPfG4k0mpVa/MWQ/kZjnhv+2
         Av9Ip4/pIW8D3pROZSk4BodBQHktj/lNWNRLiF7GhTNNx3/B6SbEmvUoZ/uixfIPPfBM
         ayx2H2h0K/swwqnpMZL/wljk9lFBEGKWTHFTId59IfpQ/7FD1ZgVLuXQa5yeEdQNelYv
         AC7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794987065; x=1795591865;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=R/VgZr4JT1tJlWk2SqtfdJVJtnjSBjwEeU2kVt1/gB8=;
        b=etLveOA6zp/XoG754UnaU/k3yx+cET4vder4ArequW+YQiKeDrgA1p+YN/Qdn+9Yym
         T27LFppu64/gornPdZB1kIxYuxOxUg5bzfZwZYgirA7mjKxS6W9uXCQK7KTVhfN3wqqE
         awYOJ23sYFF6VnWqnDn2GZTYMEWPX1dOeMmJwUqZRSocD6K2d/9QzIN8DXRdjjZYsZzs
         N5R4kKaHIPQCubinXlt/JBSv9U4c9OA2GVjW1FB5/dLomEaRGN2DaIgh3voDxFfLxXts
         XT2Hy1zPho2r/pHcCjbBsI2v0TjZW613UoJM4wAJOHLOYMOHD4k0Q8XYxj8sQKbppKzM
         CROQ==
X-Gm-Message-State: APuU4Z/TSiLdtq2ivo5CxVXZ4IeZYyi1ME3yWm6AyFeOBoEcPp+jUmS3
	lfH7KUz95TZicezV0qNZICbN9hoQPclcpB5kk8owIC/qFivavlQasMrTTcuOVeMh
X-Gm-Gg: AYBFou3NkGLuzjD0+tUzzH9VK26tNYfj6+P3lf0Z65UlW2CsE7cdoZH+z8s+bI5NpiJ
	QMYMJ4kUu8rvK94XnsKj79pXed36xbQ19EVSUumb0NR7uwlXgK5eNOrxsokO4+46vdb00K0hRQX
	a9QvfPlDeh9bqXGag5xf+kKroyRUFz5oWkZaAdiOEn6dF3JMTrcvZbzhjGKr7qsM1tFnF3FCpeC
	osPlF45RqOeNQcM47fA404MOdHNshDIeD25umunZArZEo0q4Emyk0GmZhrk3eMEVOBf/PLdPsur
	an0cJ6xmHnV5lzbNKjKurC4WUuI2JhBF49u8mrRgZKAeO/QktAISQcTGs96lmwc2+Q0va3dA5lZ
	Y4v2tc9/Ql3TuYceZ2JTIHZWAY8GW84FMy0rLU7zIIgnWku6wN0eOvuoQmNij2OIhknMMzVzNib
	XgTgLOvEGHKlK+vWwLYDp9m/imqZMnb120n2xUwwHgQl/NZpuWHJIW7NPPeZOrujSkBxWYcaB2W
	4Y3EvVAeWswqkySiEGrDg/vwSQYHwg5kESAUV9FhihcDxVBbbNc6GFs/ulp1rSMYkVb5daEf/xn
	AS2ZCATUPAQGzfFuGQBbKmpiPiSvi6qTvpmosXGJDcHwt9QD2foLElnEH/1QvZFWuTfCOnC9Qum
	zk4bEe2ddKDsO
X-Received: by 2002:a17:906:4785:b0:c41:731c:534 with SMTP id a640c23a62f3a-c510e245d89mr129001066b.24.1794987065320;
        Tue, 17 Nov 2026 23:31:05 -0800 (PST)
Received: from localhost (178-84-201-199.dynamic.upc.nl. [178.84.201.199])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c510cb14813sm64469466b.66.2026.11.17.23.31.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 23:31:04 -0800 (PST)
From: Amir Goldstein <amir73il@gmail.com>
To: Christian Brauner <brauner@kernel.org>,
	Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-fsdevel@vger.kernel.org,
	linux-unionfs@vger.kernel.org
Subject: [PATCH 2/6] ovl: do not allow offline lower changes with data-only layers
Date: Wed, 18 Nov 2026 08:30:58 +0100
Message-ID: <20261118073102.1216568-3-amir73il@gmail.com>
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

Offline changes to the lower layers are allowed only if none of the
features that depend on the lower layers being unchanged are used,
e.g. metacopy=on.

Commit 5ef7bcdeecc9 ("ovl: relax redirect/metacopy requirements for
lower -> data redirect") allowed data-only layers without metacopy=on.
Data-only layers imply lower metacopy files, but without metacopy=on,
ovl_allow_offline_changes() would still allow offline changes.

Use the presence of data-only layers as an indication that offline
changes are not allowed.

The only practical implication of this change is that an unprivileged
overlayfs mount with data-only layers and implicit metacopy will create
a new upper directory with user.overlay.opaque xattr to be consistent
with the behavior of privileged mounts with explicit metacopy=on.

Set ofs->numdatalayer before ovl_get_layers(), so that the check in
ovl_lower_uuid_ok() is done with the number of data-only layers.

Fixes: 5ef7bcdeecc9 ("ovl: relax redirect/metacopy requirements for lower -> data redirect")
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 Documentation/filesystems/overlayfs.rst | 4 ++--
 fs/overlayfs/overlayfs.h                | 4 +++-
 fs/overlayfs/super.c                    | 3 ++-
 3 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/Documentation/filesystems/overlayfs.rst b/Documentation/filesystems/overlayfs.rst
index e01f7810c0271..688ab108f7478 100644
--- a/Documentation/filesystems/overlayfs.rst
+++ b/Documentation/filesystems/overlayfs.rst
@@ -679,8 +679,8 @@ a crash or deadlock.
 
 Offline changes, when the overlay is not mounted, are allowed to the
 upper tree.  Offline changes to the lower tree are only allowed if the
-"metacopy", "index", "xino" and "redirect_dir" features
-have not been used.  If the lower tree is modified and any of these
+"metacopy", "index", "xino", "redirect_dir" and data-only lower layers
+features have not been used.  If the lower tree is modified and any of these
 features has been used, the behavior of the overlay is undefined,
 though it will not result in a crash or deadlock.
 
diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
index 646f8ffc40aef..943291da8b7fe 100644
--- a/fs/overlayfs/overlayfs.h
+++ b/fs/overlayfs/overlayfs.h
@@ -697,11 +697,13 @@ static inline bool ovl_is_volatile(struct ovl_config *config)
 /*
  * To avoid regressions in existing setups with overlay lower offline changes,
  * we allow lower changes only if none of the new features are used.
+ * Data-only layers imply lower metacopy files, even without metacopy=on.
  */
 static inline bool ovl_allow_offline_changes(struct ovl_fs *ofs)
 {
 	return (!ofs->config.index && !ofs->config.metacopy &&
-		!ovl_redirect_dir(ofs) && !ovl_xino_warn(ofs));
+		!ofs->numdatalayer && !ovl_redirect_dir(ofs) &&
+		!ovl_xino_warn(ofs));
 }
 
 /* All layers on same fs? */
diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index 990a470112c5c..58e4cc22d4de2 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -1255,6 +1255,8 @@ static struct ovl_entry *ovl_get_lowerstack(struct super_block *sb,
 		return ERR_PTR(-EINVAL);
 	}
 
+	/* Needed by ovl_allow_offline_changes() */
+	ofs->numdatalayer = ctx->nr_data;
 	err = -EINVAL;
 	for (i = 0; i < ctx->nr; i++) {
 		l = &ctx->lower[i];
@@ -1296,7 +1298,6 @@ static struct ovl_entry *ovl_get_lowerstack(struct super_block *sb,
 		lowerstack[i].dentry = dget(l->path.dentry);
 		lowerstack[i].layer = &ofs->layers[i + 1];
 	}
-	ofs->numdatalayer = ctx->nr_data;
 
 	return oe;
 }
-- 
2.56.1

