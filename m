Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5060635C698;
	Fri, 31 Jul 2026 08:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785486979; cv=none; b=R+4xmip25/DQftRI14f2k92sUkhSFE1a7jPFfa7IWMe4J9QjDIBWEpC8EhIizKFhB8Ugfv2u0nPnR+Jqg6HxvITYt3g131PoipVDUliEKc8x4e98VgxfK325nAWsa5XVpKeXsl0Vwg5Cb2Embls42MRxeqvVArIFAXjyZ1ko6Lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785486979; c=relaxed/simple;
	bh=IVbqRCpob72dCbe8vFgrS4HSdigPfHsmX5MiIG7oQlA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=kvaIMeB7jctvuErFzYFn5IPX3t2dAA5hywEg5aXkJJNnGeWuAxUgUAKIUnMlyyjprMbOkTZcTR3NGH/RfEq+CuJI62MpxW/CZMNFp0pT5yT9EbPe/P8Dr4IgbjRA5MFKncgP0iFpCXbAiCQ9fbPUlihXw4B+Aba6jxo8KvST8kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MRd1M1HS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MRd1M1HS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B09091F000E9;
	Fri, 31 Jul 2026 08:36:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785486978;
	bh=1zWiuzU9NI5mQ0Ur/AFAMgDwCPdQjJv6ntmIFRFLYrU=;
	h=From:Subject:Date:To:Cc;
	b=MRd1M1HSIHuIA4cXV4jPh/cL0HrIPGbMH+IaXl/AFH0KDkjlzYaFlXi+bxXs5YhnJ
	 v8nSUgZzhcLQg6rwW0v6Y+uAEk1P2awCUypoTDQfxhmIOmwRvIazKPdGgXVV7JI6OJ
	 1t3jP+zp/QlHDKXm2qf0Sw95y/gNmA3o387gEIkq7VPvX9aqBdxR9BvDUBPyIyWCKG
	 ObzDSYPgncIoT38dejNmHy7ZsB7R4qvXrSDVKcnBgGrNTF9d/omwWpveWlPVYiJRVv
	 R1WzVXQ/lKXBWrL7uv0mSRffxscVrTZCGbNYle1a00PypmBxAmRm9bkAANKm3fIczf
	 HYCXMaBn/50jg==
From: Christian Brauner <brauner@kernel.org>
Subject: [PATCH 0/3] fs/namei.c: comment and coding style fixups
Date: Fri, 31 Jul 2026 10:36:04 +0200
Message-Id: <20260731-work-lookup-fixes-v1-0-2412b85cf65c@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHRebGoC/yWMyw6CMBBFf4XM2iHQGmv8FcOij0EqpiUdQRLCv
 9PK8tzH2YApeWJ4VBskWjz7GDK0lwrsoMOL0LvMIBpxa5Rs8RfTiJ8Yx3nC3q/EqKRxd2WtcOI
 K+Tcl+hf59uxO5tm8yX6LqCyMZkKTdLBDiZY+S2pZn1bY9wPKBbu/lgAAAA==
X-Change-ID: 20260731-work-lookup-fixes-73bd87cc2d24
To: NeilBrown <neil@brown.name>
Cc: linux-fsdevel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Jan Kara <jack@suse.cz>, Jori Koolstra <jkoolstra@xs4all.nl>, 
 linux-kernel@vger.kernel.org, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.16-dev-af865
X-Developer-Signature: v=1; a=openpgp-sha256; l=1366; i=brauner@kernel.org;
 h=from:subject:message-id; bh=IVbqRCpob72dCbe8vFgrS4HSdigPfHsmX5MiIG7oQlA=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTlxDVslAxskeOdar5g/9Og5PPbDkjfvfNOpe1TdX202
 EZtXv+GjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIl4zWJk+L7w0ZGlXt/US3t3
 yzOpnjFkU3t/KYL3TJbnt7f3s+W0RRn+F1bmBJ3LEb9bWDg/hPOw3bvdx48LZGuaOuv/Ub77rv8
 ZLwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Neil,

Three comment and coding style fixups for your lookup_open() rework and
Jori's audit series as they sit in vfs-7.3.lookup. No functional changes.

* Update the comments above lookup_open(). It takes the parent inode lock
  itself now but the comment still tells the caller to take it. A caller
  following it deadlocks and the series added a second caller. The claim
  that it returns 0 and updates @path goes as well, that one has been
  wrong since v5.7.

* Give the return description of atomic_open() the colon that kernel-doc
  needs. Without it the description is dropped and W=1 warns about it.
  The summary line has to stand on its own line too, so the "from a
  negative dentry" part moves into the body.

* Fix a space indented continuation line, three declarations without a
  following blank line and a trailing */ on the last line of a block
  comment.

Christian

---
Christian Brauner (3):
      fs/namei.c: update stale comments in lookup_open()
      fs/namei.c: fix kerneldoc of atomic_open() and vfs_lookup_open()
      fs/namei.c: fix coding style in atomic_open() and lookup_open()

 fs/namei.c | 43 ++++++++++++++++++++++++-------------------
 1 file changed, 24 insertions(+), 19 deletions(-)
---
base-commit: b2f1e6301efa4a80becdb0715416c3cbc693fbb4
change-id: 20260731-work-lookup-fixes-73bd87cc2d24

