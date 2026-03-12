Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 909EF332623
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Mar 2026 19:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773344437; cv=none; b=dHznFOvmyOT+keSIYNNq2YWrkRFLK9q8i7qfcpRcoHCFuGzjSs1OjrCxSmCy6gHLG64GSwTHom1PnSEO/QqluXuCnfQw1K506tJZDbXcwdd/aXJI+uqgymITOXH8MS+G1LQQ36JrqehJmw1pER4Ejk7IMv5YKojBL+cFFc+866w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773344437; c=relaxed/simple;
	bh=DSO+8Zk8XOjeaPR28IfKCnTjxw1pSb3LJMv2rEPTc9k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ua2Evwxw+YbsMT2QFTBpJ3Zvb2JqYWFTcsZQPkcsj+3SNV8rHSvDBNk9TAfivcNTE9ua737qiuiOvg5EEQ0m0V1e5ujNH7cKnuwc5DgWVplm3RKAl+850fgbk/Yw/dMsJaPjharbBY+FXw+yQVUJ5WVXpWro/gNEEzQx+a+jlGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RBv7A4pu; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=QHCcZjPk; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RBv7A4pu";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="QHCcZjPk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773344432;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hy2PFZpDU4BpnTb8IFA9MBTbIMrx0szMjI2N84Y2xNw=;
	b=RBv7A4pu7IeZwPQ+tOeRP1sAbBAV6Xnn68+oUPVVLhuZO9YQ6UFwVw9TnOiIPPjdJ1xzVy
	FepnWNfqlLqHrN4hk8g4qHtJCzqAcCyilkX2IoQHhTDMbNc4IDwWe+QeqA4E9xRJuAkVC/
	83fLy05AE1gPC7R78kGQRM0dshm95K4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-248-hFDdEBdtN1uDCtscv_9VJg-1; Thu, 12 Mar 2026 15:40:31 -0400
X-MC-Unique: hFDdEBdtN1uDCtscv_9VJg-1
X-Mimecast-MFC-AGG-ID: hFDdEBdtN1uDCtscv_9VJg_1773344430
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-485397788b3so12760755e9.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Mar 2026 12:40:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1773344430; x=1773949230; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hy2PFZpDU4BpnTb8IFA9MBTbIMrx0szMjI2N84Y2xNw=;
        b=QHCcZjPkY1Th8FqOUeFZwskL4Q1qQIa3GRxj9l4YReaMfqsS8b+3xzUn4h61NGP1FN
         7E11w85e6et25OzJdHhMyWLKnoC/DG4JOKpufkMX2XHIGBIItQF2KewDtbgUvka7GWA7
         iK6dqW8A4Ee6S5o+ENFMyjneQbKzH09JzvVmMp5a8aoG09xGzxfx57LWUX7G1WLP8g/b
         jF0OmX6P4vNzLQEFG5uA4m3EHcGci1F6X2wPZZ7MqwpNI2HBM0TMZrco+xXJDazObMu7
         MDsVnWcWD4m7YVqomQ8GV5dNMavrMvkSFhobUQ7DsusnaRAAZEcX7PvyUUED1q8/1RGg
         JVcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773344430; x=1773949230;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hy2PFZpDU4BpnTb8IFA9MBTbIMrx0szMjI2N84Y2xNw=;
        b=Hh/2c3wnrQCi1VHNFSFH89PDiHjSOb0+henGqOT6LNEH0295Q8HPILzCpJPjrWbi7q
         K68Px/FyM0aDQNTDbEq3DftnXIihO4PRC1t8KY1OBf0C4/beYaxtpUuf6P+5omhlbsxo
         Lf69FX55F4XrANh5PG17exiVtsGK5Px+uU57cYHcdeDGUt9x1Z2fFiwdnMFgWDpPs91B
         OxCxoRDtk0havHCvq4tFzNH659LWgjA/9fviHErrq0nyOw5VNVGkZJZeu2TV8oIoQUY7
         nN080NEpdaCVSASHo9OePD/gf6ICiwuVvq1VIUzfko8asZOCLNViJHgKB4iahfC7tG7S
         cB6w==
X-Gm-Message-State: AOJu0YxV8fyZ/woYrUCv3h626AYia/PRJPnpKYiEIG10T05qVHTyseYG
	z47XNWky3O2f9yRqUDjNPZMh9Jj/vcNs7eXkvHtpfCTHdgzi0Gve7ofEXcQ7Kxnko2g0mYHXNVf
	Nr3eOLEaPesCagLqQO49y6Cx5OtUZAvaipX6iWQwRotS4pxnmRebE1VS+38YMcWhRlatO4RZKEz
	8QXrouwK2E7mzJrcbppT4/itIIMtGrPyou9DGw6yrPmjoftCWzjXc=
X-Gm-Gg: ATEYQzw71tQd4Wq4pSjt7Uj1qg3zUNY/Cb/Dyj4UeHaRuMM1WNbTpq8z3hNE4if9IcT
	/VnK01W8bP6ij90sxbYGmJvam8yeWZz7pQlwWOER4sEwLY+1beX1XyWS/c/OZ8Nn7Ajdxht/qx7
	ms9B4pNxIknTKAuFlGGO/DpXhfUL/zlstZzmdDQuIPSktKbOoAu4EOC02E4t8n1/CYU39qoQpWR
	XNfZcRO0oKTIXQ/Ofr3yvbj/AYebX6Ae27p1QFAt7hFj9ijfsakrCXWy1FfkEsFQh6zwGJgRU20
	nGti0ERsmODzjJIEoGRA8s7GMPPrT5zdeo7CN3ICQblsR7/O7It0wkF/GvZKV5DAKNK0lz3zpBI
	Fn0x4l9gsiHYwHNCRTkv01eIU9QiBK3eAjDpoGyQFdO6ChSz3CDwPtdbg7CYUMkQHGM5/3fG+tX
	oZIXg=
X-Received: by 2002:a05:600c:64cf:b0:485:3f58:da6 with SMTP id 5b1f17b1804b1-485566cdc2dmr9658765e9.2.1773344429671;
        Thu, 12 Mar 2026 12:40:29 -0700 (PDT)
X-Received: by 2002:a05:600c:64cf:b0:485:3f58:da6 with SMTP id 5b1f17b1804b1-485566cdc2dmr9658355e9.2.1773344429184;
        Thu, 12 Mar 2026 12:40:29 -0700 (PDT)
Received: from maszat.piliscsaba.szeredi.hu (176-241-63-127.pool.digikabel.hu. [176.241.63.127])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4854b5e912fsm396705955e9.2.2026.03.12.12.40.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 12:40:28 -0700 (PDT)
From: Miklos Szeredi <mszeredi@redhat.com>
To: linux-fsdevel@vger.kernel.org
Cc: Bernd Schubert <bernd@bsbernd.com>
Subject: [PATCH v2 6/6] fuse: support FSCONFIG_SET_FD for "fd" option
Date: Thu, 12 Mar 2026 20:40:04 +0100
Message-ID: <20260312194019.3077902-7-mszeredi@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260312194019.3077902-1-mszeredi@redhat.com>
References: <20260312194019.3077902-1-mszeredi@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is not only cleaner to use in userspace (no need to sprintf the fd to
a string) but also allows userspace to detect that the devfd can be closed
after the fsconfig call.

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/fuse/inode.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index f951f8d69e47..5608ed5ba000 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -788,7 +788,7 @@ enum {
 
 static const struct fs_parameter_spec fuse_fs_parameters[] = {
 	fsparam_string	("source",		OPT_SOURCE),
-	fsparam_u32	("fd",			OPT_FD),
+	fsparam_fd	("fd",			OPT_FD),
 	fsparam_u32oct	("rootmode",		OPT_ROOTMODE),
 	fsparam_uid	("user_id",		OPT_USER_ID),
 	fsparam_gid	("group_id",		OPT_GROUP_ID),
@@ -800,9 +800,8 @@ static const struct fs_parameter_spec fuse_fs_parameters[] = {
 	{}
 };
 
-static int fuse_opt_fd(struct fs_context *fsc, int fd)
+static int fuse_opt_fd(struct fs_context *fsc, struct file *file)
 {
-	struct file *file __free(fput) = fget(fd);
 	struct fuse_fs_context *ctx = fsc->fs_private;
 
 	if (file->f_op != &fuse_dev_operations)
@@ -859,7 +858,11 @@ static int fuse_parse_param(struct fs_context *fsc, struct fs_parameter *param)
 		return 0;
 
 	case OPT_FD:
-		return fuse_opt_fd(fsc, result.uint_32);
+		if (param->type == fs_value_is_file)
+			return fuse_opt_fd(fsc, param->file);
+
+		struct file *file __free(fput) = fget(result.uint_32);
+		return fuse_opt_fd(fsc, file);
 
 	case OPT_ROOTMODE:
 		if (!fuse_valid_type(result.uint_32))
-- 
2.53.0

