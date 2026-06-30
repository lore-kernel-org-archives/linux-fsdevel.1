Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0383421A03
	for <linux-fsdevel@vger.kernel.org>; Tue, 30 Jun 2026 10:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782816945; cv=none; b=VmkbWOl8QbBH4quYuxOK/W0ITaSfW5ZYq86hMAhW64m2LzUx/H+tIr8tmg2RgNtFpxSYHN4z+xV9bd7MoGyi8IVFOhmJJV62HlKeuzP+tVkDAvjqzbk26ySQZIfd3DePRhpxTshLLphC8FBm/3pX/4R7OaCWYYNiXGtYmOqF7MI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782816945; c=relaxed/simple;
	bh=Z0juMN4dM1k6SjhTii6VFS9Drlu8cFCY2wvNP8UjC1M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rwHfNs/Bu0AYtu8TwQ73D+YZcaC9NnmOLHFBS7ssXRtbz9uD+rMc2Xv3/ZZgw1BQfk1jefvH8r0qLhgyY8JGXbPqnwd75GOSz39MycNv0G0zqv1qRptkWGsLTBa9bGy2yzeX78vgb2iyT4JSIIDTNG6ftF6AE1oSEHELun/aZkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=AxKzoQ35; arc=none smtp.client-ip=195.121.94.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="AxKzoQ35"
X-KPN-MessageId: 116fb192-7472-11f1-b2a8-005056abbe64
Received: from smtp.kpnmail.nl (unknown [10.31.155.37])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 116fb192-7472-11f1-b2a8-005056abbe64;
	Tue, 30 Jun 2026 12:54:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=mime-version:message-id:date:subject:to:from;
	bh=b3q5WNYhBa9G66g4socKkn0pR38lYZH0ngxTkRkPUAs=;
	b=AxKzoQ35v+dPDpCDIH25LGJKsI6TJRgEcIRKAoQG1XqMadQzSGNg1oQsW7zkiuICcdAGJENT+dp+H
	 qU8vEzrBksTEQVyDOyA+/ho08tlYMZXetcaEkuMi50Dole50WQMRFSRzOxO5tOxvYt4yKBrMgOkp76
	 7iHwFUoOFqqchroy+g/BjCU8kj41NG0HoIftB3hEaLh8+DWL29DxoYHIaN1bjJ5mtdn963imj2W4jK
	 AZigw4lGB/p0/KfziNmhklTbCaAffhrjZDaXoN6nr0PaoZzYEwqoj4iyffKvgqofobaNWSckyxkFV4
	 epSzQ4BqbTKsCLso3oPRK50o6q2/5eQ==
X-KPN-MID: 33|yvEEhmnT6IL1idVGrdyDdOi0Dxc5aqNaf2g72jVqSrZAHFXIyUJ4MUDLsjdOyaO
 hz+PvVJP772rlWyhCzWUOUKIwWdDDHhCSs4CTpPLcL7k=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|RT4QiXeUkS8xm0tXxX6p8cQUK84803x3JUMR0oqhZqMULu7ilFfgD6lJbFy7pP5
 8d+Z1dauDNdzPY5NiRtNsJA==
Received: from lt-jori.home (unknown [178.226.150.234])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id 11522648-7472-11f1-91b9-005056ab1411;
	Tue, 30 Jun 2026 12:54:29 +0200 (CEST)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: Christian Brauner <brauner@kernel.org>,
	NeilBrown <neil@brown.name>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jori Koolstra <jkoolstra@xs4all.nl>
Subject: [PATCH v2 09/31] ext4: drop redundant S_IFDIR from mkdir
Date: Tue, 30 Jun 2026 12:53:38 +0200
Message-ID: <20260630105400.68459-10-jkoolstra@xs4all.nl>
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
->mkdir(), so OR-ing S_IFDIR into the mode again in ext4_mkdir() is
redundant. Drop it.

Assisted-by: Claude Opus 4.8 (1M context)
Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>
---
 fs/ext4/namei.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index cc49ae04a6f6..0992fe21b261 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -3009,7 +3009,7 @@ static struct dentry *ext4_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 	credits = (EXT4_DATA_TRANS_BLOCKS(dir->i_sb) +
 		   EXT4_INDEX_EXTRA_TRANS_BLOCKS + 3);
 retry:
-	inode = ext4_new_inode_start_handle(idmap, dir, S_IFDIR | mode,
+	inode = ext4_new_inode_start_handle(idmap, dir, mode,
 					    &dentry->d_name,
 					    0, NULL, EXT4_HT_DIR, credits);
 	handle = ext4_journal_current_handle();
-- 
2.54.0

