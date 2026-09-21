Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB20334D915
	for <linux-fsdevel@vger.kernel.org>; Mon, 21 Sep 2026 04:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789964715; cv=none; b=GazojJFK1S6d4I18nU5Nrx7YeN5ogIzToUnoW7n0PuJXwMMhb515wchZGEDBVFETekUhxCN6XDo4iDdixZwiC16rW7+dvudusQFM2hE/+GgjAJIF89sRFd5C7rb3pCvuCnW42o0hQeURTYUo2i/Po4hvgde+3nqP0Szk7kXzquE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789964715; c=relaxed/simple;
	bh=qDg5vxfsG1Ujb0tlV/p+bz1qiSIh8MXo1JQEGI6gjcY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SV0PcW37dkGGShqaGpzUjSWxAjX8HDpEMB+FymGMhcYHTCeVBt0QhMMjT1zYsokv/eKymGvSJzBchCwryOeCncffa9uxAp8cI6dxWoLoqmgSAIK0daxx5GnUDOgtiF+IfKj3sf/KH9uDue1o2TNq+8d37kbb7mA1Vr75zv+SZBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bn3qBOPe; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bn3qBOPe"
Received: by mail-pj2-f12.google.com with SMTP id d9443c01a7336-2d747eefae4so7559665ad.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 20 Sep 2026 21:25:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789964713; x=1790569513; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AFedONfdsfWRRZrYGPfCHTniDDR5y58Jm72BIyX2Ebk=;
        b=Bn3qBOPeAFzjniEAiNVlFiEY7WMtINXAY1epWMTuULYNLK80NTQ5k0INptyu6P/fu/
         H+lLH5Ti3rIKeYrxZBcxRTYteb0R1c6ktQcz31uMI4iIoujQL2o5heidXBO+DgYSDtbH
         m/t296KmeZ5Q68jAzo53q6bb2VKnZSdQWIpNLfewPMAETkc7z2IuRt9HCoRtfqbWAbOl
         pzvE3DCIhXPlQC2bsBXa6gACxTM8kbjw1gVYYEKKP/WIIRTDWHNBdfCNwYCdWDbJrFDj
         qVjbrMfnsZeajmXdlaZuRoJH4uLCis8461jApN1eU2W2ZDxVLjSNvHmticgM6aWpGe3h
         WjPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789964713; x=1790569513;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=AFedONfdsfWRRZrYGPfCHTniDDR5y58Jm72BIyX2Ebk=;
        b=oG+AvqkeZepa12DsQqKKyqseFMYzQ8aBeOyl+ErkavGdAK5dZoOyM4Hv4/ooZQfsrF
         pmxvOu/h9/oZ0j40YlXEhlw4X4wMBQSY9gD0W+aid7xmvNFUZVbNZHqS3yvFKjrIR+f9
         98MXYfNc7M3ZtlZuZluEOzhWyf2gJ2zOvflNyrqseZJ+ArW17WKw5N0tTcO4wvOLji7V
         gptXUcoE08Qe71YiPOhNVej9sJHN1tb7yBbfdYeMTwmiE0+E77JWe3JsnaOU5xOZQNiC
         mVatofLLyXWeSSUBDG0SOSyv5aNrn2rB75BIM1xXKNbk2kAEmCXJqkcdNkQBaRIkMRO9
         Ovfg==
X-Gm-Message-State: AFuF++lN7wEB9CdbV9yaBEF/Kig9myB3PZWWKPyL2o+g6nRRhixNlh07
	NPny7J7ygY15SmymNEslJuPGm6wl9PLEnFr3b3hdQ67sIualo/oRam9XjnuS8j1W
X-Gm-Gg: AYBFou1hgzFnv0++9CKOlF/qQ/j9O5MMZIIiJle7uhQTgORmHJa0SrGTqQbAEUr7d6E
	LaNltV/xBg9QBvwBL9dkl0TudUd0wf1u7/ZLlGLt72e2lE5io9fnsza3sab2uIc83yFWjGuRJZ3
	0cHKacEG6g98f1xWEt1FYVxhuOcONNxfxIWYB7jlw3in1fgWa+o3A+akCnaXFxtIxPBx52vN4B2
	X/gVC3dStw4oZu43U/EecVgV8m26GujiJ4lTFO0vR0TtgSE0DfHnTHeHUNpJt87gGJeN7PMTcED
	g+ggc9jck19kZ47pTgJGSvrV2qyYsI3TwS4Hw3gsQY6imVwL3U+YPo2RzlFnLvCIDNMu1FXbmwS
	qRAXjW1wEZWLtTIyiYBMtULI1AQ4rYH9O78ySNqw67CwfQFWHbqxbLZEN+t9u1qf39wzowNdbGB
	cE3XAHpZ4uGtWyLC3xmpb7Z5V0Pj3CXwX1Oi5/VrVI5aBS+gI7p17jUnxEW36zSqPQTECuvfnZf
	7OXOSVdqBkwb19bhaD/YdS+XU+MFJAm0FnbKujwYaSca/83iElpwCH0Bg5AIpnOcjaW2JanT9yK
	+kcvCmRSBg==
X-Received: by 2002:a17:90b:184d:b0:39e:6a7f:6186 with SMTP id 98e67ed59e1d1-39e6a7f63ecmr5905503a91.23.1789964713209;
        Sun, 20 Sep 2026 21:25:13 -0700 (PDT)
Received: from phui-2.c.googlers.com.com (78.123.83.34.bc.googleusercontent.com. [34.83.123.78])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e6c5b3932sm11742139a91.13.2026.09.20.21.25.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2026 21:25:12 -0700 (PDT)
From: Hui Peng <benquike@gmail.com>
To: Damien Le Moal <dlemoal@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Jeff Layton <jlayton@kernel.org>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Hui Peng <benquike@gmail.com>
Subject: [PATCH v2 1/6] qnx6: validate di_filelevels in qnx6_iget()
Date: Mon, 21 Sep 2026 04:25:06 +0000
Message-ID: <20260921042511.1473629-1-benquike@gmail.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
In-Reply-To: <f68323da-e90f-46a4-b3ce-70d26de115e6@kernel.org>
References: <20260919222556.3792829-1-benquike@gmail.com> <f68323da-e90f-46a4-b3ce-70d26de115e6@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In qnx6_iget(), raw_inode->di_filelevels is copied directly from the
on-disk inode without checking whether it exceeds QNX6_PTR_MAX_LEVELS (5)
(unlike sb1->Inode.levels and sb1->Longfile.levels, which qnx6_fill_super()
explicitly checks against QNX6_PTR_MAX_LEVELS). When qnx6_block_map()
later computes bitdelta = ptrbits * ei->di_filelevels, a crafted
di_filelevels value (e.g. 20, giving bitdelta = 200) causes a
shift-out-of-bounds in (no >> bitdelta) and out-of-bounds indirect block
traversal:

  qnx6: superblock #1 active
  Buffer I/O error on dev loop0, logical block 4099, async page read
  qnx6: Error reading block (4099)
  qnx6: error reading root directory.

Validate that ei->di_filelevels <= QNX6_PTR_MAX_LEVELS in qnx6_iget() and
fail with -EIO if exceeded.

Tested in QEMU against Linux 7.3.0-rc3 by mounting a crafted QNX6
filesystem image with root inode di_filelevels = 20 on /dev/loop0: on the
unfixed kernel qnx6_iget() accepts the inode and qnx6_block_map() walks
invalid indirect blocks ("qnx6: Error reading block (4099)"), whereas on
the fixed kernel qnx6_iget() logs "qnx6: invalid filelevels (20) in inode
1" and fails immediately with -EIO.

Fixes: 5d026c724220 ("fs: initial qnx6fs addition")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Hui Peng <benquike@gmail.com>
---
Changes in v2:
- Split the v1 patch into a 6-patch series (one patch per issue fixed) and
  remove Markdown formatting from the commit message, as requested by
  Damien Le Moal.

 fs/qnx6/inode.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/qnx6/inode.c b/fs/qnx6/inode.c
index 6de49333acad..13972c086673 100644
--- a/fs/qnx6/inode.c
+++ b/fs/qnx6/inode.c
@@ -560,6 +560,13 @@ struct inode *qnx6_iget(struct super_block *sb, unsigned ino)
 	memcpy(&ei->di_block_ptr, &raw_inode->di_block_ptr,
 				sizeof(raw_inode->di_block_ptr));
 	ei->di_filelevels = raw_inode->di_filelevels;
+	if (ei->di_filelevels > QNX6_PTR_MAX_LEVELS) {
+		pr_err("invalid filelevels (%u) in inode %u\n",
+		       ei->di_filelevels, ino);
+		folio_release_kmap(folio, raw_inode);
+		iget_failed(inode);
+		return ERR_PTR(-EIO);
+	}
 
 	if (S_ISREG(inode->i_mode)) {
 		inode->i_fop = &generic_ro_fops;
-- 
2.49.0
