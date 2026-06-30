Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CD98421EF8
	for <linux-fsdevel@vger.kernel.org>; Tue, 30 Jun 2026 10:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782816943; cv=none; b=NGq8+IUz/62bpMZPRiB4gqBRfo8SAKKl4O2C5OU5uCG5nDlcV5/WiYBSWOOJIcwSoTZ3KCgLXrC2NFqT+liUT0NUXj0p3D6Y4k/e7Qc61S9xm9SmQsPEnAWOQZxju9ZW4/1Ef6m5fx8SmXd+/UkO0RrRlnkVoLS+UCbwysXSyog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782816943; c=relaxed/simple;
	bh=dzpvGDqTS9CGh3cWKma50Ud9dBQpTFtadAgRny55yyY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TeTjaSW7mrbKRM6vtZGa/mmGE4ohcYQPoKQlJFh4V1vO2ZNMh/YGEvCYt2rfifPw7woBUjbJNeZPM+x168sXj+rFMYnxCLtjiIJkkMeEF1rEzki0UU25GBW3JHZBFSEjAjLaieJSpiWk1WWyLGbJa7jwZgHVXtibLEK+U1j7E5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=QwgKNxwg; arc=none smtp.client-ip=195.121.94.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="QwgKNxwg"
X-KPN-MessageId: 11c260de-7472-11f1-861c-005056aba152
Received: from smtp.kpnmail.nl (unknown [10.31.155.37])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 11c260de-7472-11f1-861c-005056aba152;
	Tue, 30 Jun 2026 12:54:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=mime-version:message-id:date:subject:to:from;
	bh=OkCyTejckD4v/LYPQZ5Rvi340S7YGCJGP14yWTInpTs=;
	b=QwgKNxwgdBBDdIeRPWDblhq8ZB+mshV/D6Q0IqrGsLA5XRi8Y8qJf/TT2LePoHJ3hD9/KcRoR23dN
	 9WcXGIFpjKIffOIUJW+03+9e3+N94SM4s5XKcCCJsVqXeAXdEMPUwZP5TZU5MwSFB3wfsjyx3XcC57
	 vMTDfJjlLk8f+rO4Kr1Ragboi5CxP2kcgabVQyz2zFLogpGeIMLIhom5pndONOx5o6Wsn8BsjmMR2d
	 2kcXWaHLO8iRS5yVA74QRUGOw6Y9tQ4ucgqhqJaSBy1UzUEDYxk34apyagCde8/5831C04daEq33xG
	 42Rpo/TrGxP5w7XPel4uE62vduHnx6A==
X-KPN-MID: 33|u9KAybM/SsJ4F1eUBqM+5RF4pnUR9A5oEPn1HLtTvuUsjmuZY4ayKbnE0Uf4C2D
 k8AQQWTD8nTAeH+XzSZnCpGnRMLPbdRkOZu8VWiSEHDs=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|wa9CivyWfmb6zJCrU765FrtjRFhfdSTSIsoUkcEgs5mCFopl62jpbWGwK8pZbGf
 qla3Zc/IPZyhlzsLRNqix2w==
Received: from lt-jori.home (unknown [178.226.150.234])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id 119ddc2a-7472-11f1-91b9-005056ab1411;
	Tue, 30 Jun 2026 12:54:29 +0200 (CEST)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: Christian Brauner <brauner@kernel.org>,
	NeilBrown <neil@brown.name>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jori Koolstra <jkoolstra@xs4all.nl>
Subject: [PATCH v2 10/31] f2fs: drop redundant S_IFDIR from mkdir
Date: Tue, 30 Jun 2026 12:53:39 +0200
Message-ID: <20260630105400.68459-11-jkoolstra@xs4all.nl>
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
->mkdir(), so OR-ing S_IFDIR into the mode again in f2fs_mkdir() is
redundant. Drop it.

Assisted-by: Claude Opus 4.8 (1M context)
Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>
---
 fs/f2fs/namei.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index cac03b8e91a1..592ef4ae59b0 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -742,7 +742,7 @@ static struct dentry *f2fs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 	if (err)
 		return ERR_PTR(err);
 
-	inode = f2fs_new_inode(idmap, dir, S_IFDIR | mode, NULL);
+	inode = f2fs_new_inode(idmap, dir, mode, NULL);
 	if (IS_ERR(inode))
 		return ERR_CAST(inode);
 
-- 
2.54.0

