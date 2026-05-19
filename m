Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 751BD3E8686;
	Tue, 19 May 2026 22:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779229484; cv=none; b=rP7y4X/Suhb100mFul7XzG7dxT8XUfYi2A8J9+Y48GD8WncmxUhXNZX9kvENXAZw1AkmVJI0AXIRcXNDkW+pRjYlSf0YxD6I6VBYROvv0xPfg1JEje/JOOfVEFtLQJe7ROJBqlQupD1pn7JkFS+A3QUR8yC4zos476vK/3fR7Cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779229484; c=relaxed/simple;
	bh=CZG3Muz3K15DWrRj3KE1K8j1DlqfxMHARMbmNlAnYdU=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hZSZKXBHUvNDqMoHrYy1wI6m/vJaQI8q7WJXWOCs0vgBIhkAt2wwmxlbV0uFfuWQWHZnsAPu+aEVgw63rio/wFKzHyV8tujwwRCqLbkfbULANia+Poq3QWFyyofrGGE3z+EeMliGZtfr1nRNDY5tJhL9G9P3j7XMUqgWN34H4mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OjqSlg0t; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OjqSlg0t"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 3784A1F00893;
	Tue, 19 May 2026 22:24:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779229483;
	bh=xiqF11beL9J+4TkoqyEwbkYIVLquxE4yjJIE5aCvWUE=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References;
	b=OjqSlg0tswGVq46lEpABPArNaGSR//pAM/ykWnnhPRGik1cc9huF6AJOcLuUTI1rz
	 OM+NO1jCm/d44h5cYw7lRDz0No62sexoUBav3yQGghSyQZ8uAenaGP0KKkCjDwbZz3
	 XKZSbuKHU4VQBxZmeY2hwwsctMNEqG6MN10IWJxMkGQmv+9kHzpSbFm29kylAwLDl+
	 vber365CyIgiVYyjjfzwGUR0+TZD6MjwxxyzhECFTRSkZ9MAchDJHCMniElsa8tjG1
	 NAAZcdObt4QudgqEK9GpqQ/9/EEfDvz37wFH+x1ghbxii2CpUF2mHV3SY9k4Asw32J
	 zbs7cskFwtjwg==
Date: Tue, 19 May 2026 15:24:42 -0700
Subject: [PATCHSET v9 1/4] fuse: cleanups ahead of adding fuse support
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, miklos@szeredi.hu
Cc: joannelkoong@gmail.com, linux-fsdevel@vger.kernel.org, neal@gompa.dev,
 bernd@bsbernd.com, joannelkoong@gmail.com, fuse-devel@lists.linux.dev
Message-ID: <177922944800.2436629.7011047808676668088.stgit@frogsfrogsfrogs>
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

In preparation for making fuse use the fs/iomap code for regular file
data IO, fix a few bugs in fuse and apply a couple of tweaks to iomap.

If you're going to start using this code, I strongly recommend pulling
from my git trees, which are linked below.

With a bit of luck, this should all go splendidly.
Comments and questions are, as always, welcome.

--D

kernel git tree:
https://git.kernel.org/cgit/linux/kernel/git/djwong/xfs-linux.git/log/?h=fuse-iomap-prep
---
Commits in this patchset:
 * fuse: move the passthrough-specific code back to passthrough.c
 * fuse: store backing id in fuse_backing objects
 * fuse_trace: move the passthrough-specific code back to passthrough.c
 * fuse: clean up per-file type inode initialization
---
 fs/fuse/fuse_i.h          |   30 +++++++++--
 fs/fuse/fuse_trace.h      |   33 ++++++++++++
 include/uapi/linux/fuse.h |    8 +++
 fs/fuse/Kconfig           |    4 +
 fs/fuse/Makefile          |    3 +
 fs/fuse/backing.c         |  126 +++++++++++++++++++++++++++++++++++----------
 fs/fuse/dev.c             |    4 +
 fs/fuse/file.c            |    5 +-
 fs/fuse/inode.c           |   40 ++++++++++----
 fs/fuse/passthrough.c     |   38 +++++++++++++-
 10 files changed, 240 insertions(+), 51 deletions(-)

