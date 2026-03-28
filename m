Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C41171DDC3F
	for <linux-fsdevel@vger.kernel.org>; Sat, 28 Mar 2026 17:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774720730; cv=none; b=GhWOdp/uA69ifWjYISnaGiVM25K2zTcy8psro3/eO34oZjO96XApRw8u5TwHvVvAwvQBU37iTCRL4dkmU4OPjkjSCPB9+S6ol6to5yRKPFldv7vDqB2EFRdvUgp3XNgKlO+CD7pGQJFi4zEeN4fjhVSmYRkOjjA1g3RiNUc9sv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774720730; c=relaxed/simple;
	bh=zrCsS31CNOHlR4LAqP3nODK/VPreyOD/MAFs8v6Bm1Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZYq0jNe4ILof4Oc+kg+HqEhDqtv+/ZJngVz0wlij4yGuGswxmYydAMBr38qA8hS3f5br1HdEAPY0uovMzrbLFS4VLtKFcG4rhqa81/Hnnmo2re+CUKjW4E/P5U936GbR170CYzlytV3wonX0Hjll0xIbJoezmHBdmEA1eQyaR2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oK7eAYTd; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oK7eAYTd"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-486fd5360d4so40979895e9.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 28 Mar 2026 10:58:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774720726; x=1775325526; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=if3Z26t2aYaIJWeen3qlPA46Qm7+5y2EZzYdQgSfu9Y=;
        b=oK7eAYTdwoqZD+QKPZHbnf6vVk8HTbpNqiFZPsdb+boCwanSSP6JGEX4L4hg+YiB7w
         tKxsPqOTFL3FrJBOKvIyPezHnxZOzUf5Fs127RtCkoZHC0pgfiTWc5fWvblS26RQfjhY
         ZUjwEt3twj+VNovOcSHd2+fTmWmmWamW1rrBteFhbg41SLp0FHCJfrJ6Db5iJTetpl2O
         cNGC5o42dpODDdLT1NHUzkqufMZ6kvxYUuiXkSAwvz/0Ex27iy/s6rfgDBUoJeKbOk9U
         1KFAOgCoL/VH0GK8BNOwuq7N0EvW12nJE/SVL8yTyLpwzObU74qteguvty4knvHOmd24
         LtsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774720726; x=1775325526;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=if3Z26t2aYaIJWeen3qlPA46Qm7+5y2EZzYdQgSfu9Y=;
        b=V4Hjh2e4MeZbHT/kDrU2FsWGWKatbnGm/ngoPaxVy/jDJEBa6mGzTPRp1i2QaW0XFb
         oPuGyvuEWQvV0CFQe7uYXTohp3luVQnHJikvOJL42IT6KiHCtBS2E2UsuMWt3HMNi9UA
         /zP4eWwu+TtWE7jKb3rhvu+eaq1BfAqrdw5J+GZlc6Rp2I4W+dZPEiN8GkNaqXHpnEZF
         Hu0ePKMf2uuo5pk1qdDr3/JPspElacVS7BSAXkp8sQbpEtwxs4LdMRdQiG6hBrCRvbpZ
         TbE6oMEKpXVuKj8tPyPPNwg9fSw6w+J2+vaK/dpxa7Z8VohtfFa2trm0qQfpXzM8iXas
         FVjw==
X-Forwarded-Encrypted: i=1; AJvYcCWDbklAEhjPHnvA5wUZfs4sGgfIuP35gE8Dqbklkzir/EhNXXq2iViRR47ECAUDYTH+xGPBv51mImYwiFvd@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+OOCIDf0+EUKucRHrIzA5rTHk9QHmFYZAf8w4Sly7yvdlVKqx
	+JdsVJlEE9KSyUjcQIllVz1+mFvOEG150mpUhek3aCff5NxIfz19SauzozUwXQ==
X-Gm-Gg: ATEYQzzGPjbuCDBcG121J0VJGtvRbI5t+gA0QSP25pxTlwXljgpSfcG39xqTQqeRpIN
	HrV91sWMxPIL5IzysFba2IqTXgkqJITV0zZeT0AETmDxkiEKNb1KxwVvn30U03/GtCrFQxMvejv
	j0xpAshb/vTkPop+Dyw8vZxyp1VS/LVJikhTfHprbIqM5nqH5fUXPQPY2U+q9sdAzw/nsm2cTHP
	L0EhwKnmzMYM8TWHzxKH6MAra6a9M4zYVsuTWn7lzws8p/YYzolW+CAptWlau/zIvatDgPz3nrx
	9AT3BbWG/GZ+AFt9VM8kA0lbdjlgo3QpLgVhmHniDlZeaKA7eRG0A8ttqCqjatAqdfOFv4QfyQh
	MhEqYFLVRUcdLxcK5AHv7a0y2hlYXTGDeJToizPB/SaPAGqHHtlFdh6mGxTZ9gDP0dZg+oQ+3Dl
	m48R+g77xeRiUQhu07EjV9+QIBP/YkDEwf3sDnigFzWXR4hTF9RbAKEdEmbyrXu8zUMDVDB/78s
	fYzUUILaNCp
X-Received: by 2002:a05:600c:c109:b0:486:f9d0:aac8 with SMTP id 5b1f17b1804b1-48727ec776bmr86007715e9.18.1774720725823;
        Sat, 28 Mar 2026 10:58:45 -0700 (PDT)
Received: from f.. (cst-prg-89-171.cust.vodafone.cz. [46.135.89.171])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43cf21e2a7asm6713033f8f.7.2026.03.28.10.58.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Mar 2026 10:58:45 -0700 (PDT)
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org
Cc: viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH] fs: write a better comment in step_into() concerning .mnt assignment
Date: Sat, 28 Mar 2026 18:58:40 +0100
Message-ID: <20260328175841.3390950-1-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---
 fs/namei.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/namei.c b/fs/namei.c
index 2113958c3b7a..c7fac83c9a85 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -2140,7 +2140,7 @@ static __always_inline const char *step_into(struct nameidata *nd, int flags,
 		if (unlikely(!inode))
 			return ERR_PTR(-ENOENT);
 		nd->path.dentry = dentry;
-		/* nd->path.mnt is retained on purpose */
+		/* nd->path.mnt remains unchanged as no mount point was crossed */
 		nd->inode = inode;
 		nd->seq = nd->next_seq;
 		return NULL;
-- 
2.48.1

