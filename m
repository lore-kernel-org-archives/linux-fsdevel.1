Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B56A4B1CE4;
	Thu, 17 Sep 2026 09:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789637946; cv=none; b=lrRpV5KBbGwrFUGHIrnlW5qfsAScxVcTBmxZdMcEHEtWYG0aksg/iE2FvQIq+vQJnpGRJmgvypbOGOu7sWdSKYHVRvhVbPZND8viL/VLdfy2MU60ZehLaEYtbIHlR9GY5azYisXTFjI37cli8F/x5O3vahmhlA9tEVbRjKRXsko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789637946; c=relaxed/simple;
	bh=gxrsB2Bn7ITh6UyMKgNCpyGNDSzcq5WXsjkKDjguNrI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ZGo9ssVT7doGw7QaaxIQwYOvNtmbWN1a9OIqK1NrMrKd5VlGgHhVdG2Hx2f6zswgSVd/ufac9+OEqswC+1J2avng2QBJDOTMDJX8BZfSAqF2bYziIdkt+rZh1e8ivwm92ieHkIUjpbhMvrT2wbqvCejpL52sk12iKoXXtSrPGzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hL6tLxCe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hL6tLxCe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 070641F0089B;
	Thu, 17 Sep 2026 09:38:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789637923;
	bh=wdqaefk2EYD7crRurK/V9FYZ6LQqMAwVZaZaHF3NB/Y=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=hL6tLxCeUDh6zKxlxtsRApCvltikdL/jjdYnX8T5yHh4E1kbNrOPXBv+AmoAsEQXW
	 dF9tuCk3fVXDROwsfFYDl4ijR22VucpPT9O8VRIbEOEnBpkgm5GaX5s7zFX2cxKyoD
	 s5UUF75IeyFiIHXFot9un7yN7EKzFylHZe36rxG+cqRQEiijpEGy09VxymRg3EILxc
	 3Oyf9D3phCZSYkFLSn5IdM0R3dW+vJZ+j5dPin1wdm6L2rySM6qTsAXpsZXKuLQiC6
	 VxDq+i9C25fwFWidOl4DGaJWGGnnjzxzytJFMfP1au+sUqiFYQBt40qjK983GTBAAA
	 F8LT5I/khhFUw==
From: Christian Brauner <brauner@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Tejun Heo <tj@kernel.org>, Christian Brauner <brauner@kernel.org>, 
 Shakeel Butt <shakeel.butt@linux.dev>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Meta kernel team <kernel-team@meta.com>, linux-fsdevel@vger.kernel.org, 
 driver-core@lists.linux.dev, linux-kernel@vger.kernel.org
In-Reply-To: <20260910045433.489413-1-shakeel.butt@linux.dev>
References: <20260910045433.489413-1-shakeel.butt@linux.dev>
Subject: Re: [PATCH] kernfs: allocate the open node outside the open file
 mutex
Message-Id: <20260917-bespielbar-achtlos-rampen-51a449bd00a5@brauner>
Date: Thu, 17 Sep 2026 11:38:35 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev-db0b7
X-Developer-Signature: v=1; a=openpgp-sha256; l=907; i=brauner@kernel.org;
 h=from:subject:message-id; bh=gxrsB2Bn7ITh6UyMKgNCpyGNDSzcq5WXsjkKDjguNrI=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSt3iqX9SrtU+ijv3ENpumXywJnKHHsZZ3ZIlO24X/fq
 8R1t3eUdJSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEwk/y4jw62TP3TYJhfYRmSH
 T5ZRKzuzJ5VvE2+I4MqOyWvvTVQT/cTIsNt7y/UldZvSlordv2V4f7/48nm/TyxTWzjxXH/uz12
 TJjMCAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

On Wed, 09 Sep 2026 21:54:33 -0700, Shakeel Butt wrote:
> kernfs: allocate the open node outside the open file mutex

Applied to the vfs-7.4.kernfs branch of the vfs/vfs.git tree.
Patches in the vfs-7.4.kernfs branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-7.4.kernfs

[1/1] kernfs: allocate the open node outside the open file mutex
      https://git.kernel.org/vfs/vfs/c/5ad03af18434

