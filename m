Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C066311967;
	Wed, 29 Apr 2026 14:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777472341; cv=none; b=NnP0liIj9SKoFz5aFPzHNEBHSuSDLNoz1ZLZ/bpgNMfS0gyeb/F7rbSY48lxbWm/a9DtWBZXIwMGi3zDGUsqYyIQVMz+6goNrKijon9EkMboEq2A+sNyxSTjpSQNPgm5/0joPZ8qcTtzIIazS6//sIu1iMtCATm7tBqVcToGvaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777472341; c=relaxed/simple;
	bh=tMckVzM+U76f+ySQKaU0rilZc9MmkTLaj6sBiJ3Bgx8=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=orJ3YZvDmAVC1iBFXjlaD/jgOiMLcAasBNiACjHuAz9n4aH6WqhcjHeg7IlhQwfnASKSlRGtyMQIjc1gy6UbPSb/IwMf3Eww37tkVDnh0J0qxf0QdCTpFwupvny/tLt7nM5LCHcFy61x1flwSUq16COrKFNnlw/6ZO0S+XcMbF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RAINlS08; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RAINlS08"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC5CAC19425;
	Wed, 29 Apr 2026 14:19:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777472340;
	bh=tMckVzM+U76f+ySQKaU0rilZc9MmkTLaj6sBiJ3Bgx8=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=RAINlS085cFyw3kbd0vaaoYnqkQHQYRRSQPxEolIaE4F9IHu2ZErNrCFKBtKDMDf1
	 BcWU362oh+Ax2UYMhRiyYQG1EeQVDBspA7Za//rg0Pw7eBCHQ68MrYLgQ1i61otuTs
	 exppNfbz98zwvxO4JiSHsHwfLOJ+qm9tJ2+eGqrjqqoBfACpmVOI9X3UyvA+hQNc7C
	 7jycTwIPEMs10X07yObY+F8qdrWa+IphjT7LDMSALHBk7JZpXGwC9kQZ5+XOnM6hqW
	 cgNR2ujjRPSJH+fo+pNrmGM2slJVb+xGFXzwk1Hm2AkFPjBEPlNSgkOTbgwrF4ytSI
	 25LdTPwA5ayVQ==
Date: Wed, 29 Apr 2026 07:19:00 -0700
Subject: [PATCHSET v8 2/6] libfuse: allow servers to specify root node id
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, bernd@bsbernd.com
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org,
 fuse-devel@lists.linux.dev, joannelkoong@gmail.com, neal@gompa.dev
Message-ID: <177747212220.4105652.10875200461200906124.stgit@frogsfrogsfrogs>
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

This series grants fuse servers full control over the entire node id
address space by allowing them to specify the nodeid of the root
directory.  With this new feature, fuse4fs will not have to translate
node ids.

If you're going to start using this code, I strongly recommend pulling
from my git trees, which are linked below.

With a bit of luck, this should all go splendidly.
Comments and questions are, as always, welcome.

--D

kernel git tree:
https://git.kernel.org/cgit/linux/kernel/git/djwong/xfs-linux.git/log/?h=fuse-root-nodeid
---
Commits in this patchset:
 * libfuse: allow root_nodeid mount option
---
 lib/mount.c       |    1 +
 util/fusermount.c |    3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

