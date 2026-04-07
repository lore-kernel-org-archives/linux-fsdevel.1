Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 476862EF67A;
	Tue,  7 Apr 2026 10:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775557970; cv=none; b=nYMDPI4OwCftpwI7+WbPC8gIKGfRncheUIgJOC7iM9xynqwi9DjkZb7W7Xtfit+JHfud0cBNixgH9JLkg8I4rmd/CoMApQnfOc22KuTLC1sPh9Gwlk5oSBDJw+0uilNs02xWtyghK6DwpTt2dXuNqI0XJ0x2sLjqXp9rLnRVwNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775557970; c=relaxed/simple;
	bh=SX9Wrjjncbv+6fS4vi9JuxjcZcD3fNqf3waTe/MEw1w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k134g0tGv5rCc9sRs39t93+k15ytIMYAu4pab9P5GeFenUj/ZL6ayT2coB3bJAQGJph85c32jhZ8EC1sAzcgH4m23XAEz+f/GcJFhNVteZgPnxiye8KgWilhx8fG9yHypabyT5vf/CTdXynubWhQAVlM6fbSW+y8HM7ScTkkwdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dztu60C7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dztu60C7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3DF3C116C6;
	Tue,  7 Apr 2026 10:32:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775557969;
	bh=SX9Wrjjncbv+6fS4vi9JuxjcZcD3fNqf3waTe/MEw1w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dztu60C7D0+ybxcwIHQ3UM6HADGRVSI8xB2J3gvjsnov7dmJYpx+pe4F0iSI8fjR1
	 rJdigTKgphgQG5KqUR8A0R5fRrJnXU1MfJEQpbf2ufxiNkKFAA8ZxiklotwDZVyMkW
	 7rdNw5G5zRqketo14PsqsxgAyG52/TOTFAXFRfmHNHRhweoqRFHWS0oB0fv+85jazv
	 qSPNpX+NCjhjUgqX0/noqBqTXphjUZeLGx4G27d0Sy/ssQcKU2vdXteDPVj/RQUKK4
	 X1tOf53dw1s1A43+OEr08QcJFu1AWFwuNAtoYP8NBHiPSWSJx39WFu+xxTVFuN7q7k
	 xayfSIxClLtVg==
From: Christian Brauner <brauner@kernel.org>
To: Aleksa Sarai <aleksa@amutable.com>
Cc: Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	Pratyush Yadav <pratyush@kernel.org>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>,
	Eric Dumazet <dada1@cosmosbay.com>,
	Christoph Hellwig <hch@infradead.org>,
	Aleksa Sarai <cyphar@cyphar.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC] dcache: permit dynamic_dname()s up to NAME_MAX
Date: Tue,  7 Apr 2026 12:32:34 +0200
Message-ID: <20260407-randgebiet-tausend-bace5997a84d@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260401-dynamic-dname-name_max-v1-1-8ca20ab2642e@amutable.com>
References: <20260401-dynamic-dname-name_max-v1-1-8ca20ab2642e@amutable.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1386; i=brauner@kernel.org; h=from:subject:message-id; bh=SX9Wrjjncbv+6fS4vi9JuxjcZcD3fNqf3waTe/MEw1w=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWReuet9acbHPEmL/z5f+eZqpMgHxO99tsBt8uVn71esV N8wwWP9lY5SFgYxLgZZMUUWh3aTcLnlPBWbjTI1YOawMoEMYeDiFICJKJ5jZDjrO4k7QyvZKmfW s0vb3s9aaZ6+wUl4TY/5GtXsfuem3TaMDG2v+2RS2nvfP0zzqHxquMvjQ2sg3yyXExyMVduSNvb c4gAA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Wed, 01 Apr 2026 01:46:21 +1100, Aleksa Sarai wrote:
> dynamic_dname() has had an implicit limit of 64 characters since it was
> introduced in commit c23fbb6bcb3e ("VFS: delay the dentry name
> generation on sockets and pipes"), however it seems that this was a
> fairly arbitrary number (suspiciously it was double the previously
> hardcoded buffer size).
> 
> NAME_MAX seems like a more reasonable and consistent limit for d_name
> lengths. While we're at it, we can also remove the unnecessary
> stack-allocated array and just memmove() the formatted string to the end
> of the buffer.
> 
> [...]

Applied to the vfs-7.1.misc branch of the vfs/vfs.git tree.
Patches in the vfs-7.1.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-7.1.misc

[1/1] dcache: permit dynamic_dname()s up to NAME_MAX
      https://git.kernel.org/vfs/vfs/c/97b67e64affb
