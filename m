Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C705040DFD7;
	Fri, 16 Oct 2026 10:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792145833; cv=none; b=XPdAmNaVuxDuuhLMRz7MKSLFAUeo7n795DQtY0J7zEv1GLBo88MwAFHwrA7jpn1cHkUMk3gDPEvEnrQLvDDf3f8eVG45HmBZ/Wgyv/dEAUr9rYBSMh+c/dXT6cznGv4bcVjtI7FNuq3WtO25qQleYiNFjG8dzx2b7J4aJgIgGbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792145833; c=relaxed/simple;
	bh=0JQ7+EHzXc9e/bw4FAAgk4tmDxWlc6C1VSQvav7/MBk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pJiBwypZdPIVTdD1PpsAy3mON5u12XdyTOiEXjBKvLgMSbnL01kR6aVWgUFYtZKsw4p6saZHx6yZXoheXfvgBnKgKonvK7k1f3xILWmZvO/9P921/SZK6T2AnK4GCN4ehmHtc2TKBTphhhdm9OeNczPN0Oz3P1lVTiLVlF8zvbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a+t4laMi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a+t4laMi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03D7E1F000C4;
	Fri, 16 Oct 2026 10:17:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792145832;
	bh=lODHsqTZMCmx2TCE1OCNt3XXDWGsFd7E/J5UsFqw2zw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=a+t4laMiT8mA8do22kuPsnpW1a/UQwr4IW/p8ZCXzBPpKUl5yiRGr0K5Zf3WT3B1G
	 xYwwzv/CH2w9dwo6SQ94d95FmO6Ygb0RJ3tkqWV8Avp88NzOEzptm93SY4DV6GYQ8n
	 Eb17xDw1HslVV40T05fum/4BLWYrFdbqciH9oUPzeXiRztC4JE1+nsPmmkNY6kUZV4
	 cySYayW0SrqEJmgOkvNhlioQgcPGfBB43D0bPrhF30r+7iefYXmkwb0XMlM1qf4IG3
	 LdEnF/iCcU8QGIam4vuN4+XxL2T66lmlKgQAUP200+p3O5fS1fi5VZiSycgSrraC08
	 fSacZTIQSomwQ==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL 06/19 for v7.4] vfs binfmt
Date: Fri, 16 Oct 2026 12:16:58 +0200
Message-ID: <20261016-vfs-7.4-rc1.binfmt-12f955685a99@brauner>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261016-vfs-v74-41eaf6c4712c@brauner>
References: <20261016-vfs-v74-41eaf6c4712c@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2158; i=brauner@kernel.org; h=from:subject:message-id; bh=0JQ7+EHzXc9e/bw4FAAgk4tmDxWlc6C1VSQvav7/MBk=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRd/DmnToTr+cN15QkyswNK/yfab7Ww/rhJsOF2mOzHU o00r8YZHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABN5Hcnw35PxQG3p2nKn61oB szv+GS//wf+6bqmc6IWunwsfhc+5287I0P52p/qkJuMJj1ebhfm2hviJbiqtXeoe91B5U5ueaF4 LHwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Hey Linus,

/* Summary */

This only lets punctuation delimit a binfmt_misc register string.
Arbitrary delimiters never made sense and nothing uses them. Every new
flag shrank the set of possible delimiters and made extensions more
hazardous than they need to be. Letters, digits, whitespace, control
characters, bytes above 0x7f and the backslash now get EINVAL.
Everything deployed uses ':' anyway. This extends the fix that rejected
a flag character as the delimiter. Selftests and documentation are
included.

/* Testing */

No build failures or warnings were observed.

/* Conflicts */

Merge conflicts with mainline
=============================

No known conflicts.

Merge conflicts with other trees
================================

No known conflicts.

The following changes since commit cee9395acd8043be0644b25c34bfa86623f2b935:

  Linux 7.3-rc1 (2026-08-30 13:34:40 -0700)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-7.4-rc1.binfmt

for you to fetch changes up to 87b76786cc04c8137133a360088d94ab2ed592ca:

  Merge patch series "binfmt_misc: only let punctuation delimit a register string" (2026-08-31 10:06:36 +0200)

----------------------------------------------------------------
vfs-7.4-rc1.binfmt

Please consider pulling these changes from the signed vfs-7.4-rc1.binfmt tag.

Thanks!
Christian

----------------------------------------------------------------
Christian Brauner (4):
      binfmt_misc: only let punctuation delimit a register string
      selftests/exec: test delimiter restrictions
      binfmt_misc: document the field delimiter
      Merge patch series "binfmt_misc: only let punctuation delimit a register string"

 Documentation/admin-guide/binfmt-misc.rst        |   3 +
 fs/binfmt_misc.c                                 |  12 ++-
 tools/testing/selftests/exec/Makefile            |   4 +
 tools/testing/selftests/exec/binfmt_misc_delim.c | 127 +++++++++++++++++++++++
 4 files changed, 143 insertions(+), 3 deletions(-)
 create mode 100644 tools/testing/selftests/exec/binfmt_misc_delim.c
