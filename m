Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF64537F730
	for <linux-fsdevel@vger.kernel.org>; Fri, 19 Jun 2026 12:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781870432; cv=none; b=Gh7Hz6mQFfcf4Zxj+haCWMgkBPk6DHDzbsfEnhKb5QcZwVWeNgMCVtK6Bgf2t6wX3zjs6rwF+OIkmDGXdKW/PiKQgiYVN6vLylXGfFarxo0shVZFJrEWRcwQLLQg/4+YjhmH2Mr+O8kCPa8n9ga3+CXJGQMsCb5q9f118BRy1n8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781870432; c=relaxed/simple;
	bh=Vg5wHxwQRmjxfOpg6Q/n/wEes06PZcgmmFj4ceOkcY0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hYhnhy6ej1FPDCVU5AcwFgTgYi77qxFaGOGJQ3jLejwcYTMPDAP2XwNGnsI9yikBixfAOdB0sAFOZm/+v9teAZ/yrDuQJ8ij5phw93vdgmBcA1CkSn5wRb2csEo6/CHDcMiE7BToAlGDlJ/yRK62GPwo5OSy5q0UUz7UOoL0sw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qR7vq6O3; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qR7vq6O3"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-490bc6a7958so23741745e9.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 19 Jun 2026 05:00:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781870429; x=1782475229; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+LdvO0oEjrFRjPZX/mnbADsvNWAvZHhQoS7JQpSrd/U=;
        b=qR7vq6O3Yi+Fy7A8PgU//m+ADU5YUhcyGWBsMWjZ+lIgtnCWS7x4GJ/34HCdvadG0L
         tOWloF/2JjD1X075XRxZ87zn093zWg9kuGX68xUdE+v8PBx+Gg2aRXgI6rkot0aVYnwg
         hLkt3qTpM/DGyM+51Grsg0RkUplKhfKgJoBSlkW+2CfsTBlddNeKirMc7NP664wQORSA
         2BR8T5XzNZALIn+xWvREC12hctz63A6NtoSY3gZbtqfLuEJ9uu45a2CvTQ5q3wk2YShj
         B4MuAQhDHV4xhss0UYeCO/tQtl7Itv+yghM+4roXJGpr4QqGgPLzfN4M7BXscGVtiaaf
         sB0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781870429; x=1782475229;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+LdvO0oEjrFRjPZX/mnbADsvNWAvZHhQoS7JQpSrd/U=;
        b=r4degIUU3mf1oJIDj64RqzlRxbONmETKdiyNHPWqyXC97r+D5T2fk53QvSkbHe7tF1
         AxPEbMkIEiw8evarTwjNMqDMCgFyweEFU+bPTk50+zrI5vFESSa4oEnTA2Y9ggHTGM2/
         6SQTXx6/a5nBqUdLVo6Eq7w6RT8nkcl1KINY1+WkRc20qotzUMmdpii4Yh1hzGwqJFln
         M2la2VlzyOxUrV0lYmcWXbE+tANGHeDwSFVuL4qGDpY7qMaN3BhjcRzXFnzEK9GchgbF
         e8MBpScKLAX4CqZF4PPKTChtvfW4Mw8q8MdY2LckzFi2LYgA32NNNzM0cbBkfsdobbdu
         Z+/A==
X-Forwarded-Encrypted: i=1; AFNElJ8wNne+KO1oVhc2ULnDcPcBWQwaDIAc9264fQdjPbolkjdAaUO8G6mQyORc4Cy9RCXKkjQWPk53xBGYkbqk@vger.kernel.org
X-Gm-Message-State: AOJu0YygMpcQUNULTma4CwauZ6wdkuR+Og7GznN1FGizdYSqlA8MduXq
	sVh/jhH3pMn7Ls65i4aLBQ+Kppe70iUqKniSqycLFJULhyP7ImK1gZA=
X-Gm-Gg: AfdE7cnd+OX8vHEwIEvMC+HUjNFoTbllcWhGEJTswSiGN5X3s/AsP2JikmSwBPXtIlo
	sCOpVVqOKySDSq99wZ/OP0fk6I9KmSEtbTO/ZouwTJ+0jkkveRsWNVmCeJVdXfE953yxRIsqLBU
	lLUCM4eCd7o1/guzZCN7237gnFE3EBp+nPw3ovJbJX9qwP2kDGmAXv/+afeHMoK+r3xsqZlHl1v
	CoVk1c2J7HWHrIg6lMgd4ehOj911Nqt+3DKxm4PTinkvwSrfxr9bPbZo4W+UuOMiTMbmhBJ/c25
	qkjnN/AnvRxUuZcJQn7PSAWS/L16TVPX3YGRteO6TO/kMmQ76es6wluMyHpatIdS4mn5i+ou/bU
	LRqgKcna0yajC+yOXk3toBfY1RiFs7a1mk46WYRl/tuhcGUyNuucMi/YdbA==
X-Received: by 2002:a05:600c:2d89:b0:490:7df7:9190 with SMTP id 5b1f17b1804b1-49240a09f97mr23365025e9.8.1781870428832;
        Fri, 19 Jun 2026 05:00:28 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4923fc47720sm102995695e9.0.2026.06.19.05.00.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2026 05:00:27 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: miklos@szeredi.hu
Cc: amir73il@gmail.com,
	linux-fsdevel@vger.kernel.org,
	stable@vger.kernel.org,
	tristan@talencesecurity.com
Subject: [PATCH] fuse: check fi is not NULL before calling fuse_passthrough_release()
Date: Fri, 19 Jun 2026 12:00:26 +0000
Message-ID: <20260619120026.2630196-1-tristmd@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tristan Madani <tristan@talencesecurity.com>

fuse_create_open() calls fuse_sync_release() with a NULL fuse_inode
when fuse_iget() fails. This propagates to fuse_prepare_release(),
which passes the NULL fi to fuse_inode_backing() via the
fuse_passthrough_release() call, resulting in a NULL pointer
dereference.

The existing comment in fuse_prepare_release() documents that the
inode can be NULL on the error path of fuse_create_open(), and the
fi->lock access below is already guarded with if (likely(fi)), but
the passthrough release path added by commit 4a90451bbc7f ("fuse:
implement open in passthrough mode") was not given the same
protection.

Add the missing NULL check for fi before calling
fuse_passthrough_release().

Found by syzkaller.

Fixes: 4a90451bbc7f ("fuse: implement open in passthrough mode")
Cc: stable@vger.kernel.org
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
 fs/fuse/file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index c59452d60b8d..9b368eab159c 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -313,7 +313,7 @@ static void fuse_prepare_release(struct fuse_inode *fi, struct fuse_file *ff,
 	struct fuse_conn *fc = ff->fm->fc;
 	struct fuse_release_args *ra = &ff->args->release_args;
 
-	if (fuse_file_passthrough(ff))
+	if (fi && fuse_file_passthrough(ff))
 		fuse_passthrough_release(ff, fuse_inode_backing(fi));
 
 	/* Inode is NULL on error path of fuse_create_open() */
-- 
2.47.3

