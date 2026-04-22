Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D22313D34A0
	for <linux-fsdevel@vger.kernel.org>; Wed, 22 Apr 2026 12:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776861039; cv=none; b=qSATslaPjW1R9bkto4CuskdzcibQGdWvNLa0hn/O103bnGxy9Ff9KOh3dwT9sC7BImxxG0eQ6m0tdO6jKHeK405F9olfTo8cHAh69MTDRNK0LxD+R28eyca7H26LW2zlSwLprwBeWQUOUeGYkEcmy9fnLO/uMveYC03CccAl8vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776861039; c=relaxed/simple;
	bh=nAbYX9ZQrzppGf4m60Ee9foCydLYQ6bdl6M7I3SzSas=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mTECtbrhgGGJh8CveUmLhkSvAEysckoXA5OtyDD1yyG9O4fs5qlXWIWNgB0sMobLns0+onkpZdpIFladSbzKzgwCxMbgv/tqkhmctO0/JLhPekBh5CHpcV/Pug8u0cHf1BjEh6/a4Q/SVhssONkSo6+24O343MI+dzYGV+Lqm14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=eLc+Uuxe; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="eLc+Uuxe"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776861026;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=4bhmcB2ZaNSoEdoPbtEUvCPYZghbDwuw8t1cGcITZPk=;
	b=eLc+UuxewBYAazQE/EEVzKxo49B0TcoMm7kLASPkeD1ZPPULr+9Wbj9gfnykVv3A6MG/bs
	Gh96EsnKuVeiX0Oz/KaPHZo8EHiwnC9bNYWfDWf8fyXnx2hFVZPw+BVLlqRJmYFKz9LMWr
	b6mHh3FdyNbHQUhPmPHkztZYwiQwx9w=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] namei: use QSTR() instead of QSTR_INIT() in path_pts
Date: Wed, 22 Apr 2026 14:30:03 +0200
Message-ID: <20260422123002.99876-3-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=608; i=thorsten.blum@linux.dev; h=from:subject; bh=nAbYX9ZQrzppGf4m60Ee9foCydLYQ6bdl6M7I3SzSas=; b=owGbwMvMwCUWt7pQ4caZUj3G02pJDJkv9nutZPqufaGvdNWdSWWLavte1J4/d8+d5XjWub+L7 i18LH5sQkcpC4MYF4OsmCLLg1k/ZviW1lRuMonYCTOHlQlkCAMXpwBMRGwlI8O3nBOtN8w3v9UU ++923X6pAcdiCQc3FckX/2aH2ti8+bmW4X+eWUv4WZb8sJglR4+tqNtbdf3nz3tGMitND9Tx2P2 PVeAHAA==
X-Developer-Key: i=thorsten.blum@linux.dev; a=openpgp; fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Drop the hard-coded length argument and use the simpler QSTR().

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 fs/namei.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/namei.c b/fs/namei.c
index c7fac83c9a85..817bba800d7b 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -3617,7 +3617,7 @@ int path_pts(struct path *path)
 	 */
 	struct dentry *parent = dget_parent(path->dentry);
 	struct dentry *child;
-	struct qstr this = QSTR_INIT("pts", 3);
+	struct qstr this = QSTR("pts");
 
 	if (unlikely(!path_connected(path->mnt, parent))) {
 		dput(parent);
