Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12DBC3BED2B
	for <linux-fsdevel@vger.kernel.org>; Mon, 20 Jul 2026 21:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784581359; cv=none; b=l5yu3BTMmZb7/63AtBygaAtDcpwbf3aURLf9MHLrtKbr4EwxoACQyhU4LOV9xJEeHN9E04wbevDVLIAVECnYvzvTW/ejt0yVEqb8m2AoddZr8vSrbpYZ6yANMiAAae5xvWIu2soQZy4Z8G6NxDl10YOhnZ1a5GzTx+d6zUGRRhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784581359; c=relaxed/simple;
	bh=w2uyXhe3wHauQqy5zzSBECi77hYH5LSW5JAF4myOtyQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HKGHZjRzyqikNl0e1kbZ7kOTRKHAk6MyGDicl3iG210evqb5uXyE/E+sIgQpdOgvcrm+qtHzFS4wbSQfefI6gVc+69dD86FF6KJxhxyCKbeUJaqjbX1TaaetwwwiWt7EzgEr4IT7VtWI1JhjD3VCruKV7fJEkbdeBeCygYmC9hU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lIN1EmcC; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lIN1EmcC"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2cf52d15d88so21426185ad.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Jul 2026 14:02:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784581357; x=1785186157; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tqh+cX8DtGUhcUH0ULHRWawdJlOCfO839uBeuSzHkI4=;
        b=lIN1EmcCNm0FZR8gNrIGfYQx3hvhPewGrdbg5jGmioBV91/gaLRgQG6rNspgHw+t8z
         H22i+x+fcwcwkPpdWRz1EIlw94LoFWpGT23y6385zD7dqEzLuCJVooREmdbpwPJMDb2f
         M/t8utqRbBlThyG3BKgYRgor6KMZtCvvzLXZ8/vRwRUbMiHOgO38iHxtkLe03sK6DkoK
         sQ78Iz+c0jHYGmgsVw0CNaewsM/DMPgXmhHrdKwB627sVRYYcxhiD1hLHgRVnAzz2GEV
         4Y/KqRw6Z1avu9sdnH3PT4457h+oUEgXB+Nb6XNGqiXASAaGLw8IkqFY83nGaNQL4XQh
         OGGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784581357; x=1785186157;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=tqh+cX8DtGUhcUH0ULHRWawdJlOCfO839uBeuSzHkI4=;
        b=oQWwDytm8rm+CTNuxSAFz3BIyu2IpXcN5GrN9ao2MlVgsEgR3uYkr3GOqIQSNuo0GF
         akNH+i3VFhmMIhft0T643gIcLFEu3DnBCq7BgbtLM2KC1hjsaPJ2dMQmiPvap7Xvb0xy
         utMjEP3GzJa6bVUE/M0FH9Pkg5VrB5rIb/udZsJ2gb9QKlhBQSzpDJJrNHHXguTcO7lW
         m/50sjOcVlyfTsAaACAgIAuavPgVFhVWCfbDQ7gA+qWI/MN56MH4AHSbgSNWhd0/YnGI
         bfZzs5NnJh0QJdau53iwEtG7vNU8saNrG7PkzRSoI1jw5P/rxpTKnz2WkUCjGuhHwJB4
         LQHg==
X-Forwarded-Encrypted: i=1; AHgh+Rrm167yjEAYsPPDYvnWDoJst0aAWqvkh5ZOEvP2OzTt/YYF6uS7xxdL+MF7w/b3X3o7MAyLYgNBIYIPNX9x@vger.kernel.org
X-Gm-Message-State: AOJu0YxH8VnENfgRVEF2WCZ+/fbwPoDDL0QJDyrc1DNSvNqnu7tUQkoY
	m9dIuyY+2CXgUxpPJKkerTFGryS/L4BWwD9o4chFFFmDNL/plYlzJwty
X-Gm-Gg: AR+sD13hfKXRrTXg5xxv1pzXmhFodBWAu5kq/tuJvUlT1RE1qpNcCFubAZ4+0DvMesM
	ga2UyG12IrO/twRoXAZlAhVGXNFnxbqGTvZb3i1u9gfVSTmChaf4mn88eADwhvWCCLT1UW2SuDn
	x0Q2/OoBf5Za0NTLeroqHZ5moGNqGRC0fGDuFg7ulJkARmkOrbTvoz7Rso2fdzdtIzbvCXsIciJ
	BGsrd0NdeOQolBUfOyz9zO37O3b0cNkNAlnv6n2+zQd59iEZnT9An5AVdSljSMLjGmm0KKpL2Ro
	2NH5XeSrzb9FfthtdW5ICB6leLWLJaC7nmZV5KwUrrRLEe3oWS8B6wgVCd+cWFda4CBQdh0BqMY
	LclWIZElRbuzc3LvaGdZS5Lvsqc/+Q9vSWUZQDqImtWLYCOu0z6jwaDqbXY1dVExfTEd4PUhWxx
	1xjmVH3cmzd2uENBh1TVdHyVKxhnbD5VnmjfYsewdVvPlhKupW+Zpb
X-Received: by 2002:a17:903:198c:b0:2ca:ed57:8586 with SMTP id d9443c01a7336-2cf3496bdd3mr169726915ad.23.1784581357363;
        Mon, 20 Jul 2026 14:02:37 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:2::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf3474100fsm62794235ad.66.2026.07.20.14.02.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 14:02:36 -0700 (PDT)
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
	Dan Williams <djbw@kernel.org>,
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
	Damien Le Moal <dlemoal@kernel.org>
Subject: [PATCH v3 12/20] block: convert iomap ops to ->iomap_next()
Date: Mon, 20 Jul 2026 14:01:54 -0700
Message-ID: <20260720210202.1163861-13-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260720210202.1163861-1-joannelkoong@gmail.com>
References: <20260720210202.1163861-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert block iomap_ops to the new ->iomap_next() callback. The callback is
generated with the DEFINE_IOMAP_ITER_NEXT() macro, which wraps the
iomap_iter_next() helper to finish the previous mapping if needed and
produce the next one. No functional changes are intended.

Reviewed-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 block/fops.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/block/fops.c b/block/fops.c
index 15783a6180de..4cff76e9eb71 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -453,8 +453,10 @@ static int blkdev_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
 	return 0;
 }
 
+static DEFINE_IOMAP_ITER_NEXT(blkdev_iomap_next, blkdev_iomap_begin);
+
 static const struct iomap_ops blkdev_iomap_ops = {
-	.iomap_begin		= blkdev_iomap_begin,
+	.iomap_next		= blkdev_iomap_next,
 };
 
 #ifdef CONFIG_BUFFER_HEAD
-- 
2.52.0

