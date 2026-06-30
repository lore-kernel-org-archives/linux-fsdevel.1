Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1747441168F
	for <linux-fsdevel@vger.kernel.org>; Tue, 30 Jun 2026 10:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782816890; cv=none; b=eyHOPC8/f/Uw05V/IFoTVHGbJWDRERYkaTgFopCiVYlwFTjio8DfkSciTz1mE7fhlwQVpbxpl4NjoakboaWGU4dWLIptD2pIE+BN9gl162Y1fFA9MuRK3fjU5LReIxRAUaHo9URl5F7F0NcjSZqOua+RaJdg4Cf+yhCVJ8A0yLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782816890; c=relaxed/simple;
	bh=FhD7r87hDuR+ur5wmbnUTHPsXF/vd1UGN3/eWbmoSlc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fKh6UAqAYc1XukgySbRf+BxzqQm2k9GLLokaon6Z5NVSU4aJUzEGpW6FVNVpBodbFAix8BT78SkgwbfdShYAiIsfPpixpwTV6ftGaa+wmvf127xdsijQvjkxnGHUdz1Pfjb8Nak0wiLLkCzCXRE/luxulgzx+U5Us78ccH4+3QQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=c6b0Vv93; arc=none smtp.client-ip=195.121.94.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="c6b0Vv93"
X-KPN-MessageId: 1c45667a-7472-11f1-861c-005056aba152
Received: from smtp.kpnmail.nl (unknown [10.31.155.37])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 1c45667a-7472-11f1-861c-005056aba152;
	Tue, 30 Jun 2026 12:54:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=mime-version:message-id:date:subject:to:from;
	bh=nbumNdnyvl6j2oNuW2WkPsDqoFFYYg5CBsziWvZ0Um0=;
	b=c6b0Vv93m8kefhMJp6ueYiFAjp7A/7Np+SGAfiploDu0e/b+qLHyo19lVgmwVpE5K+nIofdQWIyno
	 uHN4MAoekTJLUq72GJSo/I+wo2GNHR3QZVJ/UdWOsLgC2c1IlSmbx/TIVy9dUKp5w76T+SQYY84XBd
	 T8Nyqwm+kNWP/Bu/4de0+i7I7NjtP13s7RESrGUSy1h/y9lxlX6ey7Nvo3/V6Q81u59efluilIwuP/
	 G+DPM2hMkteOTiQV0KbtT4a4H0mWVGtedXTq6akL4FnSB5RAXJcTCDFfyDDQ81Nzccrsv8w6xDlZ8D
	 wjf0DbkOWC3OgyJUBRimneMf9LDemSQ==
X-KPN-MID: 33|YVkKUR2bRl3chFc1dzwXIAWHPctmqilZ8x61WPDQLGyjzw5ZFSY2O3xMFg7i5rd
 +Ea8cq4d5sSObyl6L1B7r8a5DvKwtd0agcdo9rjyMi4k=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|XFtsbxvIPXcmWdwAsQikly/Np55wAP97j34oeQpkOBhAKAN7xODbLJQngyGa47B
 HIBsh4dnv09wildxZxuNccw==
Received: from lt-jori.home (unknown [178.226.150.234])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id 1c20c143-7472-11f1-91b9-005056ab1411;
	Tue, 30 Jun 2026 12:54:47 +0200 (CEST)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: Christian Brauner <brauner@kernel.org>,
	NeilBrown <neil@brown.name>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jori Koolstra <jkoolstra@xs4all.nl>
Subject: [PATCH v2 28/31] nfs: drop redundant S_IFDIR from mkdir
Date: Tue, 30 Jun 2026 12:53:57 +0200
Message-ID: <20260630105400.68459-29-jkoolstra@xs4all.nl>
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
->mkdir(), so OR-ing S_IFDIR into the mode again in nfs_mkdir() is
redundant. Drop it.

Assisted-by: Claude Opus 4.8 (1M context)
Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>
---
 fs/nfs/dir.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index c7b723c18620..630718739d59 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -2474,7 +2474,7 @@ struct dentry *nfs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 			dir->i_sb->s_id, dir->i_ino, dentry);
 
 	attr.ia_valid = ATTR_MODE;
-	attr.ia_mode = mode | S_IFDIR;
+	attr.ia_mode = mode;
 
 	trace_nfs_mkdir_enter(dir, dentry);
 	ret = NFS_PROTO(dir)->mkdir(dir, dentry, &attr);
-- 
2.54.0

