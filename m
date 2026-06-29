Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D2B14266B2
	for <linux-fsdevel@vger.kernel.org>; Mon, 29 Jun 2026 15:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782747413; cv=none; b=HaK6mYgeR2knWgec79a64YJRVXpbyhf9F+KxFPgFWnhHGv8Ujef7nNP032y9TdbhNemHCFL+fqsrbfehTOwAYXJImumCnWN2JoXV5LnF8zIEz8ysLA0O0aHkaob/ZcdiFrjYBkD2mRFo0QefAJwegDUBlRWpm5zY/t+lRuz/wkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782747413; c=relaxed/simple;
	bh=l1Y3V8frON1fmccAe1+toUjVw6a1D/PQ3qwxYaVe+Tw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BMroycnWCWxUHO8YsOinI736MvxLM676WNrK1lXrsXdwby/3UcRIp5204oej4VssUQXrCXc9waWjIU1Tkmw6ern0Eu2TNvLd2OtokbFIxL7+1tQdMqVIEStxeMxORauYAmGj9oTyNfAFZ4vOOIb/8alxaFqYceq13nKoWy4sD4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=IFTzYrxK; arc=none smtp.client-ip=195.121.94.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="IFTzYrxK"
X-KPN-MessageId: 312ffc5b-73d0-11f1-bfba-00505699b430
Received: from smtp.kpnmail.nl (unknown [10.31.155.7])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 312ffc5b-73d0-11f1-bfba-00505699b430;
	Mon, 29 Jun 2026 17:35:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=mime-version:message-id:date:subject:to:from;
	bh=U9qKsMYpYs+X7BnsIGsUYwggvn4oHVbh6CGf6RFhaHE=;
	b=IFTzYrxKBjNizcXcfrVeb8cFLqZpCXh4q8NkPomZU5KLPQ2o+LcVttTlSoiLEruQvanMWBXoIdoMV
	 Z6fPwS1x9OSuReMaiR3ZV7II8gsUuRZcxXczfRBOiij57O696D6Kdie/ygQaJOd2bzBKCMYhW9u0hG
	 tf8+olI40ryKqq3O1k7KngxoLc6LGIfeVtX1AYfTZZynEkN2s8IGDEanClduCvL5ULtjkNqGOD1Hxm
	 2mJ6FbzMERym8dvvmUtGRbddcbXQGfodxghvwMTAPX58Lk/Ur82aK8Xse8UvSnNE0kxVd6O5kALdOu
	 nlAB5SrH3dYOGWVxpKMqPxgwBEnquWg==
X-KPN-MID: 33|tHRAZAhfclWWME7qg43OEtmfPsDapWFrzgWtikPZ29CEXpYEWeNkSZ3/ufH6nd9
 JzZxV30vOKTlE9b48/7BrUIQZQpz4+1EPShcDQYa45b8=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|axZlOYjzTi72FAs1pCE39Ey4St8fLybd7dpvA1QipSvYncLpyAyA5C4Tbt3dbSr
 FWryfEdwlbwH4Vi83YqUDAQ==
Received: from daedalus.home (unknown [178.231.11.185])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id 30efabb2-73d0-11f1-8076-005056998788;
	Mon, 29 Jun 2026 17:35:43 +0200 (CEST)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jan Kara <jack@suse.cz>,
	Al Viro <viro@zeniv.linux.org.uk>,
	NeilBrown <neilb@suse.de>
Cc: Aleksa Sarai <cyphar@cyphar.com>,
	Amir Goldstein <amir73il@gmail.com>,
	Jeff Layton <jlayton@kernel.org>,
	Jori Koolstra <jkoolstra@xs4all.nl>,
	NeilBrown <neil@brown.name>
Subject: [PATCH v2 02/14] fs/namei.c: move create error && negative dentry case in lookup_open up
Date: Mon, 29 Jun 2026 17:36:18 +0200
Message-ID: <20260629153630.2158649-3-jkoolstra@xs4all.nl>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260629153630.2158649-1-jkoolstra@xs4all.nl>
References: <20260629153630.2158649-1-jkoolstra@xs4all.nl>
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
index 98f9d788cbe5..ed0e41f4e76a 100644
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
2.54.0

