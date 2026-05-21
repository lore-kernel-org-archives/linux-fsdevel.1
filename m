Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BB0B360ED5;
	Thu, 21 May 2026 03:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779332859; cv=none; b=NUezExeGLzduom4BN+pfy/MO/poQr+3TUsvvOvd7y5AEmnC6IWryodIWzG6hOOJGi9j+PwBzJ5Yi4cXSGPY5ROn/KonLyUTZuQ4WsA3plmEpM+ZRw3eABIFUfHO5ygvh51Sp23cMpKiV+7ks8aA3CNSGHk4lsk1/08H63EKJHGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779332859; c=relaxed/simple;
	bh=SP8yZ67v2hmThS9gI2f7oNfW6Y0GtZImkZ2fPPoeHUA=;
	h=Date:Subject:From:To:Cc:Message-ID:MIME-Version:Content-Type; b=R1Urglc/tgEAgX7CyL4TqMjWVYtdIF42FqLSk6XMOGVyOUAz9vR/YtAlC2E8WhBM0bAr3XCBEFUPAAuR2CCIkBURqLEHCxgF1JnaFRlIT4/A/6B00SuZQsMgiz194pc3LPAZJtUlL82gZlT/DUOuSFO/AHcG8JylBPwspZwL9lA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MUAuvoGT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MUAuvoGT"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 9C6171F000E9;
	Thu, 21 May 2026 03:07:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779332856;
	bh=5hSkCkDcUGquuknP0YBNXRi8VgqLxM7BWkLef930gnY=;
	h=Date:Subject:From:To:Cc;
	b=MUAuvoGTxekl8d2fzFD7whg3fZ80EwMQ3vWHYLvpMDrh5CffS0/yIPr+sTDrG8wXc
	 hah3WaCmco9VDhHAGlsnVKXJL4MmTBSjbRJHK7YCkFsvsh5qbjc4gWdgyeHSyAUDZ6
	 FoWQS0EpZmnT/SuSElNNqcKjupiaX9n3MAcnuYqET5FPcIhEe8lUpNYaaORWs/CJEi
	 mCeAsOwx9KyaVpeJ6vflbH9TUTI9+zN5mzebVm3if4TTeQEgN99ZRrxgPedf9f5RXo
	 aiTeT88C9BygXAIRiQeRl585cRmPvu1DwqF6I4tqJPlPYtEJimEMqbpwY+0D57yvH+
	 K/8BCzghkZRnA==
Date: Wed, 20 May 2026 20:07:36 -0700
Subject: [GIT PULL] libfuse: new mount service container fixes
From: "Darrick J. Wong" <djwong@kernel.org>
To: bernd@bsbernd.com, djwong@kernel.org
Cc: fuse-devel@lists.linux.dev, joannelkoong@gmail.com, linux-fsdevel@vger.kernel.org, miklos@szeredi.hu, neal@gompa.dev
Message-ID: <177933241816.3536811.12585235323301633919.stg-ugh@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Hi Bernd,

Please pull this branch with changes for bsbernd/fuse-service-container.

As usual, I did a test-merge with the main upstream branch as of a few
minutes ago, and didn't see any conflicts.  Please let me know if you
encounter any problems.

--D

The following changes since commit 93892e469ddb9f5bd3b0923d95410a9d5dba65f7:

libfuse: fix cppcheck warnings in the new mount service code (2026-05-19 15:04:54 -0700)

are available in the Git repository at:

https://git.kernel.org/pub/scm/linux/kernel/git/djwong/libfuse.git tags/fuse-service-container-fixes_2026-05-20

for you to fetch changes up to cc9f7792afe2cb3df4c5cc71ab2ff5ba270acd8d:

fuse_service: fix uninitialized variable (2026-05-20 19:57:57 -0700)

----------------------------------------------------------------
libfuse: new mount service container fixes [01/12]

This is a collection of bug fixes, codechecker, cppcheck cleanups for
the new fuse service container code.

With a bit of luck, this should all go splendidly.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>

----------------------------------------------------------------
Darrick J. Wong (4):
fuse: use fuse_args in try_service_main instead of opencoding it
mount_i_linux.h: fix whitespace error
mount_service: fix some pointer handling
fuse_service: fix uninitialized variable

lib/mount_i_linux.h  |  2 +-
lib/fuse_service.c   |  2 +-
util/mount.fuse.c    | 71 +++++++++++++++++++++++++---------------------------
util/mount_service.c |  4 ++-
4 files changed, 39 insertions(+), 40 deletions(-)

