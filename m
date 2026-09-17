Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65C7A4B95CF
	for <linux-fsdevel@vger.kernel.org>; Thu, 17 Sep 2026 10:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789641061; cv=none; b=qzxpCeXCi8burpA3ArXA8FveRnOyS1LCPrl0W1U9BzLIBJdW4X7m/1ekRBZ5J8h9Y2FZE/jNmJkezlmh6XWYRYrCKHRbTWjqABGq6nWqhC0YiHkouMC8ECDvWTWFbRhq6WkM/BPocryWI32E+4h1r1HmUKrElYhHC4/GtsO2jJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789641061; c=relaxed/simple;
	bh=a1GRQrkQELUXetn/L7lbG2xwf7DlPgDZqcelW+kyMJ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l5dbywHxD6w0RP+oxQW3K2XGZS2lf5fUuUq3TniFuDSFQVenKiLY2FUmvu1+8QqYxq8m+ydLSiGbZ3vwvNWQxZoc212UOaqX5yqTpy2iBnd2USNuuspp2OzujE0OAjMXDpeGcSnW/WEWOB2jPcNU9/FlnsQB+RreuUd3SCRQx3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ahtY0vME; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ahtY0vME"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CC851F000FF;
	Thu, 17 Sep 2026 10:30:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789641045;
	bh=qovhIl1MwydMUf5GvjcFrCuz48fx27HgEsf4eh7Eox8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ahtY0vMEKRP5z0PmjhkxHHWvXeZCCkVp14nUBkYdm/q+vby4y/nPb1MBCwqFAPXCp
	 B0BsNyn3CcUgahbcXL33IBj79JU+hJPOQK/Re7YbhPz9QpkvAlVtjIVF/Q/116+v2b
	 3n5aMuDFHYvHw4J/hhnuIi7FBAvlnCBpe0AknWB1birZbWylapkWTIag0qDrckhrc5
	 7x2P4aMUmblG+o+hzLTtbCPNW1h04KyB/U29dBf5abQ4JJVO7JQ6GUEvlienxlPDaU
	 3qKaS+EWeDN3n0lWfWlQXWpxIFGyb5frpOFvEQjlmZZ2sF0lpkJTJqzIHlFbrwhp+g
	 wLMtQ0P21RwEQ==
From: Christian Brauner <brauner@kernel.org>
To: linux-fsdevel@vger.kernel.org,
	Julian Sun <sunjunchao@bytedance.com>
Cc: Christian Brauner <brauner@kernel.org>,
	viro@zeniv.linux.org.uk,
	jack@suse.cz,
	jbacik@fb.com
Subject: Re: [PATCH] fs: avoid repeated scans in evict_inodes()
Date: Thu, 17 Sep 2026 12:30:39 +0200
Message-ID: <20260917-unerreichbar-ablassen-instinkt-cf8e6c5a0462@brauner>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260915044912.3183440-1-sunjunchao@bytedance.com>
References: <20260915044912.3183440-1-sunjunchao@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1413; i=brauner@kernel.org; h=from:subject:message-id; bh=a1GRQrkQELUXetn/L7lbG2xwf7DlPgDZqcelW+kyMJ4=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWStPhgg0bvIwHHZRNbb9kceT5oQ5j934YQ+4QOegpcbi +7amf6Y01HKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjCRc18Y/pfbVWxa3bdsXqDZ kZfNT52nWm830JsVoV04kz9M8qfUoZMMv5hv8XQLC0QF3Zut6z3bb+Otr+5CZRnMP7O5Y72j/q+ 7xwwA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Tue, 15 Sep 2026 12:49:12 +0800, Julian Sun wrote:
> We observed hung tasks when users attempted to unmount a filesystem
> after its disk had been removed while still in use. During device
> removal, fs_bdev_mark_dead() calls evict_inodes() while holding s_umount.
> 
> Each time evict_inodes() drops s_inode_list_lock to reschedule, it
> restarts the walk from the head of s_inodes. With many referenced inodes
> at the head of the list, these restarts repeatedly scan the same inodes
> without reclaiming them. This can keep s_umount held for a long time,
> blocking concurrent umount attempts and triggering hung-task reports.
> 
> [...]

Applied to the vfs.fixes branch of the vfs/vfs.git tree.
Patches in the vfs.fixes branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.fixes

[1/1] fs: avoid repeated scans in evict_inodes()
      https://git.kernel.org/vfs/vfs/c/7459c0218742
