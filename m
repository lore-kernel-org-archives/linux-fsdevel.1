Received: from sender-of-o58.zoho.eu (sender-of-o58.zoho.eu [136.143.169.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7741D3BFAFA;
	Sat,  1 Aug 2026 22:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785624997; cv=pass; b=PZRf5qoaXcvOk/4Q4Bdjik5EnnfAAvCJE4m2T2h23KQdx3dV9BFuwwRoz9uymXRh7qFNqa7whvAetgh2TNmWtfcmAZhbeOfUYgMOBygpk4XtsSvp8Xz6Y7Mxt7ehfU//6VJ7Pn0HHfUoHOPBCX+qIQADNx/5z73quRDlmbK3QV0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785624997; c=relaxed/simple;
	bh=d1geiDUwKdYDEeo4Q9yzQSbg010Ij28kV8ydpJRb4hg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gi79TKydrCs2Mx8FP015kYMO6tg68StXzVbr0MQIQfuKWvvkv38qZEejUIT3NB+GhGsVrGuIdkWrbF3/PltaIyCoOSDoTkXNyctwYa3hA2YMZafyR5B5whpD7GL2AX43RXshE9t+LjHLLeASaTtaR4Ov7Co3uBMtPNL9F6qIQl4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=iusegentoo.com; spf=pass smtp.mailfrom=iusegentoo.com; dkim=pass (1024-bit key) header.d=iusegentoo.com header.i=ali@iusegentoo.com header.b=NmlXZZH6; arc=pass smtp.client-ip=136.143.169.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=iusegentoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iusegentoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iusegentoo.com header.i=ali@iusegentoo.com header.b="NmlXZZH6"
ARC-Seal: i=1; a=rsa-sha256; t=1785624974; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=kYnKyOd72RO7oaJ3gwsbA3wZbJVVNBn6bTyf/rww5eaoSa/hkAJO/fto4qZTs2OUgeH2kw8A1QJdrr2pbAT+9oNzllNp1clJR1G3IJXGvFG6Q+R9S4byFkHRCqvbvS5Ofwk7l6EWNk7Z58IKzhw19gWHxVWIMXf5e7AzVBTOrM4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1785624974; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=PVaOx+p8YnrWRXBYpD2LawNTpt/9Sm/LDvB5QnWaisA=; 
	b=UMVxTiQdo3WazkcmvSrCl0oEXg/4UiQAlWbKLO2WUjN+mVcznSgekRoN2n9NgllJpu9TZUVHSIgfItWm+9FAk0gnu0rbidz1+FppgzsAKGhFOTYoyXuTCt1QtQdWpPpmV/yHoS0PgsLz2JSSc70bTYHUjuwOlFVCegcClV1Lr5o=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=iusegentoo.com;
	spf=pass  smtp.mailfrom=ali@iusegentoo.com;
	dmarc=pass header.from=<ali@iusegentoo.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1785624974;
	s=zmail; d=iusegentoo.com; i=ali@iusegentoo.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=PVaOx+p8YnrWRXBYpD2LawNTpt/9Sm/LDvB5QnWaisA=;
	b=NmlXZZH6TPj4LzSIWijV3TUG+zXFPtn00xXj+o2pK9rbQrEyN6fnwStqOre5EOoS
	1MR/3car7Q8USPifM1i1R3AVziqYPDAY4H9GkndpJtdvlWOpCMyahhKCC9hOpRhb5d5
	hT0ard8kCyLZdzq2aZrwWCmPJo0iHxYp+ybIIdQw=
Received: by mx.zoho.eu with SMTPS id 1785624972241544.0244080962553;
	Sun, 2 Aug 2026 00:56:12 +0200 (CEST)
From: Ali Ahmet Memis <ali@iusegentoo.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 09/10] ufs: refuse read-write mount of filesystems with active snapshots
Date: Sat,  1 Aug 2026 22:55:29 +0000
Message-ID: <20260801225530.148386-10-ali@iusegentoo.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260801225530.148386-1-ali@iusegentoo.com>
References: <20260801225530.148386-1-ali@iusegentoo.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

A UFS2 filesystem can hold up to FSMAXSNAP snapshots, recorded in
fs_snapinum[]. A snapshot is an inode whose block pointers describe the
state of the filesystem at the moment it was taken, using the reserved
values BLK_NOCOPY and BLK_SNAP alongside ordinary block numbers.
Keeping one valid requires copy on write: before a block that the
snapshot references is overwritten or freed, its old contents have to be
copied into the snapshot.

Linux implements none of this. It does not read fs_snapinum[], does not
know the SF_SNAPSHOT inode flag, and treats the reserved block pointer
values 1 and 2 as ordinary fragment addresses. Mounting such a
filesystem read-write and changing a single file is enough for every
snapshot on it to stop describing the point in time it was taken at, and
there is no way to notice afterwards.

Refuse the read-write mount while any snapshot is recorded. Read-only
access is unaffected.

Signed-off-by: Ali Ahmet Memis <ali@iusegentoo.com>
---
 fs/ufs/super.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/ufs/super.c b/fs/ufs/super.c
index df95502e039e..6132c28c4308 100644
--- a/fs/ufs/super.c
+++ b/fs/ufs/super.c
@@ -776,6 +776,7 @@ static bool ufs_features_allow_write(struct super_block *sb)
 {
 	struct ufs_sb_private_info *uspi = UFS_SB(sb)->s_uspi;
 	struct ufs_super_block_third *usb3 = ubh_get_usb_third(uspi);
+	unsigned int i;
 	u32 fsflags;
 
 	if (uspi->fs_magic != UFS2_MAGIC)
@@ -792,6 +793,12 @@ static bool ufs_features_allow_write(struct super_block *sb)
 		       __func__);
 		return false;
 	}
+	for (i = 0; i < UFS_FSMAXSNAP; i++) {
+		if (usb3->fs_un2.fs_44.fs_snapinum[i]) {
+			pr_err("%s(): fs has active snapshots\n", __func__);
+			return false;
+		}
+	}
 	return true;
 }
 
-- 
2.55.0

