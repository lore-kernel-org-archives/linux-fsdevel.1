Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5311481B1;
	Thu, 16 Jul 2026 02:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784170044; cv=none; b=R8s29s+1GpLUrOBCGuPR4jfLDXYrty68G7QpNbWcr+oob66ZfRFPhQ9GqfQ0xoaIRoHRiazxJsDGdehB65KvRVuIDPTp/8cwBhuqPj95FNj/WLb8KAc0Tz1nXdtI9ZSzWdcgeHrFjCLybVQe1TGkU3Pl8NbDlD22VW7jnLfu0so=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784170044; c=relaxed/simple;
	bh=WK1DPn0k/nG09N7vx/Xy95w/OVS+ud9bC+Lrcgmg6Aw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mSsTViLx8hdQeSOjQln/j0l6qm9xnWHqvcgeesIK3EcqQ/gpbZgrPurl07qVIoiPR0WunI4pKDOgycFQFjsDnMyKMNkgc4VorE6RM5OYVriqM+CkP7EeRRyOG+DRfW2kEHS8t090jlePY7ekB5yHMWBm45cPrz0HA7H/ATDH4tI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nwrz7/Md; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nwrz7/Md"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F2591F000E9;
	Thu, 16 Jul 2026 02:47:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784170043;
	bh=tmLSCNO4TboUh9NOqfWbgpj4S8e61Vz8A+52RCDsNLA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Nwrz7/MdimWAGjOG2gL7oy9JSNaCMApwahKqQzk2WC1HJEBRnoeeoCCVeKss9QvG9
	 ZfVTd6edfZGCXajbHOq0tnGFRmR7vkEwwtBbE2QLppFkWCS/QbFIGtj4tyToS9GpK5
	 97nt02Nmm7ihF6Zf7efAOtBXgjfzCos6ruh1IQ8IQypwTpnFS+M+JCVcDn7gm0o6qM
	 JpefVtEcG9dqAEcDMhYSc5V9W/+W4cqkrWNnCZFY3GpHg8+p8RMaqVYsr9RRL+vSEx
	 SBJ8sWbcHfKGeOxc+yGxSFLF6fnJdA8rYdmTeMhgFud4p1W+fMPWTab1s5Jrx6XhkQ
	 jXDP2RcfD+qCg==
From: Namjae Jeon <linkinjeon@kernel.org>
To: hyc.lee@gmail.com
Cc: ntfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	Namjae Jeon <linkinjeon@kernel.org>
Subject: [PATCH] ntfs: remove empty EA attribute pair
Date: Thu, 16 Jul 2026 11:46:36 +0900
Message-Id: <20260716024640.13396-2-linkinjeon@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260716024640.13396-1-linkinjeon@kernel.org>
References: <20260716024640.13396-1-linkinjeon@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Removing the final xattr leaves an empty $EA stream. An empty $EA
attribute paired with $EA_INFORMATION is not a valid EA chain and
ntfsck reports it as corrupt.

Remove both attributes when the final EA entry is deleted.

Fixes: fc053f05ca28 ("ntfs: add reparse and ea operations")
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
---
 fs/ntfs/ea.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/fs/ntfs/ea.c b/fs/ntfs/ea.c
index 0eba3f41c7bb..88bfd6560692 100644
--- a/fs/ntfs/ea.c
+++ b/fs/ntfs/ea.c
@@ -275,6 +275,15 @@ static int ntfs_set_ea(struct inode *inode, const char *name, size_t name_len,
 		ea_info_qsize -= ea_size;
 		p_ea_info->ea_query_length = cpu_to_le32(ea_info_qsize);
 
+		if ((flags & XATTR_REPLACE) && !val_size && !ea_info_qsize) {
+			err = ntfs_attr_remove(ni, AT_EA, AT_UNNAMED, 0);
+			if (err)
+				goto out;
+
+			err = ntfs_attr_remove(ni, AT_EA_INFORMATION, AT_UNNAMED, 0);
+			goto out;
+		}
+
 		err = ntfs_write_ea(ni, AT_EA_INFORMATION, (char *)p_ea_info, 0,
 				sizeof(struct ea_information), false);
 		if (err)
-- 
2.25.1

