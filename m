Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70ED439A066
	for <linux-fsdevel@vger.kernel.org>; Thu, 16 Apr 2026 09:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776331061; cv=none; b=K1zois5Jj5d9e5M1GM7HObpl875+XjXicA608lyolN984+68otS9oc0JP2PHD7Sn2Ud2MHZlFDO8ES973yFajGziL+Gg79kZnZOHsDKX4kkAnu3FNPPvAqARSmcNEOwg7r8/yzx8VJKNF4nRfylGA47aeqg7ceL8zoe3Vn4xH1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776331061; c=relaxed/simple;
	bh=LctYstnyNsYTEaC7vhsdQL0VskCsO1rb18RjMA7HIRY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NwohiaR0tnCkVcSnTcXKYWJ7jGTL3mvat9FcNyta/J292b3Bjj1YDYZ3Eh6I0NJ7L/xTayZdycsF+8E7KEwwnwxdC2KA0yW18HRZHyPrj3+ptehR9LTU01P5j4ytUizoFM31qxHQxOhFTgezcA2tKSz3Uv95dnIZr9QcYMQKteA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hvYJGWzp; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Wl77Tn/V; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hvYJGWzp";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Wl77Tn/V"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776331054;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n2ATAjvzRKiK1x7dmQ7vs9SUKNkDHhKWCMxis7bRbuY=;
	b=hvYJGWzphUouncu5WJkuEbTXBtsFoN0++Oz2oLbxuLngcyBUk0ds8+99nZx0jI5REnqjdN
	cmoGMQJVj9dizYhdsEQKS8sBcsiLIhHGX9xWwaKcGkNE/fabO6dQ95poObCzGUcNM0FGBp
	xvTEsM7ayIyqXQ550QiEmj8zjGH++nA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-576-Lys31YuRO76Tk8z3s7J1Gw-1; Thu, 16 Apr 2026 05:17:32 -0400
X-MC-Unique: Lys31YuRO76Tk8z3s7J1Gw-1
X-Mimecast-MFC-AGG-ID: Lys31YuRO76Tk8z3s7J1Gw_1776331051
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-488be33b7a6so47992675e9.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Apr 2026 02:17:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1776331051; x=1776935851; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n2ATAjvzRKiK1x7dmQ7vs9SUKNkDHhKWCMxis7bRbuY=;
        b=Wl77Tn/VUVeirJzDalb+hjQY4snA0sjP53VtJT+v8A/w1ce+aiTYG9v/mOpX+w+uNd
         bsXpqeH6u9bs/DLp6lNXRAXVu5IgasWKVxc8fjsEcdrUYNM/VEEdwy4+HpjnJXaiq8pM
         ZR1P/qsn8g4DieUeNLc/G4CnhOoFqJSLG8msy69hOQ49O36fC5vEKi7NR1hcOXJUNuhd
         YAkgTosN+w8e/KupwCq+3VnkzHLXy7tzQz592gMB+6LKxAHhGvBj3BOaCVR8gAX0WGtP
         O+fT8aok653B+IRW1Q60Ga3BNvF9GRZbx9zqsOx5b6hr5mDIsn5IUW4GMh4yrx8kewPu
         X6ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776331051; x=1776935851;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=n2ATAjvzRKiK1x7dmQ7vs9SUKNkDHhKWCMxis7bRbuY=;
        b=i9qadzSqCKoZrbph23J4gcUmZZSabvcX8XrY9CIGTarGJUwNYU53RU31Jp/1lhLvm1
         bWURzOf5f7sChE0aQTceNh8th5nbFSX4De6WBI8NmJwa6y2jp7myZqhdTWXUkNjmkROp
         sKAG96Y0IcpDhl5tUUOC8HvlH4jOMnMuNmfBq6kf87Zo5Drm4C9W9EH8PUIlPFVt8uOG
         vMelcodz/o9yILeADC3x0wJx4bPc5Zjd2TsTmXsYS+RYJCyaIWpY2Z99oZB6FFHMOQeT
         qz/yXhSOu/Amqg2bS0o4q2Z4c3bccUXlwdn2WY7Ou3TtisWBKkr8BFRArzRlJpqFcOt3
         RaMg==
X-Forwarded-Encrypted: i=1; AFNElJ9k4D6JnQ5+x40nE6YYfLtT9Wy7f5C5OQg/4x4bPfNQ8UtT+RDL8Jf6Tr2TfV1LYz/PGSC2Ic79IUefpqUu@vger.kernel.org
X-Gm-Message-State: AOJu0YybuF6VUzFpPTnW65mgri1eaTajAzOC3j2/62+aNKUo2yh8mTwd
	Nc0llSmvk+z+HGWqmOI+YOZskC4hH4xCn16uHksj+hFRn6DkQaPssHeB4yeaaQjldnRO+/3OgmU
	vAOQxbeIcCGX+V1/a2ecJ+q+yuWV4VdN9PykcuxHka07/tljHTUD00Fp1VooAPMrjzBBY+M74wO
	0=
X-Gm-Gg: AeBDieuLQZJ6fIanQQogSKC9XFWu1IkHIXMLigJLqONCPLEEbwxbh13kyE02oS+xRcH
	ruqTtf2A9gRxoJ55dXyyhmsARsL7unj2UspPIbhpm4KX+I1hsvhmoJKomdhXr4BSBBofUrgxEws
	H8sT5/QAmfqgM/5/p8O7CfivLmmo9NC3MFslEep8oC2gb6iakYqtQwoCBU/v/0tcO8iplY+J9up
	R5RzPfiiw5D+ONuG89qTq2nSy/dmP8FSZ8V/aMHvDkg44JMQwD7OFS1y3sZ8G8/KZ7Inhd26m0a
	t91/tb3jgdhF5GrVYVheMMluInIV1cYZ7d+6/5kea3at6ltEgB++cYJh1B/2NMGYs7tVKXZYnLV
	c98wYllbaAt5EsUdnhSg638hXpBptmihqwKABOcqR6CC6uhmOipxQ598J8GSY20HApfvfA4fjv2
	O+rzoqYA==
X-Received: by 2002:a05:600c:c0c9:b0:487:1826:d89b with SMTP id 5b1f17b1804b1-488d67e262cmr237680055e9.9.1776331050977;
        Thu, 16 Apr 2026 02:17:30 -0700 (PDT)
X-Received: by 2002:a05:600c:c0c9:b0:487:1826:d89b with SMTP id 5b1f17b1804b1-488d67e262cmr237679755e9.9.1776331050422;
        Thu, 16 Apr 2026 02:17:30 -0700 (PDT)
Received: from maszat.piliscsaba.szeredi.hu (85-66-37-19.pool.digikabel.hu. [85.66.37.19])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488f57d80d3sm38597975e9.0.2026.04.16.02.17.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 02:17:29 -0700 (PDT)
From: Miklos Szeredi <mszeredi@redhat.com>
To: fuse-devel@lists.linux.dev,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 20/32] fuse: split off fuse_args and related definitions into a separate header
Date: Thu, 16 Apr 2026 11:16:44 +0200
Message-ID: <20260416091658.462783-21-mszeredi@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260416091658.462783-1-mszeredi@redhat.com>
References: <20260416091658.462783-1-mszeredi@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is going to be used by both layers (transport and filesystem)

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/fuse/args.h   | 65 ++++++++++++++++++++++++++++++++++++++++++++++++
 fs/fuse/fuse_i.h | 53 +--------------------------------------
 2 files changed, 66 insertions(+), 52 deletions(-)
 create mode 100644 fs/fuse/args.h

diff --git a/fs/fuse/args.h b/fs/fuse/args.h
new file mode 100644
index 000000000000..ecfe51a192af
--- /dev/null
+++ b/fs/fuse/args.h
@@ -0,0 +1,65 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef _FS_FUSE_ARGS_H
+#define _FS_FUSE_ARGS_H
+
+#include <linux/types.h>
+
+struct fuse_mount;
+
+/** One input argument of a request */
+struct fuse_in_arg {
+	unsigned size;
+	const void *value;
+};
+
+/** One output argument of a request */
+struct fuse_arg {
+	unsigned size;
+	void *value;
+};
+
+struct fuse_args {
+	u64 nodeid;
+	u32 opcode;
+	u32 uid;
+	u32 gid;
+	u32 pid;
+	u8 in_numargs;
+	u8 out_numargs;
+	u8 ext_idx;
+	bool force:1;
+	bool noreply:1;
+	bool nocreds:1;
+	bool in_pages:1;
+	bool out_pages:1;
+	bool user_pages:1;
+	bool out_argvar:1;
+	bool page_zeroing:1;
+	bool page_replace:1;
+	bool may_block:1;
+	bool is_ext:1;
+	bool is_pinned:1;
+	bool invalidate_vmap:1;
+	bool abort_on_kill:1;
+	struct fuse_in_arg in_args[4];
+	struct fuse_arg out_args[2];
+	void (*end)(struct fuse_args *args, int error);
+	/* Used for kvec iter backed by vmalloc address */
+	void *vmap_base;
+};
+
+/** FUSE folio descriptor */
+struct fuse_folio_desc {
+	unsigned int length;
+	unsigned int offset;
+};
+
+struct fuse_args_pages {
+	struct fuse_args args;
+	struct folio **folios;
+	struct fuse_folio_desc *descs;
+	unsigned int num_folios;
+};
+
+#endif /* _FS_FUSE_ARGS_H */
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index b8655c3b48e2..22a6d58678ad 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -13,6 +13,7 @@
 # define pr_fmt(fmt) "fuse: " fmt
 #endif
 
+#include "args.h"
 #include <linux/fuse.h>
 #include <linux/fs.h>
 #include <linux/mount.h>
@@ -288,58 +289,6 @@ struct fuse_file {
 	bool flock:1;
 };
 
-/** One input argument of a request */
-struct fuse_in_arg {
-	unsigned size;
-	const void *value;
-};
-
-/** One output argument of a request */
-struct fuse_arg {
-	unsigned size;
-	void *value;
-};
-
-/** FUSE folio descriptor */
-struct fuse_folio_desc {
-	unsigned int length;
-	unsigned int offset;
-};
-
-struct fuse_args {
-	uint64_t nodeid;
-	uint32_t opcode;
-	uint8_t in_numargs;
-	uint8_t out_numargs;
-	uint8_t ext_idx;
-	bool force:1;
-	bool noreply:1;
-	bool nocreds:1;
-	bool in_pages:1;
-	bool out_pages:1;
-	bool user_pages:1;
-	bool out_argvar:1;
-	bool page_zeroing:1;
-	bool page_replace:1;
-	bool may_block:1;
-	bool is_ext:1;
-	bool is_pinned:1;
-	bool invalidate_vmap:1;
-	bool abort_on_kill:1;
-	struct fuse_in_arg in_args[4];
-	struct fuse_arg out_args[2];
-	void (*end)(struct fuse_mount *fm, struct fuse_args *args, int error);
-	/* Used for kvec iter backed by vmalloc address */
-	void *vmap_base;
-};
-
-struct fuse_args_pages {
-	struct fuse_args args;
-	struct folio **folios;
-	struct fuse_folio_desc *descs;
-	unsigned int num_folios;
-};
-
 struct fuse_release_args {
 	struct fuse_args args;
 	struct fuse_release_in inarg;
-- 
2.53.0

