Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FA0B3D47CF
	for <linux-fsdevel@vger.kernel.org>; Sat,  1 Aug 2026 22:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785621700; cv=none; b=O9cfS329FeSkVUX/jpdHRcAlSf/WoctTEluqSQXHN2Z2nKmk4uvCZBcp1rN8/ensbfh0TT2jZ4uk2RfrlBJAT6MpiIGMyHPTRD8fX66laWFxyZP8buQKLH0JzECDo3LyQIEwkYmNKVA4a7DmOSqwYlHqYoXCyYoyxGBqlRg+GNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785621700; c=relaxed/simple;
	bh=2bZmsqZVVuc9CfGIc+LM2Z9Btw3Dvkpcm1xyNQyplYM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kfbKE3fgFqpvPg7BMJ6MX+2DTrt5uPPm1Tyv5uKWTlyu5cekVvKQtG2wgtYKNbMrN+iov+N7aZhRnU7erkKApBHpFFiDFJPuHCyybTf8+clxPq4ecWlZ4c4vdhS+cy/JoKZFheuGtvNBWw2tPcZS2tixR1FoGWX7+Y6cKsqEAVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z30IZIRH; arc=none smtp.client-ip=74.125.224.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z30IZIRH"
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-66893db7bccso3301630d50.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 01 Aug 2026 15:01:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785621695; x=1786226495; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qElo3yzh2qeHSY0scU/mBgdij9EIQBJHv2xpttY7cac=;
        b=Z30IZIRHurAGIj7N3745zgHKTG2pjmnNThmE9dNSZgam264BfRNFCm7OYh87fRHyIx
         w7z65QEIc5oZHERQx3nPRecefmfeZv6X+LT51z7X5iN1CXuiK8Yu0DmBkjPj42xHVwek
         16Dfn4TKb1zsRMtDhFtBI203IfG8XUIy7F3M4kfTsXj8SenMb5E4zduiu8q7B1QgJRj0
         KKvVklr1phauf9ope16nR8CqD6Ad27r6g5ufuKI7O1N075IewPYRbLVSQ3Tn3yv7lSd1
         Bf87nG9xO4cCBJLUm8Qeya8fHtVPuwz97Qw9PD0figQ5iHfxai/ZUuEDJ5CD5Hthtv3d
         HXNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785621695; x=1786226495;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=qElo3yzh2qeHSY0scU/mBgdij9EIQBJHv2xpttY7cac=;
        b=jkmkReGNXnbotzQzH3/ENnW45E2idspjnoAf0iWYiNPbPnIg8Pp12GnxPzhdKkhErT
         i7hTczIe7GngJm9KOF5hXddbxMs4IDqzA2Ez+YWiHI/aC9h8grcENgec0QdC93xvk4Ol
         DGs7sDdKIHT3jEH4IpWri/8Esb1+6WJ/XLa5vjQAQWanR/yn3n0ZAib+f7QCuc+DFyvp
         pKlGpqRQxd8Z7nOLhLIeRat7UtcJrcEb8wefbQkxJJwxXPMj6FnUWw+4SSZkIWR5f4Yg
         UYZabLIdeMHFVBExF+IVDs0gXi5LS500jUV90knWHEulEmsc52sDfwcD0ov/8hYh2pNu
         kWBQ==
X-Forwarded-Encrypted: i=1; AHgh+RqIxOSzvQL9Y/FYWnNyy/SmiCoLlo9+VPjyx1Tlj6hgACj+1ZH50iWilU3aKhGbPKX743wCZCKIpnjbc/rO@vger.kernel.org
X-Gm-Message-State: AOJu0YwRjYIgVDYq0VVnDYvNRJxvyzDf/f2NPEIbcJIvVOzJwhZLj4MO
	1QFgfYm7xL/DfIwemtoNiD9vnoXdPN7iCly++lbB7PljcbCRLueOx4Cf
X-Gm-Gg: AR+sD13plU2Q6q3Sj11ZtIRh03/Q3XkXjY86VOB6dr7/uPbFm2ThbUk/mAy3yUUb1IU
	eRu2P8E0MlGm0S4/5hRnepp/62mufSaErN/g1k5zprAzgQp32Px9NYbQTV6ICJtde7C+NLhSS51
	clNN49L5p06BqI3Z39ZcYSnIX8lDP4aUK3TMRUL1BZVkXhyywdcCGpvM4YtotkIPm4opKZ8cYlo
	pXCL7dXY89m+pQY89bl1a2hAbqrOoTTt+eKiaYwPmzN37sYnILdF22mtcG03j1Y+SXLgGMIcBBW
	9VSnWHqxcGqPGlaCXsZLhogQo9shoShKey1JdIFVth/azlFFmhvudWVoALP+ZQvufGuoSVvq4kZ
	16gTRRCDMaO/WaY5SzI04/TocJsnyvTdOhQlPzv7Kn8U+hvvIFRo5wBpwbhezabhl//+F7d7rxP
	QwzpoI99J+RzYup+gODlJKo/7DClwJdGTSHuWcdP5nRbWAxcaWkHkZEM5F7CvtEk00CvPAYZNEK
	2BSXZg=
X-Received: by 2002:a05:690c:9981:b0:81e:a471:e8b0 with SMTP id 00721157ae682-81fd4b3e2d0mr70199667b3.21.1785621695043;
        Sat, 01 Aug 2026 15:01:35 -0700 (PDT)
Received: from syssplab.cs.fiu.edu (nat1.cs.fiu.edu. [131.94.134.89])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81fcd0d6fbbsm29903767b3.25.2026.08.01.15.01.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Aug 2026 15:01:33 -0700 (PDT)
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
	linux-karma-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Chao Shi <coshi036@gmail.com>
Subject: [PATCH 17/19] jbd2: assert on a failed write, not on a buffer that is not up to date
Date: Sat,  1 Aug 2026 18:01:01 -0400
Message-ID: <8aa2ee674d147d3630f73f7b53fef7781f2aeccc.1785621505.git.coshi036@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1785621505.git.coshi036@gmail.com>
References: <cover.1785621505.git.coshi036@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

jbd2_freeze_jh_data() asserts that the buffer it is about to copy out is up
to date.  Once this series stops clearing BH_Uptodate on write error, that
assertion stops firing for the case it was written for, because a buffer
whose write failed stays up to date - which is the point: the in-memory
copy being frozen is still the data the filesystem wants written.

Assert on the condition that still means something went wrong.  The message
loses its "Possible", because BH_Write_EIO is not a guess.

Suggested-by: Jan Kara <jack@suse.cz>
Signed-off-by: Chao Shi <coshi036@gmail.com>
---
 fs/jbd2/transaction.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/jbd2/transaction.c b/fs/jbd2/transaction.c
index 5cc7d097b2ac..fdabe34a7e22 100644
--- a/fs/jbd2/transaction.c
+++ b/fs/jbd2/transaction.c
@@ -920,7 +920,7 @@ static void jbd2_freeze_jh_data(struct journal_head *jh)
 	char *source;
 	struct buffer_head *bh = jh2bh(jh);
 
-	J_EXPECT_JH(jh, buffer_uptodate(bh), "Possible IO failure.\n");
+	J_EXPECT_JH(jh, !buffer_write_io_error(bh), "IO failure.\n");
 	source = kmap_local_folio(bh->b_folio, bh_offset(bh));
 	/* Fire data frozen trigger just before we copy the data */
 	jbd2_buffer_frozen_trigger(jh, source, jh->b_triggers);
-- 
2.43.0

