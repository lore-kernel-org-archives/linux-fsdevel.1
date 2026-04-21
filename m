Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04FC913C9C4;
	Tue, 21 Apr 2026 11:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776771040; cv=none; b=Nk2kGVR+LPgrVWpFeyqxNu6poGSieS3GPva2WG1EAk9a34PiUB6eDG+X4JILOqYdS/vSaPbVGkKJVOusu4Q2OQY6Ls6NQ9nspzfp4fUFRkkfijPzQmAubIJGB/HLMHrXp7fFbLFx9dY+KqQ/v65vU2q48eeV1vXoQtLSc5IfLEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776771040; c=relaxed/simple;
	bh=EVAv+obc94d9+7cL1VyH190MzeGbUvxIIz8jmt/Kxb4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uRNGR2EWZfjJr7OovKpV1JUYtKG8oeZPODEw4HAljim79Rz6FjkHHgkpFpNXzNq86j4z3N/u0J7qwhIssfvm3fgtOdmDq6yYh2RhJS9EmsE6xwNnLR+hmW0JQCbdpehe0QlbdXXowX2pOxpdYVIb6WD3Ub3WQMaqNRqcU7BLtaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nntfueRy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nntfueRy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4EE2C2BCB3;
	Tue, 21 Apr 2026 11:30:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776771039;
	bh=EVAv+obc94d9+7cL1VyH190MzeGbUvxIIz8jmt/Kxb4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nntfueRy9BVyst+DFuwUWHrklsRhqzAXTqJQ8yLNXVbf70o+Oc1lpsY+3v0GXE0De
	 tNawiDQjhgSkneoThNqZdJNwtP12Px7d7dcVoj2Yq+iwJv/2YrW5Mco6FyBUoFRiOj
	 18oL2IVhZ+yS24VWiVG8bEjI1VdAkEJ0SQgsLooVfkhPAPv00RkQXv28eE7dnFyr6P
	 izr/IV24Ncbh1/0/yBiSzeQbNrn8jQ4XtBYeG74fWXuHL15hau2VhviySGp8RjLdYx
	 wryd1oSJDVRUMl3A4WqUsmZl3nz3KhZJzggDS81AMPHWFDxUt3XZ6SROMY+MVRGWkt
	 4yZw38pVtVrzQ==
From: Christian Brauner <brauner@kernel.org>
To: Jori Koolstra <jkoolstra@xs4all.nl>
Cc: Christian Brauner <brauner@kernel.org>,
	cmirabil@redhat.com,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	gregkh@linuxfoundation.org,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>
Subject: Re: [PATCH] vfs: remove always taken if-branch in find_next_fd()
Date: Tue, 21 Apr 2026 13:30:28 +0200
Message-ID: <20260421-holzschnitt-hiebe-de43b605ecd1@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260420101801.806785-1-jkoolstra@xs4all.nl>
References: <20260420101801.806785-1-jkoolstra@xs4all.nl>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1218; i=brauner@kernel.org; h=from:subject:message-id; bh=EVAv+obc94d9+7cL1VyH190MzeGbUvxIIz8jmt/Kxb4=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQ+j7/Vsi/NQShpR9K31MkaavxbVzE/e6S0VWLDm91t7 2/PWX/2d0cpC4MYF4OsmCKLQ7tJuNxynorNRpkaMHNYmUCGMHBxCsBE+oMZ/nta/3GoW79+UtXs xWIcUV/Kfad0JK+99Jl5+uYNpjJLMo8wMswvnBvxcX5m6hvWd8tTV1deSbp0eELfgTzRReuWfvu 98yMXAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Mon, 20 Apr 2026 12:18:01 +0200, Jori Koolstra wrote:
> find_next_fd() finds the next free fd slot in the passed fdtable's
> bitmap. It does so in two steps: first it checks whether the bitmap
> has a free entry in the word containing start. If not, it looks at
> second level bitmap that registers which words in the first level bitmap
> are full and then looks at the first level bitmap at the first non-full
> word.
> 
> [...]

Applied to the vfs-7.2.misc branch of the vfs/vfs.git tree.
Patches in the vfs-7.2.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-7.2.misc

[1/1] vfs: remove always taken if-branch in find_next_fd()
      https://git.kernel.org/vfs/vfs/c/935b31c6835c
