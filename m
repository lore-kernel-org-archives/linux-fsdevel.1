Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793359927;
	b=XgNeU1CAOCs0o21mzf1MKeckBnlzW42IoUX3yoxneXJiCbeQN4opPHvFTohklxPB+MMk
	 W/bUDsZCrkglp6I0Q2BJjBlQ5HTXHHt1m/C8e0bsX3E/avtE93JavW7H/rr9YvX3D4DtI
	 Zf5nQhFFsJLW1vbVxokNMQNAoO286PeI4h6hLkgy9pSx6TLu6m27breTNYTRSCe1Vasrj
	 uN8wvRIpV4KXTXtQrxljcf5v6IIXO51lVK/oxJixjrDz/9MKL3nPa+EM3tbcKpTWcJkyK
	 i7g6rEp9yc1mG3AL0Kcqk1AgaCvNgXL+47JLX8dyJHkjsihAAjJwD0U6VL9/J9rtTCg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793359927;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=cnrRz73SYKEZ4qoaWJL9gqpOklZcWfVKHKWX7WhjJh4=;
	b=SuNofdQm1MHt2d4MxPQzuAdT4FRDYBVVLJtDyZoiiG59Spke6Q6Etn+GPUtHnWP01Hvh
	 M2AFk/EQkrkCnA6/tKgyeRwzB8c2gpKpZyPROozYlbHez3WT5VWSKuUEH3RfQbsB01rDt
	 9J1t7XHHbM+I2fQBQSmt6MHD06Rh5uo+wCvfE0dLLMZtuy4rX3ZLRPk1SzXxuFBMOkdb2
	 brt3seKPtxrKQKBBO5tPGpIVXp1kerPBRMiFMkClnDCofSikIrcuBAB7tG3DXs7fPRkTs
	 sVgZI93z5b8Agwid338H4STHHENqrJm/n2RqhHkv9Xkwircx8jztvQl4ti6Suu4FHpQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="I/N8n4zJ";
	arc=none smtp.remote-ip=209.85.221.49
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92B21606A31D
	for <linux-fsdevel@vger.kernel.org>; Fri, 30 Oct 2026 11:32:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 92B21606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=I/N8n4zJ
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-48df54150dfso280467f8f.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 Oct 2026 04:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793359926; x=1793964726; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cnrRz73SYKEZ4qoaWJL9gqpOklZcWfVKHKWX7WhjJh4=;
        b=I/N8n4zJ0pVbzD40Z94Q2ezmntxchgRlk4DXCua+1wNeZIVA04dhL8D5347VPjCzDC
         9/ken7Rvq+kD491Mg9zZOGL5RCh5Ry/G33EV52jr3ZdDcMP/Sm2UVhH79gqawm56GS9v
         jvECGs3fqgIWpUrSVNEJXWC1/oc9cfxGtd3FTvLYWJjinx1uF7dlzqUa4/2har6i+whg
         1M76PaPA6ywJVXV3SkU7XoD/fqZjsfkJwMpTIJ5J+5DEUVzAW3EN2Tox6hx4IwlQcNmU
         7pdfOGnFi2ceQJJ3E+EdR3qWd0SUivOykTNcpRsqqIwsUCn5vJCjX7f9CKQaVe7tdyqC
         wkUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793359926; x=1793964726;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=cnrRz73SYKEZ4qoaWJL9gqpOklZcWfVKHKWX7WhjJh4=;
        b=gHT2+GJA/aen16ixfKS/56V4PTM43fiDewuzy4O0yimKZrHoCiDoGSo4BCi0irR8wY
         JuBaS+VwMmSlfiOHucXuxCeoK2R6aEaluDIM2KX4hOOnuutOVWaHpw9DEmIQcPv+yUqu
         smmBD3XvIUp7kr6n1kb88O97qHtFdBajtLFz8W61s5kzGcywdV/phP5BftviTQSvoAI4
         PvoOL6n5rMGpYMBlqSHq9ZUodL2zqX06rtBOh2FoaRsHj63XEgpsynuSubMyLvkrzMFi
         s0VPxmGNFFl4DTh7pxAOkbnazoODgoSjqHxvH0Avopie7YWCp1hKhoqZPCw6FYayd/uG
         jkWA==
X-Forwarded-Encrypted: i=1; AKwUvBzGqFYpawL49hgxs0G2cfyDzrprzAUU6K69MHEY7JmilpykaZ9sDwEH6YVYEq4/Ris252qhRwPP1rIgYTBl@vger.kernel.org
X-Gm-Message-State: AFq9FYJgu6PJEv9bsEQUw0WqKuBMPAlo98MXAfN455NCL3Z77PEu3iSv
	e/V96wRKgFrZcBm8ygRGmmx+U4GkQwmUj+bjqs4euZm86/a+y2a+e1q8vsz4khRv
X-Gm-Gg: AYBFou3gKYYvwSCv8n9ZMq7dZw9djl5S5jjwqp6ZB+xsMDcb/DiAr7ZnuZp/2GHH7ik
	FtPQgHIg0rzesRZGhBX/EgjkSImnedw/qWJX9U0SBHFPWOMHo6FUv3UbuA41+RjF5fa9a/bM1Dl
	hXvy1B36eSLl8lgZrSZQHu+hjAFT4jGdQH2af287ywSc+b/oD+xr+LUUSOR81fmgI3PwYZfiWbZ
	q6whp3eKL7y42eDvpNLj1XE8uydioA0ms+ZC5kGs4W1oRx5FAdtxzOrPYUN0ymcGNu7uud7xDf6
	EY6WYAfux3ugYDz7q/a6F85TqsymG0quwkxzH7KdyRBn4Lt9TR3naNPZs0PZ6XLyMWMU5/qSZG/
	9JPnWYIgg9PQarFaO4q3E5VjjBresIO72PAP+YectRdFMTawhtP5XTw9KW9c8ymjXexdbIU+5Zm
	ziz5DmFN+lblo1Qb0Q7kGnk0ozgJk5bxXoLo+RwXY797Al22UGTyqHeU3qde9t+BWHpklTEErBL
	Asz6pNKAfF6rfS/Edyi0xqBlnczH+dRvg0jhVP2zS9afhYpohWvJRSxG5fFeLEH3WYTEr8zANuI
	QbW+HD5ImTtxDixq4TK0iMpAHv5r8d5afYOiW0OjEsmg1xZv/tn2ZYKSIuxzGjLR9yxwitozgxn
	lZAbfB1owqq4=
X-Received: by 2002:a5d:4c8e:0:b0:48e:1c2:55a1 with SMTP id ffacd0b85a97d-48e6e500505mr3857722f8f.52.1793359925697;
        Fri, 30 Oct 2026 04:32:05 -0700 (PDT)
Received: from localhost (178-84-201-199.dynamic.upc.nl. [178.84.201.199])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71b8c6e9sm2708834f8f.43.2026.10.30.04.32.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 04:32:05 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
To: Hungyu Lin <dennylin0707@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Chris Mason <mason@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>,
	linux-unionfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 1/3] ovl: fail the mount if the casefold flag has changed
Date: Fri, 30 Oct 2026 12:31:59 +0100
Message-ID: <20261030113201.2921633-2-amir73il@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261030113201.2921633-1-amir73il@gmail.com>
References: <20261030113201.2921633-1-amir73il@gmail.com>
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

From: Chris Mason <mason@kernel.org>

An unprivileged user in a user namespace can repeatedly trigger a kernel
warning with their own overlay mounts. They do so by changing the
casefold flag of the topmost layer's empty root, the top directory of
that layer, after the layers are set and before the mount is created.

The casefold flag of a directory makes name lookups in that directory
case-insensitive. All layers of an overlay must agree on casefolding.

ovl_mount_dir_check() reads the casefold flag of a layer root when
fsconfig() sets that layer, and saves the result in ofs->casefold. The
mount is created later, by another fsconfig() call with
FSCONFIG_CMD_CREATE.

The casefold flag of an empty directory can be changed.

The casefold flag of the overlay root must match ofs->casefold.
ovl_get_root() copies the flag from the topmost layer root, as it is
when the mount is created. On a mismatch, ovl_get_root() only does a
WARN_ON(), and the mount continues. The check is not a WARN_ON_ONCE(),
so each such mount warns again.

An unprivileged user needs CONFIG_UNICODE, and a tmpfs mounted with the
casefold option in their namespace.

Reproduced by changing the casefold flag of the empty upper directory
after the layers were set and before FSCONFIG_CMD_CREATE, with tmpfs and
ext4 layers, and as uid 1000 in a user namespace.

Fix this by replacing the WARN_ON() with a check that fails the mount
with -EINVAL.

Fixes: f9377faaeae0 ("ovl: Add S_CASEFOLD as part of the inode flag to be copied")
Cc: stable@vger.kernel.org
Signed-off-by: Chris Mason <mason@kernel.org>
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/overlayfs/super.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index b452b8c5f6417..af13585709cfc 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -1372,7 +1372,6 @@ static struct dentry *ovl_get_root(struct super_block *sb,
 	ovl_dentry_set_flag(OVL_E_CONNECTED, root);
 	ovl_set_upperdata(d_inode(root));
 	ovl_inode_init(d_inode(root), &oip, ino, fsid);
-	WARN_ON(!!IS_CASEFOLDED(d_inode(root)) != ofs->casefold);
 	ovl_dentry_init_flags(root, upperdentry, oe, DCACHE_OP_WEAK_REVALIDATE);
 	/* root keeps a reference of upperdentry */
 	dget(upperdentry);
@@ -1556,6 +1555,17 @@ static int ovl_fill_super_creds(struct fs_context *fc, struct super_block *sb)
 	if (!sb->s_root)
 		goto out_free_oe;
 
+	/*
+	 * The casefold flag of an empty layer root may have changed since the
+	 * mount options were parsed.  The root inode owns oe by now.
+	 */
+	if (!!IS_CASEFOLDED(d_inode(sb->s_root)) != ofs->casefold) {
+		pr_err("casefold flag of the root directory has changed\n");
+		dput(sb->s_root);
+		sb->s_root = NULL;
+		return -EINVAL;
+	}
+
 	return 0;
 
 out_free_oe:
-- 
2.55.0

