Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 517B74AA035;
	Fri, 25 Sep 2026 14:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790346529; cv=none; b=M2npRkmEqQC9Z/VjzwCsRPfsKLTM6psNoK6cQrD76muqQ4zq4pwyqhL4xU3U3/CwMm7LOZxrdMyjlaZoMC/fExGhjV3BeRxOR1UC6MaFocn1bDTtiTrEQ7UWuLArCxS1eJjAWQfdvX96JfQZ5V399jMNH1ZBVoyscA4aBK/I388=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790346529; c=relaxed/simple;
	bh=eZMWyVHwLBeSyGNnK0wQpUPRVoQzN/GYHffzAoKLUMs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TTQTNUQ/M4NeRJJIpjh2RrqNir9JmMuxFSdSRCHSkp0M7r/MvkFWv8PZu23EBTltnhviW9REuu2Tzgx4NOUBSNQVLZtxixG1gfQSEeuxkW34ywog30oLAjPvTBx8bD+dDei3V5GPIUKW9VFTvL/EySJ/Clo51KA5iqHdqlf4iMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k4SZ6VKa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k4SZ6VKa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C59AF1F000FF;
	Fri, 25 Sep 2026 14:28:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790346528;
	bh=mJ1PqPWR+7cctR+RTsFiK9AOdycX/ohQg6/y/QX5A38=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=k4SZ6VKaR4o4uxHyz9qhBkbw0DOb2bVAmlnQ4sn2znbbdhPZS/TZWPkyEgsBkqyYh
	 W/RWyoVWc0dTJfinOvm42cTwbgB0vjG6A2KaYifPHsd0R20NyiM9ITTQ8njoxsgMAI
	 CSlAd0Bncq+sU55o2KA/DQ7DC0noaEdXNTcFuRg3sx99rlmCO7rtJ2wWngVcZpcoNy
	 Vi10vghAAKYDSUHctqu8I4libuVInSCdaozYMscrEZARrWFM0Z/+3yYq1mjGyzzCL0
	 nEazbkZ6X/A+8VdxGqEu/X0N5mV/N9wOx2/PKhb7/bu/dB4ZOq8peoCHv8psWMRiEI
	 Qg5rHmprsNIsA==
From: Christian Brauner <brauner@kernel.org>
To: NeilBrown <neilb@ownmail.net>
Cc: Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	Jeff Layton <jlayton@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>,
	Miklos Szeredi <miklos@szeredi.hu>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/7] VFS: prepare for changes to directory locking
Date: Fri, 25 Sep 2026 16:28:33 +0200
Message-ID: <20260925-einbehalten-kurort-parken-fea6829fafb5@brauner>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260904215142.1060510-1-neilb@ownmail.net>
References: <20260904215142.1060510-1-neilb@ownmail.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1773; i=brauner@kernel.org; h=from:subject:message-id; bh=eZMWyVHwLBeSyGNnK0wQpUPRVoQzN/GYHffzAoKLUMs=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRta5VqPvLl3aXUmdePXjq1b+OKbPGDF+YcjX13Jed5r 6z7tv8ySh2lLAxiXAyyYoosDu0m4XLLeSo2G2VqwMxhZQIZwsDFKQATYdZh+O/xbFZrnKrGkauC gQps0uIP+u/OXyAvXRlw/azT8WR5ld8M/5MW1rWb2jRud/1lpBsX77b+UpbT9uXe/bt7Og5em/w tgAsA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Sat, 05 Sep 2026 07:48:09 +1000, NeilBrown wrote:
> The only change in this v4 over v3 are to replace lock_sync with an
> acquire/release pair which builds correctly when lockdep isn't enabled,
> to add the 7th patch which I previously mentioned, and to include
> linux-kernel so that sashiko gets to see the series.
> 
> Previous intro:
> 
> [...]

Applied to the vfs-7.4.lookup branch of the vfs/vfs.git tree.
Patches in the vfs-7.4.lookup branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-7.4.lookup

[1/7] VFS: fix various typos in documentation for start_creating start_removing etc
      https://git.kernel.org/vfs/vfs/c/f8550827bf3d
[2/7] VFS: enhance d_splice_alias() to handle hashed dentries
      https://git.kernel.org/vfs/vfs/c/f1ac607f786f
[3/7] VFS: introduce d_alloc_trylock()
      https://git.kernel.org/vfs/vfs/c/17c7d109d8c9
[4/7] VFS: add d_duplicate()
      https://git.kernel.org/vfs/vfs/c/33d76519f0cc
[5/7] VFS: Add LOOKUP_SHARED flag.
      https://git.kernel.org/vfs/vfs/c/cc47a1ba1983
[6/7] VFS: add lockdep monitoring of DCACHE_PAR_LOOKUP lock.
      https://git.kernel.org/vfs/vfs/c/59492f9991dc
[7/7] VFS: reserve a d_flags bit for fs-specific usage
      https://git.kernel.org/vfs/vfs/c/fd96e30426ff
