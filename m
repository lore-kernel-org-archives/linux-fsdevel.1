Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A3A9276028;
	Wed, 29 Apr 2026 14:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777472310; cv=none; b=NBB/tCMdMOprfjkxfsiCiLulgWfuLwdsmWMfH7GPPOQo1+7l9QHvv+Z0ttJTD9NFXPU4gM4iT7vurpT09WS8y9HoLdrscw+rjopVtszSBAoU3Lnp2TGcB6VqrhNTU3Jalywwa14w2yUh+BTbktTtoXQjnPIh4JNBQXcmtjebdwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777472310; c=relaxed/simple;
	bh=DaaGUWj4xwnsM0FWWB8oaTN57ah8VkNfx/dA0IffgCk=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=StP0ayzhSEWLZ5ViVsmG3gtK47B+UKnLACeagC/jlmtKRLkpilJHYFt8dIVz6CAnI/VAEBnj6PfU+fOZGFg/qMUwHrAzq4hvojmpiVh1aFLl74cBhdEjl4KaxW4GNB1wiMQxAjlvI6PWSBGy5uEc9n8Bm/wcoRZITczRGB3bOBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kJQVV9nZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kJQVV9nZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 985B2C19425;
	Wed, 29 Apr 2026 14:18:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777472309;
	bh=DaaGUWj4xwnsM0FWWB8oaTN57ah8VkNfx/dA0IffgCk=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=kJQVV9nZfN8WPDQKD19NCZQa8YrY69qpAV5TJqKQGu8I1ZpOK9lQNJzXPxOKdgra4
	 zfHRXCb/Qg2epCd+enM7hVs6VBRAfSMdiLFC0uftcqHQdflOJumJl6NYOb0gg07o04
	 YUwKXW+3ZJ8PM1Kq7iTaN7IToz3zm4dyvIR1RPEgDel2bUklYKDGycUDeWGZanQSGZ
	 MRvy1/tF5uQNJMaQETMbzvWoUcl4l/pZlzFavk1agOPy/UVMv3qekLsrw/rqkJhZGt
	 sY4b7PqS0yyOeRoO+yYTXhyxkeP5u4u3UxtswzpqGcDuXqnSZxZaL3NoxC7W2qDXPy
	 Ct3tyw72Gmx2w==
Date: Wed, 29 Apr 2026 07:18:29 -0700
Subject: [PATCHSET v8 8/8] fuse: run fuse-iomap servers as a contained service
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, miklos@szeredi.hu
Cc: joannelkoong@gmail.com, neal@gompa.dev, linux-fsdevel@vger.kernel.org,
 bernd@bsbernd.com, fuse-devel@lists.linux.dev
Message-ID: <177747207487.4104197.2228921108809032839.stgit@frogsfrogsfrogs>
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

This patchset defines the necessary communication protocols and library
code so that users can mount fuse-iomap servers that run in unprivileged
systemd service containers.  This is largely adding new kernel calls and
protocols so that anyone with an open fusedev fd can ask for permission
for anyone else with that fusedev fd to use iomap.

If you're going to start using this code, I strongly recommend pulling
from my git trees, which are linked below.

With a bit of luck, this should all go splendidly.
Comments and questions are, as always, welcome.

--D

kernel git tree:
https://git.kernel.org/cgit/linux/kernel/git/djwong/xfs-linux.git/log/?h=fuse-service-container
---
Commits in this patchset:
 * fuse: allow privileged mount helpers to pre-approve iomap usage
 * fuse: set iomap backing device block size
---
 fs/fuse/fuse_i.h          |   10 ++++++++
 fs/fuse/fuse_iomap.h      |    5 ++++
 include/uapi/linux/fuse.h |    8 ++++++
 fs/fuse/dev.c             |    4 +++
 fs/fuse/fuse_iomap.c      |   59 +++++++++++++++++++++++++++++++++++++++++++--
 fs/fuse/inode.c           |    7 ++++-
 6 files changed, 89 insertions(+), 4 deletions(-)

