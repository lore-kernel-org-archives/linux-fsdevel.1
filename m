Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 515F43B7B7A;
	Fri, 22 May 2026 10:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779444828; cv=none; b=BFkd++7R4vn6UA4uHDx6lXuHv5IscZLfK5b4/elZXp7hq2A7UZh8KSuuB/z7k5jfWmNmzehS8MJcma4cwOnVUdhR0sMFf4LJ43cuZtzJqkxO4XYXMooa4eFwuRM4F11VY34i4qo1N9pnF4tB6Fc7XbNUabe3Zms4k019BIyfQxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779444828; c=relaxed/simple;
	bh=lhbV15gqFVYmCMZEvg1uU1m1PBLfa07qcuf2ui7Zz+Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JT7cP8+xZHUwQS6GCK+P+OTxXn4pFoN+GK1gVPnAUKceQCuBKhTbwLYyUbfkRAautx7jLqwZm7ztN+ADDgTQvsBwcrITzada4C9+xTj6jrCn6Aza04GGyHT2+UbER2opg2bagUV1Q/x8l19ODjh+h8k+msLs9HfLZYWzwEBO8HE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WCL+e0mr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WCL+e0mr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E4101F000E9;
	Fri, 22 May 2026 10:13:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779444827;
	bh=yep+MmzsVlWADDSUqsV9kVJgBjttfHFqU4R3V6EEppA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WCL+e0mr9bpdkDzdJgE2Jq9HRvbi/JIjrTQVzlJ4/ka9xAlhgW2vP0XfvwcveFaNV
	 4xqTJH3Y2fdiEV4bbr1ijWk3+xX2WnBK5GcX+kIT/wqS4tTQ3EqZ14IjV9CEXg/nDF
	 TJ03j5Wzk3Zst1RNElnY5VLzd2LojuCcf4bYPkTQ4whWhYTk2CM1BjpTwTQ7iZHuLG
	 V+WHzSflVOXJh2Mm9XdbGS0ghZ+kW8aFG2u+EtiXym1t3WbHUj+uhn1NVjHMGIJp84
	 9xMMCwBQwcCmsACH69DB/pwpOmFpGGsPAzeiRON0aKG2YNGzMRF2FFTWamKGol5c3z
	 wGxWzKFLY6hLw==
From: Christian Brauner <brauner@kernel.org>
To: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH] init: do_mounts: use kmalloc() for allocations of temporary buffers
Date: Fri, 22 May 2026 12:13:31 +0200
Message-ID: <20260522-gefressen-bahnverbindung-inzwischen-e2af1ef5fcaf@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260520-init-v1-1-aaf2ebac5ad9@kernel.org>
References: <20260520-init-v1-1-aaf2ebac5ad9@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1290; i=brauner@kernel.org; h=from:subject:message-id; bh=lhbV15gqFVYmCMZEvg1uU1m1PBLfa07qcuf2ui7Zz+Q=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQJ6ITtNvj7uGL2xfyp8pc9Dabutq8pjIjnblFRsp02R WqN2pnYjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIlYfGX4H5kZ/7b+vcC7Ukff sw6/Vy76fr/P4iZ39qTpOtMFO9XFGxj+RzH8/7rrPLc1j6WbMnuUwMRdat9EjHw+P755wOhE+cY QDgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Wed, 20 May 2026 11:16:51 +0300, Mike Rapoport (Microsoft) wrote:
> Several places in init/do_mounts.c allocate temporary buffers for
> filesystem names or options using __get_free_page() or alloc_page().
> 
> Usage of alloc_page() APIs is not required there and only creates
> unnecessary noise with castings or conversion from struct page to void *.
> 
> kmalloc() is a better API for these uses and it also provides better
> scalability and more debugging possibilities.
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

[1/1] init: do_mounts: use kmalloc() for allocations of temporary buffers
      https://git.kernel.org/vfs/vfs/c/3fb2d124b647
