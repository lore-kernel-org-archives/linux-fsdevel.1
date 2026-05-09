Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 491173822A1;
	Sat,  9 May 2026 18:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778351969; cv=none; b=ApWN1IeO03h/83tfWRTY7fdcULt4iyXaoZzvHUqLiuGHfCozaWMgFEr44lTwb2Ij+wUVMXjQQX7g8W8rKqkbFjW+lGwl/mSlhYMsFc1+nuTy6bdK0DXUTdLeGGvQz4dK7ey/qKOtmqwcfZJA4rbjjYPM5KI7MwugI+IqhALSxVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778351969; c=relaxed/simple;
	bh=QkyLmR+6zE4gx0l2d2bJ8D52daJqzGf8F5sAEUQeXaY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Zks0chcerSe81Oonm5N7wwn3sDuM3q3A8w0Et94rv+a9wS5pUqGIhRbE5obO66bmqJH1armMYoIYhCm0ge+ioTkR1mlm+IDwDbX4VA5wyOTnO0mu1zVJbsEzCEyVlVebBWWFkQWNbi0GdklMncv5MlR4+0VAdDzso9OAEiUaT4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cnwi8s5x; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cnwi8s5x"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A64CDC2BCB2;
	Sat,  9 May 2026 18:39:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778351968;
	bh=QkyLmR+6zE4gx0l2d2bJ8D52daJqzGf8F5sAEUQeXaY=;
	h=Date:From:To:Cc:Subject:From;
	b=cnwi8s5x9A3RTFc6UotsxULSUD7C0l8FtWvwexwcDb5CIjj2dRJf2+gSYiHORL4uS
	 XqG6HU1UuaO/Pk/QFcQ3MqaIUJGmQMgp4WLo0AllqZy+5rDiB/Pzh4Y3/ZvENQDrt6
	 Wt1mPcYImHTNuYFtBCW+vBV7woEjy+JbDMqLhsFx24F2cphhKXNEyfLn+zC0ncuuGQ
	 G01U7d8aq305JzeiTA3ZAAjF3rOTB1klAaMbXLajqO0bp1cw+Hi2LHEa9f99FdLLzP
	 WgmEGDV+xc2w2tdFqg0RiRQqbsCeaWNki6p4kI7kUVlDqcJ+3eA8tEU+gmWsy+PvDw
	 ALnnj3ekOD/eg==
Date: Sat, 9 May 2026 11:39:13 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: fsverity@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
	Amir Goldstein <amir73il@gmail.com>,
	Christoph Hellwig <hch@infradead.org>,
	Colin Walters <walters@verbum.org>
Subject: [GIT PULL] fsverity fix for v7.1-rc3
Message-ID: <20260509183913.GA11883@quark>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 7fd2df204f342fc17d1a0bfcd474b24232fb0f32:

  Linux 7.1-rc2 (2026-05-03 14:21:25 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/fs/fsverity/linux.git tags/fsverity-for-linus

for you to fetch changes up to 0c8c88b8eb82a2a41bec5f17c076d6312dc40316:

  ovl: fix verity lazy-load guard broken by fsverity_active() semantic change (2026-05-06 08:37:30 -0700)

----------------------------------------------------------------

Fix a regression in overlayfs caused by an fsverity API change

----------------------------------------------------------------
Colin Walters (1):
      ovl: fix verity lazy-load guard broken by fsverity_active() semantic change

 fs/overlayfs/util.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
