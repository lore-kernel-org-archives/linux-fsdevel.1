Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8A0F2FB99D;
	Wed, 29 Apr 2026 14:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777472200; cv=none; b=JXFuwsi17yA62D6xfeLnCxt0GZjRPNyoDHTCjihwI2tSvQBgbObuW9SsEXZwahfK2IDTI9aULhwVbYqQ+L4WthuEgyMu2m6SIaxdMWSGiXEeOrYp25/PNAWF/1ywNT5KqsBCCHRCAJ1/bONI9oaw7iouQShydwE7XIz+qRBDtlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777472200; c=relaxed/simple;
	bh=2El4W1cAb2TmGGTDIUlHw6yduXG8rbb4GU/NEoRjryg=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cRicAt851DvdEso7hcJyD6q6tBtVDqUB9CvepbUahiXV5JRxsF6nVRR9zcwaO53B4rUPeX/VfZSz+dFREUk64TW2kKnF3eW8bsEHWQB9RKZoUMLcm3R4VdYup+I7yfei58Cqks8VmJbt4T4z3vIqltdw8JjC6FHvTTlsYqDSpAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qK4cwJcO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qK4cwJcO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA5FBC19425;
	Wed, 29 Apr 2026 14:16:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777472199;
	bh=2El4W1cAb2TmGGTDIUlHw6yduXG8rbb4GU/NEoRjryg=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=qK4cwJcOtYoL3k/Qx1GVw3nueEW6THVdAZ+/dC4Fwj6w+3EZw0Sdo6PXyj8bA1ipg
	 uqpJXDxPltqnCdn7TKhv5hydhILQFA1dvDYn8shyfv6HXrWza5L6eUGoeFtMO+0wTR
	 IkOAc6ZcBWdXCHqTjcsbi0dsK0Qta+KfwuyLytTnSdpn7O/brdXhHNqQWtL3cZyzJm
	 nm+rUo630LlPzP4b/TE/QxXyHFMCL9egAefsFkY3hHgXbcqB7Ngug8ClrHqUFkR3Yl
	 DaYSbAnGHaI/XrI6TsucKrsFYlaTz0jPEQ3Dmsl98CkMf7iW5+mOgJhqpdpMc+ExWw
	 ep/LO5Y5j/7kQ==
Date: Wed, 29 Apr 2026 07:16:39 -0700
Subject: [PATCHSET v8 1/8] fuse: general bug fixes
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, miklos@szeredi.hu
Cc: joannelkoong@gmail.com, joannelkoong@gmail.com, neal@gompa.dev,
 linux-fsdevel@vger.kernel.org, bernd@bsbernd.com, fuse-devel@lists.linux.dev
Message-ID: <177747203969.4101397.1905820467457875817.stgit@frogsfrogsfrogs>
In-Reply-To: <20260429141253.GQ7739@frogsfrogsfrogs>
References: <20260429141253.GQ7739@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Hi all,

Here's a collection of fixes that I *think* are bugs in fuse, along with
some scattered improvements.

If you're going to start using this code, I strongly recommend pulling
from my git trees, which are linked below.

With a bit of luck, this should all go splendidly.
Comments and questions are, as always, welcome.

--D

kernel git tree:
https://git.kernel.org/cgit/linux/kernel/git/djwong/xfs-linux.git/log/?h=fuse-fixes
---
Commits in this patchset:
 * fuse: flush pending FUSE_RELEASE requests before sending FUSE_DESTROY
 * fuse: implement file attributes mask for statx
 * fuse: update file mode when updating acls
 * fuse: propagate default and file acls on creation
---
 fs/fuse/fuse_i.h |   46 +++++++++++++++++++++
 fs/fuse/acl.c    |  118 +++++++++++++++++++++++++++++++++++++++++++++++++++---
 fs/fuse/dev.c    |   18 ++++++++
 fs/fuse/dir.c    |  105 +++++++++++++++++++++++++++++++++++++-----------
 fs/fuse/inode.c  |   14 ++++++
 5 files changed, 267 insertions(+), 34 deletions(-)

