Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E1FD3D333A
	for <linux-fsdevel@vger.kernel.org>; Mon, 11 May 2026 10:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778495937; cv=none; b=RbXbrGjON069XUPnR+A6vspG3/W5uFEBWFHehuwh30PXi+2zjbXbg3SeuNhegIQL3qWAF7aLL1mSu+koxRAIH2tqAzjqLG1K2/QGrSCrnRqXsjuPbSiHOJtn75gFN4tM/dPor8vEPiyjRH+aqWSzQPWoefZNooquilGMF0irAUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778495937; c=relaxed/simple;
	bh=0tGeGDHDbsuODFx11O+Uhmc5NiH7oZIwV60asBAZ/Tc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U39QZAfSy0ct7GiyBivqenRZNMZ452LbsYEW8/cu4ed0a8rNtU6ujEVuedsLdKd5PaPjnTtkrCVh6XW6fFEYlsN3Z+7hmOP6y6tCrxo3SEPKPLQbXUnwkJ4KVfnKfcnpy+vusOaTqFdZbcqFrcM70EKs0BrD2DWWD1AbUimE8xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PPFliDvP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PPFliDvP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9888C2BCB0;
	Mon, 11 May 2026 10:38:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778495936;
	bh=0tGeGDHDbsuODFx11O+Uhmc5NiH7oZIwV60asBAZ/Tc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PPFliDvPcQMPqO/ThPBxDAGpyaroAi7wyjo/niM+BrKiti+wZhoTEP3j3ANz+nm1I
	 IN37lb3BVFn82/dBw120/15I4ePVNBlLQxdZYbpMmKLpExHQVDM9h6MJL9ytnLFeEB
	 H8jvqgxoySI+OCi36yCR3EGqYlQXVIrai6zYlWvhHCJm5cNA28nmvhmwkFBja/55wH
	 9Oz5pxLHjuuSclLViYDv2MBwfTsFXC6Vn7R3xlI4lZcEPVQyfYcG+2GQFjj4LRsYwW
	 Hoy6yrnO1dir7T6QMVRRsJNwfkEOtZmc09X+DaUldJ+RF8fLUgHdBRfEMY8dqk5+Cm
	 e28JKPWhUJKfw==
From: Christian Brauner <brauner@kernel.org>
To: linux-fsdevel@vger.kernel.org,
	Junxi Qian <qjx1298677004@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Greg KH <gregkh@linuxfoundation.org>,
	Joanne Koong <joannelkoong@gmail.com>
Subject: Re: [PATCH] fuse: fix writeback array overflow when max_pages is one
Date: Mon, 11 May 2026 12:38:51 +0200
Message-ID: <20260511-trotz-stopfen-bcbd74d26b06@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260506122415.205340-1-qjx1298677004@gmail.com>
References: <20260506122415.205340-1-qjx1298677004@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1538; i=brauner@kernel.org; h=from:subject:message-id; bh=0tGeGDHDbsuODFx11O+Uhmc5NiH7oZIwV60asBAZ/Tc=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQxbtwzwYk1Ur+sWTNB/vBux+In63nu7Ej3Ko9apLhrh sR68U2TO0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACYyy5Dhr3jkWp2Vr9fyr2T/ oHf4d0fJWemz/VFruPfXTNfx+cppMouR4am91+JDDycmhGax/Y/mVMx0sbC8+KHIgO+GldLfYyG 1XAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Wed, 06 May 2026 20:24:15 +0800, Junxi Qian wrote:
> fuse_iomap_writeback_range() appends one folio pointer and one
> fuse_folio_desc for every dirty range that is merged into the current
> writeback request.  The merge decision checks the byte budget against
> fc->max_pages and fc->max_write, but it does not check whether the folio
> and descriptor arrays still have another free slot.
> 
> This is not sufficient for fuseblk, where the filesystem block size can
> be smaller than PAGE_SIZE.  With writeback cache enabled and max_pages
> negotiated as one, contiguous sub-page dirty ranges can fit within the
> byte budget while spanning more than one folio.  The next append can then
> write past the one-slot folios and descs arrays.
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

[1/1] fuse: fix writeback array overflow when max_pages is one
      https://git.kernel.org/vfs/vfs/c/fde8a3147d3b
