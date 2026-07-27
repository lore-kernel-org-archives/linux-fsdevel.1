Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5E683F926B
	for <linux-fsdevel@vger.kernel.org>; Mon, 27 Jul 2026 10:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785149336; cv=none; b=oYrxbCNAhKqwRpNmEwF4WndeKyv6lWsk/DjdS5F0I2frUy0vuh4TlmXArA3tcCfsJPaGLLebq1bsOyr3i0b71btQhgc03xu8jhMxDw9e7tqjFYKzKTqq5KXY4860XBq6wcY2x9i05K8TbIcnt08FEB/DdwdS3mCLXezYP21vN+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785149336; c=relaxed/simple;
	bh=eCRRircvREoM/iKBqnGOOGYYVHjFVnNml43mqCwm7tk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ELkdb8+vIqRgc8eCR+BVMJwzDxdSFJCroHFvy/HFaqgHoD68Sq/a7+o0TDpYUwyFr22k9LNgv7I92dwRvX7zvwrzZo8XYcAeGaPgmTFn6yZ9FA64Dga082CSP5HqVbWdYw41DH5mYRq5n7k4I0/ll34uX80vCtgCSHtRT0nwXqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EUXDxWwa; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EUXDxWwa"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-47f93b2fe4cso1881060f8f.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Jul 2026 03:48:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785149331; x=1785754131; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=neqsEsWHuKT6LwcChvXBKjF2Wl4AED5GjZjnD9EI9lc=;
        b=EUXDxWwazk3tKbvGSvIdU9cWxFMs+nCf5sAAshNj4rtn8uuQ3KjX/e8yHjs7+6a1nv
         5p6N+oom3WpzziIXpUt+NRZfD6XvbdnyKsBS27dhLTkJJMbaJMD9Ut2exU/QiqaoX+lf
         cQ7/69yAK3Gu0QjMInD/VQ9YecbxRzJ2svxvUS0RINi9Yxxr1+ypBaBXkeQQ86pyUl+X
         UDk8b1c1hwvZh6ly2a0aZIkcK1qCaS9nMTT3GSwdBBT9iK6/mdVgjcYLxRGx6nlSG2gr
         6nuXltQg9SlIB8azAKM2bcfW4BstigHyZA2sE2OzK+ZIsnWrVYmltRA21bGzrhkg+eSN
         L3Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785149331; x=1785754131;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=neqsEsWHuKT6LwcChvXBKjF2Wl4AED5GjZjnD9EI9lc=;
        b=Ygn2ZUMeZWNRXVQHGF3uIBTnIOSXX+uPXBEJibaAJVYYcvh+ODBBUWHltlASQGTQHm
         29u2Y6sx2miBow0XJosYGJQXeMeW93hIfLdyBnnQdBOkDRfu+enl2gWeZtKhdRJt9Y7h
         YJzKtVosxCXgQsfNiHc7q0iqMOp06LkFocu27G+boivGRp4IwohO6yAPs4eh3OLQojph
         HYTtMm62NklFSKwg/P3p2BTkggByndZ+cK/+1M0milYD9q7WEE1qZXcs4ZSpyknkM3pC
         rUAKqf3wRKpHRI+k0MqAqVgCerzp+RcA/n9bO05HUZ3tixPPJZDQU7kmv4vIC/p/T2p4
         iNog==
X-Forwarded-Encrypted: i=1; AHgh+RrpQl+pCObfiXhMdLeKRrp7Ud4eQVW8FW3EGewrSgFWRRwkKfsD9QHtdBTsM6FtwIzLfO7aHNcJj74rdSZF@vger.kernel.org
X-Gm-Message-State: AOJu0YzJVIOpucawqi5NwlRVg8jn75ri3IE3mGU+kDDsP4dnVYezgSWC
	8SVGr5N8kvPjZi/A2G8Q+VwfY/Zordfd53fezwH6qKTf0y1L4O2aCaDp
X-Gm-Gg: AR+sD10Ut1faUfbej/LoQlezNDiJXtihdB6549gYUJDjy1qdDOP61dQvAd+Il9t4mEd
	aQqdLoU5DWgTxgEtqQzDKN6W7GvKY6TyR/uuE7dPGiYxpr/jHjFp2KWsb3RtZ0q8vOKTLaB53eh
	hkRoLScsfJbK0MVgBdatoihLRtkSuoSH9WJgk0skUynqXPhOyMWDNfN5zGBkGk65f63+yVPxP4h
	oaRvq1oo9fULj+tQClCUGBSeJwv295NDqhy3QIjvQVPhy8AJ6i5H/m1KfhiVJDi/WxvuCFfAR0a
	pAzl+UjQaD8ymwMnwIulWLS0Hf+bYX1kyZrEx9zB/yNItLHxbE5/Nb0L0YStWJr4iLF18EVXyHi
	ZAPZcQRQCUWUDqnsWCMIFhrfIZzDlPzHZ9dbUdZ29xars8icmW/nw0PbUt3aGAy4Ab4oREVpdUv
	YvoUZR+Q==
X-Received: by 2002:a5d:5d09:0:b0:472:7dce:d8c7 with SMTP id ffacd0b85a97d-47f9fe9e8bbmr10201283f8f.36.1785149330834;
        Mon, 27 Jul 2026 03:48:50 -0700 (PDT)
Received: from spark.Home ([2001:8a0:7280:4000:53fe:effd:424:fa7e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f85b9a659sm49056188f8f.6.2026.07.27.03.48.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 03:48:49 -0700 (PDT)
From: Eric Curtin <ericcurtin17@gmail.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Eric Biggers <ebiggers@kernel.org>,
	"Theodore Y . Ts'o" <tytso@mit.edu>,
	Gao Xiang <xiang@kernel.org>,
	Chao Yu <chao@kernel.org>,
	fsverity@lists.linux.dev,
	linux-erofs@lists.ozlabs.org,
	linux-fsdevel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Eric Curtin <ericcurtin17@gmail.com>
Subject: [RFC PATCH v2 2/4] erofs: use fs_context source_file for file-backed mounts when given
Date: Mon, 27 Jul 2026 11:48:43 +0100
Message-ID: <20260727104845.2607444-3-ericcurtin17@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260727-gepaukt-eislauf-waran-7c03f0e47609@brauner>
References: <20260727-gepaukt-eislauf-waran-7c03f0e47609@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

erofs_fc_get_tree() falls back to filp_open(fc->source, ...) itself
when get_tree_bdev_flags() reports the source isn't a block device.
That is the only way to reach erofs's file-backed mount support today,
which means an in-kernel caller that already opened and validated (e.g.
fsverity-checked) that exact file has no way to make erofs mount it: it
can only hand over the path again and trust erofs's independent lookup
to land on the same file, which it has no way to guarantee.

Check fc->source_file first and use it directly when set, taking a
reference and skipping the independent filp_open(fc->source) entirely
(fc->source is unset in this case). This has no effect on the existing
path-based fsconfig()/mount(2) flow, since userspace has no way to set
fc->source_file (see the previous patch); it only enables in-kernel
callers such as the following init/do_mounts.c change.

Signed-off-by: Eric Curtin <ericcurtin17@gmail.com>
---
 fs/erofs/super.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 802add6652fd..b6cd4fde3ca2 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -799,6 +799,25 @@ static int erofs_fc_get_tree(struct fs_context *fc)
 	if (IS_ENABLED(CONFIG_EROFS_FS_ONDEMAND) && sbi->fsid)
 		return get_tree_nodev(fc, erofs_fc_fill_super);
 
+	/*
+	 * An in-kernel caller (see path_mount_file()) has handed us the
+	 * exact, already-open file to mount, rather than a path for us to
+	 * resolve ourselves: use it directly instead of independently
+	 * re-opening fc->source (which isn't set in this case), so that
+	 * whatever the caller validated about this file - e.g. an fsverity
+	 * digest - is guaranteed to still apply to what actually gets
+	 * mounted.
+	 */
+	if (fc->source_file) {
+		if (!IS_ENABLED(CONFIG_EROFS_FS_BACKED_BY_FILE))
+			return invalf(fc, "File-backed mounts not supported");
+		if (!S_ISREG(file_inode(fc->source_file)->i_mode) ||
+		    !fc->source_file->f_mapping->a_ops->read_folio)
+			return invalf(fc, "Source file is not a plain, read-foliable file");
+		sbi->dif0.file = get_file(fc->source_file);
+		return get_tree_nodev(fc, erofs_fc_fill_super);
+	}
+
 	ret = get_tree_bdev_flags(fc, erofs_fc_fill_super,
 		IS_ENABLED(CONFIG_EROFS_FS_BACKED_BY_FILE) ?
 			GET_TREE_BDEV_QUIET_LOOKUP : 0);
-- 
2.43.0

