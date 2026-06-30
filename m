Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1017640E8E1
	for <linux-fsdevel@vger.kernel.org>; Tue, 30 Jun 2026 10:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782816887; cv=none; b=VFyh/xbFYsAiyRjrHv3zIMLp00dopTQVh74G7y5ETmK2RDwwkazXuFUZsOaYQO67qYFbUc0r0/M7vlgPkcSGngqncCxJyuYOLBsNjgCgptWAdwlceQ7ixFr6bK6T0hli/aQoYd56TJFQ/L2PHxdhnjmNL+ENNURG7MsP39J6v3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782816887; c=relaxed/simple;
	bh=5JUUde/jYg9si1f9Y++65xHreZdQWSaejGWqH3HkE9I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gmByc8MZZciHr+Csluafx3+K5Y2oMQcQC5cgyjIoDgJUVvimBzqsv9dt8Fd1gj4LBkoLcdVelZGJzj1qQOjtxPeQIjAv3gVJkdw2Cdd7Utjpejv/7pvUdiKuAsur4lN6P2p4aClRBaJtnaDZinuxcEZ6AD1cyqvf7QPCDRAdhaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=hhUDB0V2; arc=none smtp.client-ip=195.121.94.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="hhUDB0V2"
X-KPN-MessageId: 19bd6479-7472-11f1-b2a8-005056abbe64
Received: from smtp.kpnmail.nl (unknown [10.31.155.37])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 19bd6479-7472-11f1-b2a8-005056abbe64;
	Tue, 30 Jun 2026 12:54:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=mime-version:message-id:date:subject:to:from;
	bh=qGH6EiMln1F9iZul1du/aqFBkaPNnmV9iL3gbT7wwiI=;
	b=hhUDB0V26rMRNV8PPmuL10Y2iVHevsg7mNet25Y6sDYAG2c8WQ0N9SaiEOiMj+2CGZ4mOfgSe9uKi
	 9UrWtQz1nq6rbYGfK3aUeAWQzRIeGbBaSvbf3wN6fFwMetlLq7xEDFhOKlM0SzjGN8QPzoIvMOtwP9
	 YpCFHngFv08vbBkxaUYgHW6oNkH2B06M++CoPsKWKnmLeD6rIreXJKT/AA1Vf/u216tZ8cOB1Rqmqb
	 7UUMCcmp5qYqzkrE91437eAdYtnO/JH/VbZoeUljYwFV1IGRQ230HY/HSFp7GTY55/K4FQcMr6VTDd
	 pi20Bzm9GvNGIyC+KDR3j/HR7LM3b6Q==
X-KPN-MID: 33|RXpZdVT7xV5uq6vfVyyuB7L2wZrZFwHKYgIvhRdkKW7jKSfBSb4inaALT92OSn+
 oMtq1a8syfIt3ryxNUj9oIQ==
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|rfHyXZppCyA3tkfWg3fu2UJNf8ktKvne7BuIPyW7PDYepDcWxWWqn/cUnMFGO1g
 +jXBDcMkxmoOJtecXjf5c0g==
Received: from lt-jori.home (unknown [178.226.150.234])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id 197bc61a-7472-11f1-91b9-005056ab1411;
	Tue, 30 Jun 2026 12:54:43 +0200 (CEST)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: Christian Brauner <brauner@kernel.org>,
	NeilBrown <neil@brown.name>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jori Koolstra <jkoolstra@xs4all.nl>
Subject: [PATCH v2 23/31] omfs: drop redundant S_IFDIR from mkdir
Date: Tue, 30 Jun 2026 12:53:52 +0200
Message-ID: <20260630105400.68459-24-jkoolstra@xs4all.nl>
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
->mkdir(), so OR-ing S_IFDIR into the mode again in omfs_mkdir() is
redundant. Drop it.

Assisted-by: Claude Opus 4.8 (1M context)
Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>
---
 fs/omfs/dir.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/omfs/dir.c b/fs/omfs/dir.c
index 2ed541fccf33..418906614f89 100644
--- a/fs/omfs/dir.c
+++ b/fs/omfs/dir.c
@@ -282,7 +282,7 @@ static int omfs_add_node(struct inode *dir, struct dentry *dentry, umode_t mode)
 static struct dentry *omfs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 				 struct dentry *dentry, umode_t mode)
 {
-	return ERR_PTR(omfs_add_node(dir, dentry, mode | S_IFDIR));
+	return ERR_PTR(omfs_add_node(dir, dentry, mode));
 }
 
 static int omfs_create(struct mnt_idmap *idmap, struct inode *dir,
-- 
2.54.0

