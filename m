Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1830130F53C
	for <linux-fsdevel@vger.kernel.org>; Sat,  6 Jun 2026 06:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780728606; cv=none; b=rHLGQqN5YpwKM67GGxah5GVL7uVDPUFu8i4rD3ng1oF7wtAHKhwj7pU1rVWNmJ+viyhtmkytYf1Hm1n4xKFFpeyBWg8zxk4FKmB5m7+X3QRfxpiBFJko7FR8haHiWNFrb7Iqhv+ymvgpfXqQBjNdilejT2EsoWVkqA5Dp6e5AJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780728606; c=relaxed/simple;
	bh=mh5RTFWqTrmu5rhh1vLdnyl3vpl/4G2dn7zCGU/evsY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fKyEh56OFeQ1SBQOIePm0pkll+vCqh/vkZKVnaKVqFCld9QmwI3UsgcFroF4kKxC4AnvTuP7PNKz1LlvsGNN3wII2WZPPZZCEcz8456yznqoeKcIQITzhkWENwVbtKZAFkCWpJwu6X5GViDW6J2xo0y3I9UC+FDD3g+kz7DIp6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=RM2g08X9; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="RM2g08X9"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=bOASv7JFE02+pAPGNpqm0iE252TRzdrvlzKx5fFHkvw=; b=RM2g08X9HFpuEOOdDTlhdDVTqF
	Z/YqoYrSWJRZ9GZvf0NnlyvdwQv13SXk8Vw98XRKTrE7tqo1AGGfBaX6jH93tP1DGDO4dOc1XG3nY
	Xnl14iAKI+oPLuc96Q9vi90AMcqf+6c1xg+tdpf4t+tHm1nX4dqZn5z400AcB1IudARR1HxgkCXLy
	ND+LHNuaSocB43MnD04KJAu7rULlIQY5XSv21yPw/V7mAEcLQv/xJfjPsj86Xw9QvL6G9gC+/iY3G
	IjLVGkLrjTbnGSqaslyjmuZbmqheKkiwslvY9VkQ8OGMj1Y6XtmL36nwtzaeR0VAA5jRq1PGauANF
	QBZLpFAg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wVkqz-0000000BQM3-46nb;
	Sat, 06 Jun 2026 06:49:58 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Steven Rostedt <rostedt@goodmis.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Tyler Hicks <code@tyhicks.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH 2/6] configfs_lookup(): switch to d_splice_alias()
Date: Sat,  6 Jun 2026 07:49:52 +0100
Message-ID: <20260606064956.2722874-3-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260606064956.2722874-1-viro@zeniv.linux.org.uk>
References: <20260606064956.2722874-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

more idiomatic

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/configfs/dir.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/configfs/dir.c b/fs/configfs/dir.c
index 362b6ff9b908..cd65a69765ea 100644
--- a/fs/configfs/dir.c
+++ b/fs/configfs/dir.c
@@ -501,8 +501,7 @@ static struct dentry * configfs_lookup(struct inode *dir,
 	}
 	spin_unlock(&configfs_dirent_lock);
 done:
-	d_add(dentry, inode);
-	return NULL;
+	return d_splice_alias(inode, dentry);
 }
 
 /*
-- 
2.47.3

