Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F3362765D7;
	Wed, 29 Apr 2026 14:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777472356; cv=none; b=mxGtU7M+D4d8vw8kYWU342n1WVtf+F9N4URY/ZGvKVjNcYgn3JbRSY/aKqtLDR0RLuGFJ8TowaTWFi2bki7CeP68N2mKoJpyddXOeObuX2pM8C+DltsUM8Ff+ZTlclrNne7+q8aLzupL0iPbSxAvhVpLsa0wqc1lohcuX7HI5jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777472356; c=relaxed/simple;
	bh=nBmgSK/pTCxYxvFQYpx3+CfAJ/Lu2x2u+09EFQAN7l0=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T2w5sqTebg7kAMVtuVqcVZ5JiI7ADbwa5S+ACtzzn1aAM5vHOq+BPUJ+rWWAKcRsbNHC+FGbjccBdG5h+VWrPLWOmAdARNn1dyJ2ZznI1mw8J7WsQeECUVTfDjllbNiz6llLtSp499ayMuQq7tdM7W43jP4c3XOk3vSwV4XjrGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pLNE//De; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pLNE//De"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A137C19425;
	Wed, 29 Apr 2026 14:19:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777472356;
	bh=nBmgSK/pTCxYxvFQYpx3+CfAJ/Lu2x2u+09EFQAN7l0=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=pLNE//De76RMUOv6JVdQc4ThTMqdjgeZm8c4AYrgU7ekwUvhGtU6PZqAg41VD41L2
	 C6ds4QiwntSOKx+XcqAOP9L5tZektJfTsYhixE7e21VJoFIki7kQJ7rUf5Y7v6U7Wl
	 StyTeZZehQTQ1AnfFK92FBQtJm9YTI8Fm5GEJXBjuwSky2EvG5+JEJSOx80SSwk8RQ
	 /ioOJaNdso1zcTaKBB5pnTFobdTEp56PKAwNDe8B1IRbCzdLNXX+9T3RkgQbyxVVrw
	 xELbebnIQAzxV9wTm21ShTIxYlXiQP/ViCNWH7zcspzOcReeUkhsSSL3WpiBV898Ey
	 C/PaAmRN1YpVg==
Date: Wed, 29 Apr 2026 07:19:16 -0700
Subject: [PATCHSET v8 3/6] libfuse: implement syncfs
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, bernd@bsbernd.com
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org,
 fuse-devel@lists.linux.dev, joannelkoong@gmail.com, neal@gompa.dev
Message-ID: <177747212442.4105754.7242835990761551019.stgit@frogsfrogsfrogs>
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

Implement syncfs in libfuse so that iomap-compatible fuse servers can
receive syncfs commands, and enable fuse servers to transmit inode
flags to the kernel so that it can enforce sync, immutable, and append.
Also enable some of the timestamp update mount options.

If you're going to start using this code, I strongly recommend pulling
from my git trees, which are linked below.

With a bit of luck, this should all go splendidly.
Comments and questions are, as always, welcome.

--D

kernel git tree:
https://git.kernel.org/cgit/linux/kernel/git/djwong/xfs-linux.git/log/?h=fuse-iomap-attrs
---
Commits in this patchset:
 * libfuse: add strictatime/lazytime mount options
 * libfuse: set sync, immutable, and append when loading files
---
 include/fuse_common.h |    6 ++++++
 include/fuse_kernel.h |    8 ++++++++
 lib/fuse_lowlevel.c   |    6 ++++++
 lib/mount.c           |   10 ++++++++--
 4 files changed, 28 insertions(+), 2 deletions(-)

