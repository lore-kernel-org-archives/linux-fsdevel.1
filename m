Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 565BB4BB5D5;
	Fri, 25 Sep 2026 14:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790348387; cv=none; b=cC1W0l77c0GwauFsEULhxb4YjSOE/NjR6YBGZsfhrzeh4oeYQKXt6KiapHgWgBNH4xVNqHh+zkth5psLrC3QsyQGDwFCHVnX27qAfAC95TBHJQnq+mU1mWinBa/Eiile0J4ovYH3stvXnfnY3FTRmnJbYzH+dDu1pOGJxUgBeLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790348387; c=relaxed/simple;
	bh=HUxeVXf5P2KTocjrM6n+6CSOPvZuA8gpQPJtxtp3zBY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=c2ohm8hEeZ+UGf+x26NcXVF5aR7WataSliiM6qMuD/rFUx5bI7EzW/ve2jaGLu/pz/NjTRdOVHpkdOt5Vn+hee4M4WD4Afly3g1XNjK9w263XbWfcd7nNksl8Z2uMBfccBq+7Z046SHgD9+pJzY0Ld4GJ6bPbfIEmRPpIaSN5Dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TkUxiNd+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TkUxiNd+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 336811F000FF;
	Fri, 25 Sep 2026 14:59:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790348375;
	bh=Q6tKBHdS+7WxU5Iy+JnenvF40OikO03QgaSPtqcO3xE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=TkUxiNd+unXfYlzrkzZkHR5Y83szG++vqXXAIV3lLR4mKEzBvG6sif+GgPEc3PzBH
	 /8r0DH7hGsxxSnNIZkHf5ffrcpCDBBVfo3AtZZt/3GWOuJs7cNYo01QPm6o9cRy6ET
	 9NbQ+MgYeeIk5bpoUpk94BIDSNk5hZ80ayJgHqZLukBJrnCCiIBDC6pGErvKf+H3bd
	 2LwYpSlS02Uwk73Vgw32I+cOMVR0xLor81t9xRFIbfnXyB/rFQvNG/AvVkWCSCBVVE
	 dP88c5tr5ch3u5VCF3VGf82hPgDUG2D7HyVXmn630tKhfWkZk8q/ALEGIXjmc5MUWF
	 rtBVCdDM8LRsQ==
From: Christian Brauner <brauner@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Tejun Heo <tj@kernel.org>, Christian Brauner <brauner@kernel.org>, 
 Shakeel Butt <shakeel.butt@linux.dev>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Meta kernel team <kernel-team@meta.com>, linux-fsdevel@vger.kernel.org, 
 driver-core@lists.linux.dev, linux-kernel@vger.kernel.org
In-Reply-To: <20260913021453.21507-1-shakeel.butt@linux.dev>
References: <20260913021453.21507-1-shakeel.butt@linux.dev>
Subject: Re: [PATCH 0/3] kernfs: do less work under the kernfs_rwsem write
 lock
Message-Id: <20260925-neuverfilmung-gasflasche-bespannt-7ccbf898dbb6@brauner>
Date: Fri, 25 Sep 2026 16:59:29 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev-db0b7
X-Developer-Signature: v=1; a=openpgp-sha256; l=1418; i=brauner@kernel.org;
 h=from:subject:message-id; bh=HUxeVXf5P2KTocjrM6n+6CSOPvZuA8gpQPJtxtp3zBY=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRt6wlOKROe5TXh/Xvfoo8PE0QnPrhrfeS6WoNY5leuJ
 19nz1Fu7ShlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZiIkDAjQ9Nk/rWWXmx7VV2E
 FswTNeWyf5yovfzGE+ENG6vkU7c+82f4H9X8r6cv9cPR5v0eJ4RWFDc0TZt+58ixCfXrV7DLdDO
 VsgIA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

On Sat, 12 Sep 2026 19:14:50 -0700, Shakeel Butt wrote:
> kernfs: do less work under the kernfs_rwsem write lock
> 
> kernfs_rwsem is per kernfs root, so sysfs and cgroupfs have one each for
> the whole machine, and every create, remove and rename takes it for
> writing.  Whatever a writer does while holding it, everyone else waits
> for.  These three patches take work out of that section.
> 
> [...]

Applied to the vfs-7.4.kernfs branch of the vfs/vfs.git tree.
Patches in the vfs-7.4.kernfs branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-7.4.kernfs

[1/3] kernfs: activate a new node without dropping kernfs_rwsem
      https://git.kernel.org/vfs/vfs/c/4424f06120fd
[2/3] kernfs: allocate the new name outside kernfs_rwsem
      https://git.kernel.org/vfs/vfs/c/8b64f32fee95
[3/3] kernfs: free the old name outside kernfs_rwsem
      https://git.kernel.org/vfs/vfs/c/09452e5114bd

