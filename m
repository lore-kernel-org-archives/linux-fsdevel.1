Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 062974E3236;
	Fri,  9 Oct 2026 14:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791555651; cv=none; b=s9IlrdVb9BtfoFONbPmjE5Y1bk8oKmD1uGuALp2bd13TVzdNgPjqiMic0VvfuYqxmMQ9d3sHe/KWAJwGvhx5mS2CpaIg89QI16VVKSrXf5IVHUqqBRCbpA0Dw6dZJNhLfsXKJKrm2goCPVLdwTapWZGgiIIfXOuqmfYji6eXFEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791555651; c=relaxed/simple;
	bh=jQnnpJ+eiWNpDilfusC3mh+xJl/VnPgNoFr0L0B2Dfo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=PEIqAGwK8wS5ZUVNW8qS9SpjFe33gYRzGZBZS0Q2hHaqP0dqhrolJ2SpcdH8/fyg6sSLM+3U/zvhDznaQOlk447AYqPkVhK8UXADARUADI5/sYVmPQf4ytOF5F82GT4RkgQuRE2LNN/ul7pFL4iWVBK346KEpl7Liodp1jkx2Ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kZ3N1WA4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kZ3N1WA4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1EEE1F00893;
	Fri,  9 Oct 2026 14:20:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791555645;
	bh=BueQk2bmVcVfTSa0l8KCWdyLfA8hdh4wsn9LWxdad9k=;
	h=Date:From:To:Cc:Subject;
	b=kZ3N1WA4tvi8mHbzUtJKqUt/rbTgiM7+QycdTcdlJ/cX5v02kvs2Bjvb5qbRVG6eJ
	 saQswoLO3Yfiv4zcID7Bfu94s2PS9sQzGM7bYpqYiY0OAx9+782kJBiTADVAtIjNaJ
	 puc2va4uootXiPq0iabdq/GuPqHRTCaeTQrWUb/0mDA37JYTQdvz4IJbNERg/t76GU
	 CIFVWM3xVjYo8Q31OprcrSuywIOZlfQ1jnyEkZNhrPGMSk3syTuvx2ifEjMtPfhaBr
	 ILqiGcPcQBBN7dM5pbriR0rjJzzXq6a4PMh6spqC4h9v23EHAAxkkhyexLTO9lQ7/o
	 7DiORQ0KNmJEg==
Date: Fri, 9 Oct 2026 16:20:40 +0200
From: Eric Biggers <ebiggers@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: fsverity@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>
Subject: [GIT PULL] fsverity fix for v7.3-rc7
Message-ID: <20261009142040.GB321175@quark>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 72d3fcf802c45d00b300f25b848a93c3a2bd7c7e:

  Linux 7.3-rc5 (2026-09-27 13:55:01 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/fs/fsverity/linux.git tags/fsverity-for-linus

for you to fetch changes up to e58c3805ed325fe2d4ae2dd467c0486cc860b733:

  fsverity: RCU-delay the freeing of struct fsverity_info (2026-10-05 10:50:37 +0200)

----------------------------------------------------------------

Fix a regression from commit f77f281b6118 ("fsverity: use a hashtable
to find the fsverity_info").

----------------------------------------------------------------
Eric Biggers (1):
      fsverity: RCU-delay the freeing of struct fsverity_info

 fs/verity/fsverity_private.h | 15 ++++++++++++++-
 fs/verity/open.c             | 13 ++++++++++++-
 2 files changed, 26 insertions(+), 2 deletions(-)
