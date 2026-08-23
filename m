Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD6A9310645
	for <linux-fsdevel@vger.kernel.org>; Sun, 23 Aug 2026 16:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787501179; cv=none; b=uYo1seR7JwSAYxFgeVihJ/jPRTbIeoNH6rehB6pJE5cbVAKMU8VaM9PI0g89RhiE8N+vvcHZ/DgzAgh9FOFmYuVtCsfOFp8ufZR7jE0SeAGG4qEt6n+AcgZFx0NPu9RYtFjr/dci9Qgv0NhyakW/5TlA6ojy7VuCZK+LhHvRrC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787501179; c=relaxed/simple;
	bh=K+hE5SIP1DfMrkDoCPFRvzqMCev5XZT58nDKED1tNKU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pjz6YNj498eic6rRhJ014sk/lPwzswoDHDPNnUphk108l+UJI92gD7hTnUZeP2ybBrT20oQ0EBNANftooRa2QjZqcta3RVmqUtwj6boCy2wAGKsvSxyYYrRCh05u5Ykqfxz2ngqzPvmV7xhrvuuW76+cMXR9vQQnpG9k4wWpA+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=XG9K0vfq; arc=none smtp.client-ip=195.121.94.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="XG9K0vfq"
X-KPN-MessageId: 8f9cce85-9f0c-11f1-bfbb-00505699b430
Received: from smtp.kpnmail.nl (unknown [10.31.155.8])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 8f9cce85-9f0c-11f1-bfbb-00505699b430;
	Sun, 23 Aug 2026 18:06:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=mime-version:message-id:date:subject:to:from;
	bh=WRMkOaicp0dXfWUDHDbhi9ythsDbQ/z5UIeyTt/KkGA=;
	b=XG9K0vfqQeV3eLxNiPVu73MC+HL3Gef92mD6dszxZAHx6v8nPnVuwVLyQAcb/ZXkAohgjt2WtgTQJ
	 s56c2ovGzZqAD9SnGTAXKgIz6UD0hGBLaftvFbLnyqYyxnBnc3erFrJsBf3iXVoC65elJdE4R1MtIk
	 PBPisaEM/rhoTekV9947fRXRsSQ5hrGkSWimMJkQWkqHG/qz3epfKstXV/qB3wOumlsp6J8fguZjck
	 bm8QutLyIp6fF1qWJ/NGu/ClCobNFlqYdWye34rwF8aLdOlu9bVB2L7U04ONlY8spldD3VhhZmIdHX
	 KkalNUMkmyXAwFDPN28bnMnFQGqob/w==
X-KPN-MID: 33|an+U0fqLdWvdXtrM4l6KDirzP1DAB5lpjRlqSRqKhKxKva+0mxNX4wrLth6Dp8a
 264DoeRi0da3pAEw2/tBwku68TwrljvgmrGJA2nN3Wqs=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|Igedpa6P/9cghHainCUdkm3BPeGl7dFjbh0vO0dHl4FbmIX4VQPLBX06PIwx+km
 QOd1zuwiYewn5IlKI6dJ6Ew==
Received: from daedalus.home (unknown [178.231.250.211])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id 8f64fde8-9f0c-11f1-8ddb-00505699d6e5;
	Sun, 23 Aug 2026 18:06:12 +0200 (CEST)
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
Subject: [PATCH v5 08/10] vfs: refuse O_CREAT for directories through a dangling symlink
Date: Sun, 23 Aug 2026 18:07:04 +0200
Message-ID: <20260823160706.358293-9-jkoolstra@xs4all.nl>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260823160706.358293-1-jkoolstra@xs4all.nl>
References: <20260823160706.358293-1-jkoolstra@xs4all.nl>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

open(O_CREAT) without O_EXCL follows a trailing symlink and, when the
symlink target does not exist, creates it. Refuse to create through a
dangling symlink for directories.

In lookup_open() a negative target reached with nd->depth > 0 was
arrived at by following a trailing symlink; since the dentry is negative
the symlink is dangling. Set create_error to -EEXIST in that case
(matching the errno returned by mkdir(2).) Reusing the existing
create_error path strips O_CREAT for both the generic and
->atomic_open create paths and only reports the error when the target is
actually negative. Thus opening an existing target through a symlink,
interior symlinks, and O_EXCL (which never follows the trailing link)
are all unaffected.

Suggested-by: Christian Brauner (Amutable) <brauner@kernel.org>
Reviewed-by: NeilBrown <neil@brown.name>
Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>
---
 fs/namei.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/namei.c b/fs/namei.c
index 9da91f081c11..e1a8f18385a5 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -4580,6 +4580,11 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
 						    dentry, open_flag, mode);
 		else
 			create_error = -EROFS;
+		/* Refuse to create a directory through a dangling (trailing)
+		 * symlink. For regular files this has been allowed historically
+		 * on O_CREAT without O_EXCL. */
+		if (unlikely(nd->depth) && create_dir && !create_error)
+			create_error = -EEXIST;
 	}
 	if (create_error)
 		open_flag &= ~O_CREAT;
-- 
2.55.0

