Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C41A03D1A97
	for <linux-fsdevel@vger.kernel.org>; Tue, 19 May 2026 08:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779178413; cv=none; b=t3drZTq+glar/jENq78rPk8gsbAbD0me7d41uAnvSTVpb6H0bzBiYzaQc87VfewcweBp6bih3OccUTTnyHdgz6s72CG1JrqVwo0kaOH4QkcXSQMlrx5w3Rg6ubngQizALdfeHNcuuZRaBdamDHTorjMz8ZqDFonhet9Oa4MPyqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779178413; c=relaxed/simple;
	bh=tn2JfMlU4nezVGQkeNM9goVAlzqYmpyEubOlFIiqCr0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pdJDZOnJlcHvlvtgAM8FriDDO0H4Fo4egQ9GNxaCrrLhN9XFEvO07DoSpnW5/Llap818fmgTIYRd834vQH2JGIXIjKhCAhNUy8sEisMKhEit4IifPSRy+XA8OyBHkyyfN5ZzLiq/ATJ5PL8zFTWIobQhKjssVDD9qbDwqSvZxmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=P6fBNsGz; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=eB+JIjj9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P6fBNsGz";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="eB+JIjj9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779178410;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=8Zek5lka7I+V+M7YhuZBNsWHTpvMuxGl7NM9kjldurc=;
	b=P6fBNsGzbNpDUtxKy2mtCMGjnIaPEyGKprOGuHQ44UsKO7PdCYUMtj11aCZ3PFeMSohD+W
	As2EOcRngx6q2Be9H8W1wgnzwEOjhPbIO+2sVQbzHzcekBYJbU2QGydURsiQ0fIbAEQCRo
	hGtoqfHfxqu+TwifVJ+yGkZoqrBOUH0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-98-NulWCrecNpCAHQNq8UYn_w-1; Tue, 19 May 2026 04:13:29 -0400
X-MC-Unique: NulWCrecNpCAHQNq8UYn_w-1
X-Mimecast-MFC-AGG-ID: NulWCrecNpCAHQNq8UYn_w_1779178408
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-45e80183514so1508489f8f.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 May 2026 01:13:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1779178407; x=1779783207; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8Zek5lka7I+V+M7YhuZBNsWHTpvMuxGl7NM9kjldurc=;
        b=eB+JIjj9fH6zeuik0HQAdTHjDAe25jTDWZekBxj2WAvaBzZf3Y51wN3vDBN/+qlOvU
         xE+8wKsJQdvACpoAi7mvEMzzA/vAWnJP7eDRgY8aKh4XQ5t2E37dfn9h+m3w9BrCepBl
         oCEmVmwAVvEm2B+LSIFlDpDk6gC7TEL0oErEdYIdzH3ecYERrniJCO+e5R+WtbyfSQ6i
         toyBHRmStlWNFwy8X4KCwzl+cVfYh/fCyxRzowTOIL6FqmlYhE2hcl+lxiVMK7owgjnR
         BR+40JeoTYaKB7HNmxJqjCMdTTyFAxAN4RCqydEC372ZwG8+gQip5FV35//380KWiWnY
         Yegw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779178407; x=1779783207;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8Zek5lka7I+V+M7YhuZBNsWHTpvMuxGl7NM9kjldurc=;
        b=tI5T+WpTQxHTmMF3Zgtag9bbpScdGpJSxvBb5gKozQHYev5MCEr7OQxeySWM7K/UKJ
         LUDvEhr2nKd3HCZVX7C8gWyiSXYSBIWsUrMEVFtPpq43GqRv2RvV2DVbtKRJP3o9BHbg
         K4VJKkVC9s8J4Y2CF65LbVrAfPGVNX7nzv9xNq92OBjmVYr3XSt/H2RBmibRGcVNbaaz
         /NntNOtdtR5EdHw2n5Un/Y3xc+p5iZQbtu1xVX3oM8F5CmRnW+LRMROZcoADiRPOvEvW
         c3L8mFSAtQGs5IBemcIkj85cKxm9B8ox3P3x0FlDLK/n5DR4zOOneQPnSMdJegRzfErp
         9H7w==
X-Gm-Message-State: AOJu0YwQwqtgmCgkvsb6FSePExK/5tziWpM+h3xAM/PCKchsL27CT64U
	KhRvw4c7Qt00+L2ZHdjoXexb+AgSr1KoaqG3VPCCQdrr2y9g2VgHIV5RTUkz2jweHxOYOIISl6u
	XfjriZRoHDPDmioybxJJB+RsdOHXiofrYti9xfOOBh2QMYVdz3iGkHMpVb8Oa9VrN8/fW4Nt1I/
	qeP52xLDfZehCRN3V0flhIO+bD7ldMirRCeYlirR1JBOX0YYSkrbE=
X-Gm-Gg: Acq92OHO8AadEtnE3ODH6HrEN/5oe44Foz8nAMEl4LvJpOXi+zj9XnJNvBt8AhTH8oj
	FwEE0aqHXN+csuPYTn/0mUc8dya8D7Hw6ape7QJUq6ndEckfJbbNBSiH2MwbOm8/GdFIEd3jKil
	36FecPMDh0Pyn38SXFUzX619sVBCDGfZsfDIgZD+JCrc/N9HPj/upU10O6LpaF3wfcyX0Pjq/GF
	iP2+PWqNFz5qW4vkJ3ig/rl2EASrUkph29HJafIjbA9le9dS+v8KtPLpjDoXw4ceXeuAGQgMYgH
	juL9Pcodj17kp4rHWVR43dAU2wT7IfLLtSQzFeVAqyZpdXvky29OfZB6DL8ge415ORW9WmCyIkm
	FhhCmYsBKjKjVTgLRblBtngq7YrOJfpPg+LEUDXl6p6nqaxKhgYpD2kcBO/4MSYYvlf18wS2Cwa
	1u
X-Received: by 2002:a05:6000:4014:b0:441:1fa5:4577 with SMTP id ffacd0b85a97d-45e5c5f20f3mr28554573f8f.26.1779178407521;
        Tue, 19 May 2026 01:13:27 -0700 (PDT)
X-Received: by 2002:a05:6000:4014:b0:441:1fa5:4577 with SMTP id ffacd0b85a97d-45e5c5f20f3mr28554511f8f.26.1779178407031;
        Tue, 19 May 2026 01:13:27 -0700 (PDT)
Received: from maszat.piliscsaba.szeredi.hu (85-67-173-121.pool.digikabel.hu. [85.67.173.121])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45da0fe2464sm45189485f8f.32.2026.05.19.01.13.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 01:13:26 -0700 (PDT)
From: Miklos Szeredi <mszeredi@redhat.com>
To: linux-fsdevel@vger.kernel.org
Cc: linux-mm@kvack.org,
	Christian Brauner <brauner@kernel.org>
Subject: [PATCH 1/3] tmpfs: simplify constructing "security.foo" xattr names
Date: Tue, 19 May 2026 10:13:21 +0200
Message-ID: <20260519081324.979769-1-mszeredi@redhat.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use kasprintf() instead of doing it with kmalloc() + 2 x memcpy().

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 mm/shmem.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index 3b5dc21b323c..c7897570fc9f 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -4232,7 +4232,6 @@ static int shmem_initxattrs(struct inode *inode,
 	struct shmem_sb_info *sbinfo = SHMEM_SB(inode->i_sb);
 	const struct xattr *xattr;
 	size_t ispace = 0;
-	size_t len;
 
 	CLASS(simple_xattrs, xattrs)();
 	if (IS_ERR(xattrs))
@@ -4260,17 +4259,11 @@ static int shmem_initxattrs(struct inode *inode,
 		if (IS_ERR(new_xattr))
 			break;
 
-		len = strlen(xattr->name) + 1;
-		new_xattr->name = kmalloc(XATTR_SECURITY_PREFIX_LEN + len,
-					  GFP_KERNEL_ACCOUNT);
+		new_xattr->name = kasprintf(GFP_KERNEL_ACCOUNT,
+					XATTR_SECURITY_PREFIX "%s", xattr->name);
 		if (!new_xattr->name)
 			break;
 
-		memcpy(new_xattr->name, XATTR_SECURITY_PREFIX,
-		       XATTR_SECURITY_PREFIX_LEN);
-		memcpy(new_xattr->name + XATTR_SECURITY_PREFIX_LEN,
-		       xattr->name, len);
-
 		if (simple_xattr_add(xattrs, new_xattr))
 			break;
 		retain_and_null_ptr(new_xattr);
-- 
2.54.0

