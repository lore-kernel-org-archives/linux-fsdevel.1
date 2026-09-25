Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0E824CE67A
	for <linux-fsdevel@vger.kernel.org>; Fri, 25 Sep 2026 15:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790350033; cv=none; b=kHsdgrCdhqpV+/465xYP2MPNMRW0WtbG/ip53m4VdTglc1w9Hlxys67BoSHuwg/kwitGXlIM/AjAEe/dASEzVRCPApZ3yDy+SdEjkG+MsPyDy7tb0Xdl+I61RI7B5ijaq90NlND4VZzDmaFJISYecYwsIz23UXdoafi/A0kwoY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790350033; c=relaxed/simple;
	bh=QiOdI5ie9Wic4iqmvCCRmQNxf/g07Uk/qM7aWdUeRy0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PKQycr1E681gr8Wy38B7o/gpfG9rQpuuaoLk/qFn0eENoB3g6y/j+IeHrs+bDOosQl6Qmi+Om9WC+aIq+zAQhc6qQasIacE5GvUsITX1+xzUMYSJ3mvc7IyfGM4AFNQ8lZFCbgUTbxuyAQhOt8lk2ixe6pBGKmVynt4Hmec9+vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G6+Kz6HS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G6+Kz6HS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9691E1F000FF;
	Fri, 25 Sep 2026 15:27:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790350031;
	bh=M0Dlkk7AxI+8rNRtVS5M1ySYtEPD5rm7u8ObsT1hC7s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=G6+Kz6HSWnElnZPFmeh/2PcaTum0xwfNI61Ru6dckoL/DWbb3J3W004zVxLfKSSrM
	 Un4LCXV9FiUiws6p9TF5GvWX6E/wJUoynfuoUEfU1F9PxSKv82yH2WHGQikBq/Ktga
	 0Cippz5vRPrTezdgAeC1t6w8zoElWzY7yg89LV5pOAmgvEy80psiJ1B6KBPuN/nnm9
	 Arla20ZUz0O+3qjGfDrfhJGKI6vzPUkFZHt/eNncvGHYM2WdgwIBuau6EHpofvDdF0
	 HwahKDCObIyYey7XVab7qYuFjj7gaS9iUdFXbh6A2Raf4oQ2b9OuUYNi2NtUtv+1tf
	 h6G1gFOUba+1Q==
From: Christian Brauner <brauner@kernel.org>
To: linux-erofs@lists.ozlabs.org,
	Giuseppe Scrivano <gscrivan@redhat.com>
Cc: Christian Brauner <brauner@kernel.org>,
	xiang@kernel.org,
	linux-fsdevel@vger.kernel.org,
	amir73il@gmail.com,
	viro@zeniv.linux.org.uk,
	jack@suse.cz
Subject: Re: (subset) [PATCH v6 0/2] erofs: share the superblock for file-backed mounts
Date: Fri, 25 Sep 2026 17:27:04 +0200
Message-ID: <20260925-aufruf-fiktion-regeln-d328dc899089@brauner>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260812142907.1010046-1-gscrivan@redhat.com>
References: <20260812142907.1010046-1-gscrivan@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1431; i=brauner@kernel.org; h=from:subject:message-id; bh=QiOdI5ie9Wic4iqmvCCRmQNxf/g07Uk/qM7aWdUeRy0=; b=kA0DAAoWkcYbwGV43KIByyZiAGq2ksqj4iOUbTRt+tCP41MdiRWL4PxlsaHlbofybF0fD8VM8 Ih1BAAWCgAdFiEEQIc0Vx6nDHizMmkokcYbwGV43KIFAmq2ksoACgkQkcYbwGV43KKS9wEAs/6R ud8dpR38Hs0SE7Z2Pky1VZAl//RYB31gC5QgEgEA+gPZgiHkuTpb0ze/tOH7CvycGp61RbjZBn9 GcmGNh6YK
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Wed, 12 Aug 2026 16:28:02 +0200, Giuseppe Scrivano wrote:
> v5: https://lore.kernel.org/linux-fsdevel/20260811071241.389589-1-gscrivan@redhat.com/
> v4: https://lore.kernel.org/linux-fsdevel/20260804060455.2928514-1-gscrivan@redhat.com/
> v3: https://lore.kernel.org/linux-fsdevel/20260801075446.2508805-1-gscrivan@redhat.com/
> v2: https://lore.kernel.org/linux-fsdevel/20260731160901.2276832-1-gscrivan@redhat.com/
> v1: https://lore.kernel.org/linux-fsdevel/20260730124120.1501126-1-gscrivan@redhat.com/
> Needs: https://lore.kernel.org/linux-fsdevel/20260804055949.2927896-1-gscrivan@redhat.com/
> 
> [...]

Applied to the vfs-7.4.shared.super branch of the vfs/vfs.git tree.
Patches in the vfs-7.4.shared.super branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-7.4.shared.super

[1/2] fs: rename vfs_get_super() to get_tree_super() and export it
      https://git.kernel.org/vfs/vfs/c/09c6d98c822f
