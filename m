Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E55B339B964
	for <linux-fsdevel@vger.kernel.org>; Thu, 16 Apr 2026 09:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776331055; cv=none; b=MgLyakXDHj3rGhT9vM3pKtCWWqvosy0bDuVTOvqQXLcNLYKdGfIJrwUTHtnxN178jaYaVekVWWFzGX6HGO2VFr+Z0Pt4fcSE4yvL/AGQDa7RBd0T7UvewOWdmyDkFr6XPOWOoUAQHjSf1WiefBN7NtReK2rLhvrOfoxNw128kY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776331055; c=relaxed/simple;
	bh=cTPHIqUjfffPg1SbN9YU4EdCJN6MCkhvMu6sMd4a8LA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CjLhQ4YXUfeY8zGkUns7YXm6roiWSJjq4dQF6sSFkE66Lmltb1G1gNDdu+YBaA1MPuqdeCm3EZWol8PGRyYjJA0xnmjNj8m7LQL89R0bIBaU1dSXaZXa3iRFBCB8YMmyA//gdARNyzvLEcGIicmVdfO1PAY0e0OwYRNleeSBUvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OaJiXrot; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=fIPHiclD; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OaJiXrot";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="fIPHiclD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776331050;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TPk/yeIL85CGNg1VihA0wb2dmd3GQ79PwQ6zGc6blQw=;
	b=OaJiXrotrxRxRAkKpB53Eth2xZWGG8YYrvRwLzO0ajrscoRqey/AGZZBtQnBg3KmTSV07j
	Lio3fK5jb+Ovy6nHjw1OeDVESu/AH++6UVtT1U/CXDK1Q+QDlzw2fTiHNpqazefoJKNjh8
	PN1wuiGaARPAW+6SgjSzk9cOUEPSYao=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-556-L_6AGBfnPgWyHvCnM5J1XQ-1; Thu, 16 Apr 2026 05:17:29 -0400
X-MC-Unique: L_6AGBfnPgWyHvCnM5J1XQ-1
X-Mimecast-MFC-AGG-ID: L_6AGBfnPgWyHvCnM5J1XQ_1776331048
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-488c2cc0cbaso44802705e9.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Apr 2026 02:17:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1776331048; x=1776935848; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TPk/yeIL85CGNg1VihA0wb2dmd3GQ79PwQ6zGc6blQw=;
        b=fIPHiclDokGFzskw5qlnKDirbYnSNA5pC6b0TuQ03zccv3+acAv0ubGh60rfHa0SV5
         tpNphFOlAU8NJQQAqAJs23WKyxrH5fk9ceo0ORz6vrbrZanLzY+zJK7eW8+Nn/yxPYJp
         plLyB+X/IpuP+HYsIFWlOm0xjF4Zut+tY1LPJ2jsaT929rJKG3S8ZknYZrPcXgnK61Gw
         xNgN2HtO228xs88iIWFQW7mBVWDaDJpfV/3tRonCT/vikqSB7Biftl6XxXSLUi9Ix1HP
         2WWFuSbeOhHrZtJUPjxobij5Br9xgAas3+cSUIeIDU69XxJsaJ2qGtHY0qHDiNgOxggL
         RU3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776331048; x=1776935848;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TPk/yeIL85CGNg1VihA0wb2dmd3GQ79PwQ6zGc6blQw=;
        b=sCQPiCPsOy1RLdU5Z9D0NfRVGeXKxchUVCJtgDmfUXMqPgqdq8cqyIFV5nREoTcXwu
         OFwFyzoQ+pmuMYzXa5tGpgfv6/7UZV0gOntXb4XGOHy6LN2vD23InMKavTyJdTmIhOdJ
         nRGGepbfqQNt36llRaWsety5z8cbg/PCct6EcIlSRnoD33qThRGzLGVblO9Bz8J7tN+S
         EPa2ksMjO17uopH+IumJ4GTTkMPN0THVmkJ+n88fNrEmQmPvuoG5/3jqizWKLCJuflYD
         ACZxwKiCXHwqsM/ogmkAuC/3XV7WE32VEkEFpc0/zufUDebcid8Ki8oC4SHnRPIJKkf1
         YoeA==
X-Forwarded-Encrypted: i=1; AFNElJ96RP6VHc0G4nhMvxTaOyDvLtEY2qmJDlGG3r5HXypmBelERomC5zzG0OvTAP6ISxhQYRq7h0K2IrH+pBW+@vger.kernel.org
X-Gm-Message-State: AOJu0Yxqz/i6s931ldViJ2Xdy67l5mmtr+X8gj0aTWHQXEq+IXKqv7nv
	3ii+k1Oz+KfGw/1WpCWMw7+ThgjjRl43maDwtaNR7ADoaOxL81j6nA3p+XbPTmLaq7XUbbcJDN9
	t0chkErWxtwlbM4eHRd4+RnQufDHyvBmeHbCKNx6u9bjV/Q7Qjznh+4GXvCUji7A3bLfFOQhA2R
	0=
X-Gm-Gg: AeBDiesfMvWUsP3IBisGWSaGSETSTZ+BfgmK6FWMIs69W7uQeG7RzTvpLv4bT67s16r
	YO67j0ec7bkGa8PGCk/z9nxV3mDPyJ+OK9wIa8MFwqgMRFtI3478Vq6gNdaOuMy5cMcgJl6eoV/
	XuIYa2DKesjRdW3IdzY5alCzMl/OjvH5DIBzN0WLzmw/JIY6LbpDB89j9E0ss+7d0zXovjInyCJ
	nylUAPKegWAAsWvo3tRw9cDw+5ck3ucolt6H2huUU5KmRF6kUF3c4VgsCy36X2e28dyqQxycVxp
	wiatHHOHl3GLVeoba6IuuplyE8d5lD/JYErzxKeolAIWFyWTGB9zZyiY2Y9Yz2LRKS1+OjX6w6o
	fclfqWW+mBNwg6j5jliMTqfLtqL76i0+I+s7+W57uZF/QzpnlGFp3pYS0Y+z/ba4RirxclpuvJi
	dOZQl0Ew==
X-Received: by 2002:a05:600c:6994:b0:485:3eba:ab96 with SMTP id 5b1f17b1804b1-488d67bbcbamr354946705e9.3.1776331047739;
        Thu, 16 Apr 2026 02:17:27 -0700 (PDT)
X-Received: by 2002:a05:600c:6994:b0:485:3eba:ab96 with SMTP id 5b1f17b1804b1-488d67bbcbamr354946185e9.3.1776331047293;
        Thu, 16 Apr 2026 02:17:27 -0700 (PDT)
Received: from maszat.piliscsaba.szeredi.hu (85-66-37-19.pool.digikabel.hu. [85.66.37.19])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488f57d80d3sm38597975e9.0.2026.04.16.02.17.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 02:17:26 -0700 (PDT)
From: Miklos Szeredi <mszeredi@redhat.com>
To: fuse-devel@lists.linux.dev,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 18/32] fuse: remove #include "fuse_i.h" from "req_timeout.c"
Date: Thu, 16 Apr 2026 11:16:42 +0200
Message-ID: <20260416091658.462783-19-mszeredi@redhat.com>
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

Just need to move fuse_abort_conn().

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/fuse/dev.h         | 3 +++
 fs/fuse/fuse_i.h      | 2 --
 fs/fuse/req_timeout.c | 1 -
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/fuse/dev.h b/fs/fuse/dev.h
index 1d3d2e0c9b91..efdaf0bf6f0f 100644
--- a/fs/fuse/dev.h
+++ b/fs/fuse/dev.h
@@ -41,6 +41,9 @@ struct fuse_dev *fuse_dev_grab(struct file *file);
 
 void fuse_init_server_timeout(struct fuse_chan *fch, unsigned int timeout);
 
+/* Abort all requests */
+void fuse_abort_conn(struct fuse_conn *fc);
+
 #ifdef CONFIG_FUSE_IO_URING
 bool fuse_uring_enabled(void);
 void fuse_uring_destruct(struct fuse_chan *fch);
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index a0d120057ddb..af8e05a403e5 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -996,8 +996,6 @@ static inline ssize_t fuse_simple_idmap_request(struct mnt_idmap *idmap,
 int fuse_simple_background(struct fuse_mount *fm, struct fuse_args *args,
 			   gfp_t gfp_flags);
 
-/* Abort all requests */
-void fuse_abort_conn(struct fuse_conn *fc);
 void fuse_wait_aborted(struct fuse_conn *fc);
 
 void fuse_dentry_tree_init(void);
diff --git a/fs/fuse/req_timeout.c b/fs/fuse/req_timeout.c
index ef464bebc0b6..9c48789b941a 100644
--- a/fs/fuse/req_timeout.c
+++ b/fs/fuse/req_timeout.c
@@ -2,7 +2,6 @@
 
 #include "dev.h"
 #include "sysctl.h"
-#include "fuse_i.h"
 #include "fuse_dev_i.h"
 #include "dev_uring_i.h"
 
-- 
2.53.0

