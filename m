Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ADD5406809
	for <linux-fsdevel@vger.kernel.org>; Tue, 30 Jun 2026 10:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782816949; cv=none; b=QLhGRYI6deNBXeQL5gYgn+G9VqPi/lVgWatgMXrEGVnYmWj20ZKyn9xZRcaJnv6lgWneqd8GLBjWQURWRrJgCtu7iSiYEDCnclHbnj4spG4Kx/T1tq9sO3S7YPKEOA2bOXjV+ovrEucXMWIgsrfqjzMg7x9smCXBTN7UjldzVSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782816949; c=relaxed/simple;
	bh=Q0+LJLLvi2jnWa1przilXw2maJz34c3ntrw5h40gaH8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jC0XFvb3sg7djTlGr8nfzwVP2ym8Uz4IOLZFFHlCJ5HEbyqMsfZWe3Mmfz7FeoAXGPNVgt8PB1ujmQoU2G0z6WqzYmjvQhR1Jq0Sq9+MhdT135oPa7X3nV96TzAY7zR9A65q3viWPJlvE1hkciEErXgrQRj77FZqji9gXx9ctDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=XLJR4pdT; arc=none smtp.client-ip=195.121.94.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="XLJR4pdT"
X-KPN-MessageId: 149888f3-7472-11f1-861c-005056aba152
Received: from smtp.kpnmail.nl (unknown [10.31.155.37])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 149888f3-7472-11f1-861c-005056aba152;
	Tue, 30 Jun 2026 12:54:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=mime-version:message-id:date:subject:to:from;
	bh=SR6Aq2Q4BHgPYlcvAXxPqssmqacmxKBBv8WvOfO7iNg=;
	b=XLJR4pdTAlgyE5/otCYY4DQVziZjm3IS9U5JRtsnQ1LIGDicYAJYl8EUb67ynlyEErVasPZQGaf5d
	 GRgmEoTt8wpfw2bwxpCCBKET7UtdqEy473AX6T4+eDsXrhpFzfuKGqg557TuAxXrWxqiTuG0it8ZYH
	 zxV5woJrOGbijhDm2zQEu0evBRWd8SPvMfJ14V7c0vC6upJdHaVzxUzUIeWrjR4QZG1yADLRT1P5e3
	 2rITpOklPMdEvv8soeeF0uZShfGXwZeZBMyy64EeG6S7oC3dX564TKaE2V8Cucgc0LJYhjq5RqJAyl
	 vatbT9MtpUnOHh8J59lsGiXb4unO7nw==
X-KPN-MID: 33|uLbbW3HkR7b5t/ZJ2BB+9VsFuzxs/0TATxxokdLT3DVnoZqaYreWkerua//MpI8
 MKj8rjKhziAVrtMyhDI4qkZMYO7VUoWEp3paDFcFZi1s=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|YnQAKFO9T7Yi1voM/DlTcylk6FuX8/zsgxAzBxkrPbVaZ5cG8xuUWLEgZGAk7OP
 uKTbNCB5T/kQfpH6bai1pMg==
Received: from lt-jori.home (unknown [178.226.150.234])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id 14508046-7472-11f1-91b9-005056ab1411;
	Tue, 30 Jun 2026 12:54:34 +0200 (CEST)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: Christian Brauner <brauner@kernel.org>,
	NeilBrown <neil@brown.name>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jori Koolstra <jkoolstra@xs4all.nl>
Subject: [PATCH v2 15/31] hugetlbfs: drop redundant S_IFDIR from mkdir
Date: Tue, 30 Jun 2026 12:53:44 +0200
Message-ID: <20260630105400.68459-16-jkoolstra@xs4all.nl>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260630105400.68459-1-jkoolstra@xs4all.nl>
References: <20260630105400.68459-1-jkoolstra@xs4all.nl>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

vfs_mkdir() now sets the S_IFDIR type bit in the mode it passes to
->mkdir(), so OR-ing S_IFDIR into the mode again in hugetlbfs_mkdir() is
redundant. Drop it.

Assisted-by: Claude Opus 4.8 (1M context)
Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>
---
 fs/hugetlbfs/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index 216e1a0dd0b2..154d9fa8ccd1 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -971,7 +971,7 @@ static struct dentry *hugetlbfs_mkdir(struct mnt_idmap *idmap, struct inode *dir
 				      struct dentry *dentry, umode_t mode)
 {
 	int retval = hugetlbfs_mknod(idmap, dir, dentry,
-				     mode | S_IFDIR, 0);
+				     mode, 0);
 	if (!retval)
 		inc_nlink(dir);
 	return ERR_PTR(retval);
-- 
2.54.0

