Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793138315;
	b=LZQqBfJm1xllBZF/Wd3ggONR4A7JrdisuH1kq8WcgT1ZLiEUmKr3JsTqOSzll+AsyWBJ
	 09hNIngahvLzr9wDZnfgiS6943rbCGqyhW7YWsONdpy9+BN4ClGfYjS+Pb6Awt6k7NxR4
	 CKRa6zdNEbElHEuHNKh92aF07QBX3goU9s2Xh1UI3Bfnafvz1JDL+UziRxvmP5LXOugwq
	 1B+m57ScSHeuFIOATXA61yqQd/qXxLrNr0KiUjBCDWUvvcrZ+5CnkEXQQ/bv2i9xHiiWO
	 xssCxkZQExUpKUFKD2nge7ZhhsCxK4wwN9PbIcTUr06Xb+aqnDkcPR/R1sCfndhSGDw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793138315;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=W9OJQx+TcWNp0m+XcidattXlpUlog8C9yogSLSSgROM=;
	b=t9IsPloP3WDLVLiu+CpO300XhXLLhd58+sKc3MDNGTZYDyExrDTItgDEl3ZV2cL4DuL6
	 61qiFP2w9MDWNtaZ+ivZdYRFxFkLQrMi/jBCvD1oLkVjfcy7jqzxn32FBT4Gk1QWis4Lu
	 WC3iqQRCi4EPnKV8VVUkYPDLqxWJvr3ZCv+NQbeKHi92S6vQ1S+K2UDYl+s5fhiqT4TL/
	 T1LOvp7973JSe7VaNCNcissxvZb4011Jo15SZshh35Mf3AG+JkVV610qyio+fVfcDN7Oz
	 65U3Ps5R08R47JcrAjsmLmCFxGAOSrB5QP77rbA3A2Gp9eLW09fXbbkyGOUyeaT9pvg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oKDsmVms;
	arc=none smtp.remote-ip=209.85.128.182
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89B82606A31A
	for <linux-fsdevel@vger.kernel.org>; Tue, 27 Oct 2026 21:58:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 89B82606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oKDsmVms
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-8ab395abf79so3100887b3.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Oct 2026 14:58:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793138315; x=1793743115; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=W9OJQx+TcWNp0m+XcidattXlpUlog8C9yogSLSSgROM=;
        b=oKDsmVmsuk3dkIKPLXCEgrrBz0xgLo11lpY3b+3BJxL16XSKxaj0p+Bmb6QSRClvjk
         vQgeub/fwL+j+/KqtYUrPWdmrqMOoHx4qRiN7qr8wi7AoYcTOgTu8qTvLTN8mlMLlta3
         PRadaYH+I4mJfMBwrxUUOTN4Y17NnYPF5kfY7qSiXSUYMB6ANOrfA2ad1Z7YMIcWrkC4
         ikNN/NuZ7clzkhppK02X+qnkR7AXWJPHiDKqadRAar6whNKO1V0O+2g15MNOLrrR0eHR
         DhtfZtaofy0tspWXl2SLaHkWgeiBPnzHNxLwCbUXaJurLi0FF2JQJ69msPaVlOWQ1s3H
         utUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793138315; x=1793743115;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=W9OJQx+TcWNp0m+XcidattXlpUlog8C9yogSLSSgROM=;
        b=pGlotNE1Ut9eF0yD+nEoHP8mDBq12T3pVAHeuF8Yy2TUBodzphd9PMANGkP3dBytAj
         j98z1/vfDF0pa5Dij6PKDo7MQ/bHosNRpVoZM0eYfDC/NYHtqp1szigUnB8dr323NTGe
         V0oHBIbwUQxNTkrn+7hsFcMihGvZEAxUc7l0Axz7G/kuJ/ztMEBmTQkCMn68EaMU09TQ
         lQ0XjH6/l59JF2BUSAfxn09OOCM/ncG+wqPaClxOEYCRkocwOVyGXkkY4wutiHSND2H8
         o9VPMeW3g21C5wMPLqDDy61ouMAFSw2KwJYetlIOLOqpm0O1CRAateh4sVMevrD8Dh6G
         70rQ==
X-Gm-Message-State: AFq9FYLiG/cgLxifjPLJaTr4LUpQLClRMdMb4ZvSbbyqJ3tj4+cTayxF
	DVuh9o7c1yrtG7EQ+oagzKduthEiyBKk48HLbbangdiWVQzDui8fmfzI
X-Gm-Gg: AYBFou1hxi3kNgmP46Xmk2ZSVE3aRC28nMQIYE3oqWDyGLwMva1gcpxHktnlfXo+RE2
	cKn0TP6IJ9Y2oU/TWkmaS1s/BvVPZ2MsrMD1UIAJvLO/20RhmYcq15QuxI0YFKNV/Rs1k3VxFvX
	zuaeTCFILt3/eIwEs9TBkQ7jqsd1QamvngJJwrXmt95jR70JN/DKznUAbIMa8riS9wXuWpCm5f7
	vbakeOp3YmUNWfiKDFsRdUq8khmqgrmvMiytV7Fy6QJch3vIlD7KJef0ZjklDFdx63I3SqpJ4/o
	mFslK+TWNaseA5HeJfQfoXXUfo7hFoBywVeUdeJ27KwMYdv6HvnX9F4/EASYanY9Lc5avroGi9B
	V6CNTvavVSPrkWqNRCysB+QmGq2i+pRLzXwa0JJWXSbMf62JE1xSZbd4rYyBmw1vDQsa0uOy5fJ
	D1uN4v0YFjv5GjLehoTihYmdScNL7CcmtRQRQkK+h//sOYKL1xORvliUyhkULFzyn3E8CDcJel7
	lufl5KsL1YhH5DFm/H1r0bFLBLugpckg9AGDc0XBh9718P1qSIS+4LOXw0E256jm1l7dTSmOyPi
	Ledz5HUkO8q1SsPsxdX0bkwJrQCekZSZ
X-Received: by 2002:a05:690c:e194:20b0:8b1:7346:f1b0 with SMTP id 00721157ae682-8b1b5bbd517mr2470267b3.18.1793138314743;
        Tue, 27 Oct 2026 14:58:34 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:5b::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b19e67cbf1sm18555897b3.33.2026.10.27.14.58.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 14:58:34 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	"Darrick J . Wong" <djwong@kernel.org>,
	changfengnan@bytedance.com,
	kbusch@kernel.org,
	Matthew Wilcox <willy@infradead.org>,
	Jan Kara <jack@suse.cz>,
	Jonathan Corbet <corbet@lwn.net>,
	David Sterba <dsterba@suse.com>,
	Gao Xiang <xiang@kernel.org>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Theodore Ts'o <tytso@mit.edu>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Andreas Gruenbacher <agruenba@redhat.com>,
	Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>,
	Hyunchul Lee <hyc.lee@gmail.com>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	Carlos Maiolino <cem@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>,
	libaokun@linux.alibaba.com,
	bfoster@redhat.com,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	Viacheslav Dubeyko <slava@dubeyko.com>,
	Ryusuke Konishi <konishi.ryusuke@gmail.com>,
	linux-nilfs@vger.kernel.org,
	fuse-devel@lists.linux.dev,
	Zhang Yi <yi.zhang@huawei.com>
Subject: [PATCH 1/5] nilfs2: convert iomap ops to ->iomap_next()
Date: Tue, 27 Oct 2026 14:53:22 -0700
Message-ID: <20261027215326.2693300-2-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20261027215326.2693300-1-joannelkoong@gmail.com>
References: <20261027215326.2693300-1-joannelkoong@gmail.com>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert nilfs2 iomap_ops to the new ->iomap_next() callback. The callback
is generated with the DEFINE_IOMAP_ITER_NEXT() macro, which wraps the
iomap_iter_next() helper to finish the previous mapping if needed and
produce the next one. No functional changes are intended.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 fs/nilfs2/iomap.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/nilfs2/iomap.c b/fs/nilfs2/iomap.c
index e130ed63abd9..359786c97f2b 100644
--- a/fs/nilfs2/iomap.c
+++ b/fs/nilfs2/iomap.c
@@ -67,6 +67,8 @@ static int nilfs_iomap_begin(struct inode *inode, loff_t offset,
 	return 0;
 }
 
+static DEFINE_IOMAP_ITER_NEXT(nilfs_iomap_next, nilfs_iomap_begin);
+
 const struct iomap_ops nilfs_iomap_ops = {
-	.iomap_begin = nilfs_iomap_begin,
+	.iomap_next = nilfs_iomap_next,
 };
-- 
2.52.0

