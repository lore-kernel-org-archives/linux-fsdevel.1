Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFC794854F6
	for <linux-fsdevel@vger.kernel.org>; Wed, 29 Jul 2026 19:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785353435; cv=none; b=ljgvuXKJILdn+Y2HtWkzmZRlVcDjyZNd+SMmURs+PWNi6HeFYepcjm/i4/iTLYIV4KhCukJH1CeZ3nWZqal6sNIsmScntT+TzuRhjmL5aXG46w+wPb0E3WGmEkL/FRfkbOmpTbjmNzq30teSJTLNp/VpIUZG3UMsgIHCG38qgZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785353435; c=relaxed/simple;
	bh=HHxOrJYOsxXujbtNOZYiKxqT98cJWgSli6XX9Kw9VZk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sgsmtIjzajUw3bBdIdxlP8c2kjdPTYnIcA2H1KllSNIzRfYriNhnlBa7U3vggGoZnEiu90eOXcsJDeGxtst6EaHlPPew09O7xjJmN/ipLTn7cysGrX2UyUb8pzWXnI2wbumBF/nz73GzniUMqmrCFCdruBOE8cgotOuiFX1wA3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S0fdQQKh; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S0fdQQKh"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-38dc4553f62so1364698a91.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Jul 2026 12:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785353428; x=1785958228; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=t0Y5kYgnq47GiPzAl5xZ9gQOM4CGwKa3ZKYndZjd3EM=;
        b=S0fdQQKhubEJVvtcP6mSjEz2uh7/SlOOBBMzv+9LFfzzs3rK0XYemHPoSjM+ijVCt7
         WlgeYotHsvR9kqAuJ00qCPDTYeHQ1IHxuX1A2CJxRp+NcwmZx3NayL9c2LY5b2CDp6Nu
         GKZNPH+l3w4gl0wG52+LP7opcMvgh4yKDoNCz/G62ViK0lZCiCyZcpVdtDqYadpP5S/v
         D7GrFYZhbXkUuSrBdKpiXVjQgRKYgO8eBQBelikL58EbNUu6mQTCccApExkwT+ZAcki6
         J8s0NeyqRpzdbsqmMfWJT2Gs5LmNRn4hHG9U5N5VuOe8Sgx+viBZdnNcaEMOCmHsgKza
         gBmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785353428; x=1785958228;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=t0Y5kYgnq47GiPzAl5xZ9gQOM4CGwKa3ZKYndZjd3EM=;
        b=KlW1r1QZLgTX9W6b6aY0DL4Xkn5e6geYm2WUcfIH/rGcowj2pS5JgNlnbQKiv5o+TL
         IEKenFYJaq2Scfeba/Jaf0g/6JeXVzJ3OmPt47t8prbkJnbKrxBkg5z8BzhLNyKCNPMr
         6Ed3cI7dmdTOguMlGC9NLP3/D5S2y7UhVOYwwNJBjWou2wF/lxjacZnTu+BWgrO67WuA
         xXVrtSFdqFZAkrYNaURIt6UJv1Xvb5a6iSIuAVE+0l3LSBHzzG8j1CxvcaqGTJRMx9xE
         fXb3VU0ylbJ+ScW29SRqcaHf/SqWn7uYbRCbxeizRwP/KmM4RFt95xc2kzCcD3iPmTkO
         v+3w==
X-Forwarded-Encrypted: i=1; AHgh+Rrc2CRV3jtbLh4uDIKbm+QbSoVPLtKYfMvhGpfT+c7zAPUMt8KxL41tAD4b/8MkR0AP4MuLBJHgG/1O72zw@vger.kernel.org
X-Gm-Message-State: AOJu0YzNYPDuHcCerBwp7O85duuaVgQe7jaS71HkVOT0Y0WnbzPwhLdW
	dITWi6enVtQ3CTVEUFITHcbHS2+mt7o8t+G0TWYwHS2tz7XFpHieeYJ0
X-Gm-Gg: AR+sD10XiIkfYTsQVtGuvHZ0SUm/44XrLMP9ShKwnS5cFiTM5Muzl6OdCTjGBZJp8cX
	RPYetzmyI+XP23fPZpaRFTZgSEPfowss5ytVjzMMeNrhQTHD5pVIovp3A4kvVx82oAlon7ps+vO
	oVnbkvUBiwUigImoUAau4Gd29Hy0LkhYNUVJCOB2/1ElQbuXrDHnS+lmKirOtCjPBMPeuhpuHJg
	yO6YmmPmGxsQ6XD1Dn7kCYuX44N7R+rEB7CIziOeduXMld3dHRw4TsKi/0AU0WkkHE93wcIvzJv
	1XCZRCP48tFQr7ZL8ePLNyPxLg1vpWg37vLnsSZ8D5vUYv4OfBHL9yqPw7LYsFWQZ/JTrsZfCxe
	7m+Wzkpyx1x0p5KG4/nLje/iR7M+15XjnOi7vAQmYdz+plKgYpU62dQ/5MpzF++V7nV1dMKcC9+
	O/7+D/xEhltPvrCez5+bU5vvJhEeA4C37rr2XtuEBXOcscnKlnKNcuMiGaVZVWeS+Pl7VCs3Z0N
	/mNqovBhG2/Ru648Z6NdX5Ltnxu+PI/hTbzZhxnDrHX7FrriHQ=
X-Received: by 2002:a17:90b:3d84:b0:38e:1497:af5b with SMTP id 98e67ed59e1d1-38f98eff6fbmr167757a91.1.1785353427774;
        Wed, 29 Jul 2026 12:30:27 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:45::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38f7f1353fdsm1829513a91.8.2026.07.29.12.30.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 12:30:27 -0700 (PDT)
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
Subject: [PATCH v5 16/22] gfs2: convert iomap ops to ->iomap_next()
Date: Wed, 29 Jul 2026 12:27:31 -0700
Message-ID: <20260729192737.3190206-17-joannelkoong@gmail.com>
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

Convert gfs2 iomap_ops to the new ->iomap_next() callback. The callback is
generated with the DEFINE_IOMAP_ITER_NEXT_END() macro, which wraps the
iomap_iter_next() helper to finish the previous mapping if needed and
produce the next one. No functional changes are intended.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 fs/gfs2/bmap.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/gfs2/bmap.c b/fs/gfs2/bmap.c
index 51ac1fd44f78..73c626971163 100644
--- a/fs/gfs2/bmap.c
+++ b/fs/gfs2/bmap.c
@@ -1200,9 +1200,11 @@ static int gfs2_iomap_end(struct inode *inode, loff_t pos, loff_t length,
 	return 0;
 }
 
+static DEFINE_IOMAP_ITER_NEXT_END(gfs2_iomap_next, gfs2_iomap_begin,
+				  gfs2_iomap_end);
+
 const struct iomap_ops gfs2_iomap_ops = {
-	.iomap_begin = gfs2_iomap_begin,
-	.iomap_end = gfs2_iomap_end,
+	.iomap_next = gfs2_iomap_next,
 };
 
 /**
-- 
2.52.0

