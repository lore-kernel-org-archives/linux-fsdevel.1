Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DB91282F1F;
	Thu,  9 Apr 2026 13:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775741708; cv=none; b=DgYnN20As4zKmv00N0/a5d1lUKNwVLxK/KVAh6vi2frcsEsqqQsUI9kAJ1vpOrVc1adFRYs/69WEc7uYw6HuWkU4YdVV0P89D0hiLW6QNw+DKeflEYG/U6wQmDr2ZQDMtLYlkNeU8j69aXJThh6wdFR8/H9vfuhw/3jXzSMi9k8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775741708; c=relaxed/simple;
	bh=u8tIlJ44qEIdrvEBi+DOADNqL67KBLdI5TMdHaAR1ig=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tfrp4qvZZ0F8oCoTpm3bXnEK1aUnwgbP4JHLfLa/QBQFYUwAO8mTeMOzBsabGHVns9WOwqlVInFEt6tdYDh5mbeXQwbAB9QAoreTTIQVBE1DII/Y0gNQ1aDjtitNusDhCMNVMYXolIG4i4vviCJXfX8IgBbAN75fghYVmlhqI6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h74O5cq8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h74O5cq8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FDDFC4CEF7;
	Thu,  9 Apr 2026 13:35:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775741708;
	bh=u8tIlJ44qEIdrvEBi+DOADNqL67KBLdI5TMdHaAR1ig=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=h74O5cq8Tad8GZgY9EBcah95vX7L7wcpIwaYs55gokkye7YJUBYiMwonQfan6kyGn
	 LCVGKK9e0FWZI1oL2ct5Nhj1SmskbJnXjXf+Duwrmq8OI5VnBwyhDMvza7BHm4yqSE
	 ZwkaQBnIPfDrvMzUUxrO+jpC+RAjepkXeLPDZRo3puzsABQVbhnoyTSQ2YMie6d4vK
	 6cYwoU3a9wU3O4VlxSW62qJHrnsdo5fJVqcXB0o2/eXnJmdy4qd1OszUDPsysZKK+7
	 IFRX7whhnb9zjzQ3jJub3sQH2nHbdDSVvb7XwchUjeC9GnZuNMjPql5KjTUY0Du0wu
	 1w0MaNoc+MImA==
From: Christian Brauner <brauner@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Petr Mladek <pmladek@suse.com>,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	David Disseldorp <ddiss@suse.de>
Cc: Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	Steven Rostedt <rostedt@goodmis.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v5 0/6] initramfs: test and improve cpio hex header validation
Date: Thu,  9 Apr 2026 15:34:59 +0200
Message-ID: <20260409-aufzeichnen-anrufen-a4c5df409b3b@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260331070519.5974-1-ddiss@suse.de>
References: <20260331070519.5974-1-ddiss@suse.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=2079; i=brauner@kernel.org; h=from:subject:message-id; bh=u8tIlJ44qEIdrvEBi+DOADNqL67KBLdI5TMdHaAR1ig=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWReX80auk1CrjuN5VHY+wVJqd46xdP/abd9NVweKTB/4 /HZC7Y86ShlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZhIAiPD/+KJvFvvyhi0/Pl7 sG5+lq9U8nwPTTPvXH77W/0xxe7hrxgZ9ma/e+xw6fUCp0ffVPjOqW42Wuy1tU78gY/5MTudmlu 2TAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Tue, 31 Mar 2026 17:57:30 +1100, David Disseldorp wrote:
> v5 changes:
> - rework 2/6 and 4/6 test comment, as suggested by Andy
> - 2/6: initialize struct kstat in tests to account for possible
>   init_stat() failure
>   + drop Andy's review tag due to this minor change
> 
> ----------------------------------------------------------------
> v4: 20260329105307.2876-1-ddiss@suse.de
> - rework initramfs_test changes to use an inject_ox parameter instead of
>   having tests pass through an unvalidated format string.
>   + drop Andy's reviewed-by from 1/6 and 2/6 to account for changed test
>   + 4/6 minor changes for test context and comment
> - add review tags for 3/6, 5/6 and 6/6 following list feedback
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

[1/6] initramfs_test: add fill_cpio() inject_ox parameter
      https://git.kernel.org/vfs/vfs/c/8c5148e7adc1
[2/6] initramfs_test: test header fields with 0x hex prefix
      https://git.kernel.org/vfs/vfs/c/68080eae1c6e
[3/6] initramfs: Sort headers alphabetically
      https://git.kernel.org/vfs/vfs/c/6b5d04109e6a
[4/6] initramfs: Refactor to use hex2bin() instead of custom approach
      https://git.kernel.org/vfs/vfs/c/a1b1b7c062cf
[5/6] vsprintf: Revert "add simple_strntoul"
      https://git.kernel.org/vfs/vfs/c/eb4a4aef30a9
[6/6] kstrtox: Drop extern keyword in the simple_strtox() declarations
      https://git.kernel.org/vfs/vfs/c/d1ed9a885e64
