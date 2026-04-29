Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D70E1A5B84;
	Wed, 29 Apr 2026 14:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777472217; cv=none; b=LI4jmariG6wgTI6zrDoYB2zsbXPTVJx7WHjj2beYBn5yQhelGcQtVGbIbaY7/FY1T+kqBF45lyNkLf9y3r//n/5MW9VkfsmkwmYP+pPV/jTTty8JkfF295cqA6NitEA+CXia24BN2taAxNZNOGni9L2nSJKe4KSiylMHdD9Xj+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777472217; c=relaxed/simple;
	bh=KfIP2M0ec3m3eVtOk8+z+Qe1uV9sSdtF5eB6tF85ONc=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EDBlpqhqGZVP5f3EEbQdEKWHz8x4UpFoth6RtSSCO12jId7IosDy9gDEvSJFu0jErWHGrAOpZoM6z/pXCscx+P8g6cnRsXSDyOWiO7NcHDJ0DSUX0Wg2eCwTM+ShYFsrCg8Us1G1qnqgDAo/woLODYdML8P09UUKloRhDUHT07k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C49njlAe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C49njlAe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82699C19425;
	Wed, 29 Apr 2026 14:16:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777472215;
	bh=KfIP2M0ec3m3eVtOk8+z+Qe1uV9sSdtF5eB6tF85ONc=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=C49njlAe4CD1poaFj91LvUb4lPXTCQkjPzEfiNPyKDGw4hjagL/EIzHkq/0boWXSs
	 1kA3fs57wDH4MwXO7/yMv85vgcKHaXmf586Vtnu5bdMN+rxpvelltiV30t9y8FqKU5
	 uGSwQpN2nj2ZnLbnH3dF1bGX2ZTTkaNomTJhCcgvpU/6i78VLGQm3CVoEmCkgv3KBV
	 Fr9rYpY2te8hnFrfElQyC8GuqmC8LV6y7XqX60EXbNfqXPuf8S0FrJvBDxxKPfFbKy
	 JDFlCrs+odmSt7ytZV/OggNCO0ub6U1mwFWEgxafablKB8VLF0iIZVhgRqDxcqjeTQ
	 0CsLwjI+urgsg==
Date: Wed, 29 Apr 2026 07:16:55 -0700
Subject: [PATCHSET v8 2/8] iomap: cleanups ahead of adding fuse support
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, miklos@szeredi.hu, brauner@kernel.org
Cc: hch@lst.de, fuse-devel@lists.linux.dev, linux-fsdevel@vger.kernel.org,
 hch@lst.de
Message-ID: <177747204299.4101605.7457046403791125680.stgit@frogsfrogsfrogs>
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

In preparation for making fuse use the fs/iomap code for regular file
data IO, fix a few bugs in fuse and apply a couple of tweaks to iomap.
These patches can go in immediately.

If you're going to start using this code, I strongly recommend pulling
from my git trees, which are linked below.

With a bit of luck, this should all go splendidly.
Comments and questions are, as always, welcome.

--D

kernel git tree:
https://git.kernel.org/cgit/linux/kernel/git/djwong/xfs-linux.git/log/?h=iomap-fuse-prep
---
Commits in this patchset:
 * iomap: allow directio callers to supply _COMP_WORK
 * iomap: allow NULL swap info bdev when activating swapfile
---
 include/linux/iomap.h |    3 +++
 fs/iomap/direct-io.c  |    7 ++++---
 fs/iomap/swapfile.c   |   17 +++++++++++++++++
 3 files changed, 24 insertions(+), 3 deletions(-)

