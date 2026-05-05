Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5D3F3914FE
	for <linux-fsdevel@vger.kernel.org>; Tue,  5 May 2026 11:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777981389; cv=none; b=uJkspB1H8s4qcDcPxDB4Hs+p6y7ttz5M3OubTqIBI8udJNsrrP283DKK2scj1LKTKDhNtEyNFuE1VZn7OYGI8NNyi8Xx74OiLZpnu3Xoms5bhZJcmLr5G6RSzVb6URuwGFtNwRRJ3vVOXwzwPy6hlilhMx1UxM2wwGAwGeBErC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777981389; c=relaxed/simple;
	bh=BmYK5O/Z+DQvYl6WI1DjpP91uuMKacDT9ltQ8AxHY08=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=I2mvWQ4IFYLSzLws8GQWTbpeBp0+I/8RFg4I7qyODAgUQrRj/wcLo7jPMDeQmdiMYBhokCzI1XJz6qxCkOJVgWkWU9OR3tbArsdGWhET7qH4IharvxwLOuKYXiv77ni1dF7oXbIB0Vr3TaxTQl2fMVImCTQTno30+KK1kFr679k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Ne4hd+oH; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Ne4hd+oH"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1777981383;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Wr4hzfuW5ZM/ULHUTZ9h1gf7GOP2pEdCkryUPktgQ80=;
	b=Ne4hd+oHH3dEv0KVW5Nyx5VgX8GzJOaJhMeraZomMKOQXtw+s34L5+E0sU04ST5BkDHsOK
	joKdfhcmbO5CO/bNZ9HYNPtA2zR1syngCVPJJjR5WZxpPJ0sQjy+U64mRFeGMEeAgyYV+m
	tKaFnNfMja80l4BwdPts3Euhzpi6SmY=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH RESEND v2] namei: use QSTR() instead of QSTR_INIT() in path_pts
Date: Tue,  5 May 2026 13:42:42 +0200
Message-ID: <20260505114242.158883-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1092; i=thorsten.blum@linux.dev; h=from:subject; bh=BmYK5O/Z+DQvYl6WI1DjpP91uuMKacDT9ltQ8AxHY08=; b=owGbwMvMwCUWt7pQ4caZUj3G02pJDJk/r29qsGNcx9HRrVzIYeIq4v/qi8vniov7BM/d9/xWe Lsx9v26jlIWBjEuBlkxRZYHs37M8C2tqdxkErETZg4rE8gQBi5OAZjI4WmMDLNV4+Ijv5+ZZRbr Eb0pauv6d1W887hvHN23i/04X6BlaSDDP12vFS7Bsy+/ZtfMY9C99se6Mt1cnfetvfy9o53nZhv P4QUA
X-Developer-Key: i=thorsten.blum@linux.dev; a=openpgp; fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Drop the hard-coded length argument and use the simpler QSTR(). Inline
the code and drop the local variable.

Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
Changes in v2:
- Inline QSTR() and drop the local variable as suggested by Al Viro
- v1: https://lore.kernel.org/lkml/20260422123002.99876-3-thorsten.blum@linux.dev/
---
 fs/namei.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index c7fac83c9a85..01f3fbdf646c 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -3617,7 +3617,6 @@ int path_pts(struct path *path)
 	 */
 	struct dentry *parent = dget_parent(path->dentry);
 	struct dentry *child;
-	struct qstr this = QSTR_INIT("pts", 3);
 
 	if (unlikely(!path_connected(path->mnt, parent))) {
 		dput(parent);
@@ -3625,7 +3624,7 @@ int path_pts(struct path *path)
 	}
 	dput(path->dentry);
 	path->dentry = parent;
-	child = d_hash_and_lookup(parent, &this);
+	child = d_hash_and_lookup(parent, &QSTR("pts"));
 	if (IS_ERR_OR_NULL(child))
 		return -ENOENT;
 
