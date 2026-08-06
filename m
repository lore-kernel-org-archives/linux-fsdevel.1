Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33C673A75AC
	for <linux-fsdevel@vger.kernel.org>; Thu,  6 Aug 2026 16:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786035543; cv=none; b=CY9k7XteuMViixBhpjdqhpFmpri8iNeB7Qr35lVqGqdlB+nROxq6p2SW0EOyUGNgM6BgmR154sOiQet5BTksLueSmyJbs3QHs+r36kv+lsbxXeW37d5qqJelS1Cgzx4rOFeL26ixbn46Wy2FNZkZtvM+soryRdUSCLYq/Zc9gU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786035543; c=relaxed/simple;
	bh=lzP4aegwZTPCQw0cJ3VVWrrvdN+pa1Cx+PvabTKZT/0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e4vYNCSj9+Hlyaq8IX/7ZKB/DkudsPm2ubWoYH2z/K+7j4nh242nmok0GoeJgwciMLmfSFKrmGZDL5TxgjL090PPn3ZH9NdQQmx/aOF1fstepu+M4R7Ml0Qe2WD0BBUzzQVq6Te1sONTMcAjl/Det57m0GFY0H/iK8XDgGy7oAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pfdXrfjU; arc=none smtp.client-ip=209.85.221.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pfdXrfjU"
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-5c38568d9e1so883250e0c.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 06 Aug 2026 09:59:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786035539; x=1786640339; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=l4wawGSh1ayASvpYyyNUW0xG9j87AeVkrycNAPRNAqw=;
        b=pfdXrfjUkNr+YpIAxW3VGw7zEHPJpnM4qqP0VGAcK90I0ESgxg6n2lugFNQwdGQr6T
         BPonjuqzbAnVfl63svf4eLuxkOM8AjZFstSyYR77ttZFSv6fdkdle3O99IOdmH1CElSB
         iKV6emEWyJSIvk63ESopkxAU+GhZZs9+7dHy3ihJB+2VMnH59Zn2+0J9UMJr/Fm56qny
         b0mH2jjV+v0dSEcOWQsfrix5fOvbg7uZcQR03od6zRbrMdxhcHZm8KtGuiMhCTo5QTB1
         cWCVsKV7mOMDB1J1EEj3u5X4aqrbThx0DNb+RyWieF+QBN1OnnNKmKWImgzw+YX75oDp
         rhiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786035539; x=1786640339;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=l4wawGSh1ayASvpYyyNUW0xG9j87AeVkrycNAPRNAqw=;
        b=AE0FGm8v20kpGSKH1t6IwaIbZWL/NgtKHFO4NrQtFWIHlCsc5q7poyQ8tAILxwzrHj
         Jm6GnzPbaDYzG+vVN29xA4KLM2toI/GpVvHd2AcpK5B9Y4AkJnBVd9y5oVxT9JgxFpXp
         tjlEc0kioeQE1TP7g6BCh6OryWo2XRVSEEnpZ9EtWmjwsP7QHWXbNChxpQIpmfJap3wl
         rynJkoCnZ5Of9qkPsJO3aaPNZiHxIiFx1DRIPf4Vt2hxD4cnwhy/rZEDeWw63XVFvX79
         cvZNdlbI7mwnl3JWLnT2vzbC44gIQV+HDTpEkmZd6oq6/uHdFeKnz2BvwZzV7FBMLrBU
         qbtQ==
X-Forwarded-Encrypted: i=1; AHgh+RrdAF5OpmPkl50mG1RFGwwmDrXneLUYxvRrVZAerbgNjzpmYzYzjREE8GslxN5BT6OFpX3vKleWs+x3/XIZ@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+U3aHfSQFtPrCNDabAM6SUFAUObzukKZ/Nx+KqQphddTztEYG
	1GIDm8bduR8XPRajFCUynR/S2wWSYUst6exAqWkrfY6eAze+pwhyHs5E
X-Gm-Gg: AR+sD13w/pnhL67dBoDcXAOM4IKP06ogcQyjUQktLANI/7MZ4gRyKB58F7rBCobV0io
	wbJS0Tp5f2C0SAYdSdELL8KO25Eyr8w167/WfoyJkWnNNJHQqf48I1mZgwzrqVaTTtcYJm2FkmD
	+fbeki/g84M3z7iOYnIEz5FXUgz2Ex/M3/TgibOUMPwkLcfrNtpO2fzKngQOaUHuBI977b9rw4g
	k2aJrAg8sws1GpxhlfFj/voTvryezy5bpdBa4h3+al3Vt7NAM/B1tdhjoX+05deVEY8Bvj8mA8m
	78QllRi07YqeOEOHl9fYg+L31AKhHUYCVAySOXdS73ZEuDEPxtNQiNRf/lGRTmJxqTq3bfnGr47
	q/lWZ/j8vKvPXDdBdbVnDgq2+WCIyghD9Bur6hKOV4lB+5LGXDjKsF9Uk0FYtBRnh/I/blZtSmW
	Hj2GWqus5k4AI28s1aoy+Pc/uMmutGN7aafp1ZQQzIPo4vfUeMdilUEkNQGd/SfTTNzscYgOo0c
	Wb8lfc=
X-Received: by 2002:a05:6123:2c7:b0:5bd:faa8:74e1 with SMTP id 71dfb90a1353d-5c3d92900f0mr2224979e0c.13.1786035539083;
        Thu, 06 Aug 2026 09:58:59 -0700 (PDT)
Received: from syssplab.cs.fiu.edu (nat1.cs.fiu.edu. [131.94.134.89])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5c3d05c594fsm3706321e0c.8.2026.08.06.09.58.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 09:58:58 -0700 (PDT)
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
	Zhang Yi <yi.zhang@huaweicloud.com>,
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
	linux-kernel@vger.kernel.org,
	Chao Shi <coshi036@gmail.com>,
	Weidong Zhu <weizhu@fiu.edu>
Subject: [PATCH v2 01/21] buffer_head: Remove b_page
Date: Thu,  6 Aug 2026 12:58:24 -0400
Message-ID: <e9d168901578902bffe78ac8b5dfaf1210ee7fb3.1785951556.git.coshi036@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1785951556.git.coshi036@gmail.com>
References: <cover.1785951556.git.coshi036@gmail.com>
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
Acked-by: Weidong Zhu <weizhu@fiu.edu>
Reviewed-by: Jan Kara <jack@suse.cz>
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

