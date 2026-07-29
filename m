Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE742450410
	for <linux-fsdevel@vger.kernel.org>; Wed, 29 Jul 2026 19:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785353421; cv=none; b=CcIatMfQh5f8hYfPeriJp0ZOtJGRHoYWGlPrUEn3KEC5a3v4XKQA7MNuyTnzgMl7R2g/fdyrOH8p9GuqmCu8yhBo+8W6wH+E8dj/pNlZBm/B6GEZT73bAj01rIha4imKLNrb4x14TcfPMtDp+KUBQFNK7QVlt15ZuzqvKFEQWEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785353421; c=relaxed/simple;
	bh=1LODBsXTJz074zPmHlKPolHt/XzrgN7p/Zc0cYoesy0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AImkyZazJYgome2YDXxSaku3psYUZM3AP1wtowLvYPAKlQgfyailnu530nlhJDSwlZCV+vav3pELCLZLF1b92NXreEnVuwpS20CzQiDtDOOWoEhJpRfLhR2ZXRCG31z1ZUxO3WBjyhRXgNfuw4h6kG9xtRolLk870yJnx9NAXI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EoItSVoQ; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EoItSVoQ"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2cf50c6f235so15184065ad.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Jul 2026 12:30:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785353412; x=1785958212; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+Cj5pCwh9UiKuAyGTCN2ecA2rWhLN61eKI8rtelBEo0=;
        b=EoItSVoQKQVIL734m0fcIWVZ9zz4QMBKJxFKBGgm9VLzNpt7KiQu0lnC4FF/i/WXCK
         RQDFD8KU7Ys1AyNBsN6wjiIJjg2FZ03gsLXmJwrv6RirDcG/0nCjJvI/OAkn+EYAebe9
         XM4Y2hShgFKvCPCiTFJZPrZfmlBImBiVuyX/OIp8f+zOEbMc9MfKPCoiXPWQ7ncVzJdU
         oih6QXvepGuRChQFUT+Om34RlmmJNPCD+05YetzzgWp1LQDwVUoiX9Xl15undzpq3cV6
         4wu6t0NN1LrVbiBe4T8mHS8gjf9YF9VEZwcpaDO7aZ8OX1PJF49fa7CSreUyI39747RJ
         Neow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785353412; x=1785958212;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+Cj5pCwh9UiKuAyGTCN2ecA2rWhLN61eKI8rtelBEo0=;
        b=me5c7+bh2wcJ7W4yJHoWeWX+QeafYbkWPr53hcu2ibCu48qwFLMjMFe9sl095ERrUq
         Ru9Z+Fm6b1NA3Vq706qkM+3cj+A+b6eaatosgZ65zGYrNokedwztcWd2JIw1gWysFtpq
         yzgS0SCQTWA3Icp43+b5jtTyL/Da4SVsJYGI2QdLscMbxcCNWxfT26Kosl1jxvoGfVDt
         psGvBBZ40YYZmbkWYJJQT+N53BZ53TLSkML+YfapTg0Q1odmpX7YraWOk1v72450m5Th
         b/n4utZ/rfFKtUtjFlhhbr3NM1a6ICggVxQJsaK5MP6BepohwkvxkHnps+Wx4UXyJLIc
         K5iw==
X-Forwarded-Encrypted: i=1; AHgh+Ro7LfScQsusLqA0jEfmU62su9tuZLdciKl4aguaE5vi2Y0O/Zo4S+xwrAN7sRotVyZI+RTwYOTBFGigcNJH@vger.kernel.org
X-Gm-Message-State: AOJu0YzjobzbFj/tg7BTUIboc8Xr5Zq6zUVrSIX9NRcsZn8Dng0sbE2t
	GB/w2kdiG+Wi6P8sz+RT9cngP2oS/ABF7Zv721P94EJgL4H22xt4FtLr
X-Gm-Gg: AR+sD10hXfaFqMuQm4BxdvocqXRvfsfUZUODGvqqHZm36s9zSoYU6PV4o/sLWM6BUpe
	pd2/RNQT9wBb5ryxfpKwNlPehsrAE6J5d+8Rv32sJm2opRnlT/K4Ghf+RTcfCtHldl7nt0lhljp
	Hp3WLApjDJxDx8yEvebbzNA9UopomlHG3v6LHJX0xUeioPHwPdy+aqQkmcuL5eDpOy6EnEQxMqm
	U5cWLR/PaykWrKrQjub+fW7kXlX4NhScfwyB4yyv/NSOXHgywcsq5IzCUHjYbjnHW2mI+XQAs8R
	bW/VqaT95Xu/vBFtFhzaeTWkPflOfgN+OUX4Sg6EFwCImrhzr4HYYXaSlCQDlNtoc+POLrp+O5u
	FYunrxu+1+z7eGOduSNEo1w7jLWmtcQcYPF29ZqAYpl7qiKLn7WBoGOCyi/bu+NBZP3PR5A51LV
	vIxLVf0A8S+Q3oaMUwX4TAWCyBBUi3zu6DensGN4CHL9n9qyPaor8401SquMDUgUHbbeSKRf0SI
	MYvrTA2SxzjONeuFgqwYUxO35ZVPHYluR4r2dd7Hltba8DU4wE=
X-Received: by 2002:a17:902:d492:b0:2ca:5970:732d with SMTP id d9443c01a7336-2d0340d9998mr1527565ad.41.1785353412042;
        Wed, 29 Jul 2026 12:30:12 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:47::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d022bc9fe9sm15534575ad.51.2026.07.29.12.30.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 12:30:09 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: Christian Brauner <brauner@kernel.org>,
	hch@lst.de,
	"Darrick J . Wong" <djwong@kernel.org>,
	linux-fsdevel@vger.kernel.org
Cc: changfengnan@bytedance.com,
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
	linux-xfs@vger.kernel.org
Subject: [PATCH v5 10/22] ext4: convert iomap ops to ->iomap_next()
Date: Wed, 29 Jul 2026 12:27:25 -0700
Message-ID: <20260729192737.3190206-11-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260729192737.3190206-1-joannelkoong@gmail.com>
References: <20260729192737.3190206-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert ext4 iomap_ops to the new ->iomap_next() callback. Each callback is
generated with the DEFINE_IOMAP_ITER_NEXT() macro, which wraps the
iomap_iter_next() helper to finish the previous mapping if needed and
produce the next one. No functional changes are intended.

Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: Baokun Li <libaokun@linux.alibaba.com>
Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 fs/ext4/extents.c | 4 +++-
 fs/ext4/inode.c   | 8 ++++++--
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index 91c97af64b31..15972410d460 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -5171,8 +5171,10 @@ static int ext4_iomap_xattr_begin(struct inode *inode, loff_t offset,
 	return error;
 }
 
+static DEFINE_IOMAP_ITER_NEXT(ext4_iomap_xattr_next, ext4_iomap_xattr_begin);
+
 static const struct iomap_ops ext4_iomap_xattr_ops = {
-	.iomap_begin		= ext4_iomap_xattr_begin,
+	.iomap_next		= ext4_iomap_xattr_next,
 };
 
 static int ext4_fiemap_check_ranges(struct inode *inode, u64 start, u64 *len)
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index b48c54f3312b..bf9755b541be 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -3850,8 +3850,10 @@ int ext4_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
 	return 0;
 }
 
+static DEFINE_IOMAP_ITER_NEXT(ext4_iomap_next, ext4_iomap_begin);
+
 const struct iomap_ops ext4_iomap_ops = {
-	.iomap_begin		= ext4_iomap_begin,
+	.iomap_next		= ext4_iomap_next,
 };
 
 static int ext4_iomap_begin_report(struct inode *inode, loff_t offset,
@@ -3905,8 +3907,10 @@ static int ext4_iomap_begin_report(struct inode *inode, loff_t offset,
 	return 0;
 }
 
+static DEFINE_IOMAP_ITER_NEXT(ext4_iomap_next_report, ext4_iomap_begin_report);
+
 const struct iomap_ops ext4_iomap_report_ops = {
-	.iomap_begin = ext4_iomap_begin_report,
+	.iomap_next = ext4_iomap_next_report,
 };
 
 /*
-- 
2.52.0

