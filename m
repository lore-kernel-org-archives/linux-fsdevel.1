Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.224.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793138318;
	b=NR0REceioSY5K0Dj47Ezv0JRiI4vTzz6j+1ogboDH7kCFvcKLvLTKEk1NZvcv/363xYK
	 tqNa4QPxb8VNOJ9vUkzNksDhkCLVGKe7FeVee6hN09PFSt3CnXy7jOCrnAOoghzf0hV5n
	 0P7M46sk5Zg7kwS3sCvOr9Hofmpjw6oPbV+mCgEqHx3RxP2YLYQQBvP6X20euz+BbpPtX
	 Mf46PM+7TcLWy2+xZIlnZ48cz2Nng/bVvL1WFFIx9LdZYWmxfnR3MtbKQ5z7Jgd68n91T
	 okLBG6005lyWULft705iyGMWF+jV4W3hAurWSGugB4/sl9IMbMrGOTNob4HUohYVnSQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793138318;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=iqfPoWTkUvjEoiyLTnmr5mj5KovsR6sHRhbPRdxo4UA=;
	b=JeXgK6XiOMksraLV+QMvRDKGkDlVNv+/DwaZXW4TBYQgt48zwVv/2nuYKUSqKYfp7QIz
	 2UsWcfo+mz7z4PZmAhSF8hQk1/nxiiH6tOv9+2ARM4EOUwBYa+h2oh2obO5aEm4cQHWpT
	 QjdsVxcnMbNjhJwF5uF0MP2xo9FaK2uDmBpTwneXdZ/ALS9tLJZBdwEwADW/rspDPtwgn
	 3J+GmFYI6M5DpljMlaGDgG2gwSdfx9FTgYUBK3Py2L9dQ7qno919d9ka5WLSVWKEwuByZ
	 dcUjnEkWshV0JdE+6OXyKeUCPqygloEq4nnRHLYLhNLeQblTM1JPjlI91fwcqzqZlKg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hHefbI+9;
	arc=none smtp.remote-ip=74.125.224.45
Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 452FD606A325
	for <linux-fsdevel@vger.kernel.org>; Tue, 27 Oct 2026 21:58:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 452FD606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hHefbI+9
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-679aeeddc6bso412350d50.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Oct 2026 14:58:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793138317; x=1793743117; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iqfPoWTkUvjEoiyLTnmr5mj5KovsR6sHRhbPRdxo4UA=;
        b=hHefbI+948nzC9V3ObgOm7xqIlu0T2MEDj0gG6avl8Xb2kbhf6Z/cbqoyxSTnA73BW
         CDF5OTDEdklbOqujS6eVhxL5dGvh/C6tEqLgDMTWvMNYjG/xe9C8VnbQomQrlEVPuJFG
         m+SVQ/r0R6uk3NynScu0b7mMuf29mIgeofx6m0l3z2mL0kRhgjYRJbMWyYYrRrbZUIG4
         AG1hLaUcgUGyfeP1pEu8FX4TgOHzM5iAwdAKt4hZbNHbOhfpISpbqGywIGZjvg1dRFdo
         GgL5HVvBjS2vRht/e+neQcTE4BQOXDlg/uGmJh01kZlWUbRinQzJknNHTTrFiU4vjNMu
         iDIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793138317; x=1793743117;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=iqfPoWTkUvjEoiyLTnmr5mj5KovsR6sHRhbPRdxo4UA=;
        b=nvMaWHHIIafH6AgdJ2aJ9nJKRXgfGyb+okcdy+oFtaOxhIjxOCAM9xECYISeXy1GEp
         jFMdh+fwL9Lra5olb0gxXKFfPqQtQoOyAlwbLmzczrW9Munu4HZV5QNU5mBfgaiVQYge
         AvvAbV1XlVl9giYg0m2632L0V89a3/tAF1DwIjGiUPN4AKH5noxzXtdRPR3WK3zz7zKs
         sYL3+Yw8+CRfzRZa876l/vcyZ+r20tkc8MaLB2V1tRPrBfllLKgs9dKIFPR607JzhI8O
         mqBaVGqI7ztKFJTgcIsE3+Nwrb+LFf9O1nXHVYjX1F18cfoIVSdsssb4nbDH2l4fI6Zi
         5dTQ==
X-Gm-Message-State: AFq9FYKbtvEgvotRt7U+hiiHIC23CRblamLOh2FnNNgk2ew1pPJO91re
	tWWZ146EhfYDiTiYIq+Xzi/e7on7b+ajDXR9I6aiVJC0OncQ7RoXWcwo
X-Gm-Gg: AYBFou0ADHpKkXv7wv0A4HqHq13aXujKkwLKI0u7+Zsls0Kgd9gj+/YXwohpx1Mv8EY
	NAdTbDaAKJh5rYxuzaO8NZQYmD57vo4eu4vSMnf6czBejWq0q6mNKJoAT1U2A5ugEVMJzxVE4ei
	gPaByYjeF57+7Bi3WUUIjb9ZzBC1eaZwj5oLhVp2EGnM8g4MwlYq2HJxUYWlb2RIBZMHHXQgNsL
	XYffGvN94SQk1EC0t9gQbtPrQgVg7ABsaQVFTZ+gdJEZ2yJdFkys41nuYkq0vaURIKlO4+Y1RLx
	OryvIQbIGkkRqv/HtOrkRVrczSkm9klsxE9TNeaLT17B3CMLvIuEWk7O98Um1H+xD/Lr708J8gd
	ufJeDE6zLIsQCHNvgcsn1QkyJYoDbsRiniEMycgbNu9fS26mgmo/0KkL3MWMUeF2wKulf7a2ynK
	7ZwGrB5HP4gBqM8aoWszyEs7pgNSSbjahAeNjlQVl3uSXWcn4p9reSRxqZigp8vXD8uVjSX5h/q
	KAeuf/4zkDWxsRC2m1BOabgJCqDyxKYY9saKjxAS1sluj3gfOLvmFX96bWhFgvKDJ58OCRyRiGk
	+DghktFuX9l92D4y9OzalfSz7hKwwho6
X-Received: by 2002:a05:690c:a418:20b0:8b1:691f:ab4d with SMTP id 00721157ae682-8b1b5ba3a5emr1705147b3.35.1793138317281;
        Tue, 27 Oct 2026 14:58:37 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:4e::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b19e43e1d2sm18903937b3.5.2026.10.27.14.58.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 14:58:36 -0700 (PDT)
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
Subject: [PATCH 2/5] fuse: convert ext_map iomap ops to ->iomap_next()
Date: Tue, 27 Oct 2026 14:53:23 -0700
Message-ID: <20261027215326.2693300-3-joannelkoong@gmail.com>
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

Convert the fuse ext_map iomap_ops to the new ->iomap_next() callback.
The callback is generated with the DEFINE_IOMAP_ITER_NEXT() macro, which
wraps the iomap_iter_next() helper to finish the previous mapping if
needed and produce the next one. No functional changes are intended.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 fs/fuse/ext_map.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/fuse/ext_map.c b/fs/fuse/ext_map.c
index 7f04edc33fe3..edb19498d496 100644
--- a/fs/fuse/ext_map.c
+++ b/fs/fuse/ext_map.c
@@ -210,8 +210,11 @@ static int fuse_ext_map_iomap_begin(struct inode *inode, loff_t offset, loff_t l
 	return 0;
 }
 
+static DEFINE_IOMAP_ITER_NEXT(fuse_ext_map_iomap_next,
+			      fuse_ext_map_iomap_begin);
+
 static const struct iomap_ops fuse_ext_map_iomap_ops = {
-	.iomap_begin		= fuse_ext_map_iomap_begin,
+	.iomap_next		= fuse_ext_map_iomap_next,
 };
 
 static vm_fault_t fuse_ext_map_huge_fault(struct vm_fault *vmf, unsigned int order)
-- 
2.52.0

