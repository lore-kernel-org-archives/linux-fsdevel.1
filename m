Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FDA132D0F5
	for <linux-fsdevel@vger.kernel.org>; Sat, 17 Oct 2026 13:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792244427; cv=none; b=fYHO7yH8lvwSsfYfi/KrkbGfptWq4N41S4g+BKnW9CzM8deYjUz4qjVMN6d8BxYniMuxLmn+um0l6N1i5xEoUgN3SQbZi2CoWXTS/eWfh3NkfhC/8N70ABL9XqO9DlaPevSIEY32qBVv/eR5dwKCPbKFePN6BCJLaHWZQpDF0ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792244427; c=relaxed/simple;
	bh=L0SvlG0HgqpzEKFEwHq7wDfZkYZ0WTBPvieUdovJWzY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PqIfRaPpJCuCqgoilbqVvs0Hl4i5Gbj8KoeslLANH6ljvngxLjDWn2971y7CtWZdWPiC3ndvtyJTch6UMVCrgxcPjR6yMLkpMo6GO+gCvTiuRoA1P52fTc7TVoPK39oaLtFCJqbjtoHe7oY2/FlNyBoJHGpI+JVcQJC6f6p6aV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NVWi+qVi; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=XyUnlntv; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NVWi+qVi";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="XyUnlntv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792244425;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0ycK1hfInrWAuob/OJzi5liuKRYAR110GQUd0Dl9JT4=;
	b=NVWi+qVi2G4ksjPapzfnA0sBP7SZDLW/Ovw4HYzxC7y+b6pLtmJ6Xz51Wokfk/UepZ283w
	FySd6rNa5ywsTzMmneXolEOkuUyx+FGSdyUBfYJNcEr+a42nW2e3XTYVjOmeTl0wTqf+Sq
	kPWN5NnrTESOa/V3ADVEfpU7LZSngkw=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-277-4-pRj0USP9qB8AGRpWfMqg-1; Sat, 17 Oct 2026 13:40:24 +0000
X-MC-Unique: 4-pRj0USP9qB8AGRpWfMqg-1
X-Mimecast-MFC-AGG-ID: 4-pRj0USP9qB8AGRpWfMqg_1792244423
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-6b1bc2e62d5so804131a12.2
        for <linux-fsdevel@vger.kernel.org>; Sat, 17 Oct 2026 06:40:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1792244423; x=1792849223; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0ycK1hfInrWAuob/OJzi5liuKRYAR110GQUd0Dl9JT4=;
        b=XyUnlntvGLhTtVa4SSV6jfIrrEH2T1kOCiZ3wT3IlETiOOhk3wMCf6pndZWwVcXrJd
         cv5/9zwXe9pTYBBtOQYgVlGbbXcAb23Ihi3wkl9qfNttUZTcBqXjiepBFH5gELPHf63H
         WNxBHxGHRg6RgZAyxtFS/bSD96wOr4NcZlowC/R2RSKAHSAqtiICq01pJKHdSB9VN/EW
         S8h77T/bECy+zN35uDrVPW/ADn9y10FsPXYbMu+EQ8jESJ6TX3ZIJFt8DfsgJkx3JAuX
         YpRlu/DOCgjAWqF8q4cQmrhdUZKpZAPHRD0OrGg9WbkIhbAZFzZL7fTINM782+U0BLGm
         ZpQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792244423; x=1792849223;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0ycK1hfInrWAuob/OJzi5liuKRYAR110GQUd0Dl9JT4=;
        b=s417lofM3UiKM6Whzsg+sYpUdnpUbH10YRrm7rR56O+DnC21VwRjP1HrIPD2cvQi2w
         aaEIkrSmY/eUMizFbRF4dPBxxF1ij89g+R701/tSf19X4AkJlR8d3pPW20eDTUG0txG0
         K9XtWC457kpQ80WKjSDs78mGKgwR4h4wGtmN98JuNYZn6NrZ9HRadyYM5wOPiHJvyNoO
         4hT1WVnLm+L781UoH+QBqO1OHQ+2WSF6kgTGZbgdfFSh4/31FrC0hloxVr/uwmbVianU
         UWM/ErigoeL5Kt3NddETp+/H+oUVihTtbWScaTqkQyFQW8knR2jBpFctgOU4bpGVVMOp
         //DQ==
X-Forwarded-Encrypted: i=1; AKwUvBzgmpxx2RvMgZDc5xXzEqAheG9hEAa9wBoFkKfIfQQZT9WW+XgDQ1ufMOHukL2/4qkDXenMlFOQ2Kb5/+SN@vger.kernel.org
X-Gm-Message-State: AFq9FYKmsYqDB2bssPFRNas/gACuemXPwCYBh3t+9dRWmX8X4Rp2UNw4
	+Mn97VvHtQlbflzRFTSZtDpWuUEs5nQHskwmEtm50dg8a49uXo/20+cQ8MjjeHeCl0WVUyJBSXi
	FSNWP9cEhw2IkV9gpqUPV2EmNAnCQ2ZhFVY3h4aAp9CCVxhfTCLLGMnT+HfrC4rTKcTQ=
X-Gm-Gg: AYBFou2iFzp0nALedr7/g2ZmwbgDjZg0otbIUONMaEh3r4OZ2TpHxvz5uWrU1pLqaoS
	RXpfYbjC1LKhRKOWHl3OAG0Pga+ork4zRBanRevmmbmpgM48bMJ7EQrom8fi5isMJQF4SpOgJ4r
	dcs6FnqwvRv2srBDb5jCNldO4TxVPBkLlLF9bR0f0U5nLgBetYEdhRkHvaCiD5Y53t1e/SRIOrD
	J67i6Ov1dIIhmfWkaFf82ZJI6obLi10/6GwQL+4ReAWweA7dL5WO3qAB6Z4iUvuIaKntjUylJx5
	ctKkf3jX0V0C+/9tHXtfIion7yvwGHvqGucNzX2E23RCXfkaInicqYqljquMbCqmIh9dAMcI4mt
	J56hXETfLgdBIDS8cIkMBUOSWGQuXiUBTzumVCdiGNNiCyGbuGFWpNPr+Gu4NmLLlrzXNlD4uJJ
	YTTKil3vLCo45hOEUkFfWn0p3pTaz6fQRJ7vTAtJvryoiKD+cKdApBBr4vVTeKF+7UjdpH5yvXh
	dc=
X-Received: by 2002:a05:6402:4510:b0:6b1:ac0d:6f77 with SMTP id 4fb4d7f45d1cf-6b3a80cea6fmr1729590a12.5.1792244422913;
        Sat, 17 Oct 2026 06:40:22 -0700 (PDT)
X-Received: by 2002:a05:6402:4510:b0:6b1:ac0d:6f77 with SMTP id 4fb4d7f45d1cf-6b3a80cea6fmr1729571a12.5.1792244422538;
        Sat, 17 Oct 2026 06:40:22 -0700 (PDT)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b38a1b113dsm1913032a12.10.2026.10.17.06.40.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2026 06:40:22 -0700 (PDT)
From: Alex Markuze <amarkuze@redhat.com>
To: ceph-devel@vger.kernel.org
Cc: Alex Markuze <amarkuze@redhat.com>,
	idryomov@gmail.com,
	xiubo.li@clyso.com,
	slava@dubeyko.com,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel test robot <lkp@intel.com>
Subject: [PATCH v3 1/4] dcache: export d_find_alias_rcu() for modular filesystems
Date: Sat, 17 Oct 2026 13:40:13 +0000
Message-Id: <f93b4a902ed00af44019ca88eeffbf686d920e2c.1792241577.git.amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1792241577.git.amarkuze@redhat.com>
References: <cover.1792074165.git.amarkuze@redhat.com> <cover.1792241577.git.amarkuze@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Ceph subvolume quarantine ancestry walk needs to find a dentry
alias under RCU without taking a reference. d_find_alias_rcu() provides
these semantics, but it is not exported, so a modular Ceph client fails
at modpost with an undefined reference to the helper.

Export d_find_alias_rcu() to GPL modules so filesystem modules can use
the existing RCU lookup without changing its lifetime rules.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202610171220.i77KPiw5-lkp@intel.com/
Signed-off-by: Alex Markuze <amarkuze@redhat.com>
---
 fs/dcache.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/dcache.c b/fs/dcache.c
index 1b1a81f10da6..13ba553081b3 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -1248,6 +1248,7 @@ struct dentry *d_find_alias_rcu(struct inode *inode)
 	spin_unlock(&inode->i_lock);
 	return de;
 }
+EXPORT_SYMBOL_GPL(d_find_alias_rcu);
 
 /*
  *	Try to kill dentries associated with this inode.
-- 
2.34.1

