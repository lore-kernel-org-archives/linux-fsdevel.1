Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D21692F8E80;
	Thu,  7 May 2026 22:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778192122; cv=none; b=f3oc9KCMBus6rvZKPpsjHuG5a4S99DXWZKR0pHfDyYtCnAIvHXaqPpKxEuv0u8QdlnKNZdfv5s4YVnBDHd/qt8WhrMgxA4EuuRd/Y4k3Rnd5rUbLoay1Bp8132TYPRPt4EPtp3jok6NHew+KIJ3LnQSyc9x3kp3TadqMuoe+Ahk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778192122; c=relaxed/simple;
	bh=lbNTcq3tgcnfN3p1yogcoX1nobmFagdnDuNl8jbmmGk=;
	h=Date:Subject:From:To:Cc:Message-ID:MIME-Version:Content-Type; b=nIzQAJjYnhq18mOYr0+uwRIj3HGKXXVlRBPJwDU4dcshNdlnQJpzqL58BWJ5z0+tmqThpt9e7dVCDFjBTm6Vs/AvQ8mp9PECQ3ED2ljClkBEBwmz2gLHZALK9xSEKYDg4cD4Sa1AXwUod7H41Z0gStO3hCNN2A/imeyVCJIYios=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UWck9Njo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UWck9Njo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37A86C2BCB2;
	Thu,  7 May 2026 22:15:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778192122;
	bh=lbNTcq3tgcnfN3p1yogcoX1nobmFagdnDuNl8jbmmGk=;
	h=Date:Subject:From:To:Cc:From;
	b=UWck9NjogRbhOKPgo1dinW/PNIzkoRW6sUNCySZC0ttTpCxB9A2MffhQxecOQ2dmS
	 7+iOY+uirATWQI2CEn+n5EwUmKM39CHFoFUfDgHPQvYLci1Wdkdio0tIpVG9vSFEkm
	 wWaH6hX7gPTKKIxBEQV2WOoPd5bU9FS7SYtccVFspt4o3vz6QxIswqwL2mPzsavNRz
	 B9+FDrbAptNntozRPNDoxv4qEjWH1XdGXeT6cWbtgEi8GnEj+8YwVrHpsCf93sPJ8K
	 RWDK+9/fYfE/5DmmvRD8Xs8zi0c4TqL1YcIG0TdqhGAE/yq3o4ej96LNH7q1kiV19Q
	 eRrbioUTmVYrg==
Date: Thu, 07 May 2026 15:15:21 -0700
Subject: [GIT PULL 1/2] libfuse: new mount API and SYNC_INIT fixes
From: "Darrick J. Wong" <djwong@kernel.org>
To: bernd@bsbernd.com, djwong@kernel.org
Cc: fuse-devel@lists.linux.dev, joannelkoong@gmail.com, linux-fsdevel@vger.kernel.org, miklos@szeredi.hu, neal@gompa.dev
Message-ID: <177819210365.3493306.5644302857661456554.stg-ugh@frogsfrogsfrogs>
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

The following changes since commit e3db9d31953fc5640999adcc8b74a54dfde0e651:

example: fix cppcheck complaints about constifying pointers (2026-05-04 16:22:44 -0700)

are available in the Git repository at:

https://git.kernel.org/pub/scm/linux/kernel/git/djwong/libfuse.git tags/fuse-mount-api-fixes_2026-05-07

for you to fetch changes up to 1760a7221342ada367b5102641e3ecc9f03f7805:

mount_util: fix mount_flags entries for MS_RDONLY (2026-05-07 15:12:21 -0700)

----------------------------------------------------------------
libfuse: new mount API and SYNC_INIT fixes [01/11]

Here's a collection of bug fixes and cppcheck cleanups for the new mount
API code and the new SYNC_INIT code that landed in main recently.

With a bit of luck, this should all go splendidly.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>

----------------------------------------------------------------
Darrick J. Wong (1):
mount_util: fix mount_flags entries for MS_RDONLY

lib/mount_util.c | 4 ++--
1 file changed, 2 insertions(+), 2 deletions(-)

