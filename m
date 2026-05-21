Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 415F837EFF6;
	Thu, 21 May 2026 19:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779390865; cv=none; b=VkwsgcpnI6ynSamDolKz5Tws0DmDiOkGn2eAfg8fb2aA+G9TxE/+OiCR/Dmc5UHR82L+0ozA8rJQ0c/msAbbbu8sYDOc1lkIFkyUKJwl6vWXjKHRs20y0qlKMM2xXIE0acjVFNBZ2kkd4m1kZl0HGIy0ALxc1cgilE77iHRFNyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779390865; c=relaxed/simple;
	bh=+ZPxWV6uBkJcCyegJgmCT4PA/9c6F5xrXZvLHtxAkLk=;
	h=Date:Subject:From:To:Cc:Message-ID:MIME-Version:Content-Type; b=izw6PbU99go/AFPcsHDMytryY68+uZTsPOH30x9b/GFDLRRbSPOvx9/54QB7wazBtf0mv2FB4LtTRt2wwCotv6pwZDwQhdNzamli+u92ZmVRMFP4b376VYdICb/wJKcDC221ZbMIriR1Lp2nIdTwiDWw5WfwPgvkICAJgxawMVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hpqbeAFl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hpqbeAFl"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id D159A1F000E9;
	Thu, 21 May 2026 19:14:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779390863;
	bh=AVBJsDOztpCJw/sd7VfXCTELXMgqfLq2/U6lPfe3CEI=;
	h=Date:Subject:From:To:Cc;
	b=hpqbeAFlBv3EzR5nQMiZMMjvoMSfP+DeMRLAWuyPb0kTwH0nHOULi8w+QfyQPf0nc
	 vzoBMYx6xvaICIUN/sklBMwmdGFiLmCOBPBY2mTAycnR+tQ2SXhgfYRW/k1G8eQKFu
	 ODNevwpT/QyxNb5jC4Nj+EbU7oXlSDG6hRHeksYhNH9AdDISgzohYMynTKrQVrsH/2
	 1fWkg4y0FXakn+cgIzKEXc5i0US5gjbIl+qRTlbP5r7bXNZK4HtGBI8WHXRnW2OqIX
	 Zhwvue+mW4Mj2FYFHjbbz/Cm14d+u1Ghgu8ixa9Cdgxjbk9QSkCyvW8hmWxoqSLe8x
	 HbtRADtQrL5TQ==
Date: Thu, 21 May 2026 12:14:23 -0700
Subject: [GIT PULL] libfuse: new mount service container fixes (3)
From: "Darrick J. Wong" <djwong@kernel.org>
To: bernd@bsbernd.com, djwong@kernel.org
Cc: fuse-devel@lists.linux.dev, joannelkoong@gmail.com, linux-fsdevel@vger.kernel.org, miklos@szeredi.hu, neal@gompa.dev
Message-ID: <177939070141.36130.14110789652036671732.stg-ugh@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Hi Bernd,

Please pull this branch with changes for libfuse.

As usual, I did a test-merge with the main upstream branch as of a few
minutes ago, and didn't see any conflicts.  Please let me know if you
encounter any problems.

--D

The following changes since commit cc9f7792afe2cb3df4c5cc71ab2ff5ba270acd8d:

fuse_service: fix uninitialized variable (2026-05-20 19:57:57 -0700)

are available in the Git repository at:

https://git.kernel.org/pub/scm/linux/kernel/git/djwong/libfuse.git tags/fuse-service-container-fixes_2026-05-21

for you to fetch changes up to acb5e53dabb8383edb0474e901f159d43284bf5b:

mount/fuse_service: replace strcpy calls with memcpy (2026-05-21 12:11:06 -0700)

----------------------------------------------------------------
libfuse: new mount service container fixes (3) [01/12]

This is a collection of bug fixes, codechecker, cppcheck cleanups for
the new fuse service container code.

With a bit of luck, this should all go splendidly.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>

----------------------------------------------------------------
Darrick J. Wong (4):
mount_service: rename IGNORE_MTAB and constify it
mount.fuse: constify arguments to try_service_main
mount_service: fix null pointer deref in mount_service_init
mount/fuse_service: replace strcpy calls with memcpy

lib/fuse_service.c   | 16 +++++++++-------
util/mount.fuse.c    |  5 +++--
util/mount_service.c | 43 +++++++++++++++++++++++++++++--------------
3 files changed, 41 insertions(+), 23 deletions(-)

