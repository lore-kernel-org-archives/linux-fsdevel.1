Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A4B13C585E;
	Fri, 22 May 2026 10:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779444438; cv=none; b=qzBIpw0OjBJOsHlfXYVNfeZWUdkNhO4xgebno+smihsVbZW4rvR/wbKhjKuF5JegikEw/BP6vui33PlChULPo7fKxOD5bGc1c/HHtOQl8s53WD9HiRH7npxxG+Zd36Ts4XLKYVm4NJIkg9Do5R7JYUIge2CD8yHAoH3E/MyhnEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779444438; c=relaxed/simple;
	bh=63hb7CMMGrdxJXxOr76qZ3tjAyyGDoNHG+rTOblsBOQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cF69c+Rx1D6yO+wKqXJ1jGLd6mrGdVAc5iPg9uGaSPfHe3LiYf7keRL8Yjt/P6qUGRCBhnbtmtgMCpTDl3RyIg1WIVrqH38E2jJv8rpj1ZvC5k2AG+O+TWTtDERAZHSwDublPpeB6oTRBl6KYQQXiHcbyaQLfCXU/IY9UaoUHbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GI/rAB4p; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GI/rAB4p"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D0991F000E9;
	Fri, 22 May 2026 10:07:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779444437;
	bh=24NrHwx85KJ7d7g8G28zlKylbgtZyT3SUtMUdrMSpKQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GI/rAB4pP4EbSId6SdtXhnG34oJuIfCUPY59EIY7av7lQxIVWLUg9WuN2AcbJyTTp
	 BjGLVdbZBnNbDXLuhq9b3PwR+qPbP1vU4s36LQC3a4kHrY2fsBR8/bzoCbhH+OSxCU
	 Dl4CqHQ9/MvIP4M6bSS1TXSFc3M1dGUSdyuGVzt0KxOM9mnhMC+PckAYEBhEUBSSsm
	 MPAwA0zFT+9FwBz/bi6WhiFuPZRf2iHsDLyZsW8dKCgei8LQQiXNilyAGxxxDBAWqr
	 SZdV/Z/7//mJQfY338S5HGYVNEIT0/HIj7JY9Z9XGI8Xim+tGt4dHMZM1DJG+h4ZTe
	 MBWYxKSrB+FqA==
From: Christian Brauner <brauner@kernel.org>
To: linux-fsdevel@vger.kernel.org,
	Baokun Li <libaokun@linux.alibaba.com>
Cc: Christian Brauner <brauner@kernel.org>,
	viro@zeniv.linux.org.uk,
	jack@suse.cz,
	tj@kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/3] writeback: fix race between cgroup_writeback_umount() and inode_switch_wbs()
Date: Fri, 22 May 2026 12:07:09 +0200
Message-ID: <20260522-androhung-gesondert-therapieren-7992a31de6a6@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260521095016.2791354-1-libaokun@linux.alibaba.com>
References: <20260521095016.2791354-1-libaokun@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1546; i=brauner@kernel.org; h=from:subject:message-id; bh=63hb7CMMGrdxJXxOr76qZ3tjAyyGDoNHG+rTOblsBOQ=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQJaJ3f+DH23VLRK51r3z/z6g+2L7T78EAuqEdf6b7mK cFrHG0rOkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACYS8J6R4XxV0JO1tceOPLh1 2HC7UEHdyilaUeuf6Iddfrym0jnh2nRGhvb0poJt8fNF3qZ/PX7s7vx912af0VkqvcCt0+rieoU fkjwA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Thu, 21 May 2026 17:50:13 +0800, Baokun Li wrote:
> Changes since v3:
>  * Collect RVB from Jan Kara. (Thanks for your review!)
>  * Patch 3: Remove stale comments. (Reported by Sashiko)
> 
> Changes since v2:
>  * Collect RVB from Jan Kara. (Thanks for your review!)
>  * Patch 3: switch to wake_up_var() / wait_var_event() to drain
>    s_isw_nr_in_flight. (Suggested by Christian Brauner and Sashiko)
>  * Polish comments and changelogs.
> 
> [...]

Applied to the vfs-7.2.writeback branch of the vfs/vfs.git tree.
Patches in the vfs-7.2.writeback branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-7.2.writeback

[1/3] writeback: fix race between cgroup_writeback_umount() and inode_switch_wbs()
      https://git.kernel.org/vfs/vfs/c/cba38ec4cbd3
[2/3] writeback: drop now-unnecessary rcu_barrier() in cgroup_writeback_umount()
      https://git.kernel.org/vfs/vfs/c/e90a6d668e26
[3/3] writeback: use a per-sb counter to drain inode wb switches at umount
      https://git.kernel.org/vfs/vfs/c/31c1d19ead2c
