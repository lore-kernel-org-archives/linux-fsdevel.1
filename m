Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA66338837C
	for <linux-fsdevel@vger.kernel.org>; Fri, 22 May 2026 08:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779437259; cv=none; b=Pn9jkPjhSVL7QhhgJiPM0mHNbmky6YIF7axjB5hIIRC8kozF/DJMD1DSm/fis0h237xjvEuN3ifnNxSGT7ZcgePmCz6rQFbXegLVPlpzf+C+JCQ8T46p6OkJnHPZIIc5qvgqmlBjbbjBsWEshFL0g9VzSvHxCpAyEb/ugdbCW8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779437259; c=relaxed/simple;
	bh=sbn22Ab6F4JxQ9DA+8d9gkqt0j5KFigQFhFUtkhHf6U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WsILiZXieC7tBgfdxXIjidCyeAgTAm1nghfd2Kgoqe3RrEtqdTGytrnjPdUrS203yLFNLBdkw/0ojw/GfhTMjRysY+TnmlvUqNI7i6PXRIW5kmTlo7l+YLCikEW/Jwn/QJG66em3G342ykl+JHdmJzg4ULlXYxBTdwPrwNmDB/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hwPLzqQJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hwPLzqQJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BC691F000E9;
	Fri, 22 May 2026 08:07:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779437258;
	bh=bt1slAT8pFszpBYAj0TcAJOK5wXvq6Mh07DJXG+jPFg=;
	h=From:To:Cc:Subject:Date;
	b=hwPLzqQJiZIJ0CoiOa8jPsgRfdDcrE6wNcfSkMhZXBTkk5pqYW3nrU1roF17LyJ1v
	 HUXFz2HktsYH6C61v3ts0UFwP6afhRNR/Tvce+U1WE4sff4OSTIaM/sIHW5d0i4Hq1
	 /Uzn+uNPLl+5Se8kuGlV3UMOt2lOUnHK0KvHfRyef1Ps2NG9gYnHR/S9Jz1dmsMUF+
	 0EckACv/FYAacwaHnkBzG/TE/DV19BQsaUeDLH9GXCLUHnZ2sZjUdgt6wCTgVS4Itr
	 KuNs8JI/5DJ9qNkfpKSZOfoxGr9NDUVDSfmpqyO9FRenb9bJnCtdWTN4cRPrdfduHA
	 Mu3sXjPKBFItA==
From: Damien Le Moal <dlemoal@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org
Subject: [GIT PULL] zonefs fixes for 7.1-rc5
Date: Fri, 22 May 2026 17:07:26 +0900
Message-ID: <20260522080726.529603-1-dlemoal@kernel.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Linus,

The following changes since commit 5d6919055dec134de3c40167a490f33c74c12581:

  Linux 7.1-rc3 (2026-05-10 14:08:09 -0700)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/dlemoal/zonefs tags/zonefs-7.1-rc5

for you to fetch changes up to 3a8389d42bdf4213730f4067f8bfa78bae6564ef:

  zonefs: handle integer overflow in zonefs_fname_to_fno (2026-05-12 07:53:20 +0900)

----------------------------------------------------------------
zonefs fixes for 7.1-rc5

 - Avoid potential overflow when converting a zonefs file number string
   to an inode number (from Johannes)

----------------------------------------------------------------
Johannes Thumshirn (1):
      zonefs: handle integer overflow in zonefs_fname_to_fno

 fs/zonefs/super.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)
