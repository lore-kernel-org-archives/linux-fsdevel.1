Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DC6F3BBFDA;
	Fri,  3 Jul 2026 10:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783074716; cv=none; b=U9Uf5UxTrQeSQyav0F9vTMHaMl6etmdgu2K8rftBsnxHOz2hR3D6IgvavMD/A+nSkkZjrJNohL+Sc34rB0B/stu3klGFB1dnImmgLQ0U4cosRmWZQgLV2Qv2PCfwOOjHNQcSp+miKB8sg8XfqIsUxsZRdXCzc0hdUPa0Cql2QwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783074716; c=relaxed/simple;
	bh=tNNT9DMojtFQQNhjiyeFEmXBYRZjmmXbO+FCb/+eTsw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=rmdQB9ifr7Sc9h40OPj2YZrpLfCpMfXZBsSW+NrdVRNBP/FTTOe3EmYuvQ57GjeSB4K8+0PpC8/qCcfJbQiku+2rc3sMr+Fy3usEU9DV/SNnla4VtbEZeIjNVQhJwvuGbzTTMXl+Xp95S69IsOzUn8pklIM8SYYJMEGBaZMxvVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=emf567b/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="emf567b/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6CD81F000E9;
	Fri,  3 Jul 2026 10:31:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783074714;
	bh=6Bu3OiTC/RegbODZ30ywa3/xjuAXrgAmImrB/sTt7bg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=emf567b/q1fEtywBoaEPlzxdV+QqdSzYq8sBKuiA3CTjoPUPP0+CqksNubGpDvGnk
	 56GVeAaz1+EyEC0tRHWH6saT2b8fxFUkzKiSGPTJmYHTey8exIz19cTWn9t8dHAhC7
	 CzNWFzqKHIsrK7+VdvWyq81UC0jKPzf6n4lh0NJEwmwomETNmeaMSMB33kJcdl1k2Y
	 8ngknZj6/hAAYUfU1ttKU/NR7OeQgsVzgBDf+ZJiw9V7JHnwJuO8/9XQ8CtneJTMJc
	 8XhOOGQp2Sc2IrubjZC5xcSp4Dx2sBq7pg5gm0PvNDXTJBCoWaN16wOKtDaEQyLv4L
	 20FQgM6jrpQnw==
From: Christian Brauner <brauner@kernel.org>
To: linux-kernel@vger.kernel.org, 
 =?utf-8?q?=EC=9D=B4=EC=83=81=ED=98=B8?= <kudo3228@gmail.com>
Cc: linux-fsdevel@vger.kernel.org
In-Reply-To: <20260701220729.822112-1-kudo3228@gmail.com>
References: <20260701220729.822112-1-kudo3228@gmail.com>
Subject: Re: [PATCH] romfs: detect hard link cycles
Message-Id: <20260703-vorteil-miteinander-planktont-3ce9bf98dcab@brauner>
Date: Fri, 03 Jul 2026 12:31:50 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.16-dev-4217c
X-Developer-Signature: v=1; a=openpgp-sha256; l=842; i=brauner@kernel.org;
 h=from:subject:message-id; bh=tNNT9DMojtFQQNhjiyeFEmXBYRZjmmXbO+FCb/+eTsw=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWS59890iN64xZSVm3lbwsYE65/OqsZTlgm3fdNZufxj0
 27TiRFrO0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACYS+YThn5H/rzylrp8p4g4C
 R/UbpM6IrL2mKBZor/2o8f0yuauOFxgZ+s5Y5T1KLq+d7vNwzqb/Wryi1a7xf6TvKf84s/DL7sb
 /XAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

On Thu, 02 Jul 2026 07:07:29 +0900, 이상호 wrote:
> romfs: detect hard link cycles

Applied to the vfs-7.3.misc branch of the vfs/vfs.git tree.
Patches in the vfs-7.3.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-7.3.misc

[1/1] romfs: detect hard link cycles
      https://git.kernel.org/vfs/vfs/c/c4d617e5d28d

