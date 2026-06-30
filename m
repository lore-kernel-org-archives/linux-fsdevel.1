Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CC12400E13
	for <linux-fsdevel@vger.kernel.org>; Tue, 30 Jun 2026 10:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782816939; cv=none; b=NGvdQFPTG6Z8xeeHd395o3aKMxEHBetJtIaelhmPQG5EH3VWyCB/J1E0fswrdSERJQlQlq1qHv1gvMSu4XTNB7g4W52LhaCLJxwMxjkPPXuMY7IUTm31DZO9ttbijvVlxKTWcND/irKgy1jlX7GK+5KDIN15Kr6XQfvHLIzqX5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782816939; c=relaxed/simple;
	bh=B7K06SoWKKUYP9dweYzG8soBmUO/j1LNzzjbJLWEs8U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a4L4nS4WMuFyak1vnIezlMZjSZirm6dJtjKMNr9Ba79BabAC2FHalOlt6MuFaYKUU5hQz125Cet2SHX0BwWn2v9k0BnEFdnGvWZDB1GBYA3AVVzCxzCVBqzzH1DGZlunEjHxlL2ZTmu1LB4sTaosiEnHNxb4XNRrYlmhAEX9oHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=M6ku/kJ9; arc=none smtp.client-ip=195.121.94.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="M6ku/kJ9"
X-KPN-MessageId: 0ef22ad0-7472-11f1-a055-005056abad63
Received: from smtp.kpnmail.nl (unknown [10.31.155.37])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 0ef22ad0-7472-11f1-a055-005056abad63;
	Tue, 30 Jun 2026 12:54:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=mime-version:message-id:date:subject:to:from;
	bh=ssbLL6hscoi2GHw1IOEqBG48GFc2aq6UAHLmcM2pkw8=;
	b=M6ku/kJ9i2E2mloCn5CPRmBEaKqYvBpx9sRxteiQdU4TqGz2rB6DnT4nQm/3i/4GKbWVqeL7JrYE3
	 ha0VUjqd6iBlaxia40cT5b9LUmyFD2bbJD2BnGzRI7wEGa3Pl+oylbMbR3j/gymfmMddA5tgAzdoQ3
	 HuAOiVaXIzdqpQlO625JhsEGFcCiCdGCLvoq74vVxKMNr/HECtbT86YlEaZDdh1BKwtMkhQWTKn4Zr
	 hE3Ab4aGHiy92LQk0FgpMRQ6NcMaRxqwAn3QMIPFcpR/WlyWXyOoIw5AMPXxpKHLNlv2A6TG22Brtn
	 oevWfg+AOeurEbxv+so1Y8CYc7+SfSg==
X-KPN-MID: 33|Z85z4wlLM6gZ5GszYL/h0HPDsSrxfdvFpYPR7YLj27PEnf+4ooowlAj7V9AWkXo
 1mu8uex11rOJ4kwO9ZAZckzNQuCN0udnfGUIE2EqFiuo=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|ZzvRN2ms/bpEVSVYmpmKoTOMoIYaTtMVV6627jQcHpVCuKNffwLPJQ1zfUWDaRX
 x5lhaH2lJBBy9sDK/sHeAdQ==
Received: from lt-jori.home (unknown [178.226.150.234])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id 0ece22f1-7472-11f1-91b9-005056ab1411;
	Tue, 30 Jun 2026 12:54:25 +0200 (CEST)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: Christian Brauner <brauner@kernel.org>,
	NeilBrown <neil@brown.name>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jori Koolstra <jkoolstra@xs4all.nl>
Subject: [PATCH v2 05/31] autofs: drop redundant S_IFDIR from mkdir
Date: Tue, 30 Jun 2026 12:53:34 +0200
Message-ID: <20260630105400.68459-6-jkoolstra@xs4all.nl>
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
->mkdir(), so OR-ing S_IFDIR into the mode again in autofs_dir_mkdir() is
redundant. Drop it.

Assisted-by: Claude Opus 4.8 (1M context)
Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>
---
 fs/autofs/root.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/autofs/root.c b/fs/autofs/root.c
index 186e960f1e23..b36439f4521e 100644
--- a/fs/autofs/root.c
+++ b/fs/autofs/root.c
@@ -741,7 +741,7 @@ static struct dentry *autofs_dir_mkdir(struct mnt_idmap *idmap,
 
 	autofs_del_active(dentry);
 
-	inode = autofs_get_inode(dir->i_sb, S_IFDIR | mode);
+	inode = autofs_get_inode(dir->i_sb, mode);
 	if (!inode)
 		return ERR_PTR(-ENOMEM);
 
-- 
2.54.0

