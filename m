Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 916563E9295;
	Tue, 19 May 2026 22:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779229515; cv=none; b=U5IE4u6aGtJYHqTPVSIUEJsWVMJlp0QLfNHnKZ5min/Ha4jp3gKU6TG2EdKo8YpixjsXKcwvaW80i7Z6dqGaFw8IhAdYhS13xpgTOgGJoSnMsxLhrrwiVGgubw/t3gp5QmUAbdJdE4KCN6S5pJ2Fo7hazWDH77Tsbc5kOh+y8S4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779229515; c=relaxed/simple;
	bh=Ra9CmlV9BcYaCni2BzEalrE+dqYcLnTPIV1kpfc64HE=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pmU+IJcik08J/20R3wXft72U/YQcdXv9nr10tu7Yr0DUwjGH4ieHzBCSQrOjqVtUSEXCkBd+/PWLzdrVYya0SS8caQGLsog0gaH0UxWWXHhQP93pfT/7S9W0GTcRXIY0uK8ux2lJ7pUeb4t7as4VOvzsKCPNW4iustfki+Kzhkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fVYO8v+K; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fVYO8v+K"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 470AC1F00893;
	Tue, 19 May 2026 22:25:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779229514;
	bh=VUi3RdSy3oRjLxQlacDDgo8dG6G20fMG69qGqMkZ7Fw=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References;
	b=fVYO8v+Kn4OtSRyzEyaH0ewYiejOu0XAabAv/Mm+F2WYzhE/GvME8AbJtyB5DzQw+
	 HL3l6fa9HJ9ax4Ud0fK7xkrfMPpW10tyOXFY4wxmW3rqMCO4PNqwyRyFKvzmDIsV81
	 qKtF5ETJRdwz7YsbOZzRna+Hf3Xwj+oYs7wQJp2y/Uz6JE1To+HwKOEsPdG85k5XJW
	 eiBWQMYd1NTFmgL6yM0S7rL1aqMj39qsM6tY9uFtj6xu0KZm7VlGp/CJS+I2goEu1f
	 tWMQ520SC3wyFvzeWNpg34rNyddUPtgPzDWrku4rw0UH/qthyguWcBB9e58fU9BwAG
	 7peNvnmEXjrzA==
Date: Tue, 19 May 2026 15:25:13 -0700
Subject: [PATCHSET v9 3/4] fuse: allow servers to use iomap for better file IO
 performance
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, miklos@szeredi.hu
Cc: linux-fsdevel@vger.kernel.org, neal@gompa.dev, bernd@bsbernd.com,
 joannelkoong@gmail.com, fuse-devel@lists.linux.dev
Message-ID: <177922945706.2437300.14187386529698019759.stgit@frogsfrogsfrogs>
In-Reply-To: <20260519222229.GB9544@frogsfrogsfrogs>
References: <20260519222229.GB9544@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Hi all,

Now that we've gotten the basic mapping plumbing installed, it's time to
actually get fuse servers out of the business of handling file I/O
themselves.  By keeping the IO path mostly within the kernel, we can
dramatically improve the speed of disk-based filesystems.  This enables
us to move all the filesystem metadata parsing code out of the kernel
and into userspace, which means that we can containerize them for
security without losing a lot of performance.

If you're going to start using this code, I strongly recommend pulling
from my git trees, which are linked below.

With a bit of luck, this should all go splendidly.
Comments and questions are, as always, welcome.

--D

kernel git tree:
https://git.kernel.org/cgit/linux/kernel/git/djwong/xfs-linux.git/log/?h=fuse-iomap-fileio
---
Commits in this patchset:
 * fuse: implement direct IO with iomap
 * fuse_trace: implement direct IO with iomap
 * fuse: implement buffered IO with iomap
 * fuse_trace: implement buffered IO with iomap
 * fuse: implement inline data file IO via iomap
 * fuse_trace: implement inline data file IO via iomap
---
 fs/fuse/fuse_i.h          |   18 +
 fs/fuse/fuse_iomap.h      |   37 +
 fs/fuse/fuse_trace.h      |  526 ++++++++++++++++++
 include/uapi/linux/fuse.h |   29 +
 fs/fuse/dev.c             |   10 
 fs/fuse/dir.c             |   36 +
 fs/fuse/file.c            |   83 ++-
 fs/fuse/fuse_iomap.c      | 1320 +++++++++++++++++++++++++++++++++++++++++++++
 fs/fuse/inode.c           |    2 
 fs/fuse/iomode.c          |    2 
 fs/fuse/trace.c           |    2 
 11 files changed, 2033 insertions(+), 32 deletions(-)

