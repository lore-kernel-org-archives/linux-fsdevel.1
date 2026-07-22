Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 742A635B650;
	Wed, 22 Jul 2026 13:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784727771; cv=none; b=e3oyP665UZC84Hpqvc0vYl9vkPyZg3Fd0iHQjLwqcL2dOIeTfTkbfEHGjWzSiS/6ADzHk6t5YXRbKNYt5vcZis8yxHoYw6U60Z0oXAr1NiyG4ES5VhT1jjaoL2TW7B+xgwzyL6ga8rlo1nuERpkY5W925vYLQNnWnM0zqxB0uJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784727771; c=relaxed/simple;
	bh=21CTANOtgp4SEErZyRJGzI62y3A3/1HD4Xkpolv2jTI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=aECnT+lj9c0AcqonxCykYWPlVOmxAKvqz+goH+Sva//Y7/swV91vPqlUuaLntAS81jwNKjwj11zd7VAsYA8LItKTEczRUgpVikig1DxRRoCBbVL0fhAFWeYlHrvAciyv1S+RUtbUG6M0ETn5fnp6N2pWE37F/2vkGdpw778mP+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oGVfgQtb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oGVfgQtb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D4C41F000E9;
	Wed, 22 Jul 2026 13:42:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784727770;
	bh=lCyRdp+wEhUDd0LFtLoAhUkeSKnus/Wy7uUfHU/37GQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=oGVfgQtbq8Gl5fxBnFHIis/RbZDGU/EJd6wyH8TZ4iK/w/H9V54N0PXVh0irGA/+i
	 0ZiyRNu5c+goJhjCwo4fVKZUxiBoDLLqOPGVmaRshJSARiDdX60H43RsHatQDyAYfs
	 Rfl+Xm/eaahjXyrycA/w8ecqCikY2W8sy6E+bAl3x+ky8Gokb9xhXm5VaWuEgcOZP2
	 9UlaAdAbmhobbjL3LvHzyftoeULt4L0mfhcZjCOUOWG9VLiLuz3pKkDYzJTQ/VuiCN
	 pCmGe7voI2Pqburq04VCbRMIjuGRRcUZqmv+RcSW4N2WgmSouDhnNfk+m/oPuC1iek
	 UCMUi3zc4g/mQ==
From: Christian Brauner <brauner@kernel.org>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: djwong@kernel.org, hch@lst.de, miklos@szeredi.hu, willy@infradead.org, 
 linux-fsdevel@vger.kernel.org, fuse-devel@lists.linux.dev
In-Reply-To: <20260707220450.1200943-1-joannelkoong@gmail.com>
References: <20260707220450.1200943-1-joannelkoong@gmail.com>
Subject: Re: [PATCH v3 0/3] iomap/fuse: add helper to keep uptodate bitmap
 in sync
Message-Id: <20260722-lernen-morsch-gewachsen-d0127dc27936@brauner>
Date: Wed, 22 Jul 2026 15:42:44 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev-2f6f2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1611; i=brauner@kernel.org;
 h=from:subject:message-id; bh=21CTANOtgp4SEErZyRJGzI62y3A3/1HD4Xkpolv2jTI=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQlnLhxiPP9lSMb9ZO+fXmzYEEbs2Hg9n71KRYr/pyed
 vsEo+7ESR2lLAxiXAyyYoosDu0m4XLLeSo2G2VqwMxhZQIZwsDFKQATMa9lZPg/bV+Lbdf3M9q2
 Zw+KZUwI9/ybvCf/gbmtvcfatlMHG7cwMtxrDud4dWi+vr2qSIi2ZMb5m0Wddm4qklKMzqtMEws
 T+AE=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

On Tue, 07 Jul 2026 15:04:47 -0700, Joanne Koong wrote:
> iomap/fuse: add helper to keep uptodate bitmap in sync
> 
> Filesystems that use iomap normally mark folios uptodate through the iomap
> read/write paths, which keep iomap's internal uptodate bitmap in sync.
> However, some filesystems need to write data directly into the page cache
> outside of those paths (eg fuse, which may need to write server-pushed data
> straight into the page cache for servicing notify stores). These filesystems
> need a way to mark a folio uptodate that also updates the iomap bitmap so
> they're kept in sync.
> 
> [...]

Applied to the vfs-7.3.iomap branch of the vfs/vfs.git tree.
Patches in the vfs-7.3.iomap branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-7.3.iomap

[1/3] fuse: don't clear folio uptodate on writethrough errors
      https://git.kernel.org/vfs/vfs/c/e4cd50a53ab6
[2/3] iomap: add helper to mark folio uptodate
      https://git.kernel.org/vfs/vfs/c/f2286d1715d0
[3/3] fuse: use iomap helper to mark folio uptodate
      https://git.kernel.org/vfs/vfs/c/01c7fe2396a6

