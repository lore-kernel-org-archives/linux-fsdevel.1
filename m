Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48C073CFF4C
	for <linux-fsdevel@vger.kernel.org>; Wed, 29 Jul 2026 19:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785353443; cv=none; b=ZcTrvLgYsIe24jCq965ZFRf1MCHqcRKSJox0hvs2p0WZS2TgzsU+AUjS+2SvZCTIrKgXUVm7ynBC3nLEALEovZwiP9Nlv+yxwpsFqAj8U81hMdHq/mgxUbGNWLMKouLgJGaTquzxG67grKOuaRe5Gf5rdihq26f+EDlS3yNtY/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785353443; c=relaxed/simple;
	bh=RAVvjWU3PzVBWv16Hd4Tai94P9Dy53r30XLsHoi9Bgg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k5/SUGDx4FuOlamfO9ygoUooxziSULQrJIVqg/UnXrg1ZOhloYVO807sVoDXj8B7RBv/0eby8h5hDzkG69Zo2XdyiwkfmPOnb3y1u9rALXj4cP9PYrL7zZwTfa+s5U3FSPu0gLrGNfzJ0FkWnF3zM+geZtsatbAJ6hp4vnpo1YE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HEnxdguy; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HEnxdguy"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2cc7e86e7aeso15994095ad.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Jul 2026 12:30:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785353434; x=1785958234; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9/In/JZMweca3q+77p/P5Cn2PY2lsATSfApR3PJ3ALQ=;
        b=HEnxdguynFZb+fmc8HSjbLUPKlvjv/7BKDOifbOIyfb0LSR6JopcPNPmTXQPNLCrac
         kgB7WfrMRrXHl178rVhs8aVPjt3OYYVU9W/AthyoBh5fhqo7q8DE/G4S0ulB+5I7A7WO
         bqvHjzk4E9+s9ke2YZdn5sPovtl7S7jOuPRd2DjtJXGCReMiZnmRzRMJ91gJyMW6VW0C
         WHaSgTBBtbmylKJ19Xwc8NH/bZ1DgbYOUbIP0FhO5G92eyh3Mj8rrbqU0u1Rx+q4VHk/
         /sGuuH1NO2JXxh7By5lPszaVHLDP69t4xqO58DlEgqWmO53/IUIlqribCPP/fYlaOQVI
         e3BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785353434; x=1785958234;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=9/In/JZMweca3q+77p/P5Cn2PY2lsATSfApR3PJ3ALQ=;
        b=m6Z3hekRqKnVt+hdBo2678UeGTt7SCQsLkNmEf9BTzl3TrxwGG9lPrRFUQVG3VSP6D
         466XLVONLpqCge04E9yvVCo3DLuh49paiiF5WVwKaUK/SGjlysgfB08zG4DqsS74aDa6
         0Fkf5WV2y/Cr5Mm7myy6DTm1Z0xMuvbfWcOWo22gbYj3p+kMYvEVRzUwyUAzGIeDlvCn
         GMkJCNGkPmduhm/thfFp/eBPEhJmPyfZqzkTDDmy28QzbP0YXA4Qxo6uNrYjJLjncLQ1
         L3JPpf77moo/nBv+b+YCnMCzOfvykyiokICHVdiR66T+sqfbkk8FPb0aqWfxIXlLDBF7
         Reqg==
X-Forwarded-Encrypted: i=1; AHgh+RrYlqB9qEsJwNYWAgmzS5g5yXZKa83cTa92Op8pD+d9YyF1jTWP3LUP8lZokWXEfbMQ+QATHoKH4ZNNpLiO@vger.kernel.org
X-Gm-Message-State: AOJu0YzFn8VboH6NylltqDKEobt1P3n5ABkpChBGQ8mNOzelQzRSbVvw
	K57Pe1NimeI5Iimazgz/p5xap2QrVWv/Uqt0kgR2fClpOC2rTsgzTjW4
X-Gm-Gg: AR+sD13JHlMhz40EmCMYfWKNDl4071MGr7fO3zDBBgpcIbK336IU1vL4nwHZSaDseSL
	VDbBFFXbmID4+GyEszqzpXJ3zCausL+NxqI+ZJwtLQXWDIiIuY2dXwQonYsRtD+sFOQAzjkcKUV
	OB2joEGkOeTxPDS1O/MZsRRefzEArvd39Aeo7T46CgueU4EjBwodwq6oNMIaiL9pTtdVyFdgQsU
	E5MJhimK7Dk5Fxy/jGROoW7IRgCcAzzcIV9pjhBZHHU5XAjqbieAreZoa7JkW66tVeZaTjSNxpF
	Y9L7/mZaXus/msn+xIAWVTy1oZzwsmQcBgN8eAs1GOl9/2iFlz27f+rklrwhC1Bc39v6mr/vkQ7
	8E0mWeuhRsKtSCfdiYcCVotA2JjzvihtgzhYY7wlaWpT1QDpXG2XyNqMsKGb1ivIOn59Gzp+ddW
	UlS4tKXukwpM5DHECxzut7cvpdDcLF0drCg7j5uV6ZTGkAC7NjK2+M1TARLZ/RTsd6o2//8YRp9
	lUw/gZ6XdSu0s6vdm/cLPif2Jm8Wn2BYbeueH+6aQ==
X-Received: by 2002:a17:903:3843:b0:2b2:67ca:5ff9 with SMTP id d9443c01a7336-2d0336001eemr2188245ad.0.1785353434068;
        Wed, 29 Jul 2026 12:30:34 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:53::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d022c3721esm15989085ad.77.2026.07.29.12.30.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 12:30:33 -0700 (PDT)
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
Subject: [PATCH v5 19/22] exfat: convert iomap ops to ->iomap_next()
Date: Wed, 29 Jul 2026 12:27:34 -0700
Message-ID: <20260729192737.3190206-20-joannelkoong@gmail.com>
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

Convert exfat iomap_ops to the new ->iomap_next() callback. Each
callback is generated with the DEFINE_IOMAP_ITER_NEXT() and
DEFINE_IOMAP_ITER_NEXT_END() macros, which wrap the iomap_iter_next()
helper to finish the previous mapping if needed and produce the next
one. No functional changes are intended.

Acked-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 fs/exfat/iomap.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/fs/exfat/iomap.c b/fs/exfat/iomap.c
index 1aac38e63fe6..b6dd396aa60a 100644
--- a/fs/exfat/iomap.c
+++ b/fs/exfat/iomap.c
@@ -151,8 +151,10 @@ static int exfat_write_iomap_begin(struct inode *inode, loff_t offset, loff_t le
 	return __exfat_iomap_begin(inode, offset, length, flags, iomap, true);
 }
 
+static DEFINE_IOMAP_ITER_NEXT(exfat_iomap_next, exfat_iomap_begin);
+
 const struct iomap_ops exfat_iomap_ops = {
-	.iomap_begin = exfat_iomap_begin,
+	.iomap_next = exfat_iomap_next,
 };
 
 /*
@@ -186,9 +188,11 @@ static int exfat_write_iomap_end(struct inode *inode, loff_t pos, loff_t length,
 	return written;
 }
 
+static DEFINE_IOMAP_ITER_NEXT_END(exfat_write_iomap_next,
+		exfat_write_iomap_begin, exfat_write_iomap_end);
+
 const struct iomap_ops exfat_write_iomap_ops = {
-	.iomap_begin	= exfat_write_iomap_begin,
-	.iomap_end	= exfat_write_iomap_end,
+	.iomap_next	= exfat_write_iomap_next,
 };
 
 /*
-- 
2.52.0

