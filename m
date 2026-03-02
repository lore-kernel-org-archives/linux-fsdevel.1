Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com [209.85.210.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B8D27262F
	for <linux-fsdevel@vger.kernel.org>; Mon,  2 Mar 2026 03:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772422875; cv=none; b=KVy7kFLZI1M2/5d6y/r57Qfgnp+deY0OTplYwO7MkhAIss8l8MuuEyGld5B2C3UYCM4VxKnLITKiir87KDSVxmDkGATXxQe6r77mvMRuXUA9LApy9NlirtqBrMuQAkRPzNIG0CN3cKkuCGQlxV6/a0jRQDojs8cNEjVEAdXrrC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772422875; c=relaxed/simple;
	bh=3qa4hmvHbPhSvNvauzFwXvrdL/d/yHeEOifbBfPywCk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PkgqVPMTWtDtnlw8VhUwpvnT8SLiH3Qk4dV1c3jd/ec8GJiARddF3FkaI1etc82EtEsORR2qSz6AdPq6f3d3o0sKCdOjokNGxJizX8w7yG5h5DfaMvHOzu2Wb3fqnA+1CBDnadhQzXaJ4iqgTQjDOtd91+ViXm7C3KNoEkNdh1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QYMnrsgb; arc=none smtp.client-ip=209.85.210.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QYMnrsgb"
Received: by mail-pf1-f193.google.com with SMTP id d2e1a72fcca58-824c9da9928so2300875b3a.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 01 Mar 2026 19:41:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772422872; x=1773027672; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VnRkT2AhttnAXKxBGtLqNZYa9ovtnVLLt5dqgljoP2A=;
        b=QYMnrsgbKL2nJUcA63eg/e2IjUO/mtXc5R0kdcxY/iLmzfGrvTh0ZJguKTA2rsRaN9
         ybZF9RTs7OgJZzF435Tj+MCbY3uz6tlWKOdFTxL56VU4W3MpkwmMkjVm62mv6G2IyoIE
         HIvBG9pevPazW/7gP0PeQmpQkDUntOzYv/FGLTYRDv4Hwuo9cJnDjimNK75sfe0gn3JT
         oo0jYKk3/QBlK2l8ZWnCiDZ28op891WwdQ+8C0XNIzCu0Ed8ShipfdqYhTPvVpoo552N
         wW+5H0k0xstr0H6DV/iifRFnNoX2p6xwwO/ro5v8BPu3b5Hzu7ExQKFRv6DFEcWrTbNO
         4OPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772422872; x=1773027672;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VnRkT2AhttnAXKxBGtLqNZYa9ovtnVLLt5dqgljoP2A=;
        b=Y4THSCR13GeI6U6/foCjXmVxTaEF8MrrDI50hRNE234AhurBtZDUklSHPuePbL9Azx
         nzTPOzCEQSYtUZBPTrYvyiLsPTGbkgA4QshFhLNwnsJZvPKRdN2D/jEm3blEZOfOgk/K
         97lbO9SwlzAeStI/qX4fVsqR/ejkXrkZZnFQkghcHOpwaE8FpO9rj+ClqaqXpbTuOymg
         Iv95nSn7tETUPPPib8fV1zhoYSc4wGTmWXTH3+PSBQMmADI1a6qDkvD/uk9V74i0BXCW
         RHOxFDylEG2Q4dAgt8NeVp4A5MEHR4zQ2LF1/3pTWjxgHsM6Tmp9wLKfbnLm3CcKab9F
         gJjA==
X-Forwarded-Encrypted: i=1; AJvYcCVNxm9GISTPBxC7JYPCFIPYFq0A87ePLXaK7ApRDuzDHGnDS8jexKJRy1sZycoO70vTDF7GUtf1Er6XSA71@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2UWp/2WHgB+30hIrwfa2mfuA95QS/ctXT7mCzPcS7N/ljUYEC
	Z/f/DOfj4SgcwtMDj8LlXAor/D9XikJ7mQ8PN/VNVjP0DC7+VkK4UbkN
X-Gm-Gg: ATEYQzyzv/cf03OQKqeKjlsotZ9Kr2gyYwKEsQPCJ9fm7enHGbdgONfqU2aTuH7l4mD
	vUDDXYh81mMgreucPxg6tTK9Wl12n+ywMhadSIb8nlwM6hRKPePTfnijhqTunO7p3skAzICkovG
	c8NXtbcoBZAyOV16Hq1PMyxcYGsv+A1+NosASQwkRaLj3qrTkdivKGtchMVHFgVE0xYpUxcF233
	ANsFfaNP5cGSHUpuWo6cvSscSxBTpYToLiouY0ETJuKy9tUBn/JIPL7o/lFAzKA/DQyRka2U/UZ
	BNM5QOIaLLwSt+3PjRxRN9PzWE4agXrmK8zKBEEjHcye0/tTf09sTvlv8gwkWlsXSykxXxIfDO/
	sGNR1P+LYKmsdD8GWw8ENKNOrOn+B8uIbhPJ0qcIlAM2/t+SMBOcHsKC5DXZjOO5BFZo0LhPCmG
	C1zti3TDDVt9Bll3iMpFA+K5doxFI1bQ8Hds/SCwuIZA9SUBKb3A==
X-Received: by 2002:a05:6a00:f85:b0:81f:852b:a936 with SMTP id d2e1a72fcca58-8274d9530b8mr11492201b3a.15.1772422872419;
        Sun, 01 Mar 2026 19:41:12 -0800 (PST)
Received: from lima-ubuntu.hz.ali.com ([47.246.98.208])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82739ff34fesm10838369b3a.42.2026.03.01.19.41.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Mar 2026 19:41:11 -0800 (PST)
From: Qing Wang <wangqing7171@gmail.com>
To: syzbot+cae7809e9dc1459e4e63@syzkaller.appspotmail.com
Cc: Liam.Howlett@oracle.com,
	akpm@linux-foundation.org,
	chao@kernel.org,
	jaegeuk@kernel.org,
	jannh@google.com,
	linkinjeon@kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	lorenzo.stoakes@oracle.com,
	pfalcato@suse.de,
	sj1557.seo@samsung.com,
	syzkaller-bugs@googlegroups.com,
	vbabka@suse.cz
Subject: Re: [syzbot] [mm?] [f2fs?] [exfat?] memory leak in __kfree_rcu_sheaf
Date: Mon,  2 Mar 2026 11:41:02 +0800
Message-Id: <20260302034102.3145719-1-wangqing7171@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <698a26d3.050a0220.3b3015.007e.GAE@google.com>
References: <698a26d3.050a0220.3b3015.007e.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

#syz test

diff --git a/mm/slub.c b/mm/slub.c
index cdc1e652ec52..387979b89120 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -6307,15 +6307,21 @@ bool __kfree_rcu_sheaf(struct kmem_cache *s, void *obj)
 			goto fail;
 
 		if (!local_trylock(&s->cpu_sheaves->lock)) {
-			barn_put_empty_sheaf(barn, empty);
+			if (barn && data_race(barn->nr_empty) < MAX_EMPTY_SHEAVES)
+				barn_put_empty_sheaf(barn, empty);
+			else
+				free_empty_sheaf(s, empty);
 			goto fail;
 		}
 
 		pcs = this_cpu_ptr(s->cpu_sheaves);
 
-		if (unlikely(pcs->rcu_free))
-			barn_put_empty_sheaf(barn, empty);
-		else
+		if (unlikely(pcs->rcu_free)) {
+			if (barn && data_race(barn->nr_empty) < MAX_EMPTY_SHEAVES)
+				barn_put_empty_sheaf(barn, empty);
+			else
+				free_empty_sheaf(s, empty);
+		} else
 			pcs->rcu_free = empty;
 	}
 
