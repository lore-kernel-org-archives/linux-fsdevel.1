Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA8B223183F
	for <linux-fsdevel@vger.kernel.org>; Sat,  6 Jun 2026 13:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780752988; cv=none; b=JQTwG8jIjEZCKeX0r70yBX3/C2wrX8i1hlasetaiAWuFKmhm5GLND9Bjy53roF7Xa7aMwm4SxOHJauOKU9Dcr1mVdfOzuCj3yJMtjcPk5WvarRaoPRwEFC7eFIoEYZJxT8tOnLbvc1V76a2k4ROxU14/LwDAs1OyQJtBQr9rSOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780752988; c=relaxed/simple;
	bh=FVkgi4vzmZOz8sNtWtoBDOSTlSK/9RrBdCZ0uliyQ8E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u2caEMIKW/+eYVBxqDSkhv9yjyqjAwzpbcu2xVQ0hcxKhb3scJIhVYzNLPjnSQfTm/nruDbzQvJnI4idIlr1qeLmQrV7ENVObMDEljViCgfYv58ostt0Ycw/Ut7kluwmy0z0VqbCOW3npIfuzgjOJipkQUxOtHsrAJJ2sFaHQuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ztp4a6gE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ztp4a6gE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D68441F00893;
	Sat,  6 Jun 2026 13:36:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780752987;
	bh=WCL1DGdK5VoTJ7kRMJ+stWbakzctFyGyHCg44ZHZ0k0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Ztp4a6gEP1Qffbb9p4/HaQl5bvGOgtjQJDqDB+t4F98749pYhVFan6DqD/LZ9hNbu
	 8CoZqkBX3Q19+DLYuC/d3H0WMXd+Wkvd3uQzlL+RBXrm6zjeonXpl1H2HLoandHBP2
	 Wbch/3XGKOb+phIlDAPmG66xafM4VHItVutvvUilhZo2ZnLOtVMyhaSHpEL/O/UmSz
	 m4rogezdQvkk6qkBk2zd0M7SkaZTrRK9BsKCCqRTKk68HRZJaTjrdu6dENb00aMD9w
	 yqFOsXT8OrvIoru6o04J4UGbfrWMwgnAuHW6SEXyK80KB4tq2DB8zBvAGKreTWVKCO
	 Gp2SmxfjD9C6w==
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>,
	Aleksa Sarai <cyphar@cyphar.com>,
	Mark Brown <broonie@kernel.org>,
	Jori Koolstra <jkoolstra@xs4all.nl>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] vfs: uapi: retire octal and hex numbers in favor of (1 << n) for O_ flags
Date: Sat,  6 Jun 2026 15:36:21 +0200
Message-ID: <20260606-pappkarton-hallen-verzeihen-325e5ca8da03@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260604222405.5382-1-jkoolstra@xs4all.nl>
References: <20260604222405.5382-1-jkoolstra@xs4all.nl>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1479; i=brauner@kernel.org; h=from:subject:message-id; bh=FVkgi4vzmZOz8sNtWtoBDOSTlSK/9RrBdCZ0uliyQ8E=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSpKIXNOv5CQvaR0X0ODvEEs2rDK53PZni1/7Ltlmbf8 evw+QOLO0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACay/Aojw4eMv0su9lcof+t8 faDmwtSviSvXv3igFJV2ty+Xt//a1z6G/8lc3r3zGC9lvtQ/ERIwTdqpNzTBWPPd0cUrHnedn7v 3MB8A
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Fri, 05 Jun 2026 00:24:05 +0200, Jori Koolstra wrote:
> A recent build failure[1] exposed the diffculty of working with the
> current octal and hex definitions of O_ flags when trying to find a gap
> for a new flag. This difficulty is compounded by the fact that O_ flags
> may have architectural specific values.
> 
> Replace the hex/octal #defines, which are hard to parse when looking for
> free bits, with explicit bit shifts like (1 << 11). Also, add comments
> that identify which architectures redefine some of the seemingly free
> ("cursed") bits in uapi/asm-generic/fcntl.h. These should not be used to
> define new O_ flags (for now, at least).
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

[1/1] vfs: uapi: retire octal and hex numbers in favor of (1 << n) for O_ flags
      https://git.kernel.org/vfs/vfs/c/0da79c259ad0
