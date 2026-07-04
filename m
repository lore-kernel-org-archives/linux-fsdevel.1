Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C359374E5C
	for <linux-fsdevel@vger.kernel.org>; Sat,  4 Jul 2026 16:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783183284; cv=none; b=YhCMTZ7u14y7XvvytkjU0gt+CVnFcldipBHF+jZ8txvXU/4GzZ/bhJzHSvUPnDozP200GpucgOKo74HVMf8PbUjkLKcWuBgp5ptMsBm0+11PCokBZZNvYxDTo3gdsy/tSweK4CF+9sIoc4Bs5fbNJ4LyxtGtzi5WdFM96O3QkCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783183284; c=relaxed/simple;
	bh=6TbvUjm/vKZ8SuMokqtk9ryfZjQh1Ge0Cisl9CTuAns=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bV5WLBiDNtdIahBWPGrXtXL1mBHLHLOPKSRgcjyTXLj0IkqLxNfx7NviBLPVUINgtdIvSNHegsw1ryu3EF3l7HXlZ6m9Ewe/BK55/Yt/Qxvgf5krtXdnfaJGTnKMy281+IRbfXW++60QxOdu6fIt9pGpVPggcMbVumXH6xJio34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=aq7EKR7e; arc=none smtp.client-ip=195.121.94.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="aq7EKR7e"
X-KPN-MessageId: 2c9a88c7-77c7-11f1-b2a8-005056abbe64
Received: from smtp.kpnmail.nl (unknown [10.31.155.38])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 2c9a88c7-77c7-11f1-b2a8-005056abbe64;
	Sat, 04 Jul 2026 18:41:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=mime-version:message-id:date:subject:to:from;
	bh=nUTpH0lAxQSMVbJ+SSd+bPpKLaf+crd5MTkWXk8H8io=;
	b=aq7EKR7ehCzXvP3t6BnVkQA6PAepqTFxwtGKyFspKqpc1xj95VtNfVqhaRok9gs7eQ/U8nwv59Cgf
	 3WG9x0L0Z5VtqTDZqKDdCsdHoe2EgwPmZimLdFTHhw7foP0FRoc1OUMag/1RGYXWqqju2gNH4IB6n8
	 73JmUXsHCAD4A5DrcNtvSXR8AxGzGaEENl6l1vC5aiNLiAtQHGRTBDtJZJZfUFo/b0yJoLOjnqMv9g
	 KmEL58JJJKmTrYGjBdJtF/88TYtow3DbIz98d2njCBcOrxPAd5mmFe94OI+A2S4VCBV/mcHrOFYkaG
	 cgoFk0WAFkNxj3aZoisRSmBuih9kBrg==
X-KPN-MID: 33|kU4hVqoSl560N9dvQWdeZx2j+LdjHdRDR+jDVjSZlAMGCETvH12dXCRd0LHRRjy
 7KDTsGG9OCCU20WNGkidZ+TMf3MbZA4MShk+8xleMITE=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|4Z5oBN1BTKtP3UR4AntRXlrQp2HysXuVUoyGizciTyL3x45BkeRji49qsqmILwU
 wERm8xeAPDM42pMMYNGtinA==
Received: from daedalus.home (unknown [178.230.195.42])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id 2c57c941-77c7-11f1-a998-005056abf0db;
	Sat, 04 Jul 2026 18:41:15 +0200 (CEST)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: Jeff Layton <jlayton@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Aleksa Sarai <aleksa@amutable.com>,
	NeilBrown <neil@brown.name>,
	Amir Goldstein <amir73il@gmail.com>,
	Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jori Koolstra <jkoolstra@xs4all.nl>
Subject: [PATCH v3 05/14] fs/namei.c: update docstring of atomic_open()
Date: Sat,  4 Jul 2026 18:41:39 +0200
Message-ID: <20260704164149.3480051-6-jkoolstra@xs4all.nl>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260704164149.3480051-1-jkoolstra@xs4all.nl>
References: <20260704164149.3480051-1-jkoolstra@xs4all.nl>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The docstring of atomic_open() contains several errors:
  - It does not return 0 if successful.
  - path is not updated

Fix those and be more explicit about when FMODE_OPENED and FMODE_CREATED
are set.

Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>
---
 fs/namei.c | 29 ++++++++++++++++++-----------
 1 file changed, 18 insertions(+), 11 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 956adcd14c4a..88d56a470832 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -4355,17 +4355,24 @@ static int may_o_create(struct mnt_idmap *idmap,
 }
 
 /*
- * Attempt to atomically look up, create and open a file from a negative
- * dentry.
- *
- * Returns 0 if successful.  The file will have been created and attached to
- * @file by the filesystem calling finish_open().
- *
- * If the file was looked up only or didn't need creating, FMODE_OPENED won't
- * be set.  The caller will need to perform the open themselves.  @path will
- * have been updated to point to the new dentry.  This may be negative.
- *
- * Returns an error code otherwise.
+ * atomic_open() - attempt to atomically look up, create and open a file
+ * from a negative dentry.
+ * @path:          parent directory path
+ * @dentry:        child to ->atomic_open()
+ * @open_flag:     open flags
+ * @mode:          create mode
+ * @create_error:  return value from may_o_create()
+ *
+ * If FMODE_OPENED is set, the file will have been attached to @file by the
+ * filesystem calling finish_open(). If FMODE_OPENED isn't set, the
+ * filesystem instead called finish_no_open() and the caller will need to
+ * perform the open themselves.
+ *
+ * FMODE_CREATED is set when the call to ->atomic_open() actually created
+ * the file.
+ *
+ * Returns the opened/looked-up dentry on success or ERR_PTR(-E) on failure.
+ * On error, atomic_open() consumes @dentry.
  */
 static struct dentry *atomic_open(const struct path *path, struct dentry *dentry,
 				  struct file *file,
-- 
2.55.0

