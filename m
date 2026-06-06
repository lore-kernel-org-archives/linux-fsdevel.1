Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 440E61DE8AE
	for <linux-fsdevel@vger.kernel.org>; Sat,  6 Jun 2026 06:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780728606; cv=none; b=JHxvcQwZeABwf/+ni5ty+XIp2FMLfYV3mZmtbrfGsZcR4QALuJNuId7yuLV3/ygntOxvLwVj45TLkbgSdOPgBOSNc8M9CgLqJAlrMkB2OXA7oFa7AMlGIPBOa1Gl2XQvQecJW9xrUg8i12wlYpp5QX8n6DWopclhnbRExvWiFOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780728606; c=relaxed/simple;
	bh=uMp44yuZ0K/mIvq8NjCpb5Fd93P+2U4S/NIuFjQ8I6U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P0oJSW1G7lCALWxs0Q5FdDLg/EJzP+cFSseWb+oxoHVcuJNvCfwblEnRpsj8lEDgbRxL+m6/yYvXqrqa2LqlkG5wsJwolL2fCTjwgaJyrYQyfXF8fmPPgxPV+/lFHbdI4Fwtqyuf1BUYAuFEsu3uXb0M2E6NVf8jVg9ZE7GRJL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=djiUeBxi; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="djiUeBxi"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=lwP2oli6Yzv+Uwq332S74aCpU75fWraUNuqjYp3NqU8=; b=djiUeBxiDqPH8YI2Z/Cdg2tpdD
	f/2EeEQr0UEcprugX4QSjg9Jn349zsy1OLYN+4VkzwFs1NsHZrBvwpGsUIJ2KUk2y98PGFAQD7tam
	rBhM/WZNc4AbqL0sNsg3UU1+V2AlU5jeeUKHJk473WbAX4TMFcKaBzr6hMUCkdnaN0Z4vnazgzqeN
	4ow1uriMnbb7ipn/oO3LBJrXibY+BXhuhdgf9Qwq7M1WEamLW3qwoMTJTNmgZaU2OXozjkYrbrhmh
	C8FTWbR+/EE/FtdHNlp8jF2JCIYTbKkn2K2Fsb2obvz3z/DUOgtZsjQ819KGgEbNVZyo0pxB69OEF
	/zdzfDDA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wVkr0-0000000BQMF-1dHY;
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
Subject: [PATCH 4/6] simple_lookup(): use d_splice_alias() for ->lookup() return value
Date: Sat,  6 Jun 2026 07:49:54 +0100
Message-ID: <20260606064956.2722874-5-viro@zeniv.linux.org.uk>
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

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/libfs.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/libfs.c b/fs/libfs.c
index 1bbea5e7bae3..d6205ea61afa 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -78,8 +78,7 @@ struct dentry *simple_lookup(struct inode *dir, struct dentry *dentry, unsigned
 	if (IS_ENABLED(CONFIG_UNICODE) && IS_CASEFOLDED(dir))
 		return NULL;
 
-	d_add(dentry, NULL);
-	return NULL;
+	return d_splice_alias(NULL, dentry);
 }
 EXPORT_SYMBOL(simple_lookup);
 
-- 
2.47.3

