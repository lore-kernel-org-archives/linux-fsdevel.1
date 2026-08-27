Received: from wata.am-1.org (wata.am-1.org [46.235.224.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3DB248AE0D
	for <linux-fsdevel@vger.kernel.org>; Thu, 27 Aug 2026 18:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.224.96
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787854843; cv=none; b=diFFzkz6h/N/2g6N+nOjRFRni9/qAuewoCQ5tDqFyEPZjE+2TobVk/XXT7naEP5Qv0wuQ4kVTdgqO5YyXYp8sT/9OqOP6CU9w5m0UVsT4QukN9DFLPt3exavnLCBoMQQBJaCMFWqCk2qdhUglAscHuvBg4nBHlLqdd2yV8r/GjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787854843; c=relaxed/simple;
	bh=4/PschOL1yodg1donUFdRfJeugAZhgumFe+IXZDA3gQ=;
	h=From:Subject:Date:To:Message-Id; b=lXpezhy1cG8tmTtD4FXZsRIa2qt9RtylB6ILCIt9nqFigON0fp/ZdtedIYfwpjOaNLb9C90wZRMG2teBuZIyo6NLUkPL7vmVgoDjQ2xbeHGRML28o8Fnb2g/eWev2pMldjxrpMo+a/g065hI0RysW8z1mXNUn5MNrPVA2HcuD1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=siamics.net; spf=pass smtp.mailfrom=siamics.net; dkim=pass (2048-bit key) header.d=siamics.net header.i=@siamics.net header.b=ZiRI58fb; arc=none smtp.client-ip=46.235.224.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=siamics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siamics.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siamics.net header.i=@siamics.net header.b="ZiRI58fb"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=siamics.net
	; s=a2021230; h=License:Message-Id:To:Date:Subject:From:
	Content-Transfer-Encoding:Content-Type:MIME-Version:In-Reply-To:References:
	Reply-To:Cc:Content-ID:Content-Description;
	bh=k4pl7AWoIMy3edfKh50VwNvnPhHRGGOuEKWfXmB8iUE=; b=ZiRI58fb+fpBMuj5lV3mKIUsLa
	3QaDbIl8sIU2FTlXa3/rkNzAH0hPKF85FQtBhddlNk0IXjtaQGwlBqssdNj7/fzuzMsjxtvejqqoo
	kgKZLde65v5ZR3LsEHtJtCpgHbENUuwAdgxrUo0PxeNYjZ+Pmi59g0E9J5AXwK0+sFhfm3Kjo9J7K
	XRplTvelpcoDCIRV548ReFhIL3TOqai13rWmnwMDwhhObReV8OGz+5mwXRryNE2vUxRFSKGrZh7D2
	nYtS+fQBRhiZNmj9I1npvQyR3kdmohUqK+qLMpfvkQrHFBpKp5fgN6z9YeKlHbklmYncanf7nz6fA
	70qkhdBA==;
Received: from violet.siamics.net ([2001:470:1f13:1eb::1:1d])
	by wata.am-1.org with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ivan@siamics.net>)
	id 1wzeJy-00018O-Ed
	for linux-fsdevel@vger.kernel.org; Thu, 27 Aug 2026 17:55:27 +0000
Received: from ivan by violet.siamics.net with local (Exim 4.98.2)
	(envelope-from <ivan@siamics.net>)
	id 1wzeJv-000000004BC-2BYx
	for linux-fsdevel@vger.kernel.org;
	Thu, 27 Aug 2026 17:55:23 +0000
From: Ivan Shmakov <ivan@siamics.net>
Subject: fs/isofs/rock.c hardening change fails to account for multi-session 
Date: Thu, 27 Aug 2026 17:50:15 +0000
To: linux-fsdevel@vger.kernel.org
Mail-Followup-To: linux-fsdevel@vger.kernel.org
Message-Id: <2q5do282ZtqTkEmosKhhr3-1PfHslV8i@violet.siamics.net>
License: CC0-1.0 (original contributions only)
Organization: Dbus-free station.
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

	I believe the check added to fs/isofs/rock.c back in April [1]
	is incorrect when the session other than the first is mounted:

[1] http://lore.kernel.org/linux-fsdevel/20260419212155.2169382-2-michael.bommarito@gmail.com/raw

--- a/fs/isofs/rock.c
+++ b/fs/isofs/rock.c
@@ -101,6 +101,15 @@ static int rock_continue(struct rock_state *rs)
 		goto out;
 	}
 
+	if ((unsigned)rs->cont_extent >= ISOFS_SB(rs->inode->i_sb)->s_nzones) {
+		printk(KERN_NOTICE "rock: corrupted directory entry. "
+			"extent=%u out of volume (nzones=%lu)\n",
+			(unsigned)rs->cont_extent,
+			ISOFS_SB(rs->inode->i_sb)->s_nzones);
+		ret = -EIO;
+		goto out;
+	}
+
 	if (rs->cont_extent) {
 		struct buffer_head *bh;

	My understanding is that here, ->cont_extent, an offset relative
	to the start of the medium, is compared to ->s_nzones, which is
	the size of the mounted session, relative to the start of that
	same session (either ->sb_sector or ->sb_sector - 16, I guess.)

	Consider, for example, that a DVD+R has two sessions: the first
	starting at LBA 0 comprising 1234560 LBs, and the second
	starting at LBA 1236584 comprising 1058200 LBs.

	When the second session is mounted, ->sb_sector would be
	1236600, all the Rock Ridge records would have ->cont_extent
	> 1236600, and yet ->s_nzones would be 1058200.  The condition
	hence will always be true.

	As an aside, I often have several ECMA 119 / ISO 9660 filesystems
	mounted at the same time.  Were the message above and the others
	under isofs/ to mention a block device or a mount point, they
	would've been way more helpful for figuring out which specific
	FS might have a problem.

	TYC.
