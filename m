Received: from mail-pz2-f40.google.com (mail-pz2-f40.google.com [74.125.228.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F3E8355819
	for <linux-fsdevel@vger.kernel.org>; Mon, 21 Sep 2026 04:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789964719; cv=none; b=ZX4LcF3tijYBWOo1w8RyeZ0b5pK4hSUkyL9JaPQ8OiwiA/4slnznq4r2rkwlSuzwhSbeM7lJDDrBDoigpFeMqSs3i4V5HbVJ3iNVry5cBGQsbPB32um4MQF7nX9BFnLOmWqX5jXfzJNooWMJsz6WrVf7HEyIwK0enRVspFPAzXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789964719; c=relaxed/simple;
	bh=o5a8cwchYptTJ18OlpOPh8cxQZIhxGe/fRbf5AoNx+0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IFwprm5WdmHGnocIUQeB0fxiIcnRIAv6+/kE9Qb36P4fwo/507vhsPE9WZS3sa7W76B+1fYcJQ4PKpOtVe0S7RC33ubJ/TDtXfQxCHtgyNneKtWd2GbVF/iUxn03oX0CrjyvKpf8LsqX+sApv2Nu+5t3LeUq/jaHt65pi1y+6+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aoaHgwix; arc=none smtp.client-ip=74.125.228.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aoaHgwix"
Received: by mail-pz2-f40.google.com with SMTP id 41be03b00d2f7-cc5256c2a4bso1658108a12.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 20 Sep 2026 21:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789964716; x=1790569516; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=A2auV0/VE1Iheg/PPPrS18TZ3S2aE13Fg8YmU7kSPxk=;
        b=aoaHgwixZOjyjCqvmfFPYxEbMTisz/Yi+Bf34aEjdnP2oIKqn5odWq+AlvQ9lRrj0P
         HckDteinIXc3NWUN3e0K/FwXHLLy1bF6OfQtcIQgrL1Y0FtcMJEwHKxXB2P3ztEW9YFO
         XYZXmxbfOgXnD35EHhUtEJiZ+YB5IFoKtLhn1ejzDmSKKib1bynlRaM9HMGnQ201wOrg
         u2KL7UUPxUqdXlkqAErDcRhfuLyQyzium6ehP3vSF7T/rdH8RKr+KFC79oe4B4CJubz4
         4qoiAvrHGOOtKDH4/Zw8G7FExo9i+HGkrYKBaZOTK/vr38+0oaA+VVO+8wN9b/U8m5QF
         wRPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789964716; x=1790569516;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=A2auV0/VE1Iheg/PPPrS18TZ3S2aE13Fg8YmU7kSPxk=;
        b=j7uIIj2ER0jqGs6eNAUv5RjHZeH9dv2YCpmz8Av+RFq0MMqIfreF8lCZXDTa85FnJB
         mY8C7B9E5gJqzPuAkNIL3yFnF2xoYXOF6AxukFJmjlIRpDtUFDuTLU5k891rC299nM+z
         mmSzoF0h1G9tZeU8XW9/xsLfuzYUcwDwWZmkUYTmmt22IxDE+Pkkw2iPRHP7hnU8Npz1
         sF9D1qzv+PB4bMH4A8q8T1uu7ZhDndGtwn7dLdsjmhZxZ5rVd2QnSn/zkhy839MNIQCf
         qHGFL5dxxCv+fbs7Zgd0YTMXLEAvkUbgOf+gL3jxo+ybVfmaMX+fsYsEN0TnMOXI+ChX
         kCiQ==
X-Gm-Message-State: AFuF++m1K70UyFrH5PCDMhJq76xhEJsrsCwItmMrnkrbAxzc5wUFr2U7
	qb/0karrrVUfCVCgpBcXtwzyoqCyzMAzm7a6Lmk//p2PcKemI+hwtdtt
X-Gm-Gg: AYBFou2ZL80w7TKG928R8IwACpUxsmGgpQVxCfQlmVjxoHgtrmhRcDAyHEt6sN7Z2gH
	3b2r6IwB5kn0cYP+fYmoHQB4yAeKDwoP7YwWHrE9sgwMXs93Yy94AWefrWaaZ3g+DYFkyNEk4HA
	YrfG0dEtdgcoZj/KIEKE2I2u7ibxnBH7St8R/06M73UUXj7795ZVF6VshCotZSQlmNjWbd/qdFX
	2XU5F7eUTKBIw59cH4OKRqEWbFz+9+A0NM2SmkCCCHU4HYQ5skrsAOAcPrDYZKsG+kt1PVBhW0t
	xzE+N39/rMLaJgRyL0yyASZyW4FgcuBOJXsv/YQxQ+eMtS7usa8p/MJynlMiANB2ZzDLpFrXWub
	RRh7meVBvNPt+6/8BUJY0f9AELglt97adar1hUYwcxrsjfFjXDVizhXCI7e7a8O22geU5U8VvnN
	xNc/aanduUI09iyLXRbVfPgbtGeTrIbtmHahJv6r0AvpjYiFJJ0I9WDEgTXc8qqxEFr2PYH4kyX
	G55gfRRfK4/7PBX6/3MppIAcFwg4Nu7vKcWKIRr4mAy29IY789z6FYVYIC2HVJ72WOepHnp9JWM
	42jmNN3fdA==
X-Received: by 2002:a17:90b:4cc1:b0:3a0:3d1c:2dc6 with SMTP id 98e67ed59e1d1-3a03d1c38ecmr3528951a91.66.1789964715575;
        Sun, 20 Sep 2026 21:25:15 -0700 (PDT)
Received: from phui-2.c.googlers.com.com (78.123.83.34.bc.googleusercontent.com. [34.83.123.78])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e6c5b3932sm11742139a91.13.2026.09.20.21.25.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2026 21:25:15 -0700 (PDT)
From: Hui Peng <benquike@gmail.com>
To: Damien Le Moal <dlemoal@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Jeff Layton <jlayton@kernel.org>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Hui Peng <benquike@gmail.com>
Subject: [PATCH v2 6/6] qnx6: validate sb_blocksize before dividing in qnx6_mmi_fill_super()
Date: Mon, 21 Sep 2026 04:25:11 +0000
Message-ID: <20260921042511.1473629-6-benquike@gmail.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
In-Reply-To: <20260921042511.1473629-1-benquike@gmail.com>
References: <20260919222556.3792829-1-benquike@gmail.com> <f68323da-e90f-46a4-b3ce-70d26de115e6@kernel.org>
 <20260921042511.1473629-1-benquike@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In qnx6_mmi_fill_super(), QNX6_SUPERBLOCK_AREA /
fs32_to_cpu(sbi, sb1->sb_blocksize) is evaluated before sb_set_blocksize()
validates that sb1->sb_blocksize is a non-zero power of two, risking a
divide-by-zero when sb1->sb_blocksize is 0 on disk. Move the offset
calculation after sb_set_blocksize() (matching qnx6_fill_super() in
fs/qnx6/inode.c).

Tested in QEMU against Linux 7.3.0-rc3 by mounting a crafted QNX6 mmi_fs
image with sb_blocksize = 0 on /dev/loop0 and verifying that
sb_set_blocksize() logs "qnx6: unable to set blocksize" and rejects the
mount with -EINVAL before any division takes place.

Fixes: 5d026c724220 ("fs: initial qnx6fs addition")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Hui Peng <benquike@gmail.com>
---
Changes in v2:
- Split the qnx6_mmi_fill_super() sb_blocksize division ordering fix into
  its own patch (6/6) and remove Markdown formatting from the commit
  message, as requested by Damien Le Moal.

 fs/qnx6/super_mmi.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/qnx6/super_mmi.c b/fs/qnx6/super_mmi.c
index 18298e273a13..28cb9322278e 100644
--- a/fs/qnx6/super_mmi.c
+++ b/fs/qnx6/super_mmi.c
@@ -63,15 +63,15 @@ struct qnx6_super_block *qnx6_mmi_fill_super(struct super_block *s, int silent)
 		goto out;
 	}
 
-	/* calculate second superblock blocknumber */
-	offset = fs32_to_cpu(sbi, sb1->sb_num_blocks) + QNX6_SUPERBLOCK_AREA /
-					fs32_to_cpu(sbi, sb1->sb_blocksize);
-
 	/* set new blocksize */
 	if (!sb_set_blocksize(s, fs32_to_cpu(sbi, sb1->sb_blocksize))) {
 		pr_err("unable to set blocksize\n");
 		goto out;
 	}
+
+	/* calculate second superblock blocknumber */
+	offset = fs32_to_cpu(sbi, sb1->sb_num_blocks) + QNX6_SUPERBLOCK_AREA /
+					fs32_to_cpu(sbi, sb1->sb_blocksize);
 	/* blocksize invalidates bh - pull it back in */
 	brelse(bh1);
 	bh1 = sb_bread(s, 0);
-- 
2.49.0
