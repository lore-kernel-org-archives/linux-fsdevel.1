Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E207C309DB1;
	Fri, 20 Mar 2026 14:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774016648; cv=none; b=KjGAu59wRJKcsaGMRZpua3L/K57Tf8PmgjIdKiKWgGd8wn00CU0TRdcVbyzI9lzX4dA3+flZijBcHYuQ4W9dHtdQU5KA87ECHTkCByktE7hayzkQLuzVFuXiLpEvwcU8bZqnThDwxqkZJ9J7dY33CdYrckWxW86Ecl9wyair51Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774016648; c=relaxed/simple;
	bh=j6AV2tjQRBaWzksghm0YwfGD3Bod66+58L63y3xsTAY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ltjpJL7xNoEBmt1wxzJPs3IETGpyTb/zqbF+CzZ7DsOg7sgO9AtwHRFtJRBjZhrKcSDqh+4nCHLSzLdLvJf9/UNashCiEWLGpmRIP3N35IkPtpkspPUUw6UkQhcIxHuQfO43KRrnQv145AzkWR66S3A7bMfGKQsyrOHmsICRIJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ATt4JOWe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ATt4JOWe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CAD7C19425;
	Fri, 20 Mar 2026 14:24:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774016647;
	bh=j6AV2tjQRBaWzksghm0YwfGD3Bod66+58L63y3xsTAY=;
	h=From:To:Cc:Subject:Date:From;
	b=ATt4JOWe7bKn9k30jEVGrI9snhjrEAGj9NgApJDyr8BIW//R7Z+73zb5JToSFGAoR
	 uIulR8i4HdYyYnXFDmyEXGv/UpOxB2uY1I35HRXROY6bjQXu59cqGing6jEOaTMPh2
	 AoppKdtIbRM1ME/Jv6uQdBkxora8aIOKS5Nv5kfI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Bae Yeonju <iwasbaeyz@gmail.com>,
	stable <stable@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Russell King <rmk+kernel@armlinux.org.uk>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH] adfs: validate nzones in adfs_read_map()
Date: Fri, 20 Mar 2026 15:23:56 +0100
Message-ID: <2026032055-abstain-ending-6acc@gregkh>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1582; i=gregkh@linuxfoundation.org; h=from:subject:message-id; bh=qGSDIElMfC7mKC1BG0HUXAAUovLZS7+kf/FajiN7QIQ=; b=owGbwMvMwCRo6H6F97bub03G02pJDJl7I6qbOlc/3Pn2c8OjBcEX9thu9q/STc/3416woGC1f NWOK19cOmJZGASZGGTFFFm+bOM5ur/ikKKXoe1pmDmsTCBDGLg4BWAiS8IY5selGwef/WF+c9XD w12tCv//rGu9uoxhvrPox1W5b+Ry9s1f5yp4qjuo9OasFgA=
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit

From: Bae Yeonju <iwasbaeyz@gmail.com>

adfs_read_map() reads the zone count from the on-disk disc record
without validation:

  nzones = dr->nzones | dr->nzones_high << 8;

When nzones is 0, the subsequent kmalloc_array(0, ...) returns
ZERO_SIZE_PTR (0x10), and adfs_map_layout() writes to dm[-1],
causing an out-of-bounds write before the allocated buffer.

This can be triggered by mounting a crafted ADFS filesystem image
with nzones set to 0 in the disc record. It leads to kernel heap
corruption and a NULL pointer dereference during mount.

Add a check to reject disc records with nzones == 0 before the
allocation.

Found by syzkaller.

Fixes: f6f14a0d71b0 ("fs/adfs: map: move map-specific sb initialisation to map.c")
Cc: stable <stable@kernel.org>
Cc: Kees Cook <kees@kernel.org>
Cc: Bae Yeonju <iwasbaeyz@gmail.com>
Cc: Russell King <rmk+kernel@armlinux.org.uk>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Bae Yeonju <iwasbaeyz@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/adfs/map.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/adfs/map.c b/fs/adfs/map.c
index 9d535a2ca2d1..5d671e7b4663 100644
--- a/fs/adfs/map.c
+++ b/fs/adfs/map.c
@@ -361,6 +361,10 @@ struct adfs_discmap *adfs_read_map(struct super_block *sb, struct adfs_discrecor
 	int ret;
 
 	nzones    = dr->nzones | dr->nzones_high << 8;
+	if (nzones == 0) {
+		adfs_error(sb, "invalid zone count");
+		return ERR_PTR(-EINVAL);
+	}
 	zone_size = (8 << dr->log2secsize) - le16_to_cpu(dr->zone_spare);
 
 	asb->s_idlen = dr->idlen;
-- 
2.53.0

