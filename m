Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1837930F7EB
	for <linux-fsdevel@vger.kernel.org>; Sat,  6 Jun 2026 06:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780728606; cv=none; b=JlnXNuyY0mE614+aFSpocz9bqWGH9E0RpOzyng59S0WdzoiYwtQJ/9YUcfcKAEiM29hTGrcmANId/4DHPIDLLBoh0WVo8kZK4q0D1bbIiYYMm+/J+UOSwrCYYynZbRgrEOvxpk7HfEYd3UEQ0Yg7hoPASDVcF2qOj0BeI5cZHNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780728606; c=relaxed/simple;
	bh=lZQQ0Ij24FbEdq2r/eEwl2yDQP1AMvQeJ0AF+paAZrg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QbMOdXFbZgjZrdWAKCPb+B9qOZ/YDIGZ9YHRss6NrlVAC6pgfZRSHsxojz3SOCxUOKBcAV8nZGMeMou15WwGwmTqjs3CnUEctBQ4C4ooXWZgaOmpZYj4FO2RfqI6GMfPPRLzPNi5jX0DBKbrFjaZ7PxfEesERl0jsUBw0PxALOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=KrWxotKC; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="KrWxotKC"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=ikdnrmbc4aFGpwHKSneOcdNLdGGrElPzHfLLqvh6iOY=; b=KrWxotKCbD0kUcIvqhR9gNY/IN
	ZA/Abbx8VcC7XI3sIHRAaNd9lsC2CcBT9WiLuZbFzF0bw03yHnOovoEzBehmu+WWAXBdNMcQ/8H+D
	46BnAC2KAQYX3NPkJpki5vnD3YiXa7anNmHu86Qje3i5o5bsiZ3iWCFLeLLcjHfagfhmVJByuoXDK
	kWKGPHhAbbgy6xEynu77QTl6XNvdbqP1d8o5Xkb/WuDumJpsJkaHJnbbKV+O4gtvnOStAincINLLJ
	CyutT0kzmYLEvPxbHUed0MKPt2zHLhNTCDlH0Fwu2/brDCqOCHVBeRGQ6H2Qcu0/I6w6BTVdMhmn/
	uA8zcXYw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wVkqy-0000000BQLc-2D6n;
	Sat, 06 Jun 2026 06:49:57 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Steven Rostedt <rostedt@goodmis.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Tyler Hicks <code@tyhicks.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH 0/6] d_add() misuses in ->lookup()
Date: Sat,  6 Jun 2026 07:49:50 +0100
Message-ID: <20260606064956.2722874-1-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

	This series converts a bunch of unidiomatic uses of d_add()
in ->lookup() instances to equivalent uses of d_splice_alias(),
which is the normal mechanism for ->lookup().

	The branch is -rc6-based and lives in
git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git #work.dcache-d_add
Individual patches in followups.

	All of those are equivalent transformation - we used to have bugs
with d_add() misuse in ->lookup() instances, but all cases dealt with here
were actually harmless.  If nobody objects, I'm going to throw that into
-next this weekend.  If any of these ends up picked by the trees of
relevant filesystems, all the better - just ping me and I'll drop
the commit(s) in question from the series.

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

-- 
2.47.3

