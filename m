Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9765B42C516;
	Tue, 25 Aug 2026 12:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787661891; cv=none; b=ZrhFXQyrJsEEFHeSkJtG2hbuWCdqIX2C8AacnY0t1u4Bl/GxcbMhZwlsmgz1npzf8wtjp6Vnc6R+eseSBincoe0xCqJK1YZKtiPGu1DfyO9/gcbOau1g5j4JTfRbIkNWIWcaFD1IzCFnJ4TnNLnV1D7Qqr11Nswe5JZOgBYatPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787661891; c=relaxed/simple;
	bh=qVkXllcC6+xHHWdpkdPqZ6dg3e1BuUt3CPAdbqAlAmM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N1ftHRT5eJI8XgutIc/9CMza4k1s48gl83df2PCOdfHUbAv9ffy7RZcxwzON066wQ+Gt5msOCUygBbkBI6PjYV9+kU3c9p2jC/Wd96Srie8VnFh5tOg58ue9wSKYnn8GPNE+1CiNCR5mQlV41yAIkhjd/NjRwcV8YTbtsNUPoro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iKqWpNVU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iKqWpNVU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A049F1F000E9;
	Tue, 25 Aug 2026 12:44:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787661889;
	bh=cXcnfr7FlfocdJ2Co3mfADDfPER4cR1g61jdcno3Zto=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=iKqWpNVU+gwh85NG5HaaKerNlVtv+sI7S7zDomTW81wjx3neqDsrcqEnKU8wqcl9n
	 HtMMn//7/ldnFoUL6VuWtZbyBQ6HuDFMF9ga2RKBR847EnqRngWOhEBV86VZ5IJXzE
	 CO45XuTJcngLDBzIchqwkhJ4JVedePsLGoE5vOwR50Uo6rp0Y3idBbU67tCCxMxI4G
	 W1/vVOcONVQT0KdLzAaOY2UNdz1kuy0Hy0XStxOF+1BzGstsAq2B6vBE2JQGEv35zs
	 qtoQUYVcSeRSTPfiAPEVPbMK27x2HZII7cMFo4zWfviQ1+G+9ITsbfBGNv0LB/6lu9
	 Zc5+a6cJJdaDg==
From: Christian Brauner <brauner@kernel.org>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Ali Ahmet Memis <ali@iusegentoo.com>
Cc: Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ufs: do not treat unreadable directory blocks as empty
Date: Tue, 25 Aug 2026 14:44:42 +0200
Message-ID: <20260825-dorfgemeinschaft-labil-paktieren-6e7c667e2cf5@brauner>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260801013942.279992-1-ali@iusegentoo.com>
References: <20260801013942.279992-1-ali@iusegentoo.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1478; i=brauner@kernel.org; h=from:subject:message-id; bh=qVkXllcC6+xHHWdpkdPqZ6dg3e1BuUt3CPAdbqAlAmM=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWT19tnU3Vx40uOa/35zOd5dvVeZIt0bS52ap71bctvE4 eJFHguXjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgImsW8XIcHqe9I+bB4N0k0pn nue68PG9pd61syf+my2ekfZom6jr3YMM/zQ8bh9y6FY/Kfl6gZD0/JsTbrMt6/wbsPlkm8gS/ek saqwA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Sat, 01 Aug 2026 04:39:32 +0300, Ali Ahmet Memis wrote:
> ufs_empty_dir() scans every directory block to decide whether a
> directory is empty before rmdir() removes it. When ufs_get_folio()
> cannot read or validate a block it returns an error pointer, and the
> loop currently skips that block with continue and keeps scanning the
> remaining blocks.
> 
> If none of the readable blocks hold an entry, the function returns 1
> and the caller unlinks the directory. A directory whose contents live
> in a block that cannot be read, for example because of an I/O error or
> corrupted directory metadata, is therefore seen as empty and removed,
> losing the entries it still holds.
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

[1/1] ufs: do not treat unreadable directory blocks as empty
      https://git.kernel.org/vfs/vfs/c/08edfb34ee9c
