Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF183339379
	for <linux-fsdevel@vger.kernel.org>; Sat,  1 Aug 2026 22:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785621671; cv=none; b=GhTMiJYnq5ufqz6zLmkWUrbRniArjpxturdKMuMzEU/SBUQ3Dr/A/RIBDtD6EZg72ghQquzrVEglvPOTA1r2+MmCm8Tb6U4HMon7T/RoP/9JO/8IRVPzJzumEbidklpSDKZqzb6LGiR5dfpqsovtd4N+vuURdedranFIDDB4eMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785621671; c=relaxed/simple;
	bh=fQPgfXMhlq+1VG0MRuQEzdSC7q5vWTQFKVnCNqnuFvQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sur+xfrFKYP0Mm0zrmuXXDZ/A/t7QjXa8GvTbgk0YO63BgvIgo5Z90NBz1qx3afv0/lX2JuBai6D/FgVi5QB+WGIgwaWpmWTSZ7qGOuduE0YzIYcgMZdKhi6yEZ3JnX4QDxsjXHOxkCeZTJ/Jtn7LylGmCxYjp/uSEIJM1mpYeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QOCmht6G; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QOCmht6G"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-81f36179d72so31506207b3.2
        for <linux-fsdevel@vger.kernel.org>; Sat, 01 Aug 2026 15:01:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785621669; x=1786226469; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=boTJ4NLnnkEUxDYA6Ii16la58dxC2XdEwOIDbV8GTAs=;
        b=QOCmht6GN+gIAff33a6iQXQu2gFFYkEh8ROR8X66nLwsVhM3eANiFUbiKvLCjtanHB
         M73eFpJ9SDjG5EhyDZ5NO8AVXtN7Vt0gyCaJKXwagSHdPgzz1yYsHdP55rp7UUl6sgDo
         l4MfUcdMURX4bSTzSsDRAATt3Kwcpj2L/nQF2z3/2DWgoFRLXVo/p1sbbC6JPP6+/NBx
         CwVjbRWHr5/4OuA9Q6Ujbvy8j8uqW/boI9L+AHOzYqhrjWaJD8o6VHcYliDXSlYUGel9
         5ouLtzhFQbzmbFtf4GF/oB6EImRtHPDX0bW6VA3En5HY16AinGjUcHp1KI933r4Q+SuY
         v8gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785621669; x=1786226469;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=boTJ4NLnnkEUxDYA6Ii16la58dxC2XdEwOIDbV8GTAs=;
        b=YYbfqd2iZuLXVpELMrjdhGi2wECS6ZcBgp0b4kfoHehql47Eb9K7AxgdCpkNsqSjEG
         ZnvRs6MuLOUP7UGvYU+Xf7Oe89sQGfKaEcBIwddrLJR6K5NFt9lgaHqTNFk1LHOg/AKH
         YM2kU+gTOuWu431xT6+Ed60wlNnbXIETQlAaAN37QtD56x5500IOacjekRnhgw88CF96
         srHy9w/LctFVTRGsrNMIWEq6w62p25lBiYWgBrHkPY8HvPTiC8yLKE0PqeU1fyImvIEP
         urZlu4oaSTeEBFMuwd1dmxMAuWQzi9titnB2SQ0cy4afAre7tKvNobXTDntlJ4CgHx7U
         oQ5w==
X-Forwarded-Encrypted: i=1; AHgh+RooXz2CEQzjdeKpogrLJUMyt8Jl5grTBmLrRdHpaEhXnXqtoMxgmQs8UN3QJpRJwczY1PPFHM/wUNZvqR8w@vger.kernel.org
X-Gm-Message-State: AOJu0YxtRsjLw10d2rBR55pJ0dAMU8O8nASWPqAGooPDZS48G2Gmyg/y
	7BgowBKx02ZOqCQYv5DbAFbnPxIlrUG6935PGCscr8KmAeCTAYIE32l0
X-Gm-Gg: AR+sD12cq9YOAvB+3ASaWD+omqInmb+Fknduybr0D8LXRpkuqaSjuaUmIwMEkA/ycGA
	UYlsURtapMyYsGk9HHQBnFGS2mCaxSrci34SkppjDtmLNgn4MQN4kiOZ9xgncOrjH5kIbERoCuo
	cQvupeGC7zX6Qtt8yx9lFd3TAgSS10xS0a0z2UdEXnKxr/CkhjEhUidBtbqqPNcbYB7EGTEjyZ0
	wbpP/fLF1to0u24DqJsJ8yFPnDp3F1gUgA/f0ev9TKmSi5H0zOYs5XBEve3iaPA8Pw27WDZ4dp1
	FSOfbD2m3rNFLOqCw2acbBLezWqvII+Q/CrMJ7SEL2OZu6kH3W7A50vi+5A6+AYicsfskMWVqEE
	22UETY1AJnxtZWEW3sBtPuz1Px6ErUDDh8zc8yImDlOF+JcA/3zM45Rs/rKJnz3ftO9UeUcQFWg
	/G4g+bBGZIK9doFhHGHSCkNVLoA7MZxJVcFDQp78/HXAhE094SwpBEwBYrCJpRiBjNvhh/VAr5e
	jUa7wE=
X-Received: by 2002:a05:690c:688e:b0:81e:c998:9c9a with SMTP id 00721157ae682-81fd4bce906mr71495667b3.17.1785621668857;
        Sat, 01 Aug 2026 15:01:08 -0700 (PDT)
Received: from syssplab.cs.fiu.edu (nat1.cs.fiu.edu. [131.94.134.89])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81fcd0d6fbbsm29903767b3.25.2026.08.01.15.01.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Aug 2026 15:01:07 -0700 (PDT)
From: Chao Shi <coshi036@gmail.com>
To: Jan Kara <jack@suse.cz>,
	Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Matthew Wilcox <willy@infradead.org>,
	linux-fsdevel@vger.kernel.org
Cc: Theodore Ts'o <tytso@mit.edu>,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	Baokun Li <libaokun@linux.alibaba.com>,
	Ojaswin Mujoo <ojaswin@linux.ibm.com>,
	Ritesh Harjani <ritesh.list@gmail.com>,
	Zhang Yi <yi.zhang@huawei.com>,
	Bob Copeland <me@bobcopeland.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Sungjong Seo <sj1557.seo@samsung.com>,
	Yuezhang Mo <yuezhang.mo@sony.com>,
	OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
	Mark Fasheh <mark@fasheh.com>,
	Joel Becker <jlbec@evilplan.org>,
	Joseph Qi <joseph.qi@linux.alibaba.com>,
	Andreas Gruenbacher <agruenba@redhat.com>,
	linux-ext4@vger.kernel.org,
	ocfs2-devel@lists.linux.dev,
	gfs2@lists.linux.dev,
	linux-karma-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Chao Shi <coshi036@gmail.com>
Subject: [PATCH 01/19] buffer_head: Remove b_page
Date: Sat,  1 Aug 2026 18:00:45 -0400
Message-ID: <e0780ecfda9137d5755b4ac3e227152bf4c7983c.1785621505.git.coshi036@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1785621505.git.coshi036@gmail.com>
References: <cover.1785621505.git.coshi036@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

All users except bh_offset() have been converted to use b_folio instead.
Convert bh_offset() and remove b_page.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Chao Shi <coshi036@gmail.com>
---
 include/linux/buffer_head.h | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/include/linux/buffer_head.h b/include/linux/buffer_head.h
index fd2c7115c054..699970b4bbf2 100644
--- a/include/linux/buffer_head.h
+++ b/include/linux/buffer_head.h
@@ -59,10 +59,7 @@ struct address_space;
 struct buffer_head {
 	unsigned long b_state;		/* buffer state bitmap (see above) */
 	struct buffer_head *b_this_page;/* circular list of page's buffers */
-	union {
-		struct page *b_page;	/* the page this bh is mapped to */
-		struct folio *b_folio;	/* the folio this bh is mapped to */
-	};
+	struct folio *b_folio;		/* the folio this bh is mapped to */
 
 	sector_t b_blocknr;		/* start block number */
 	size_t b_size;			/* size of mapping */
@@ -172,7 +169,7 @@ static __always_inline int buffer_uptodate(const struct buffer_head *bh)
 
 static inline unsigned long bh_offset(const struct buffer_head *bh)
 {
-	return (unsigned long)(bh)->b_data & (page_size(bh->b_page) - 1);
+	return (unsigned long)(bh)->b_data & (folio_size(bh->b_folio) - 1);
 }
 
 /* If we *know* page->private refers to buffer_heads */
-- 
2.43.0

