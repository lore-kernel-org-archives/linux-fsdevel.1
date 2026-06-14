Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A7A32475CB
	for <linux-fsdevel@vger.kernel.org>; Sun, 14 Jun 2026 22:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781476347; cv=none; b=AIq/P2bMzw2Prnjn4Vy0cCbRSICi3jp7OS1zHnKKo09DV2eqvFFp+y77SIh92nGmKGKT+ff4re8GBKlp95XTR95VP66iGjjayv74DsvJLIsHrX+KVOkaWGPN5UU4WGT9MtTZOnxJ15oGPuH6y0ctWYqJdcllEA+MWqE7oOZ1+WU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781476347; c=relaxed/simple;
	bh=ZAB28fJpej/l6RyspaX34gKmo2BTMOiwVYHpa+TYIgY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kzEkly8xFhJ4XU9kVQ9mDV1Vw2mDR5lyOHC7x4y0JIxGOMeVgobdrdcvwdMpOn8wl9MkhGx2uVYXkR/wwpXbE8uVwgdwOtlo5M7pVG59tx/jiDJ8YDzW3ADO3MlZnuLnGs/MQgJdBkXW5FxKregBuORBCBbQ+uc5UDvZV11MTKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=FN9Qd2NN; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="FN9Qd2NN"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=kd1c9Oq3DRSItwF5edIOMKm7tZY8mBIUZkSY86PbsT0=; b=FN9Qd2NN3QdUUnISCRTSMzUqBp
	WIN7E+dYH+3mtKE5xHCf07M94p7fTzStlUcAOkJRek7FINg8OcywYeyhD8EKBdRWCHEtdfRU/vMze
	X/yYpTwwA22uoa1duSvLMcrl6QFJ6iTArYgtYp/UAuA8lECj258cTll6pUqmAlHSA4WOo5ctce5jS
	l1JF8AH3Z1yXyX+QQfm822rmrZD+qyfHoUvsRXApNN0ut8m9z+7WKcX5SxCqWTfuzRY1yFDmj1Tb5
	fk48PWxslZrjclPBbAaGy8fjCMkA4Ggbl39X5ZZBzl0CLFvg9TuxbXaLbdcJj8CzeGyV3wdwNhAtG
	pHu+mClw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wYtNL-00000006aZZ-07yz;
	Sun, 14 Jun 2026 22:32:19 +0000
Date: Sun, 14 Jun 2026 23:32:18 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Steven Rostedt <rostedt@goodmis.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Tyler Hicks <code@tyhicks.com>, Namjae Jeon <linkinjeon@kernel.org>,
	Andreas Gruenbacher <agruenba@redhat.com>,
	linux-fsdevel@vger.kernel.org
Subject: [git pull] vfs: d_add() misuses in ->lookup()
Message-ID: <20260614223218.GQ2636677@ZenIV>
References: <20260606064956.2722874-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260606064956.2722874-1-viro@zeniv.linux.org.uk>
Sender: Al Viro <viro@ftp.linux.org.uk>

The following changes since commit e43ffb69e0438cddd72aaa30898b4dc446f664f8:

  Linux 7.1-rc6 (2026-05-31 15:14:24 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-d_add

for you to fetch changes up to 2555ac7a450bf11f8e461ce6cd0f62613734a796:

  gfs2: use d_splice_alias() for ->lookup() return value (2026-06-06 17:12:54 -0400)

----------------------------------------------------------------
This series converts a bunch of unidiomatic uses of d_add()
in ->lookup() instances to equivalent uses of d_splice_alias(),
which is the normal mechanism for ->lookup().

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

----------------------------------------------------------------
Al Viro (6):
      tracefs: use d_splice_alias() in ->lookup() instances
      configfs_lookup(): switch to d_splice_alias()
      ecryptfs: use d_splice_alias() for ->lookup() return value
      simple_lookup(): use d_splice_alias() for ->lookup() return value
      ntfs: use d_splice_alias() for ->lookup() return value
      gfs2: use d_splice_alias() for ->lookup() return value

 fs/configfs/dir.c        | 3 +--
 fs/ecryptfs/inode.c      | 8 +++-----
 fs/gfs2/inode.c          | 8 ++------
 fs/libfs.c               | 3 +--
 fs/ntfs/namei.c          | 3 +--
 fs/tracefs/event_inode.c | 6 ++----
 6 files changed, 10 insertions(+), 21 deletions(-)
