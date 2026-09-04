Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DEBD3EEAF4
	for <linux-fsdevel@vger.kernel.org>; Fri,  4 Sep 2026 10:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788519312; cv=none; b=Yt3ib8e6VOYJNu+Ufg8GzLOest2QYVcWtUPnvZYMtjmU+7eiQcb0NfsXLGePGnfciK/VZOkWSRFGRy3Ve4gN6zzwrfPXcUlvUqzGwe7ILSPBzBqTSTTwUudMXFzxHBfnz4dN/FQMzfwaUHazdpkIuJyc+1nJAVPcfHFajLw8wBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788519312; c=relaxed/simple;
	bh=S1SJr8UbfCEGALIt8QcBF+thJiIuJ0INCq0S9U45FLY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=li7btR/0R+xmweIjGL6OnkudO2vTU4zaslDUyHeO7tHCtdBYR8tE+5d1dMF00hYpKI36rvi7POsxkX/vcy3Zvt1LBWfShbasE8N0h34FBWUqgnP8qCR+zq8nLHWP4pPsJ94GRG+hkCCGEKfjTOzFHYwfRbzVFh3mFtjTsZA4d9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ohRxS7Xf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ohRxS7Xf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 040C51F00A3D;
	Fri,  4 Sep 2026 10:55:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788519310;
	bh=kJQo5PQlxLuJKkQWQ1jriZpureLfoB73xzfvAO+4aAE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=ohRxS7XfM7NtztrnFOQebW0Ia3CORAUfxI6jiB4y6/Fj7ooCVe3ABH1mSnFo03VAq
	 8yZzg3NdtC25ZufPea3qYa3yllhIDbnQV8nkRFQV9PZTHPBD7s+DM4bJCkyF1jVgDl
	 1aU8VhdhRFvpxF6zDbQQghXyLIntUVOfkKaChwuNqlUN2bA8KDA/swnPLHcRwCwXkK
	 DBt+H+1iN+LMOLF4SYBOb8VSw4OfoEG3gSLmqiqoaFdBW9bl8fuMSpS+eVh8hTOQPs
	 3V/+uG45yyjPnUTpUnNWNxIIPnQ+IOxw34tVM7tZxvc0l2pBB/bCVolskrPJZAMxWX
	 hAH088YfaW4LA==
From: Christian Brauner <brauner@kernel.org>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org
In-Reply-To: <20260828205429.3678204-1-willy@infradead.org>
References: <20260828205429.3678204-1-willy@infradead.org>
Subject: Re: [PATCH 0/6] Buffer head documentation updates
Message-Id: <20260904-nettigkeiten-assoziieren-bioladen-120adaf29ea6@brauner>
Date: Fri, 04 Sep 2026 12:55:04 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev-db0b7
X-Developer-Signature: v=1; a=openpgp-sha256; l=1872; i=brauner@kernel.org;
 h=from:subject:message-id; bh=S1SJr8UbfCEGALIt8QcBF+thJiIuJ0INCq0S9U45FLY=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTNWtwTds7F/tOiL33+vZs1dJ2bL6+Mu7khqi6n3C11j
 prDTJG6jlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIlUZjMyvD66ujBv53KXnK3h
 23wnMSjqPZryffbxne6GtzfeL3kp+4/hny5PQlRy1/spKxYym+zSdd0iW7AlS0mk9Id1RMNbwRW
 eTAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

On Fri, 28 Aug 2026 21:54:20 +0100, Matthew Wilcox (Oracle) wrote:
> Buffer head documentation updates
> 
> Mostly just tidying up some out of date documentation, but I found the
> time to document some functions I thought were worth documenting.
> 
> Matthew Wilcox (Oracle) (6):
>   buffer: Remove reference to unmap_buffer()
>   fs: Remove references to mark_buffer_dirty_inode()
>   buffer: Document sb_bread(), sb_bread_unmovable() and sb_breadahead()
>   buffer: Document mmb_mark_buffer_dirty()
>   buffer: Refer to folios in comments
>   buffer: Rename label
> 
> [...]

Applied to the vfs-7.4.bh branch of the vfs/vfs.git tree.
Patches in the vfs-7.4.bh branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-7.4.bh

[1/6] buffer: Remove reference to unmap_buffer()
      https://git.kernel.org/vfs/vfs/c/d786d6d71513
[2/6] fs: Remove references to mark_buffer_dirty_inode()
      https://git.kernel.org/vfs/vfs/c/6bfa37fa455f
[3/6] buffer: Document sb_bread(), sb_bread_unmovable() and sb_breadahead()
      https://git.kernel.org/vfs/vfs/c/984cc59b6b42
[4/6] buffer: Document mmb_mark_buffer_dirty()
      https://git.kernel.org/vfs/vfs/c/2ce4bdcedd23
[5/6] buffer: Refer to folios in comments
      https://git.kernel.org/vfs/vfs/c/624ae75c3878
[6/6] buffer: Rename label
      https://git.kernel.org/vfs/vfs/c/72873ce78b36

