Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C425403E94
	for <linux-fsdevel@vger.kernel.org>; Tue, 30 Jun 2026 10:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782816872; cv=none; b=FeTyLTjd4jLsPVc6Tz+Eupodh+Q4XvFJ60DXgYLqQS2CXzfRMf9XELR9MPaTZI4uTKcs7TCqTxqq+KJy8Pe9c8I1JbFe29afZbMlw0ZTsk0R8uBzHr3cc6eQZ+o9JWxyGlTIOwStfvs1akSIUCcDaUJv4ca77hIoXYr4VvAWn4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782816872; c=relaxed/simple;
	bh=Q0PtbJ9KuKdULNn/yv3gUsFDjekFH5lcZDn1W1HwBcQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eKWK3ElRNsIw9s5cNlMsbwJ+C6m3nqITrdlkhJyNMpsZMfVf7N4R/Exfx7xPnDbG+c9PIcM4NdM7IRX7xBlNmUFZstl+5Qvznw4tzcUwF0ORzuJkqiR3VYmAuSt9NA46pjOoD+Q7eEKFPg+l9gYoRpUT0bC63ovbfz6UoVR68vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=QAyUs/KT; arc=none smtp.client-ip=195.121.94.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="QAyUs/KT"
X-KPN-MessageId: 10f50c9d-7472-11f1-a055-005056abad63
Received: from smtp.kpnmail.nl (unknown [10.31.155.37])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 10f50c9d-7472-11f1-a055-005056abad63;
	Tue, 30 Jun 2026 12:54:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=mime-version:message-id:date:subject:to:from;
	bh=zLxa/iZfTu3/C6M2rs437luL4i236LIQYgRqSOqNxxI=;
	b=QAyUs/KTuR1M8RHRkU+MyF4TXq/puA0G3VtBXdKU9/1OmKlLNIT7LPgtbztns642hPIGlrIEHEV6B
	 xzkDwTbWXx+kfzw/AWDNphu/o49y43r1lKlJyqihi+sxub8uvnsWdJH8/NSi8hl/qqYC7Q0cYJ/7gu
	 A049TNjumgyggwNwvHXK7j2/z/0FtfErGKeNq6B0JxHKli1jKydZOQPcYn8yxiXlFz70S0tsLy1U9D
	 4Z25WE8i7DoRAijWqJeVQKJIaRhFRzDIsVO9u46WeM69z6URQTLIm2hTX9PkyHu7n7dJ85ogIfilQn
	 aBaV+SyX/68XwJ/N0EtvZBy28fR/I/A==
X-KPN-MID: 33|OosAt2fvSKLFX+KfYJjDHoY89+AF8VHrzQL0bgzqu5kSDhIeDTOcNnnv8/PCGYh
 ksOEzIfPLizGolWrh6C7pko1SbUnugtW/hao4uGPpt7E=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|RBRgrjc0bKHg2VPQNPie2iJ1eJMOG0TQUdXIuPxPSTEAUPEgiqsMqwf91ziZrru
 7cGVUL44Y4PGVKvTO5DGiag==
Received: from lt-jori.home (unknown [178.226.150.234])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id 10ad1435-7472-11f1-91b9-005056ab1411;
	Tue, 30 Jun 2026 12:54:28 +0200 (CEST)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: Christian Brauner <brauner@kernel.org>,
	NeilBrown <neil@brown.name>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jori Koolstra <jkoolstra@xs4all.nl>
Subject: [PATCH v2 08/31] ext2: drop redundant S_IFDIR from mkdir
Date: Tue, 30 Jun 2026 12:53:37 +0200
Message-ID: <20260630105400.68459-9-jkoolstra@xs4all.nl>
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
->mkdir(), so OR-ing S_IFDIR into the mode again in ext2_mkdir() is
redundant. Drop it.

Assisted-by: Claude Opus 4.8 (1M context)
Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>
---
 fs/ext2/namei.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ext2/namei.c b/fs/ext2/namei.c
index 0d09d22fe708..411fd09c3c7e 100644
--- a/fs/ext2/namei.c
+++ b/fs/ext2/namei.c
@@ -236,7 +236,7 @@ static struct dentry *ext2_mkdir(struct mnt_idmap * idmap,
 
 	inode_inc_link_count(dir);
 
-	inode = ext2_new_inode(dir, S_IFDIR | mode, &dentry->d_name);
+	inode = ext2_new_inode(dir, mode, &dentry->d_name);
 	err = PTR_ERR(inode);
 	if (IS_ERR(inode))
 		goto out_dir;
-- 
2.54.0

