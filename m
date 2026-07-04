Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AAEA372ED7
	for <linux-fsdevel@vger.kernel.org>; Sat,  4 Jul 2026 16:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783183282; cv=none; b=BCz3RuhCvNluMbBgxmhYARqNZaCWCTN/1RAtWVCr7/2dlEygEjWUyEfmeLUqvGvjm0gO93yHDO0inanefcF6Wgc1kGQh9MM9SfQzknjvvn4O0TxYtOf4BVoVytmZESfKlGSN8kLuor+91rniGxcchiWIl/DAcbgOJQ0sT5eOmtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783183282; c=relaxed/simple;
	bh=qOspL9DR/Ap3JjrdqfEG20fX9OHFrfSy/VqzZGrRr/c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HfTRu4hWLKSMDprJrDcjxCOsunKXGR50zQNPlgV8DE8E7yKodrJJii1eaKvadRHwWoSXKkvrCsX7R3Dz89ZypVDYmMbQQXnTrHkSX8Zl6dl42TstTOCqLbSKQgWEQJ07laRl8OlQv36HfwvP1jEj9JbwtyHkMLe4KYwQDlyCwv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=kgR7hAUL; arc=none smtp.client-ip=195.121.94.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="kgR7hAUL"
X-KPN-MessageId: 2a793dab-77c7-11f1-83b1-005056ab378f
Received: from smtp.kpnmail.nl (unknown [10.31.155.38])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 2a793dab-77c7-11f1-83b1-005056ab378f;
	Sat, 04 Jul 2026 18:41:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=mime-version:message-id:date:subject:to:from;
	bh=uWiGEwZZ76ghh+E+QhXpEXoQ376JG6nQ+5thiNgmtKs=;
	b=kgR7hAULSW6uwzAQnjeC2+jh+JX8nL2djDZZLoOYxFT5wcdKGBE2yQuXY72RRXrMbCsrlcT7GtfGr
	 0AudabSDFnzyHTCc69SHr5xL2iQX5TLp0bDOjJ/iSVZgA25graOY6NdKYGjTdwrLyab1BwQSA9b2q1
	 /4kD6Brq+OQTtNIo0TEc28C1Cch9FaqZIdfmZkpVDVPw/MrakQuXcvCZfXC3TVd4q0J4Y7uPzJU/di
	 gZ1qECHGLD4uk8wvzmcINWlTSpW5vrmufomHrHVddk4RMovXHRMuUPTh1E6W7BfGO2fmzAGyRh0WZH
	 tGExbSckgv2RIh9y52W/DCAqyjc1LYA==
X-KPN-MID: 33|GUnIbBsuG8ZyTjDnZE2wBQGAMwVXvMO+gK9peMiABanxEtEmZbT32si3wHz4QDC
 Z4CY5GN49MvkTK9dxtp8exth/I9e2/4FJ0kh6ZHLU9Ak=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|XdNqFvnKLFGWngnaCdvimuAkBAm+GQGCRTzBTU6khB2psraS8oSPU51wtfOUnzO
 JP7zXrM71LAX7PdD4FRMiYQ==
Received: from daedalus.home (unknown [178.230.195.42])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id 2a31420e-77c7-11f1-a998-005056abf0db;
	Sat, 04 Jul 2026 18:41:11 +0200 (CEST)
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
Subject: [PATCH v3 02/14] vfs: move create error && negative dentry case in lookup_open() up
Date: Sat,  4 Jul 2026 18:41:36 +0200
Message-ID: <20260704164149.3480051-3-jkoolstra@xs4all.nl>
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

O_CREAT is stripped when create_error is set in lookup_open(), so when
lookup does not return an inode, the case

	if (!dentry->d_inode && (open_flag & O_CREAT))

is always skipped. We can get rid of this cognitive step by handling the
error case first.

Reviewed-by: NeilBrown <neil@brown.name>
Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>
---
 fs/namei.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index a8890bc0ae21..40f83a942e12 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -4496,6 +4496,11 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
 		}
 	}
 
+	if (unlikely(create_error) && !dentry->d_inode) {
+		error = create_error;
+		goto out_dput;
+	}
+
 	/* Negative dentry, just create the file */
 	if (!dentry->d_inode && (open_flag & O_CREAT)) {
 		/* but break the directory lease first! */
@@ -4515,10 +4520,7 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
 		if (error)
 			goto out_dput;
 	}
-	if (unlikely(create_error) && !dentry->d_inode) {
-		error = create_error;
-		goto out_dput;
-	}
+
 	return dentry;
 
 out_dput:
-- 
2.55.0

