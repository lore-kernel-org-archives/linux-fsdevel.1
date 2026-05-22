Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27B6F1A6839;
	Fri, 22 May 2026 12:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779454610; cv=none; b=HuR4REOl0cFrk1Ttd839Ys+h26HX3IbEwrM4Kw5ud3puPJhGJgmjYQjMkR227UGZS0GkbSYEgn65RM+BFvepYmn0wOgQ2PSpWhfKWBKgEc3DaixmuBqPU0LybyX3igLzBtSdjsglpFct4KEI96nhdy0/AdnkiMZoqfziYjSmMxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779454610; c=relaxed/simple;
	bh=gNY4pi0AnH7uN3LbxfsuCEH3n2CQKYhqwCZ1F7P1eus=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y0JAR6C+tkSHC7Mj5KG4GqPpDwV+q7UC0+zdJa+BeMqBfISHG4T5tdxQAY1e8+mTI0x6qUa2hqot9wo+zwSTtWcDO+GlmEhQuAd3Nk+zyoJpny4E7D4EfyuoBYrcCruvF61vSDYiUebCQFeXJacoz0O7YYwE5SUMtcjWetxcNyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ne0UtThP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ne0UtThP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00CF81F000E9;
	Fri, 22 May 2026 12:56:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779454608;
	bh=hiC8aF4eMlUu29WVYFgIsocdgY7kB9iU0pYbEnymTNM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Ne0UtThPFBS8EE5jf2vp08WWmPUr4QyVWLKQK4qH6o4s8vV27hkt8jRsaCmnPxGY7
	 RXDsZXkcRlkvciZ8wfaR0lV5wEo3fcggAnot+f1mLi9f4c/yBRHfLODu7pjsw3C9mt
	 h/Keu4VAhmN797hjxrXiZP0hEc2HHIW39eJ9i+0tOJ6AaK+sCZyQfUu5Si+nq1mfa0
	 miyBJ3uQH0WFQ3++f8bgeq3srcMRbDiKiLZtD3BtbGckh0M2YbTgQNnEK/XhURqD2X
	 onp/d4zSWBhz4ipmZ5pj6r1R/LZeE2tI27kr14M0h6/QHE6yOo9dw2G4ChAaF43uKB
	 ASPa4wR2GTv0w==
From: Christian Brauner <brauner@kernel.org>
To: Jia He <justin.he@arm.com>
Cc: Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	David Disseldorp <ddiss@suse.de>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] init/initramfs_test: wait_for_initramfs() before running
Date: Fri, 22 May 2026 14:56:36 +0200
Message-ID: <20260522-ausgaben-vielsagend-zinspolitik-f55d04026ef3@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260519093937.1064628-1-justin.he@arm.com>
References: <20260519093937.1064628-1-justin.he@arm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1206; i=brauner@kernel.org; h=from:subject:message-id; bh=gNY4pi0AnH7uN3LbxfsuCEH3n2CQKYhqwCZ1F7P1eus=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQJBPX8lF88+4KehGhCsnad2eV92T0nH1w97BA2v9PDa 0fGBi+hjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgImw3GZk6DeeU/kui9Wj85hQ uPM5E7sLZ//zeWsrxq7W2Lbb6nx8IMP/sm7bznaW8E2eewM3dN3QFU71XydTPcH0+LsJh1V5T0e yAQA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Tue, 19 May 2026 09:39:37 +0000, Jia He wrote:
> initramfs_test_extract() and friends call unpack_to_rootfs() from a
> kunit kthread while do_populate_rootfs() may still be running
> asynchronously from rootfs_initcall. unpack_to_rootfs() keeps its
> parser state in module-static variables (victim, byte_count, state,
> this_header, header_buf, name_buf, ...), so the two writers corrupt
> each other.
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

[1/1] init/initramfs_test: wait_for_initramfs() before running
      https://git.kernel.org/vfs/vfs/c/c876fe9797d8
