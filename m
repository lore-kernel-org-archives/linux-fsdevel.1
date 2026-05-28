Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 717CA3DEFF1;
	Thu, 28 May 2026 12:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779969986; cv=none; b=s13yN3H3TWcnwQL1flEUiVkhvHqnuHPtCYj6G5yjXKYutxR/qcwZkx8OG94pP6fOJRMLO8FdaiMuv67Y8nU/E9f1M6TIS73fsR/GE2cGJfsC9Has+FGnTI5A6VANKpr13pRfwIruYv61WHS/7K8eJcCGB8RgtcQLOPFh0Cq5yzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779969986; c=relaxed/simple;
	bh=0Xw5RhWXwjpT7MjUzBFFZ5hRnnD+uEwKAO343Wi9GFU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gjf0r6L4u1kEuhEzUFEF+GJfcpR/2RmisWJwXSjSMiG4JMD+lDQ9/ibj2dB/3qhCoSoPlhjwRpQB8gxVy5OabDY1vtYIvH101XwpuUQ843tJAkD2H1tlZYsZN6AIzwhYMAJpeOVcFqYhz5+9GnNdxu8fHK9bwhjux9vPN0kcy38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JS0ACI/J; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JS0ACI/J"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 084F41F000E9;
	Thu, 28 May 2026 12:06:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779969981;
	bh=M9HTaHKkK3V9210sJDrQs5UI5ckPf5RldErK9zXwpnw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JS0ACI/JpIuYAWLxIpH+xFgCypd9vq0Lbb39afi98nct1IxqTr+iTH0V+wd75sLYP
	 CUFFPg6IWzeOEkkYsO2HE1ViJ6gvUpOR4Dq00UUxuqRM3mQZhV9VuNietXnV68CL0L
	 LVBKgYqtrBvMjhTVNee/eR8+95gAzF6H49KUn7z+rwJpHyfe1OOylnPetJ6HlryHC1
	 kDRvlDnrLiLEG5EI30zY5lCD+/FUgdwalh17YzYqORMRWcsVTArpnTp06adH9gRge2
	 Z4um91/49pCXrxJdVMijPnlYGj458YRvxL5xe14MQyt67Hhe0biLT63p7t7JN0kS/9
	 vSMTuOIsAItrw==
From: Christian Brauner <brauner@kernel.org>
To: fffsqian@163.com
Cc: Christian Brauner <brauner@kernel.org>,
	viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Qingshuang Fu <fuqingshuang@kylinos.cn>
Subject: Re: [PATCH v2] fs: fix spelling mistakes in comment
Date: Thu, 28 May 2026 14:06:09 +0200
Message-ID: <20260528-ohrringe-impfen-herrschaftlich-cc96cd007822@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260527100025.960339-1-fffsqian@163.com>
References: <20260527100025.960339-1-fffsqian@163.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1116; i=brauner@kernel.org; h=from:subject:message-id; bh=0Xw5RhWXwjpT7MjUzBFFZ5hRnnD+uEwKAO343Wi9GFU=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRJ6O/YVWnklaFznHVxxPaj32YGSrq/TPOVfsV8uWrl/ BemlfVbO0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACZydjXDP9Vf75T1n3GxHnOZ u/r2LC3NY40Ry0LXvpDcvy5CpLw915rhf7zRhzDFG26WzrEpNpytypfSlDmS5TZV3RDh335ymrk yNwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Wed, 27 May 2026 18:00:24 +0800, fffsqian@163.com wrote:
> Fix three spelling errors in the comment for an internal file structure
> allocation function:
> - happend  →  happened
> - over     →  exceed (grammatical fix)
> - int      →  in
> 
> Changes since v1:
> - Fix comma after e.g.
> - Fix incorrect use of "imbalance"
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

[1/1] fs: fix spelling mistakes in comment
      https://git.kernel.org/vfs/vfs/c/5afe734e7621
