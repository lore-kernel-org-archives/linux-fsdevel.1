Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A5CE31ED8B;
	Tue,  2 Jun 2026 01:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780365222; cv=none; b=GTpmw3+o0NdxQ1ia/RgNDlfy+J1OizYUTnGeRt19FX9EDrRCZyS9OODNnCfyaeI3MrPpf1wi1+QhJxekokL9stfGpJRejVKjaQRSl6LLVwtarIocLuzM5G1Amxbxc/f5runDuI5x07wGCBzhGeZ1drEFse/M69gMoDfyoyL8XME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780365222; c=relaxed/simple;
	bh=tjyKspkJ1LgAWN2Mxni8AN27xGO9q3yAKpsjQu0lZpk=;
	h=Date:Subject:From:To:Cc:Message-ID:MIME-Version:Content-Type; b=XrCzNJXg8kk6fiEzehYRMlFlbmxF63yfQ8DTMWk2SzdzCGIVo3grM99bSEYspPDCcFoL1Qx4JHGe6n7Y7mRGzA6RVVXKBFFTH9vkEXnR1DG4BFuLMnDG28+BV+Nmth6ope5Cwky8cJ1LsTO80SC56mO1MRqTiro/1Fl0pWGDlk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MGW4gPDV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MGW4gPDV"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 721141F00893;
	Tue,  2 Jun 2026 01:53:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780365221;
	bh=Nj+VRd7OK1LJX1OqynSRL879zyEyE4QoCPGI9t5tilw=;
	h=Date:Subject:From:To:Cc;
	b=MGW4gPDVeiDKrSc+R44V/ZSNj+5FQGqh5YqxLtAJ5bdQlFRcra+gfoixAipuco+lE
	 RfH8svg7ji+YNZulS+PalbYoLRh1Q4t+jFjvuc5ipLK7ondcaCkm5WM4sC6U1A0YPC
	 pTXwkYaJ9W2ijBye3taPoV4DP0abPwHRMxl5LsUclTbM7F4eV8XBuOHDTQn8r6FALX
	 DYzbAunF4OZa5pPTnjsaUm0nel6yl3Gm0ycLds9MaHH+SulLjNAFVs/wzSb+jXS5lJ
	 0BJiI0tE2mwHLagbqXv7eZ4/1nkjgR7NqK2aiC5RqOfKOSCBapO0hT6j+0Mp7hHNU9
	 kn0m7FS2KUN2g==
Date: Mon, 01 Jun 2026 18:53:41 -0700
Subject: [GIT PULL] libfuse: more random fixes for fuse service containers
From: "Darrick J. Wong" <djwong@kernel.org>
To: bernd@bsbernd.com, djwong@kernel.org
Cc: fuse-devel@lists.linux.dev, linux-fsdevel@vger.kernel.org
Message-ID: <178036512347.432506.164688566914401782.stg-ugh@frogsfrogsfrogs>
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

The following changes since commit b71dd2629ff24405ad95814ba24773a24436a49e:

Merge pull request #1444 from bsbernd/fuse-service-container (2026-05-26 19:56:02 +0200)

are available in the Git repository at:

https://git.kernel.org/pub/scm/linux/kernel/git/djwong/libfuse.git tags/fuse-random-fixes_2026-06-01

for you to fetch changes up to 82f46798b91b23e38329f7e276342f306a8507fa:

mount_service: call the new fsmount ms_flags helpers in the right order (2026-06-01 18:51:24 -0700)

----------------------------------------------------------------
libfuse: more random fixes for fuse service containers [1/2]

Here are some miscellaneous fixes for libfuse.

With a bit of luck, this should all go splendidly.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>

----------------------------------------------------------------
Darrick J. Wong (3):
fsmount: don't truncate ms_flags in set_fsconfig_ms_flags
mount_service: don't pass the chopped buffer to apply_fsconfig_mount_opts
mount_service: call the new fsmount ms_flags helpers in the right order

lib/mount_fsmount.c  |  4 +++-
util/mount_service.c | 14 ++++++++++----
2 files changed, 13 insertions(+), 5 deletions(-)

