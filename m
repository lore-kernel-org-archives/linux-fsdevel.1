Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7E612DCBF4
	for <linux-fsdevel@vger.kernel.org>; Mon,  1 Jun 2026 16:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780331104; cv=none; b=BrnhAC6rzNI0ZC6IJaHu1ncA5G2A9ezo21c8bNw/8yHuFYSjaZXns1Ji255HBGpByrRVDAHBmHq/odSePi7DUVB3S8hUc+5+/1cHgO7vE6s2xizOUu3m54zdZDnzlSPGgsaZ95aqv7rsLfFAeD05bcV54WTx//FxH1WoLGpophA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780331104; c=relaxed/simple;
	bh=tn2JfMlU4nezVGQkeNM9goVAlzqYmpyEubOlFIiqCr0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mSnzzymCDys4sySVjkRnE+y6hy/YenxQEaJ42aCEDewRKY1VDQfsLigZfRR+FO11CRSEc4ZNG7EWdXLbNOCk6f0/rpa+IYzwcchknR9XbYDcuLs04QuVL2WPOS9VVkfLp/FT9iUY8fwp0Heixzk7DzmNRhQjxEkFhxee3HT0Eo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OiPhfrjJ; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=fa13aC65; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OiPhfrjJ";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="fa13aC65"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780331100;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8Zek5lka7I+V+M7YhuZBNsWHTpvMuxGl7NM9kjldurc=;
	b=OiPhfrjJPd7ttthQw1NahOfmQivBCpEkNeDxyCySWOV2L0owBXcphgQzsfLNgzqzdC6UnZ
	zy5l67+GzeGYX2iWmdfgKVpRotpIyxdHOAh77RvXQ5WntOsmiMCUSdzUoTuoDxKNaldz3V
	3s2mkCc7N6FrHGiS2x/pOpgypnGxfEE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-85-STSh_k5DOquiNkxyruk6Pg-1; Mon, 01 Jun 2026 12:24:59 -0400
X-MC-Unique: STSh_k5DOquiNkxyruk6Pg-1
X-Mimecast-MFC-AGG-ID: STSh_k5DOquiNkxyruk6Pg_1780331098
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-45ef6417092so1792378f8f.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 01 Jun 2026 09:24:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1780331098; x=1780935898; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8Zek5lka7I+V+M7YhuZBNsWHTpvMuxGl7NM9kjldurc=;
        b=fa13aC652i+3eam6Bl4lTnRM6WMieD8Zf1zNF7Ib7sd1jPEuGiX4Gq/wfog2XfmRi0
         cijqs8buSUtJYjm7fv6BanE7g3OUYF6LGwKFEqS+HJtpI3m4gdGn14wU9bHaN3bLKehx
         OP4kI1yXGEFfyQVHA+aBRnNsmhALRV70kUlUZtwA0aurfJKop32dKJ2C57d0HHi6gRTN
         DlD0r8fBussThdSjkJS911nrNDSHTKJONYtQ01nRJRbsivLJb8+eApWlZbDNPhqzbmAl
         520PRPnGItRxxuViwGRsChIFt4U/rVl+eAgxGEh2uClN8xpxyXdQQVKRb4yoDiu4/F2W
         IyXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780331098; x=1780935898;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8Zek5lka7I+V+M7YhuZBNsWHTpvMuxGl7NM9kjldurc=;
        b=hE0v/YRvFmM3k/qAeF9rRtoPjM6edWgxS4urUxXoUKrY3BxJY19U7MOwQs1WVI9p5I
         Mo0KyXeL2KCzkVpyBUDCYyjQ0VjcPALxGeYPIkylP6JLDb2I7XMW/3ePpBoWAIsdoWLD
         1OuJ61C5ATJbdDrVNLzbvuMCuIh4Ri8kg8uNh6J1QvHyyiDS/s1eDLRgq/UbQNvPE+EN
         BKvwrXZMxhGkrPZ7rFZ2GdN0YhKC5TzIkrQMtY6susGV5o0xXNvk920qaAZkbwQzlhx6
         yiPjsUs5np67kpG1MWBG5sm1BA4VnJ7J0skSkikGjYa5gvdtb88mclB6tteLnrUX6loB
         81zA==
X-Gm-Message-State: AOJu0Yxz84mzJsB+e3Mjdu/dlTL+xkN2AvIQq2DnTvAGovjAO6OZ1A2v
	SD33sdaATIhYpyNk+U/6r7dsLfWGeudC8diaKQ2hV4rk7/YPb8H/PlCp/mQyVNDsjMOt3z/1dkE
	dr/C/GkQARaYr+yjFrqaK2Ycdjm9O3rcrrPdbB0o0g8w3AWUexIfwrIsxfu2FM6kipZBYai6zAm
	9ZYAsk17lomgTHjJA+/Qq/YII3S8WfMUoW+Ntc66ZuZAS884MgilQ=
X-Gm-Gg: Acq92OEMv/cG1xbQRQKC8fdw8JxFY/HbFl6JiuOhPkT82hFNbC08VgES0u/B3qiO/vt
	nPHtzxLPB9ZIO+xzrJ/6kKuQgbAhs+28R2GJ2+cUIJtbdvSBX0s7Q0mI9Ao3mOCyko0PksNWDIy
	q5BmigzePudobQqi+ofTYBQOs6/QnXrFvzok/GDrfmIVH/J0eIFG3bEZvuunkhjvzt9ucIHtSlY
	Ju6PispsIar6v8jYNb7hQEpU8PyO//iKIQ3KFPJHlabbZbs/mHaYj5bFdRtY4wgKm0nzh+Igiy+
	szGClD6TH9+uGicKhc9MEgo8tX1lvgbi59RtXuPDrVEqXC1qUBCHBLiXaHMYlKhyTQnHCThReyd
	Qmsan/2QwWfmttSHnEg5ndowHuPCwiyar/eoWtmZc7ZDtZ/4A9aV6ahjtiIg6m9lahmt3vDkBbv
	81Lzpuu8Wuc80=
X-Received: by 2002:adf:f312:0:b0:43d:6fb7:fedb with SMTP id ffacd0b85a97d-4601754b5d0mr878607f8f.36.1780331098187;
        Mon, 01 Jun 2026 09:24:58 -0700 (PDT)
X-Received: by 2002:adf:f312:0:b0:43d:6fb7:fedb with SMTP id ffacd0b85a97d-4601754b5d0mr878562f8f.36.1780331097747;
        Mon, 01 Jun 2026 09:24:57 -0700 (PDT)
Received: from maszat.piliscsaba.szeredi.hu (85-67-174-180.pool.digikabel.hu. [85.67.174.180])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45ef356b129sm33036213f8f.32.2026.06.01.09.24.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 09:24:57 -0700 (PDT)
From: Miklos Szeredi <mszeredi@redhat.com>
To: linux-fsdevel@vger.kernel.org
Cc: linux-mm@kvack.org,
	Christian Brauner <brauner@kernel.org>
Subject: [PATCH v2 1/3] tmpfs: simplify constructing "security.foo" xattr names
Date: Mon,  1 Jun 2026 18:24:48 +0200
Message-ID: <20260601162454.2116375-2-mszeredi@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260601162454.2116375-1-mszeredi@redhat.com>
References: <20260601162454.2116375-1-mszeredi@redhat.com>
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

