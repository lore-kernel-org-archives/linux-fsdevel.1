Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3D293DE43B
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 Jul 2026 22:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785449720; cv=none; b=JMi7JkGlMeFCVj7zHaqK00He00QcS/hs7ltGaLLValLoQkllIkojEGc9VKbBdcWXagoS+Q/zy7F7ESY2N59jTmViA1iUHshyMqgdlU+XzRgSjjutQ1Nj/Q/I0v2oqrsLLvIXpHN1dauhu2Y9/543vJILz5GAaTN6KvV5M5iSPCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785449720; c=relaxed/simple;
	bh=F1rEmNXQzOk6OiI1HK1cJYPI6H5MIWo3CP4E+Vo3730=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=i5mY6mdsn+vLVPePHOZbU48gVbc1KWL0kodLnv7XvJZCudZhL7XUGf/Ky5dPT8TbVM3vR6q6dsqm7BqaLfjvffj1x2atJdEwYrs38weL2D3a8qGSZ88U+O8eBTvRqgJXCKm/eZhMfiqVTCxVH8uVCymr2roxtckib8FpXuDPaNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cvOSGhbJ; arc=none smtp.client-ip=209.85.216.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cvOSGhbJ"
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-38e7b87ce77so785561a91.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Jul 2026 15:15:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785449711; x=1786054511; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Qc/ts1hmL0WVE+qOHJWMrc9/nQ0AZqaOClV7FICRT3k=;
        b=cvOSGhbJWsltSd0E/Jg+v1pmHF/l8MVhVOQRtfFvI8ca5WOEXh23gBz+YsAD6fqVrN
         34dJb9ZuK26JBxeyKfStdz6MEoa5c8Y+ovdVMP2HsC1kBGreynkUz8N57p7AjRSzE03L
         3k4KlDV+oAXMtXkOlH0A9TwWCIYPPG9Fy08hF1dGvPSG66SzShWvYJnaEsAMkMG8+kUV
         h64YP2PhOILA6vqQX7NqMFxNESv3WGr5ICqHXiQ49lexhmtbwhnocqcGXhUgymx5WgSd
         iMv2okApsrYanX2kl6fnfuiZ5Y+VxOWDgm1sMX1jQgyQMgTCW/c3+054abXyZfYr+bGw
         FrGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785449711; x=1786054511;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Qc/ts1hmL0WVE+qOHJWMrc9/nQ0AZqaOClV7FICRT3k=;
        b=N5A60AjHvodHEZMJAp2dn6npGYkwH8odK4kDO7dD7qs8rEv7S1qg7GV8QT67hV1uwF
         v5T+AzS/OaHAc708+b0j2/kQQ7ScRbHrW3nBXZhXGGSVUyHElMJbdCoIB8e44W/PJmyW
         e8ncadFqOe7vRyZbz/BXgf65SwT7HKRgGiW2+oS8Cw5WhtQ/w1YVvD63WjYdr3ifkuBj
         Isacn2O46NLqCf2AqkVwl8vzMbmvCHqV61jkSJZNAtbvKqbXqFJpwhhkUu9Ucm/SJSEz
         b6sy5ujUNbN9hytt104OKHR5OLYWAzn05mLB0Cj/BhQtahmK6VSPDzgHnAaFoIendI8f
         seeg==
X-Forwarded-Encrypted: i=1; AHgh+RoZza+oag8tqId/Wmd/vvyA3y7D3dOWs8h+EZ+OfRl41c8fHrSNr2P9nA0dVMVaAJ1M/vQWcrkit5JRo3wv@vger.kernel.org
X-Gm-Message-State: AOJu0YwhPGmhY3neuIH3iLu2jWEF5B4fabk1TGOrxQEmCgQIQlf/seif
	mPJp6BucF34XSGPZ+S3/La+7usnrjJnigJPlVddJyR4RznaCALoBbPXu9xgzSp2qO+myK7G43y8
	WSSdOgQAS+qZPow==
X-Received: from dykg15.prod.google.com ([2002:a05:7300:578f:b0:313:cf74:cf85])
 (user=cmllamas job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:4c12:b0:381:bc4c:da74 with SMTP id 98e67ed59e1d1-38f9c0545e2mr3245704a91.32.1785449710561;
 Thu, 30 Jul 2026 15:15:10 -0700 (PDT)
Date: Thu, 30 Jul 2026 22:15:07 +0000
In-Reply-To: <db6fe5d2d4081f20f85abc6020b831fd@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <db6fe5d2d4081f20f85abc6020b831fd@paul-moore.com>
X-Mailer: git-send-email 2.55.0.508.g3f0d502094-goog
Message-ID: <20260730221508.3846409-1-cmllamas@google.com>
Subject: [PATCH v2] selinux: bpf: check SBLABEL_MNT before isec init
From: Carlos Llamas <cmllamas@google.com>
To: Paul Moore <paul@paul-moore.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, 
	Ondrej Mosnacek <omosnace@redhat.com>, "Christian Brauner (Amutable)" <brauner@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>
Cc: kernel-team@android.com, linux-kernel@vger.kernel.org, 
	Alexei Starovoitov <ast@kernel.org>, linux-fsdevel@vger.kernel.org, 
	Carlos Llamas <cmllamas@google.com>, stable@vger.kernel.org, 
	"open list:SELINUX SECURITY MODULE" <selinux@vger.kernel.org>, 
	"open list:BPF [MISC]:Keyword:(?:b|_)bpf(?:b|_)" <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

selinux_inode_init_security() marks the isec as initialized before
checking if mount labeling is supported (SBLABEL_MNT). This was fine
until commit 9722955b5430 ("bpf: Add simple xattr support to bpffs"),
where genfscon bpffs mounts fail the SBLABEL_MNT check as expected (no
xattrs) and yet leave the isec->initialized. This breaks subsequent
calls to inode_doinit_with_dentry().

Do the SBLABEL_MNT check before the inode security is initialized.

Cc: stable@vger.kernel.org
Closes: https://lore.kernel.org/all/akWdcp6P0FkNDzBk@google.com/
Fixes: 9722955b5430 ("bpf: Add simple xattr support to bpffs")
Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
Signed-off-by: Carlos Llamas <cmllamas@google.com>
---
v2:
  - Move the check further at the top per Paul's feedback.
  - Collect Stephen's Ack.

v1:
  https://lore.kernel.org/all/20260730181008.3654413-1-cmllamas@google.com/

 security/selinux/hooks.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 8d6945edae7a..18dd28b2bb13 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -2974,6 +2974,10 @@ static int selinux_inode_init_security(struct inode *inode, struct inode *dir,
 
 	sbsec = selinux_superblock(dir->i_sb);
 
+	if (!selinux_initialized() ||
+	    !(sbsec->flags & SBLABEL_MNT))
+		return -EOPNOTSUPP;
+
 	newsid = crsec->create_sid;
 	newsclass = inode_mode_to_security_class(inode->i_mode);
 	rc = selinux_determine_inode_label(crsec, dir, qstr, newsclass, &newsid);
@@ -2988,10 +2992,6 @@ static int selinux_inode_init_security(struct inode *inode, struct inode *dir,
 		isec->initialized = LABEL_INITIALIZED;
 	}
 
-	if (!selinux_initialized() ||
-	    !(sbsec->flags & SBLABEL_MNT))
-		return -EOPNOTSUPP;
-
 	xattr = lsm_get_xattr_slot(xattrs, xattr_count);
 	if (xattr) {
 		rc = security_sid_to_context_force(newsid,
-- 
2.55.0.508.g3f0d502094-goog

