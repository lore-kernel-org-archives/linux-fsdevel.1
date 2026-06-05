Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D58237F007
	for <linux-fsdevel@vger.kernel.org>; Fri,  5 Jun 2026 12:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780662823; cv=none; b=cMo6aioY/0UF1rZQ6+dW67TusEtVHZgCXRgmI4iUn5LJKFjz54GZmhC7gaU23SPDmBiI42V31Q1sddOc26BaemuMAfzJymhA+RYXiTjQIepJTZpwRwV/On8RmI3ZJ8z9JPRZrTNLZ8n8+hC+nrSRqPNGA6Yitv5Oa+khMKBraZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780662823; c=relaxed/simple;
	bh=tn2JfMlU4nezVGQkeNM9goVAlzqYmpyEubOlFIiqCr0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oegkZkVU6PyXJO0pLTOBcORdrNCpRPr9OYJK3VqZr9rRPaW96U6Twoo7VO/0ERHeTHAvnz9IcbTNWl8sbX0eXpGY9QMFedYGLxi7y/f/AnsoEbp0MxE8yUBWMYJmwpIY9UTlgQ1UZ2x9bljOb92gm/pSqdtamWPuMdiSDX8kokg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YGx2IBAH; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=qS05tQzv; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YGx2IBAH";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="qS05tQzv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780662820;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8Zek5lka7I+V+M7YhuZBNsWHTpvMuxGl7NM9kjldurc=;
	b=YGx2IBAHgB8CRogsHjN2/ddspBYf31vf/FRsXmhfuWr1OQJkrugDBekxqhU/fso+bXF1Ne
	KdhLoXP6ReiyKyA6Rfboo6A5VTo2RGaTHuKnpWwDbviqNucgCSYkI5oOGecuerX47OS/Y7
	Q9mjdsSdQjuRwE0pRgn+wo1Or+GB4y8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-648-MfNlXLzyPzKM3d9q9wX89Q-1; Fri, 05 Jun 2026 08:33:37 -0400
X-MC-Unique: MfNlXLzyPzKM3d9q9wX89Q-1
X-Mimecast-MFC-AGG-ID: MfNlXLzyPzKM3d9q9wX89Q_1780662816
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-45ef55779d1so1184469f8f.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 05 Jun 2026 05:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1780662816; x=1781267616; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8Zek5lka7I+V+M7YhuZBNsWHTpvMuxGl7NM9kjldurc=;
        b=qS05tQzvBgxMrgIoFoxCcVQpSnXnj5Gniz3aJgool7bXTN1/7scgifHzk3lzXEoXHY
         4rkrlIxpRvDGibm8hmOhVG54g+vCBX57nkL2yJBcGDdG/Wp1rC+nS0E8FhjsIwDxs/Uc
         qixmDxna7tMaTURVCB3liSEXDuPoQYEMDOeBafDIbVnejOL17atw3EEykihW/DiWHg3R
         iZso+iBS7aIftT8KGqMeAVVBJtzcabFilM0HQ6WM2P+Oo8joGMjWe4fL9JS5yLCia9TS
         Hx8FGXjnMn34LPz07waVuCMwQ9fDRaaXZhOMrMWFQ8OwXwZHZd7m4iBzzqCZIWpFWJ8K
         jh7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780662816; x=1781267616;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8Zek5lka7I+V+M7YhuZBNsWHTpvMuxGl7NM9kjldurc=;
        b=VNxoReTUPoqHwH9/plHdYRUZ6Eyd6I/7ix3u/ZMIG4xO/Kj2y+6C8J/4daBiC8m+6o
         xdF5wlHpdgG1lDs3wft9Q6fod0bYMDKzyO3YhRbwWsq+B/c5Xg8L7naeUb6Nxguf0ErC
         ht68M3P9WmhkrwhEXTq3Q9pav5KWtNkEmI6LG+cLhObRbQ1rmrpX7ixU2MzMfMo1OPES
         I0i644ygb1ORhOThwiEYbaZBiO+EdeS8mijckGBp8lRJvTL+5d3xjpAltTsT0jfnL9c7
         sl4NSbyRLRSb+jiaxKqmirlFn9cX/7kzMJK+ji1sxEFfQetSWVKkY4ts2u9ehqZugTg/
         /f9A==
X-Gm-Message-State: AOJu0Yw08qpmAfBJ+19S2cVyhaOm85cK2YgWHEUj7PjZ7Q69ojBl2/wD
	nRWZxTLUWOSDRUKATMqXnCYOF+C/Ky3zGo4ihphCD9ycqMiSOvxRNvYL1qc8gz+n0hqAJyB0VKQ
	eCNhV7GzMg4KhOYkKk+kpfiidPWxkPwH9xNtsRhhytP2XJgRD2o5LFKJi84TSIukhGWMaPfByWY
	PLmM43qyBUsDWzNrm+/ObSHPuxfw3Lp27W9ksDnNX35igenxicYco=
X-Gm-Gg: Acq92OHT7J1wkaKo2ewCMURZZcZPpjqEDlrefMwi/P1NQq+dwdpd7nbL3VgRRLE81kl
	wlwhqKwDq18+/WoXKT8xRrASChZlXFn0DOzInFX8HpffkWXoIjErGWYllFS7n4B3eGWLd0Cbsfb
	MYJ03DWwUXO0qOVxlLuLngB9eWA87SIDNYIonwdivk+PESwGKWUA/QSqbQsZif0h+0KmL7R4gq2
	MOKYmKqxa2f59u9AdtswYEG83g1IbZHClemBp2UFFpyr1Mo9nHb42SC75k/BnKI8J0z2ht3RlD+
	OOIz/DOX7s0NykHB2roMWMYSPOeJ8YqfDDUmauSqZETs9puONsprHn1aLuc5hBoc9LhGgt9w0Tn
	Aex4rBXD09+p5Bk6fG1uCMgSEXkvMUt9YPOt55aakvMua37K/7zcVvsmrMpRSEWZC5VDUWk8nyn
	A/AyfZsA==
X-Received: by 2002:a05:600c:1c1e:b0:490:bccf:2bd6 with SMTP id 5b1f17b1804b1-490c25f1143mr58625795e9.15.1780662816390;
        Fri, 05 Jun 2026 05:33:36 -0700 (PDT)
X-Received: by 2002:a05:600c:1c1e:b0:490:bccf:2bd6 with SMTP id 5b1f17b1804b1-490c25f1143mr58625105e9.15.1780662815924;
        Fri, 05 Jun 2026 05:33:35 -0700 (PDT)
Received: from maszat.piliscsaba.szeredi.hu (84-236-1-92.pool.digikabel.hu. [84.236.1.92])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4602cda3651sm12702780f8f.32.2026.06.05.05.33.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 05:33:34 -0700 (PDT)
From: Miklos Szeredi <mszeredi@redhat.com>
To: linux-fsdevel@vger.kernel.org
Cc: linux-mm@kvack.org,
	Christian Brauner <brauner@kernel.org>
Subject: [PATCH v3 2/4] tmpfs: simplify constructing "security.foo" xattr names
Date: Fri,  5 Jun 2026 14:33:27 +0200
Message-ID: <20260605123331.2621677-3-mszeredi@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260605123331.2621677-1-mszeredi@redhat.com>
References: <20260605123331.2621677-1-mszeredi@redhat.com>
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

