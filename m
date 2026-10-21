Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792580531;
	b=ueZtqcUVx68jqbx+gkCl+yEjbYDBDz66TGlvmpNd2eUI6kLPr89eMfxDtUvnSR89kRMz
	 NEBR1TIfA5M0zHcI3/5KLeof3xhBctxaWYRWMy4yIo2unaQ1t4gwDITWHh62DPL1UN+Ls
	 OuZig5L0d6GbyZq9ir1UJdvAZ+xWl+xaRRwaS3KL3C8Z65cppijoTEsnR+ceFw24vJ0i9
	 7iElBiRHEXqC/ERrGE8zs26G74pIK/59xxeGibaoPJuMe3Sfaq5OgfWU2Dssu9d/7+EFw
	 StHlvhkdm8CHf3SNilHUftHH9SckMuuttlklVR3GIuu/JQb/UO6N3u2T6gd6OjRUs0w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792580531;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer;
	bh=PdmJsgTpv+nptfyOOmmbrW0YrX6jCcLIr1uvv9rx8+8=;
	b=P9Jo0D3l6v7K6+IYYzkqVVuDD3cIE1pgV7+dJu/W8zR55CFWXL4XBEcFwE/eMfJKRR3n
	 P+VXjXxX7StJ6GE+4cC10ljcynZPG4lr/Xa6Gb9DzI2cIy3IrhT7/2ygVxfI7Y/llFEPn
	 GGGUa7DyLoHRZW/d/fH8zhmPZU5MKSFSSlLFeJqPCBATp+RnMcEjEEcvLI2PPIllHHHt3
	 p3Cec/UGc+lnps5h1UwIbg5FyYPOSGs+Lsw8U9pM3/jzLYjoeBODRLNy7pWc1P4cIvlTX
	 tY2Wzo+3yy2gJwPc1KLbWFWBMIbaqoZCaWwpWDeSMbHaukllvWshR6X4kLMO+DN0EUA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TYxoOD1w;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECF5A606A319;
	Wed, 21 Oct 2026 11:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TYxoOD1w
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61FB11F000CA;
	Wed, 21 Oct 2026 11:02:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792580530;
	bh=PdmJsgTpv+nptfyOOmmbrW0YrX6jCcLIr1uvv9rx8+8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=TYxoOD1wR4SOXzcuxepKrKZgUk5VXai1Af8sEauxt/cDng/w7j5AWg38BhHUzeLTG
	 jcnXnAPVyieeuZNQUxd1hFsXLpl42cd0Dp8tXb1nEWdaEvp56cp2FgMYUY5qi9CQdt
	 pM9fjfUJqGHT37aWawmWd+HAbJcmOpeEs5j6DLNYmu0pAj3WdTSSabIw9REi9o2qKN
	 x/wCuB0MOaggT2MSMlB4mskvmbIRKGZ9vjv6Z8EdBIln2174e36RT238PertY+Cnls
	 76vZyQTA1K+D/k+YJj3wIpxChBmuIG5aQ2l00e6picu5Iv6Pvl3LQaQ0NeR2qoyb3z
	 1UUPIQptU434Q==
From: Christian Brauner <brauner@kernel.org>
To: Nicolas Pitre <nico@fluxnic.net>, Tal Zussman <tz2294@columbia.edu>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260906-cramfs-blkdev-read-folio-v1-1-1be99a82be55@columbia.edu>
References: <20260906-cramfs-blkdev-read-folio-v1-1-1be99a82be55@columbia.edu>
Subject: Re: [PATCH] cramfs: convert cramfs_blkdev_read() to use folios
Message-Id: <20261021-perplex-bahnstation-beruhen-442c7b6f814a@brauner>
Date: Wed, 21 Oct 2026 13:02:07 +0200
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev-3d1b8

On Sun, 06 Sep 2026 19:45:33 -0400, Tal Zussman wrote:
> Read the block device pages through read_mapping_folio() and copy with
> memcpy_from_folio() instead of going through a page.

Applied to the vfs-7.5.misc branch of the vfs/vfs.git tree.
Patches in the vfs-7.5.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-7.5.misc

[1/1] cramfs: convert cramfs_blkdev_read() to use folios
      https://git.kernel.org/vfs/vfs/c/06e2e8febbcc

