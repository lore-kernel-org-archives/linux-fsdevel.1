Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F383B39B97A
	for <linux-fsdevel@vger.kernel.org>; Thu, 16 Apr 2026 09:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776331085; cv=none; b=ghOMFqNfsKeuyAuoyVjM6//fkOZUWx8OK5hurAdYPU5/LvsVfyFCeYrqQcmeI0JI9Jcrzc7HELN+ISZ3j7orsvRRMN57xpgBPrM+gOenRXig6hFM5EGNBgZtB3aZM00AmgsEdQocs8pOY9YtXDThW0mbenejmNP+CnkvxqiLo4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776331085; c=relaxed/simple;
	bh=oupKbopHoZjGKCXVfgLdV73YFvSm3nL01eZ8SkoReg0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wqp3HmLhMbDM98rajafSfsnrXcr4XmqhGZPaP9fLM6QdG5+y5SfKygoKlg/x9m+wXJLclapYLVz6ODqklwUCTGA6W8r9T6+GNGWmcgW9UNIPgo8D8kP88pa3cq+SbPzrKpalM0M3ctF1xlxqWQlUuLtuo6ABY8KyRKOJuMmvGgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MuMqlPRM; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=CMr3jkhE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MuMqlPRM";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="CMr3jkhE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776331080;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Hwd2KVO2gNiboi+7UNEBdWG86Ja+wtOAOwDZUksJfYw=;
	b=MuMqlPRMgGnXBzwk3jmh+SeZhU14kfEQ8osZ9aBJwMtyeiD3Fzw6ScfRdLt33rfB1kwXU8
	5P4slTjOZXlQK9x+foY07KXGIV840BXO9WmyVJq2jKE6cOF6MynY5e8HeIWVvLKdY5HUa6
	sngYh1JCWJyITuRzIZAipt8uK+YvGlE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-568-kov_ttubORy_nFsLdOpiIg-1; Thu, 16 Apr 2026 05:17:42 -0400
X-MC-Unique: kov_ttubORy_nFsLdOpiIg-1
X-Mimecast-MFC-AGG-ID: kov_ttubORy_nFsLdOpiIg_1776331061
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4837b6f6b93so64194535e9.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Apr 2026 02:17:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1776331060; x=1776935860; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Hwd2KVO2gNiboi+7UNEBdWG86Ja+wtOAOwDZUksJfYw=;
        b=CMr3jkhE6v9Ox6PWKoqAdIUfC+P9IC0+D6pgZV60GfLxp81+d426xc6yRlspibA9BU
         1CMRnPK5HApv1zHO7RA58/Wdf8/MuS68iVwta7Yjd1O/5UbaD0yQBFlRxLcHP0SHVLxl
         q9PoK/MTvqm7lFEMvOLDbC36yxmDv6XNKzfOpwNkEUVjHj66/26RJBQMhOMdUo6WPpGP
         49BswBf441pj9Nm85yPDxnaB9RozQePgjQgryFHw2L5T47IdWLqE9VVqJ4c9HUnJO3PS
         l5d2hzNIsXLAziwlcQdlrrgChziZMdvIFPEe/NVTqmsaug3oRaSazWhqRhfyDo0XJoGh
         jfLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776331060; x=1776935860;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Hwd2KVO2gNiboi+7UNEBdWG86Ja+wtOAOwDZUksJfYw=;
        b=srDP1CRgHuoiY9rxgF0JMZYYWxyo0LeIHyLd5XsybgoQbEkdBiFoHRWd57BvF6R8Pz
         cy1KdY84fIC9+acDUvrn/SZSY0U8QpBxkbv1Gh48KlRblp0smll854VIDLvVxM6g8rup
         HGLo6lWOTrhqGyNBOgwGLIqI++FruRUFORUX4GQMFQlCkKzRHpkecFqt074GoNTEu/3z
         o8/FOacx5tXwokHBQ2Vblf133eJgTkf8rRbzqI/xAsm3qkLWwHsxqi7zeBjgkAO2+cCd
         pqlsAuihtfd/RcnzV00ZVxQVCENUx+qjfiI17LJASB2isveRatqYbsuecrowKt7x3OZb
         p2Nw==
X-Forwarded-Encrypted: i=1; AFNElJ9O6Z5WoOkRpSJYtKZiP5CBwr36/IvOpS0/zmiPRCOyZ2/415bfczWGhWBhenGk2AlPn/Z9DCGCAiQuXGQz@vger.kernel.org
X-Gm-Message-State: AOJu0YwSHRFu6DMHYQSoFWjk2yJLPzZ5HyfJBmYtEcbGh18wAjsKpWnS
	Si8fEiC19Idhla4oRMdSOx6aINDs25Mjfb/46HvFFkpIvxmC89EOih26buSLVnL16q6qMmJhSUp
	M7AjvRW2OyliXfuQuQ9h9A7yyOjCX0oZddjGfUTKodNXjH8m+g/gkc3uU4Ub2aIE1W5//Vi0S+I
	E=
X-Gm-Gg: AeBDievyLuEfCoMinBoKqQnRfpZ6ajn55YoJpqoNESTLyZDHwNQ01YUutubsAl/VGQ5
	1ehPSNysp0sJTCpcQJj8whdy6rHrHY2dJx5MZ+2JftfCrc9k3hRT9UBYdRGCpBVMkp2uWd0Xkj/
	uNq6QTqX/zIGgx9O165PXbJinuG32ahjPIIo5P7Jo35nPEj9qa8HU0BfN+Gt6JFSnfaLK6hyOOa
	c4hchHVKFRPMB3mZ+CHyv2z2IHqis30Mujp5qWxoEcFmvq4bk+wQzsNdIbeSNf4QKeCK+HM0ekW
	FusuiFVdzZqdvo4X1ewdCxKiVIQIWyYTyCuXpAD7TpvCAPIgSi/kHCbIwjd7XTz2t1NtbrTlOOS
	LE1VpSL9gvtRqPscnKIULXWrq6ZhDPvvQLqfs5wY39jReWTids2CMiwgPIsG9/yxlub4p4MjuW3
	0PmyTyhg==
X-Received: by 2002:a05:600c:528c:b0:488:a2ac:a337 with SMTP id 5b1f17b1804b1-488d68c2bffmr322775885e9.21.1776331060400;
        Thu, 16 Apr 2026 02:17:40 -0700 (PDT)
X-Received: by 2002:a05:600c:528c:b0:488:a2ac:a337 with SMTP id 5b1f17b1804b1-488d68c2bffmr322775555e9.21.1776331059990;
        Thu, 16 Apr 2026 02:17:39 -0700 (PDT)
Received: from maszat.piliscsaba.szeredi.hu (85-66-37-19.pool.digikabel.hu. [85.66.37.19])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488f57d80d3sm38597975e9.0.2026.04.16.02.17.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 02:17:38 -0700 (PDT)
From: Miklos Szeredi <mszeredi@redhat.com>
To: fuse-devel@lists.linux.dev,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 28/32] fuse: remove fuse_mutex protection from fuse_dev_ioctl_sync_init()
Date: Thu, 16 Apr 2026 11:16:52 +0200
Message-ID: <20260416091658.462783-29-mszeredi@redhat.com>
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

In normal use ioctl(FUSE_DEV_IOC_SYNC_INIT) comes before the mount() or
fsconfig() syscalls, they are executed strictly serially.

If ioctl and mount are performed in parallel, the behavior is
nondeterministic.  Removing the mutex does not change this.

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/fuse/dev.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index c59cbfd3ffee..5ebd6f3e0fe4 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -2297,16 +2297,13 @@ static long fuse_dev_ioctl_backing_close(struct file *file, __u32 __user *argp)
 
 static long fuse_dev_ioctl_sync_init(struct file *file)
 {
-	int err = -EINVAL;
 	struct fuse_dev *fud = fuse_file_to_fud(file);
 
-	mutex_lock(&fuse_mutex);
-	if (!fuse_dev_chan_get(fud)) {
-		fud->sync_init = true;
-		err = 0;
-	}
-	mutex_unlock(&fuse_mutex);
-	return err;
+	if (fuse_dev_chan_get(fud))
+		return -EINVAL;
+
+	fud->sync_init = true;
+	return 0;
 }
 
 static long fuse_dev_ioctl(struct file *file, unsigned int cmd,
-- 
2.53.0

