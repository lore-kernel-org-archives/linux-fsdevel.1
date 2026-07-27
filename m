Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B24E4322F8
	for <linux-fsdevel@vger.kernel.org>; Mon, 27 Jul 2026 21:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785187507; cv=none; b=gZgdzS+MXu8gJ1nIwAqvrx1lL0f6Y226/ZTsXOexXE8P/mOLMJlrV7zO2ykSlnYWuTwE4SdHzrfMMJlx9xqPsM4u9H3doO3C4oS8Qr0p0J09/4l0JG9H6lt4AVveDvlun9guuOTyprzUuyoQnZAjs9RcttrzBKGO+h2iZGXdO38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785187507; c=relaxed/simple;
	bh=RAVvjWU3PzVBWv16Hd4Tai94P9Dy53r30XLsHoi9Bgg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r/LENDXkEu7/yyL1uBfvnvfU6uk9G8SNej+fd4AEEpPfB+utyoWSDdBZGMExeVlwvByFIhBebrRsDXFa+q/N26qKGwu+TMbUUY3H1IZEr3F/s7TEYkqFhHsoG9vPfqjFZMt1rRkRdO+tt7lMoGmzK4cPxwCO4xYu579InNoAy7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TJ9m9qtA; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TJ9m9qtA"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2ced3386430so32854455ad.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Jul 2026 14:25:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785187506; x=1785792306; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9/In/JZMweca3q+77p/P5Cn2PY2lsATSfApR3PJ3ALQ=;
        b=TJ9m9qtAVWvlQZ3bfDpWjyKN2ifrelWkPwJZQehG3Qm8ejoMPM3BedESYsigNL37iT
         kGLf4XYvRo4oZtxuaqQy7MPbHHoBKrOBH8twVdkv+KXEZgtWTuSug2OwFepDXYPjfB0d
         ZhQ5sYgfCGpNCChfvefhmo2zmP9T5ia3jEfofWS1eB/BbAoqGKFZyOPe8pElsM24bRpY
         Bwi4/WhzQCHWLk8rnsuxLQ9hD3ehIx0uNQgfbDrH2xljaQAGQwXgmEnepPW60NERRt94
         agr425+ecpnzzAEYaKzNJRjAlL4Rh24bbDonbbCXW2Uxzh7dL/H/OAwoGzpeNpVixsJ/
         +vgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785187506; x=1785792306;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=9/In/JZMweca3q+77p/P5Cn2PY2lsATSfApR3PJ3ALQ=;
        b=FRnvvRKMpUHd8r2rvgw/+EzvR5TripJRFj7/htO/so2XALjetFwtglQ8fzt5anq2pe
         WH8xycAlDp1Pt2E+KJG0t1i/dhDEyQGzcnDclL86v65btgAs2cJczJQvLUBonyl2+o6U
         2dXgU6qP3C2x56koV4+Z8gPXTaGjxe6F2WEAWIJfPt9BtfLMrCa9IU9XWn5MruMtYGL+
         rRnMtd/XNXsTtMd7CR4+5mmMVHuZhuCqHUA9cBKL8GHCWhjulcNXU9exEemTqZ5A5B4o
         aV5kQQf+/bnSfnzLdc9ItEwjnVjyQLgCa//wmgUijSkUlUw4iUeemYbEURyLpgA3KnMW
         W7Bg==
X-Forwarded-Encrypted: i=1; AHgh+RqM9aZE2TUAdV15bBlhTRro4Zt30O/4HevnI/Nc1T4hYbupA+BxH26Z/sAHjRVAb5Dpngr/HSh16l5WN9IP@vger.kernel.org
X-Gm-Message-State: AOJu0YwfeYE1Hyv25qNHYEwZkeW7V6HTouXTXF0f+34yZVSNdarpDVVY
	fkCZfu1/nvxNWqZ/lPpK7BXEfOmeNrazyjUg9gGPUFnuS3Fq4Ws329Dn
X-Gm-Gg: AR+sD11Is6q7xBfsMEeMYjY8GAv+MFyG6lLCJEHm8oAmOaH2dvYPIxVZmMHMRmhaXDJ
	c9uJq3UNvyPGzRBudxFVuOO6G5vSp+P4JVwEqNObFha25UQYZyGPPwauOkEh8rx1Nj7YgmOWWr3
	nPytnumsDI3u3WeErEd4HkyzPHgEwlvetPxnvIcK6Gf1bjC9MFDTTIwGkiYFK1jcAlH1uXJzyiA
	S1lSUyD/nrYLg0HLtc9TtSJlYn5BKC+KM7tclQb9OmvBOCK+PbqXxMEO70NGOEpmZobyIH4eU+j
	2i14jJymxcxLBVApcEDTbXk9yAs3A1bj9S+axSWnSIDQDgcdBTNMq1WAU/ZvBqWG8tiDCVQwo7J
	mRGp4p8iz6GZ0WhV751tf34PPsXaj/Dtn7+rOlJHMvSanqqdP/MHWnIRf4BTsJ4Op0GmjRkjHzC
	WerLMXopdEW6MDlyD4XgcDVlr7GQwdwj+246pcNPCHtbSO2kVkrcmCSA==
X-Received: by 2002:a17:903:2ec8:b0:2c9:c46b:1286 with SMTP id d9443c01a7336-2cfde86f7bdmr86035985ad.34.1785187505979;
        Mon, 27 Jul 2026 14:25:05 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:4f::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cfde7bbdb7sm40703835ad.38.2026.07.27.14.25.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 14:25:04 -0700 (PDT)
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
	tytso@mit.edu,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Andreas Gruenbacher <agruenba@redhat.com>,
	Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>,
	Hyunchul Lee <hyc.lee@gmail.com>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	Carlos Maiolino <cem@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>,
	libaokun@linux.alibaba.com,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org
Subject: [PATCH v4 18/21] exfat: convert iomap ops to ->iomap_next()
Date: Mon, 27 Jul 2026 14:17:55 -0700
Message-ID: <20260727211758.1116539-19-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260727211758.1116539-1-joannelkoong@gmail.com>
References: <20260727211758.1116539-1-joannelkoong@gmail.com>
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

