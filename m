Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9516C3CF024
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Mar 2026 16:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773680010; cv=none; b=ItSgLyDzCOP/k+ThkTMK4FqiO+0IO6rhlyoAagLuH43Ts33W+y9ugvWqU3H0LbQ4sO24tzgzdpq584fQAYBnlm833h9jfypHxrDsNfi1kdJFW5bHxT+79xsS40QfN/Wig4nHFaU/8uD13wYEqLDIT/6yFSDVychVjhiZ5b8kj7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773680010; c=relaxed/simple;
	bh=Gj9ReL21qkCIwwx5AuSkqh932hkHpOSUWcCxA7paFuM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rLAxJjAoC8SQ5CSjhnXShzShpF1ZspA0Le/alINSa8NJgTBnI5DnOnMc5S2O1ocCZsv2AEWNs+o8HDbiE+swf5hNJ7JRKXanGQGzIoGjZ20YgnAdAvcCPvPPZNsFkxw0xe0gPCeuEUSM5sBRJU5Mn8QdbcW53njdTanM8NJTaxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=a5FjR+i/; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Sg0wkE3F; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a5FjR+i/";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Sg0wkE3F"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773680006;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RwybaCr/UoGq6Cq8k7p5oy22lmCgSShsaMlgHq7FEH0=;
	b=a5FjR+i/viZS+TzSwzhRTAxRUL7KpXlQqAqGQSqnko2mhLZUvcHoMUG8mf+a5R/9+jMK+8
	dhBUjAGjaaEJuD+lZK14RBLpwKUH9NIq3/Z0TzuqpfmbwdjxtkoYTv+J6Q3CXyEwDMGNhl
	p7muL9YiJeG3Bp1Z+lZ4q2RLj0CzZeM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-556-IfricVsNNgKGkrhLasRKlA-1; Mon, 16 Mar 2026 12:53:25 -0400
X-MC-Unique: IfricVsNNgKGkrhLasRKlA-1
X-Mimecast-MFC-AGG-ID: IfricVsNNgKGkrhLasRKlA_1773680004
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4852cf0318dso64610775e9.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Mar 2026 09:53:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1773680004; x=1774284804; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RwybaCr/UoGq6Cq8k7p5oy22lmCgSShsaMlgHq7FEH0=;
        b=Sg0wkE3FUMZ0gBrbxNxikITudfS6EiEsov0+TQmrNj6wMOrb6qjYotTCpoXEdHhmGD
         gQhMvDeEh4Q+T1B8AXvsDPD5pk1bgnockbjDIDGhSV4rV9hmIFBDwt2zqp5cFq9dupOm
         4D3cnKCuiVaUe2gjznPbahhbb1GSw3DalSuz/RY8e2rksEwyCPdM9jLr0Mv71gTOdkjt
         fxUem/8mFPD/J5mT3YhQyxJFY31cmp62NUMg70q1biWulZv28oEO4F2o/5hDib9Qh3YW
         Gvl0sMV7BCgmFdrgYx51s2l6rvh2v66bkxwantz96Vum37kdNDAvCCA2Z6ebfR4n+Izn
         ZKwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773680004; x=1774284804;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RwybaCr/UoGq6Cq8k7p5oy22lmCgSShsaMlgHq7FEH0=;
        b=dz9ADU69m7jGjFk9nQx8AFYBfmdS90cekddU1bUpHQqVx0k2vwkYJTptc6zAY8zyQw
         ZWU9kgtDe0z5Po6uRZrD9QJooWeo9emvIqcGt0mvXjk4xxjsAroClhztmbK4aLefZd5R
         3uqV/vZMVFC4ZGGKE45eafcvR2tng/qaKV/0zlJVJTP+DDtjEiHPL5L3GzPeDu6qJp2E
         QAjajG3h3OzW99zkq41C1mhpzyV7D4uIa2YVsbmiB8U+MlN7MpR92gF16PDiHOKy2fBt
         RJwNPcdfnEkKJ5ipc0ZqIE4cTUsoL8mN6xF2Lgq24pKZQdltkjBfD2YX9qi7jLBwrzhV
         XIDg==
X-Gm-Message-State: AOJu0YxMFHOzOpF9AbOlo6YvhSf5Pkt8P6wZNeeYBU+fU7Gg+wLl3gTk
	5JTmBFYW0axa+dw1f23oBfP5qX62KRBiX5cNj1ZoWV+homVEepjqmlbvb1udblO6yGLGGAbMaQx
	rGm/a2Q0cvtWRCbwUQ3J+ifKWqh8xsJzlXIASoSqPuc7PbNLNoDUbCnOkcsgEf8bE32Tmt92bUL
	X5obVi+BsM9XMGkAbj1hWb1NWWSLF5q9fuewlVkECP+yM27GbGm+o=
X-Gm-Gg: ATEYQzwi9YzDOU81qZxcZA0iUwR5sNhW3lvKBojqfg0mfPlClGDIKyK+hhKkyZGcaX8
	LSYCCrv3JsNTIs3jb/APWoRv9cFsnVWTjVKtNVAABFYFzKFoIXXk3mR51wlbUjctM8OE92R9WIM
	BWOsBv7KhMqC5ogn1ZF4uHuc/aVVpb6PPjY1rk8n2F5SENWk/rVbI5LXaZqHll5fJSMNpbBNJ8F
	B7cxeoKFBsE95pIRMtQU+4iboXXjGdXIE2q5nnH1Muh17u/4CyQBomAoB+TSUxyi7fKCKtDrzt0
	ddwt2Nd5UJpSdoGJ2YGml0Kc9kk/gQ3hJBFpJ9anO7QO3ZtziLl62JBcxT8B/+nBLe1nlK+/fJz
	U0+22c51oATZhC2PilG4hewLU/ya/IPovLcRQ4xRF4rc8furYn/2Zm60HGPrjlbL9hQ4EoPOYTA
	==
X-Received: by 2002:a05:600d:8486:20b0:485:30f7:6e88 with SMTP id 5b1f17b1804b1-485567149fbmr167661775e9.31.1773680003982;
        Mon, 16 Mar 2026 09:53:23 -0700 (PDT)
X-Received: by 2002:a05:600d:8486:20b0:485:30f7:6e88 with SMTP id 5b1f17b1804b1-485567149fbmr167661205e9.31.1773680003366;
        Mon, 16 Mar 2026 09:53:23 -0700 (PDT)
Received: from maszat.piliscsaba.szeredi.hu (85-67-172-54.pool.digikabel.hu. [85.67.172.54])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4856ea9c340sm4978295e9.7.2026.03.16.09.53.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 09:53:22 -0700 (PDT)
From: Miklos Szeredi <mszeredi@redhat.com>
To: linux-fsdevel@vger.kernel.org
Cc: Bernd Schubert <bernd@bsbernd.com>,
	stable@vger.kernel.org
Subject: [PATCH v3 1/7] fuse: abort on fatal signal during sync init
Date: Mon, 16 Mar 2026 17:53:12 +0100
Message-ID: <20260316165320.3245526-2-mszeredi@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260316165320.3245526-1-mszeredi@redhat.com>
References: <20260316165320.3245526-1-mszeredi@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When sync init is used and the server exits for some reason (error, crash)
while processing FUSE_INIT, the filesystem creation will hang.  The reason
is that while all other threads will exit, the mounting thread (or process)
will keep the device fd open, which will prevent an abort from happening.

This is a regression from the async mount case, where the mount was done
first, and the FUSE_INIT processing afterwards, in which case there's no
such recursive syscall keeping the fd open.

Fixes: dfb84c330794 ("fuse: allow synchronous FUSE_INIT")
Cc: stable@vger.kernel.org # v6.18
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/fuse/dev.c    | 6 +++++-
 fs/fuse/fuse_i.h | 1 +
 fs/fuse/inode.c  | 1 +
 3 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 2c16b94357d5..f0631c48abef 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -576,6 +576,9 @@ static void request_wait_answer(struct fuse_req *req)
 			removed = fuse_remove_pending_req(req, &fiq->lock);
 		if (removed)
 			return;
+
+		if (req->args->abort_on_kill)
+			fuse_abort_conn(fc);
 	}
 
 	/*
@@ -676,7 +679,8 @@ ssize_t __fuse_simple_request(struct mnt_idmap *idmap,
 			fuse_force_creds(req);
 
 		__set_bit(FR_WAITING, &req->flags);
-		__set_bit(FR_FORCE, &req->flags);
+		if (!args->abort_on_kill)
+			__set_bit(FR_FORCE, &req->flags);
 	} else {
 		WARN_ON(args->nocreds);
 		req = fuse_get_req(idmap, fm, false);
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 7f16049387d1..23a241f18623 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -345,6 +345,7 @@ struct fuse_args {
 	bool is_ext:1;
 	bool is_pinned:1;
 	bool invalidate_vmap:1;
+	bool abort_on_kill:1;
 	struct fuse_in_arg in_args[4];
 	struct fuse_arg out_args[2];
 	void (*end)(struct fuse_mount *fm, struct fuse_args *args, int error);
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index e57b8af06be9..84f78fb89d35 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -1551,6 +1551,7 @@ int fuse_send_init(struct fuse_mount *fm)
 	int err;
 
 	if (fm->fc->sync_init) {
+		ia->args.abort_on_kill = true;
 		err = fuse_simple_request(fm, &ia->args);
 		/* Ignore size of init reply */
 		if (err > 0)
-- 
2.53.0

