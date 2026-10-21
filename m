Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792576510;
	b=tdGsho0m/Y/2JpytN8G4rRKCII+IX52UE+fkM1YkGkzYQG72+FuzjUwOMeNV5wzOF2+n
	 UYYfKNq/RrPdz1SP733JZ3OneZypaChZTjIoeexVXPrxEyY31WPwCtDps6eaC2GW/U9gg
	 e34YrTfIkWQ7o1suEopHuJiKlDBL4/VogElNqatrq4yVNKBrTDUWx8mV0bK/S/df6MyW+
	 ax8EnAsG554OlkhrqF2EeIT7dPXByb33YE8hnmrfGSD5YqdLlgDgcbEsTdLvee/AJ+F2q
	 2D7pttGiTQsTV6lUs2BsAuRvP41OFC0ry3FE7BgTPQ0oArsuT6OXIaoFc4rHF6jLhMw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792576510;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=ZWnlvenSrWTUdWlcb6RYZMAc7Hr8u885gkQoD0ExKWg=;
	b=EQC/g1fgB/YgSQMl+AbMAQclPKtGWDBeEdFtsI7v1CBtRUvbJbXv1gMmQYYUlzEkXTup
	 54gowFMRbxT15iPLx85iuD2XxZUtAyEXROcblKv/v9t8Vp5f5gv0q7vLShnwGdRo3PrRD
	 Y1t8xVrsQ3RVQTW1GOriEPAsdbItMg/zV3JhukZbSCj/gU2TiVMjkAWmVI3rtNVpDrLoz
	 rH44ZJn1oKZvrG1Q5zimZFR1Hct19t+O8hOHuzgsG7yaCLRzvMZJVDghoiu1zin/HrxkO
	 CTSbwwobfQa4UGRVh7/NsqkkEeNm2lkCGmf6eq6RyX62kKEYLst6tkHA9b30n57ib6w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=U+pAeIj8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E1BC606A31A;
	Wed, 21 Oct 2026 09:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=U+pAeIj8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E63D1F000CA;
	Wed, 21 Oct 2026 09:55:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792576509;
	bh=ZWnlvenSrWTUdWlcb6RYZMAc7Hr8u885gkQoD0ExKWg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=U+pAeIj8z9oR6fSpTIgn/CYa1uFw9OwXyJVbP2HjE9MBB/74sJt9ZeDD/oxPN84DE
	 24j8t3iL7ufsJ8pUR79OIsb5PnzZnGTbTx9BE+Pe7LVAqZY9x/CjPqfC1C9JVOLma3
	 KHBuxYT5KKjGecXrSLyzYzA9Oc7oycuG82uWkYZfzXnprfIOmARaf1Nlfhr3MFCTek
	 Vxke94MBh1UPrHveiPQiSwrWF0CM9YnRsxJqRtFZ1+/X5biCyFZ374A43PTekrWHqV
	 pwGmXW+i0bjUyMnC2ZvoYEvjjTx65uZImdWJSz2g/ZXP8EsF8bbmfJM3ULk+tCWVip
	 rMLvy9329df5w==
From: Christian Brauner <brauner@kernel.org>
To: linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz, 
 Matthias Goergens <matthias.goergens@gmail.com>
Cc: linux-kernel@vger.kernel.org, hch@infradead.org, djwong@kernel.org, 
 david@fromorbit.com, amir73il@gmail.com, ansgar.loesser@kom.tu-darmstadt.de
In-Reply-To: <20260926043836.3301898-1-matthias.goergens@gmail.com>
References: <20260926043836.3301898-1-matthias.goergens@gmail.com>
Subject: Re: [PATCH v5 0/2] vfs: add FILE_DEDUPE_RANGE_REPORT_PROGRESS flag
 to FIDEDUPERANGE
Message-Id: <20261021-rente-privat-mitfiebern-1b76f4650038@brauner>
Date: Wed, 21 Oct 2026 11:55:01 +0200
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1423; i=brauner@kernel.org;
 h=from:subject:message-id; bh=GOaRj3Gv5NlsKeckjn5SooRjdUT+GiHvGJ855DmMAns=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTd6P751arzdhPbe6kpNldd1apVTh4+4DNV3J+pqFZtw
 zm+z1xpHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABPx/8rIMNHm9HVB/8sl53uK
 0+f8OKS48cH+ivOmefZqAZxbMzl8BBkZNv2J2FHlkZLPt6dmBoPkU6tbMTN0/5hPW918YGl+84k
 eVgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

On Sat, 26 Sep 2026 12:38:34 +0800, Matthias Goergens wrote:
> vfs: add FILE_DEDUPE_RANGE_REPORT_PROGRESS flag to FIDEDUPERANGE
> 
> Dedupe tools advance their file offsets by bytes_deduped, but when the
> kernel shortens a request to a block boundary it still reports the
> requested length. Patch 2 adds a flag under which bytes_deduped is what
> the filesystem actually deduplicated. Patch 1 fixes the DAX comparator,
> whose return value would otherwise surface through the flag.
> 
> [...]

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

[1/2] dax: return the comparison error from dax_dedupe_file_range_compare()
      https://git.kernel.org/vfs/vfs/c/1922bdb0b9bb
[2/2] vfs: add FILE_DEDUPE_RANGE_REPORT_PROGRESS flag to FIDEDUPERANGE
      https://git.kernel.org/vfs/vfs/c/847f74d6293b

