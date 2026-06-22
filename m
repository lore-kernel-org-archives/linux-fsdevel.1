Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD0923BB11F;
	Mon, 22 Jun 2026 14:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782139081; cv=none; b=DPGTnOgG4REUSR9zCYnsqILJULGglHV1n0VXC9BgRCxZa0C5MRw4SFVnF5EFb29T06SnqgdUXCl3HludsjBL+Z2yE5n4DcVDWwjZoxbcrhtanntwoBq3Dy2TdBwOGEoRf/XVwfCVDscAm2O/Mgmp+Vl2DVOcGx4aX1M3DTu3VOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782139081; c=relaxed/simple;
	bh=iPOuT8icMLqMoxvRXCpi0GrqBGnmJO1lfYmIe3sip44=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=p+4FCqMb6TLTEaP+ngrzBzCSU5lqETJ/wHVKp1hjCfZge3xixhidCPpRm43yDcIv18hWfr0mKbZEcFK8ULGv4oFkU+RK6OUkc4NpYOgUhNB51AgjmNT7riw9QlQxqfQ51qUDqT6iaTXqmsws9sC43bsMf3gGrseK6NSX/6wAX8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GU78nGmu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GU78nGmu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C0C61F00ACA;
	Mon, 22 Jun 2026 14:37:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782139080;
	bh=yspqunTEr1X48SoZkEr1im+eJR4xuMAPAP2SEO1DbBI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=GU78nGmunQvYSSUs1kTQsVj53enMqqvTdHQsEuEOVkGBd7+JzqvuNV53nC06UvnNU
	 2Y3cENGPzEkCXAwnphsuJKw9PG1hlsKN0eI3gzO/FgYGf+bBiamPtEEjydhl/FQnvY
	 gAiZts/kNlhhc8LmLcZOA+uiP330hS9MZ6J8iWfbyuzdspxCl98J6aLD2N9K0lKHtI
	 nTbW2RhvGXwrDuMhJ4EMkzCWUZw58hW9K2YXlYtg3DQS152GO42/g5LfnNrubSc2IO
	 41xkSHQMngXuMXaXdlTxuXH+kGTBT28sIynYOVOUPfBt12vvXqEg3GmVdPnY6YTaVZ
	 KuQBM/UKbVyrQ==
From: Christian Brauner <brauner@kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: Marc Dionne <marc.dionne@auristor.com>, linux-afs@lists.infradead.org, 
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260622090856.2746629-1-dhowells@redhat.com>
References: <20260622090856.2746629-1-dhowells@redhat.com>
Subject: Re: [PATCH v4 00/21] afs: Miscellaneous fixes
Message-Id: <20260622-finessenreich-fehlen-stoppen-11455cc51c1a@brauner>
Date: Mon, 22 Jun 2026 16:37:35 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev-490fe
X-Developer-Signature: v=1; a=openpgp-sha256; l=3456; i=brauner@kernel.org;
 h=from:subject:message-id; bh=iPOuT8icMLqMoxvRXCpi0GrqBGnmJO1lfYmIe3sip44=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRZehzfvLVlwkadPAHZtY7CqSz7OvX36Dz1u32q5/2Rb
 cts4+42dJSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEzE8zfDL+Ygrfu3XPZYvKqI
 aP904upe/tpQpRiGvONlFV/KuDZNb2f4K2/695TersbkjUdCTbRWxDz759ssKfVjTWXWlHrh6T3
 6PAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

On Mon, 22 Jun 2026 10:08:34 +0100, David Howells wrote:
> afs: Miscellaneous fixes
> 
> Hi Christian,
> 
> Can you pick up these miscellaneous AFS fixes, please?
> 
>  (1) Fix the CB.InitCallBackState3 service handler to handle an unknown
>      server (server pointer is NULL).
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

[01/21] afs: handle CB.InitCallBackState3 requests without a server record
        https://git.kernel.org/vfs/vfs/c/f45dfe9144c7
[02/21] afs: Fix error code in afs_extract_vl_addrs()
        https://git.kernel.org/vfs/vfs/c/0acc5546d4a4
[03/21] afs: fix NULL pointer dereference in afs_get_tree()
        https://git.kernel.org/vfs/vfs/c/bae1d000c485
[04/21] afs: Fix double netfs initialisation in afs_root_iget()
        https://git.kernel.org/vfs/vfs/c/a3ee80a4b58c
[05/21] afs: Remove setting of AS_RELEASE_ALWAYS for symlinks and mountpoints
        https://git.kernel.org/vfs/vfs/c/706849a44880
[06/21] afs: Fix directory inode initialisation order
        https://git.kernel.org/vfs/vfs/c/af8fcf434550
[07/21] afs: use kvfree() to free memory allocated by kvcalloc()
        https://git.kernel.org/vfs/vfs/c/de75d538b414
[08/21] afs: Remove erroneous seq |= 1 in volume lookup loop
        https://git.kernel.org/vfs/vfs/c/24062f2bb2a6
[09/21] afs: check for duplicate servers in VL server list
        https://git.kernel.org/vfs/vfs/c/677d037efa7f
[10/21] afs: Fix bulk lookup malfunction due to change in dir_emit() API
        https://git.kernel.org/vfs/vfs/c/3986f11557ac
[11/21] afs: Fix misplaced inc of net->cells_outstanding
        https://git.kernel.org/vfs/vfs/c/d45daf4b24cb
[12/21] afs: Fix reinitialisation of the inode, in particular ->lock_work
        https://git.kernel.org/vfs/vfs/c/c0d3fb0b2da5
[13/21] afs: Fix callback service message parsers to pass through -EAGAIN
        https://git.kernel.org/vfs/vfs/c/705627309745
[14/21] afs: Use scoped_seqlock_read() rather than manually doing seqlock stuff
        https://git.kernel.org/vfs/vfs/c/288fff610357
[15/21] afs: Fix missing NULL pointer check in afs_break_some_callbacks()
        https://git.kernel.org/vfs/vfs/c/95b0a4b91aad
[16/21] afs: Fix leak of ungot volume
        https://git.kernel.org/vfs/vfs/c/7d9517ebb956
[17/21] afs: Fix vllist leak
        https://git.kernel.org/vfs/vfs/c/11b51f828fb6
[18/21] afs: Fix lack of locking around modifications of net->cells_dyn_ino
        https://git.kernel.org/vfs/vfs/c/c3a9fe822d14
[19/21] afs: Fix premature cell exposure through /afs
        https://git.kernel.org/vfs/vfs/c/6baa330b35ed
[20/21] afs: Fix the volume AFS_VOLUME_RM_TREE is set on
        https://git.kernel.org/vfs/vfs/c/2d02c376a453
[21/21] afs: Fix unchecked-length string display in debug statement
        https://git.kernel.org/vfs/vfs/c/6e05f5903290

