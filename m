Received: from mail-lf2-f13.google.com (mail-lf2-f13.google.com [74.125.229.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B58249A3AB
	for <linux-fsdevel@vger.kernel.org>; Wed, 30 Sep 2026 23:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790810650; cv=none; b=pU2m09N0N1RzDLXjpR9ch6yw4GZZJfyONuJuBYtm18+n5298H2v864SzwFFGpteCV4nBTEVYkn/AXl3rm0INc20oO6qT2NMPbt4+cGorrsAVp+3tG9QnU1+orNzPH2f8cS6C63Oc5uV7GWT7Is2JziafeOemRQ07trhIxJLO3C4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790810650; c=relaxed/simple;
	bh=HSDehu6zKcCUBJdvUllZcY/3rbhZgfYH1a08z42ov6o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rYVrROEJO/rXrpkaQK3f4uzCDPodRyHp7qd0RcguTdNCB66ACJgdpObeJ9GMLkEvngozFuxBDytwqRkoR+auXWVRcezCwQtySUNHR83RB7SfCu2FifUn1S+R4mVMDdXYiNG2iveN6BqYAdFml4f+Aped3cCZlG04+elEH3JCxJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=noroxi.com; spf=pass smtp.mailfrom=noroxi.com; dkim=pass (2048-bit key) header.d=noroxi.com header.i=@noroxi.com header.b=hfRMbGaJ; arc=none smtp.client-ip=74.125.229.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=noroxi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=noroxi.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=noroxi.com header.i=@noroxi.com header.b="hfRMbGaJ"
Received: by mail-lf2-f13.google.com with SMTP id 2adb3069b0e04-5b8eacb7c8fso5253646e87.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 30 Sep 2026 16:24:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=noroxi.com; s=google; t=1790810643; x=1791415443; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SQ0OdnmP0LrZt1KQaEY+HbbBliVRtQdPTnqFkA08fMc=;
        b=hfRMbGaJdcpBdtIGMJxRIq2iw4T/NxcgRpKtcDBIlcabytnsiM/71lP1qeKMViArDI
         tlBxNMhhsqUHL6jWCamYUfhHT/jVQP15JqICFO2ASvEbMtA71ET1S9RWMi46ZLkG1dSY
         4Tvn3gipduLCs3NblV0PyRxxL+AIC2bBr4C60idc/PWNgYjSKBDEeAU+qs1lJsQNYq05
         tS8NXsWw6YnI7U4GiwshmvLNPYWCJOx4yApqxUirxuK53VRpIEA3txAYj7WztILAk9UZ
         M9Nb/sFeBaISO+KON64pYqtfAo3CSzZRfsdmvefJoJt5c6pf4eB+b6D8gD0A4q8gr2rV
         7Bxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790810643; x=1791415443;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=SQ0OdnmP0LrZt1KQaEY+HbbBliVRtQdPTnqFkA08fMc=;
        b=bhn2VzQXapYhVw8KTBVtWx4BDvut+FAu0ffDsJcVx/tlsZO0Zdpd+HksNFyV0IGDkw
         1cnnHHz+GPTu2vX3SZDCrAPylhS0eFpWJRnZHBNI6kAP6GBHGrSt5rcBVf37RtGaKnbO
         t4kxQrywhF8zq4T1Slfze5JM/a77Glz8aH5zhqSPzpD5buH2/Fv4MKPRTeZZNYTaHsBQ
         rn9hEuSpNIWv217wq2FSFH0tM0bb5p1psE0CdH8oXUodfRXZhLlNPWXSTdfL4cLmUxcL
         E7Rmf8B3h4s7FI+RNlQ32FPIi4cGZ+xWeMii7DBFQX1V5J34Q85ILVYAgVkDQ8vowJZS
         VpUQ==
X-Gm-Message-State: AFq9FYIgknfMukqpqCnM1kuPE/0yN0GNGprabddF6PDsFDpAUaQm0TCt
	CA40bxtPm3SZXgIcMxebNoHPS11Lf+XnEyGC1pMJJ6Sh0leRk9MWskeyQEV/beC7ihxAq9UCkQx
	MXIx/SKglxx0=
X-Gm-Gg: AYBFou3O3xxHaF87pxcsvgMeeYShpgJWspAMBS0gqNRY3SWcdhdyOnquPHaaOk25MSi
	oLHvf2yslanvwNhE8t3faeXRVRRMU7IedWCkYefBkJt07lWjuEXDtFGHlztX+ZJrIY4mL93IRRR
	QwkVMHrjVwUHCrpboZpIPyVkW8psfIA2T6jrNtrDaw+D+ebleHdg3kpN4HH/G7BcPFkeh+y764l
	wcqqX83BLeq2wlDVSnB2GYmEW69vroJkpTG9WLo/40q0vppJ+ZbLo3ZMGXta8VoZVe8x/GRbj/p
	yCfEbLXGR3kAvCr5PczQ6EmrftN87gpxMvJYSmUHPJtnwXC0X8x12ui9cIzu3Wuyf9lxdHaQBzg
	bA0j+eR/LRL6MiAGQMz+TYW5hhrb9QqIv3tFmOwZb50fQEOfBqrxD173wAl48BHvBo4nD8Y+OOB
	53YTuSt9pZNGKM0XzSa99+KVqfPBvHrnF/uF7KnLZxBp7Uabwa3SYo7n0cntfB4QeF91CBsZtZf
	BDpIxPKaDY=
X-Received: by 2002:ac2:554a:0:b0:5b8:f960:1bd8 with SMTP id 2adb3069b0e04-5ba40608d46mr811098e87.61.1790810643087;
        Wed, 30 Sep 2026 16:24:03 -0700 (PDT)
Received: from lab01.. ([2a01:4f9:1a:a462::2])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5ba42fc8023sm279117e87.81.2026.09.30.16.24.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 16:24:02 -0700 (PDT)
From: Mahmut Emin Kurhan <guvenlik@noroxi.com>
To: linux-fsdevel@vger.kernel.org
Cc: slava@dubeyko.com,
	glaubitz@physik.fu-berlin.de,
	frank.li@vivo.com,
	linux-kernel@vger.kernel.org,
	Mahmut Emin Kurhan <guvenlik@noroxi.com>
Subject: [PATCH v2 0/2] hfsplus, hfs: fix B-tree node leak on hfs_btree_open() error path
Date: Thu,  1 Oct 2026 01:23:10 +0200
Message-ID: <20260930232312.1405042-1-guvenlik@noroxi.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <ea8cfa5978a90d27e498fae626edfdae5bf84af7.camel@dubeyko.com>
References: <ea8cfa5978a90d27e498fae626edfdae5bf84af7.camel@dubeyko.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is v2 of the hfsplus B-tree node leak fix.

Slava, thanks for the review. Addressing your points:

- HFS: you are right. The classic HFS driver has the identical leak:
  __hfs_bnode_create() hashes the node before reading its pages,
  hfs_bnode_put() only frees a node when HFS_BNODE_DELETED is set, and
  hfs_btree_open() does a bare kfree(tree) on its error path. Fixed in
  patch 2/2.

- Dropped the inline block and the duplicate variable declarations. The
  freeing loop is now a small helper, hfs_bnode_hash_free(), reused by
  both hfs_btree_close() and the hfs_btree_open() error path, so nothing
  extra is declared at the call site.

- hash_lock: correct -- it is not taken because hfs_btree_open() has not
  published the tree yet (it is only returned on success), so no other
  thread can reach node_hash. hfs_btree_close() omits it for the same
  reason.

v1: https://lore.kernel.org/linux-fsdevel/20260930185033.1335238-1-guvenlik@noroxi.com

Changes since v1:
 - factor the node-hash freeing into hfs_bnode_hash_free() (Slava Dubeyko)
 - no inline braces / no duplicate declarations (Slava Dubeyko)
 - add the equivalent fix for the classic HFS driver (Slava Dubeyko)

Mahmut Emin Kurhan (2):
  hfsplus: free cached B-tree nodes on hfs_btree_open() error path
  hfs: free cached B-tree nodes on hfs_btree_open() error path

 fs/hfs/btree.c     | 34 ++++++++++++++++++++--------------
 fs/hfsplus/btree.c | 35 ++++++++++++++++++++---------------
 2 files changed, 40 insertions(+), 29 deletions(-)

-- 
2.43.0

