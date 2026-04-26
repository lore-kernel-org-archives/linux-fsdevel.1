Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB153262FF8
	for <linux-fsdevel@vger.kernel.org>; Sun, 26 Apr 2026 04:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777176158; cv=none; b=eizBIWwYlsyT6T+K3G5z/5UYY05fXUkJb6biap8HA7ZvgaD5CFX5lExQWFgCm9tel1MSbko7zjL/48WtISnAKu0PTtPl6by7GHbdEzJpIXuh3DnJ9dPyCc7q25B/UZ9gBM1oRE2vLUt3wLz1MYHInjhONnVbGzjBR60YbmorLeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777176158; c=relaxed/simple;
	bh=b1C/+FmsQj6zYNd6Wt37YzGi/DP2GWJFaf0pvPFIGCw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LQdWJYakq8itd2YkyTUFWkr/Talzi83B5hu5e3kPigU21HqHnbFqOrtChmd5Su8Z/TMNeTH+hlkdt6Bave8w7AStf5aTOG1YaU2Ti5lli8LCu+DNhW9zVrKedEn2/vuZfQAZcMnqXDeUgZKJKjSuBPpVeAXmFOmkTPOWaVEUiR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bElmC3Gr; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bElmC3Gr"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2b467d03d57so7312915ad.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 25 Apr 2026 21:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777176156; x=1777780956; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RLw9b27ckszpi+Ob4fzjwHDQ49PnkmJ7MVzQtGjvkUQ=;
        b=bElmC3Gr06IQGadLQEQdjb6B251AIUWOf5MUH1tlIdvbOCr9Eaf4c/ws6WZbM8+kAS
         /F3ZduwwHh/9z4afuYqvBL/Fi/lL6ut/wdHvasji40Wt6GSpIBV7JAGa2+HXiBrqwdma
         UIwua8zosesCsjmi2E+KT0fEQ6hCVmiXqygTnl47nEuc9sQoaTXM4sY9Auorsj3jE7v7
         dbmr1tpiV/92MhlI70vu683aud+o8jc9KgxXt++iWgHsodrRP51ghho4omAL39Dkx664
         sSh+50A+aTIbWhVkVDc9w2S0VHeR6vgRQ1cyAhM/u3OcNe16FLfAsx3/AhjMhWlyx1RS
         skiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777176156; x=1777780956;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RLw9b27ckszpi+Ob4fzjwHDQ49PnkmJ7MVzQtGjvkUQ=;
        b=dv/qdRjzkGDGhm80lpMhQNpFJeaNLtV5mwfPZGQeJYM1Kr4PNG2Vep8ObUQrIfoBL+
         gKQN1BL72/NBjzi4mZn8tIYfxo3OEKLRjbiR90gAjQLPkKjVW7Gi5WB24QIoEykzzeqf
         dERmmWxm26IlWHqD/pGGv3hDzF/m3rq8waeBxBrPH0IUVxa1J4fxWWCjBts3GY7Wr7jQ
         ZccHYE0OHTNkl4ZDA7C6N8HubNhISGIWgZu64A2v0yLGkXIbcuXel4Q+lnp0re+cIPVN
         u0Z6PbdukzqfuZoM0dPsyhiQYXnPXTvMytqY0w+dbgvIShk39mBn/xw/A1Ne0hzBTAZO
         p/LQ==
X-Gm-Message-State: AOJu0Yxg2yLPN1eN1TFBEuiOiJJPYMW4IUOG3XbpQXBUvF+pqEiISDAL
	/dVMEOgx1waE2eI9Zk2RN+biAb4f5p53u1qxXpMhPwXTTm7LumOMqfq0
X-Gm-Gg: AeBDievvWo1fiMI0KUpUhSiV1Qt3sLwNCv1H7++BEAE+v6vmpd3Kysl81gnPHn2Kij4
	4xk/UZvpmDpNGjWREKH/PXd1CPLDVGRSteAkccguRrmwWK0U+lplojbmzqgxB45mwg8hRjfn2gS
	SzWAIoa9L5OK1vymlQ1bQPExZdJcqAK8ls/jeMlg616gIeiliQqR1R2Cn3fyYC8vh6amdh++f4y
	i1lymiKZHClNEiHedlKDWhiKHi+ale9vQtfE4L4nPHdhxXeUBex3p27+WG7xHHVf6EAjKmUVavk
	wE7O2Soywcg1zS3RRMCnYVZ4IR3UaG7JRM+sUbv9lhj1XT1NY9bxQkeXX4sKJDM5Q7NH+Nhp6Fq
	n+ZhNj4nwViJZKQFf9ZiXoz1RwRvZ9b7wOSECLQ4FyRIOkWdMfpqHjORqmRrf9VN0UOZKQ0jEDh
	qwxgAIuS+3GvPmyucFsSZUvTnOxzk=
X-Received: by 2002:a17:903:1b6c:b0:2b2:4f56:d571 with SMTP id d9443c01a7336-2b5f9f829d6mr214716035ad.4.1777176155966;
        Sat, 25 Apr 2026 21:02:35 -0700 (PDT)
Received: from ser8.. ([221.156.231.192])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b5fab0c17esm265149125ad.41.2026.04.25.21.02.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Apr 2026 21:02:35 -0700 (PDT)
From: DaeMyung Kang <charsyam@gmail.com>
To: Namjae Jeon <linkinjeon@kernel.org>,
	Hyunchul Lee <hyc.lee@gmail.com>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	DaeMyung Kang <charsyam@gmail.com>
Subject: [PATCH v2 0/2] ntfs: fix index walk NULL deref and WSL symlink leak
Date: Sun, 26 Apr 2026 13:02:30 +0900
Message-ID: <cover.1777175371.git.charsyam@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v2:
  - 1/2: switch IS_ERR_OR_NULL() to IS_ERR() in the walk_down loop
    (Namjae Jeon).

v1: https://lore.kernel.org/all/20260425184243.116396-1-charsyam@gmail.com/

Two independent fixes for the new fs/ntfs/ that landed in v7.1-rc1.

  1/2 fixes a NULL dereference in ntfs_index_walk_down(). When
      kvzalloc() for ictx->ib fails, or ntfs_ib_read() fails mid
      traversal, the function previously returned a state that
      ntfs_index_next() and ntfs_readdir() could not distinguish
      from end-of-directory, and ntfs_ib_read() itself could write
      through a NULL ictx->ib. Errors are now propagated as
      ERR_PTR() through ntfs_index_next() up to ntfs_readdir().
      Reproduced with failslab fault injection on getdents64; the
      reproducer is described in the commit log.

  2/2 fixes a target-string leak in ntfs_reparse_set_wsl_symlink()
      when ntfs_set_ntfs_reparse_data() fails. Also switches the
      kvfree() on the local failure path to kfree() to match the
      kmalloc() done by ntfs_ucstonls().

The two patches are independent and may be applied in any order.

DaeMyung Kang (2):
  ntfs: fix NULL dereference in ntfs_index_walk_down()
  ntfs: fix WSL symlink target leak on reparse failure

 fs/ntfs/dir.c     | 13 ++++++++++---
 fs/ntfs/index.c   | 17 +++++++++++++----
 fs/ntfs/reparse.c |  5 +++--
 3 files changed, 26 insertions(+), 9 deletions(-)

-- 
2.43.0

