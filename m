Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37C353E2AD5
	for <linux-fsdevel@vger.kernel.org>; Thu, 18 Jun 2026 10:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781777585; cv=none; b=SzGxk7456/hsq42ledo5FUxVFtGTwhLdufRWPQmoJ6EY9/fzpFIvbdWBlDA4AwuWZN7nW4UG7PG1Y2q9Cheyo58me0vPJIGF8pMrO/G21gKgYcSHrN/1lGQwHvOQsjBkVp2MoFb3dOY1bb0TzIWN7MeMtUkaPg3SKzdw+Zk1le4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781777585; c=relaxed/simple;
	bh=mcoKrYorVNnm76YRTwx167W5hp2wd/TWvYr7oERQuNQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=N3g3vl4LB//uXCKYj0YSH9pErTuVcdoeXGOuoxHdSXcKUnpGj9m+JEfM8qCAE32y+ra2not+VuAQyg5iX8VwukYxzH8anC1+BKzNPQuziJH5fA3L1XFWpyA+dDFkO1gwKqoAS9hNwIsXPprmfwSboQQEXyfNYfSugvnQY5kWfRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Phrc9D3F; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ofJWmf0+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Phrc9D3F";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="ofJWmf0+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781777577;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=syVyWPNbQoi40k5vUXKNpOcBPXysG+YdLIEvJjGu1vc=;
	b=Phrc9D3FVDXv6Tl33DlNX8L8bp9bAiGlsrmH9wgrJ2XWiI9Wo/WRoMUW7HPPhRcQwiP9yc
	dZj1aHRXYYKE80v3+CCtQjjCy93YJ+/z7c/g+boFcFuhl4RwhyEPIea8X80gphF2WcPx5C
	y7OZVY+VmGYUgpYgXah/vxlDaEdzVlU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-511-3RwrAYd0PAWtllY2qGLl_g-1; Thu, 18 Jun 2026 06:12:55 -0400
X-MC-Unique: 3RwrAYd0PAWtllY2qGLl_g-1
X-Mimecast-MFC-AGG-ID: 3RwrAYd0PAWtllY2qGLl_g_1781777574
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-46010392f89so714499f8f.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 18 Jun 2026 03:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1781777574; x=1782382374; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=syVyWPNbQoi40k5vUXKNpOcBPXysG+YdLIEvJjGu1vc=;
        b=ofJWmf0+icitUurzLn8S4m+ZAEWCJHBltpjOWpoLMW5P/Ge1lpD4JplZLHI+kjW1wx
         NxdKc0q+vRIKP+U9ZLrBm+XD47vQDVxfYnXcOgcd+qiYQrSudp1cDSYBOa1O/0SOLB3R
         3NXkwq4XQ8oalc/4ZST6h2Y7kDx2qDaqZGX7v0i3uzzK4p0aPuSKRPyh7wNbcsg5Ijl+
         vyNjEmap8qR1KuFT0QRyQpMydN7Fyu8DYYcy0PRh0oZwqCYDdE8Z+umhWnGCnVQEQhN1
         V+azIySyS89Tk/ls8yfgcVNmKc+qINsMcm0QH0gxZ4Y17wuNmHazZ84J57JclI382BrM
         FGdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781777574; x=1782382374;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=syVyWPNbQoi40k5vUXKNpOcBPXysG+YdLIEvJjGu1vc=;
        b=Cq8hnfeIDhwf+YcSXGMrtRV2qV8+8zxbQdlklpk0QwfIISmP+qrzfQGsX1uvD30hBv
         NBfsNjsQQwFkGJhuGKhiNk5Z3yxDiEPvR5pH6CKNznX0ugtOM7r7U5le8+4fThcVBpxG
         osSZjaq3tqx1mEs7op8x6SY7C+A4HRaURhUjf3ShP1BvR617gyFZK+ksJl7jxrXHoJYJ
         8pPw1TVeUeMp7UjOSAJ5twbF6cKvW6nUxTiqPC9MDSj45otLT4AGlvhVAH3WKAT211hp
         m0HulSyLl41gu05OXbrSEapzNgMMWDd5wBaiUzovPsDuR91Q8Fhu08YVZX4Ef0zSpijW
         NFLA==
X-Forwarded-Encrypted: i=1; AFNElJ9qKOVkeci45C9mD5QRz7m7LO979aoNkljS7YBWu0W+H0yf7n1g9CZxrLM04MUQ5+/yIn/v+7JUqOMgKN7C@vger.kernel.org
X-Gm-Message-State: AOJu0YwVSODSSDupoBIPTrMr9bAzpAWS1OnHc1+u57YFxORBw2lmuh2S
	GCccztYeUtwrLNkMD1/Wa7WdLnSW1/U23FjZh2sXvT8EDGCBpHwXnFC4B5E+82oowh1oOLoYUv0
	Vg9N3vfDVrwA6x1To6n8Ar4Y1Ur3ZFk/dfYu7l2Rs86vAYFQ5Jox7QRYxMFQIQjU0K3RYoc1QCP
	w=
X-Gm-Gg: AfdE7ckLrdcsYidwmk4o6cKfMPOOYCvWVomP8BGph/Qz3nKPDhaCEKB9mlotwZjCbQr
	dN1GtPm171wRu0UA4wjNDQ5sTs3bsKln3rqfx3C1SaCmUDDQlQff9S03o1nid4sj2Ni3rK2ptTW
	Nl+I7pGaWpuw4+qPTYVjRm3kNmdkdCI9rmCn00aXnTrLhEKBi5ksGQngiV/ctnGN5J64RXCYnl4
	TW2g3NqhSPVWFwe+3zbCMN9dF+ZWGe3CtQ3JYWz4P9vC8K8h6gsUBU5ASul+3wgex7HRXVBu+r9
	wDSJtYjXbHBcP7MEvr9hxCOCt4LXMDkYPmHzFODybDJ1UP6TmRU7G1TS1XZiZX0Cid+EMxHsys6
	kPanTyFj9RXcGQK53tqZjFBgkw2Vxc+wE3KBZYTYjj2o=
X-Received: by 2002:a05:600d:8443:20b0:490:44eb:c1dd with SMTP id 5b1f17b1804b1-492341328b7mr83393365e9.29.1781777574164;
        Thu, 18 Jun 2026 03:12:54 -0700 (PDT)
X-Received: by 2002:a05:600d:8443:20b0:490:44eb:c1dd with SMTP id 5b1f17b1804b1-492341328b7mr83393135e9.29.1781777573835;
        Thu, 18 Jun 2026 03:12:53 -0700 (PDT)
Received: from 192.168.1.130 (cm-93-156-201-22.telecable.es. [93.156.201.22])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49230a96d14sm216388815e9.12.2026.06.18.03.12.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2026 03:12:53 -0700 (PDT)
From: German Maglione <gmaglione@redhat.com>
Date: Thu, 18 Jun 2026 12:11:53 +0200
Subject: [PATCH 1/2] vfstest: move sys_umount2() to cleanup path in
 tcore_acls()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260618-xfstests-tcore-acls-fixes-v1-1-45a1aec1d99d@redhat.com>
References: <20260618-xfstests-tcore-acls-fixes-v1-0-45a1aec1d99d@redhat.com>
In-Reply-To: <20260618-xfstests-tcore-acls-fixes-v1-0-45a1aec1d99d@redhat.com>
To: fstests@vger.kernel.org
Cc: German Maglione <gmaglione@redhat.com>, brauner@kernel.org, 
 linux-fsdevel@vger.kernel.org, zlang@kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781777571; l=1163;
 i=gmaglione@redhat.com; s=20260618; h=from:subject:message-id;
 bh=mcoKrYorVNnm76YRTwx167W5hp2wd/TWvYr7oERQuNQ=;
 b=QGOYDmDELQCxB9qbFg6syednsahwTLKuyJEfQcWWfr6AERdtOiEW6xRPApXGAPbUng5tJeFu8
 NJ5v29wCj8kAVMJUcinRHkbwlF5j/J+4HFnN0arI9WaqGeJs/1zXmAO
X-Developer-Key: i=gmaglione@redhat.com; a=ed25519;
 pk=EgoGsSGnVamWcruH9kiHxwzZf0dPTHHxIjd1Gigd+yo=

sys_umount2() in tcore_acls() only runs on the success path. If setfacl
fails (e.g. no ACL support), the mount on DIR2 is left behind and
test_cleanup() can't remove T_DIR1. This causes every subsequent test
to fail with EEXIST on mkdirat(T_DIR1).

Move sys_umount2() into the out: block so it always runs.

Signed-off-by: German Maglione <gmaglione@redhat.com>
---
 src/vfs/idmapped-mounts.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/src/vfs/idmapped-mounts.c b/src/vfs/idmapped-mounts.c
index ed9992f975c14b57c5d6d1634ca011b015b78bcb..d0630f5931ade713a99f5dec1cbe24bdaa75d35d 100644
--- a/src/vfs/idmapped-mounts.c
+++ b/src/vfs/idmapped-mounts.c
@@ -240,12 +240,11 @@ int tcore_acls(const struct vfstest_info *info)
 		goto out;
 	}
 
-	snprintf(t_buf, sizeof(t_buf), "%s/" T_DIR1 "/" DIR2, info->t_mountpoint);
-	sys_umount2(t_buf, MNT_DETACH);
-
 	fret = 0;
 	log_debug("Ran test");
 out:
+	snprintf(t_buf, sizeof(t_buf), "%s/" T_DIR1 "/" DIR2, info->t_mountpoint);
+	sys_umount2(t_buf, MNT_DETACH);
 	safe_close(attr.userns_fd);
 	safe_close(dir1_fd);
 	safe_close(open_tree_fd);

-- 
2.49.0

