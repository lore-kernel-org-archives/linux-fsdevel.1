Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6401431A046
	for <linux-fsdevel@vger.kernel.org>; Fri,  5 Jun 2026 13:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780667610; cv=none; b=QA5vMEOQhKR+xcdbKQuUUXr3g6RxzszKoaiBeRFGNF2jfUA5RVw3QJy0gt9wBSWQrCUALyLZ/O/8zK4YEz1aiF1jIclypKmdtiDkzjNw12xl0KgaRKPL5xZobQm3XqBjhZuzSF44e1IrVxUW9wYoWYWd4aeV8BqzCJHi7KWf7Q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780667610; c=relaxed/simple;
	bh=tn2JfMlU4nezVGQkeNM9goVAlzqYmpyEubOlFIiqCr0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QYwCsw5w7uMaZP2FAzs10p/tPzZ99tbwU9VB9L4+BtoVDl00kHqmrm0gtJORwuxee1RYz8ubIw+XjcxRq12rijH2FWrH8K+ErpQMRiVlk93iRejzFqRg49vdrTEshYWcM2ZFJ3Hziqt3aKi/ZgOZU6JL7LIcO/AyOGqlhDins4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LTG5cjX5; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=kE2iStST; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LTG5cjX5";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="kE2iStST"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780667608;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8Zek5lka7I+V+M7YhuZBNsWHTpvMuxGl7NM9kjldurc=;
	b=LTG5cjX5p1zbkcfYDcCrQYhw8Vlw+r+GZqNhKjh9CblBMc0pf4Iv+doWa65f6zWR2GsLZP
	UR7KTsguHWpwuusOj7qNBJ1+fUPMOsSn9MyAwNSEYd8u/seJYJ9sk3kfq2wJuxh8ay+cm9
	nCgHrk5kTM9NitWTDMAOfV4dS6tY7Z0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-121-S9jJsCQENCOy-wr_bBnkYQ-1; Fri, 05 Jun 2026 09:53:27 -0400
X-MC-Unique: S9jJsCQENCOy-wr_bBnkYQ-1
X-Mimecast-MFC-AGG-ID: S9jJsCQENCOy-wr_bBnkYQ_1780667606
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-490ae3bcf4cso10305435e9.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 05 Jun 2026 06:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1780667606; x=1781272406; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8Zek5lka7I+V+M7YhuZBNsWHTpvMuxGl7NM9kjldurc=;
        b=kE2iStSTYRPVv7RoSaFPUc3pqFusKFBIufN15N75CVola2/amk6G0BNIJGLSxP0bK/
         i3jaH3W89IeqVIY4DNZMseAHBDD7gbp7V4LklUCx44DYRfmCNYDuCP7OiF15+QiEqDj/
         uaySfHEilSSRD0Orx8tl6lci/e8yAhZkqRJ8C78T9izjTbyWRI5f0UxPqpRR5vNY5miy
         jyyRPU/npNp7tlO2m84aOxZoDRdy5wxZs114ENIQvFVT1U0qKZCw2V4So9nXjDWFVnSU
         3R4tZrSkeFuXHilrMxtiVsA8H9s6xMvcXfWXiSLf+C0vYiwA3Wmi9j5IZxKynZzf2fsm
         C4aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780667606; x=1781272406;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8Zek5lka7I+V+M7YhuZBNsWHTpvMuxGl7NM9kjldurc=;
        b=jTP2La6hWfFJxnBuu4eGy62EY+1oEKSjyo4VAatxk0A/FoBHSxsgUbuVirway/JHgK
         N3neu4g/uvgTBFRiZ+5S+Q+gqiVzawRivxAu6UMMGNXT+HjS/YZGon9IvUsS+ycU3qj4
         qQc8MY9yINZn08IJUvAIv0MXwgoaaT9M2MFPG1L69uA42CYkdw++x4p1/NlQ8bAZAQGP
         jirA2tqyW5HPYvYhUE03bPxaX1+tZIlu/W0LDDUyHA9JHjuo29nNiNmw5Puo9t83rPaa
         iX5pXECs7/F5XRuFS4r8myoaJtz4AOR+fTiMPkHYW7BddHWzR8uIo7B4CJ6t3T8TWMTP
         gSRA==
X-Gm-Message-State: AOJu0YxwdKBX6cRRudFIzCB59NW+gXwCwtsN8bjrUnAgQamavgPUgmd9
	hJLQM/MpmJbQLHsksyxv0/CBZ+h+Z9BdsCWwkaVkGiO+4T8WVfa8TfaohmTGrc02T7A/t+vtwZb
	mci+7W7RBPeP/3vMC4TIV+PwaGenWLXuUc7BBtjZIqoT3E8BZK1coubkqpbnqHd17mCcD3iHRIz
	tF1x8wLTFbPIhjyAGxb8oCCta/D4+1hmUTk32NYc4c3I5fRxpKoRI=
X-Gm-Gg: Acq92OEXvpgZhnu28xE4dJm6UA8FUpxcEKxHfzYlJGabHN5sjPjbFM7ZAx7NiebnaWW
	dit3K34BV1Dk7FuEBlaNOxAQm83BODZEMsRvIdBomCxKgkijnmaHZBKcbVEGr3g6sBJ2v4nDxEY
	rkzTf178AmOHb8gZrxGc+RYt3LzHelCaBSmnp5Iy6726h/u9LAzmsyFhU7fKlxdJ7a5IU69fby6
	k94zAckp0dQaUhkDpGDIRf2AWnOYsj55yVF4ai18ovo+HKrf0psXW1KLfAowDOSzPSp9jmet2Cs
	ivL/ePvoq/hFcs3x7TI5dn877HQyAo2ojlH95mHMGW3Oc+yr4vsLdz91OzwRxYN1kajZbqlv+/L
	9BTdBxf74+qu/X9ZKhISJ9S+2eBKX1hkMYLs7ac0F4nqSApUgFQjGE8dt3QR4cQn1tt9enTJIaE
	XV/McWhw==
X-Received: by 2002:a05:600c:314b:b0:490:bfae:55cb with SMTP id 5b1f17b1804b1-490c25f5df4mr55867625e9.21.1780667606170;
        Fri, 05 Jun 2026 06:53:26 -0700 (PDT)
X-Received: by 2002:a05:600c:314b:b0:490:bfae:55cb with SMTP id 5b1f17b1804b1-490c25f5df4mr55867145e9.21.1780667605812;
        Fri, 05 Jun 2026 06:53:25 -0700 (PDT)
Received: from maszat.piliscsaba.szeredi.hu (84-236-1-92.pool.digikabel.hu. [84.236.1.92])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc3cbfe4sm157999025e9.7.2026.06.05.06.53.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 06:53:25 -0700 (PDT)
From: Miklos Szeredi <mszeredi@redhat.com>
To: linux-fsdevel@vger.kernel.org
Cc: linux-mm@kvack.org,
	Christian Brauner <brauner@kernel.org>
Subject: [PATCH v4 2/4] tmpfs: simplify constructing "security.foo" xattr names
Date: Fri,  5 Jun 2026 15:53:17 +0200
Message-ID: <20260605135322.2632068-3-mszeredi@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260605135322.2632068-1-mszeredi@redhat.com>
References: <20260605135322.2632068-1-mszeredi@redhat.com>
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

