Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1C3C3BBA1A;
	Mon, 31 Aug 2026 08:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788163375; cv=none; b=Osq3TLVY5IE0nWu/Mt9u8LToAsPVvH3inaewJmblhJanlI9fwiLnpjXhakTWxCIxDTEa0WZP2EKMckeYTFbt0h4ACzwmHV5PlieFTVkw+Y2ysgbeJ9kN43zgzkCN8dPK1go59V4PjegxTKakLi2r+8xOHuGutcwinrBIUprvawc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788163375; c=relaxed/simple;
	bh=mNJ6TtybuemdnjfJ+xTQ38IRvVsMmZTIi52GSp67/TM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ox/qqKHzXzfPyrDQvnjI+jaVEP5bldsE4yWB6QAYZFOXW3DhtvAF+NMI37axDOXorvWIoauEFL7R4/gCfrap3H+pnxJkuNR9FGG92jjTICu75HK50+NmXSGoqsOyFKiBxflfFRivMuPLXPchG0thS+5zgAbLyTYtKEDI5UTkThg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NRFf2RWn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NRFf2RWn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EF3B1F000E9;
	Mon, 31 Aug 2026 08:02:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788163374;
	bh=Ye99NQfdXi7OZKG0raTZd4ewb9mN+Asa1Yy9ESWHvFE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=NRFf2RWnx8dsoP6gUfrwmIcALgAsK/bxcT4SbZ0luqJeUo3VMUoNbFvgq4WAHrCss
	 uOG+kkt0MW/2t3pVffnIF1n8jWcipMJXpU0Q7w5HpOxo5GPqSr69fm0CCT/+ezENHm
	 KQ33E5k1cbgOh44w4qBlyojTYRlUI08Ku3zMYp8s7nhnjIKo9iel7o1ewHz21ueR0F
	 bfPSrdFPd5Wd7UQ2Lfw/4u8Y69jnQNQQ3g3fiBNO7rsho8GC0wpzQveqlnAPagHrcg
	 Ii1msK1JTPdq69jNTR45rnx97kUZVMPLs/WKEl0lidgYIvbCnIFCrT7dBOca+qLcmH
	 rN42vN57oyfjg==
From: Christian Brauner <brauner@kernel.org>
To: shuah@kernel.org, Mahad Ibrahim <mahad.ibrahim.dev@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20260819161738.3517-1-mahad.ibrahim.dev@gmail.com>
References: <20260819161738.3517-1-mahad.ibrahim.dev@gmail.com>
Subject: Re: [PATCH] selftests/filesystems: Add .gitignore for
 fscontext_ns_test
Message-Id: <20260831-pfosten-geoutet-knicken-8c8a740962a3@brauner>
Date: Mon, 31 Aug 2026 10:02:50 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev-362b8
X-Developer-Signature: v=1; a=openpgp-sha256; l=904; i=brauner@kernel.org;
 h=from:subject:message-id; bh=mNJ6TtybuemdnjfJ+xTQ38IRvVsMmZTIi52GSp67/TM=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRNNdVR4C1nq5spUcQ6aeL6BZVFhfkLOwtzTm5s/HbgS
 f5ni4YXHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABPp3sTwh+f7PcFnBcf2xUyu
 P2AnHq4zsUmg7lP0hOx5Aq3z3JS+yjAyTGC6YF17Z8Yn7RDZNyfPRB/j5jnV4Spxb93j+X+W2t7
 axQgA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

On Wed, 19 Aug 2026 16:17:38 +0000, Mahad Ibrahim wrote:
> selftests/filesystems: Add .gitignore for fscontext_ns_test

Applied to the vfs-7.4.misc branch of the vfs/vfs.git tree.
Patches in the vfs-7.4.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-7.4.misc

[1/1] selftests/filesystems: Add .gitignore for fscontext_ns_test
      https://git.kernel.org/vfs/vfs/c/b653a9e55173

