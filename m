Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CB0D339844;
	Thu, 23 Jul 2026 08:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784796753; cv=none; b=mTGw407T7a9lYW0kVz9QYjaSF9DRMNDWgn1KFIDBqlKb7tCRB2qdVgEW9vvwWEQaZ6OTxApBWAtUX3qTeViJhB1BD46noLI2cMllLin3LNHs3VhEzysK6i8BlVHyYg1avrR+bkYcXetqrotQqnzpGXkMOl/hqv7y62dLQ0nNwoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784796753; c=relaxed/simple;
	bh=sygNxrJNzEZSDNSpqK536/20nDdvqXWrYYrZJIWtP10=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=bXpnTFWWWDvHHa3JjiyEbqzI/u82q9t4pDsd9SiEjrzhnFNRh5CrVBPU8BLSzHEsL0zwZSPm5Hba6Y+y6NpCXPZFn4sEf6+FPwkYaihb6jPQY/9K6EA1UrMgbxynjQYFuxTQjLoHKh1qV6LdNYAU4PqheegOX6i8ZttEAOIHUXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b4/z5urM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b4/z5urM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2A6B1F000E9;
	Thu, 23 Jul 2026 08:52:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784796752;
	bh=NU8y+cC/oaafSAZ3dNPDlx3TNs9e+/N/XiEq2pGiLpQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=b4/z5urMPW09iyeZdrzuYxi5/OwsNznk/yI3+3l8rkKP2YgfzvkxmjZGUTeF3zeak
	 SOjiSvoNEnw+XWIea+NiaVIswG92ryBrKIMAlbfgRLzXe898IjcOcpGWquWF6PGlFY
	 nto3kRDOn6FPePbTZXKBsLZwShrKj58gNK44Gos3Gav2C5IyaW2dYhHkgL0369OVab
	 Ik3NfglSZ4aR9PN9sjVtVBU9TfrXgf+jBMqc6BhvY9hIyZ464bXrKyqT1lZF8flmFA
	 Yx2R82fO2NFtHOLaG+424LQgDpdDa8wUBPBn5EdeMN4Ti729nfP2ci2cbn/MtvK5tr
	 zEixPXM/iynag==
From: Christian Brauner <brauner@kernel.org>
To: Li Chen <me@linux.beauty>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260716052822.1034228-1-me@linux.beauty>
References: <20260716052822.1034228-1-me@linux.beauty>
Subject: Re: [PATCH] pidfs: handle FS_IOC32_GETVERSION in compat ioctl
Message-Id: <20260723-atemschutz-posaunen-lebzeiten-3d9491b3331f@brauner>
Date: Thu, 23 Jul 2026 10:52:23 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev-35fdc
X-Developer-Signature: v=1; a=openpgp-sha256; l=869; i=brauner@kernel.org;
 h=from:subject:message-id; bh=sygNxrJNzEZSDNSpqK536/20nDdvqXWrYYrZJIWtP10=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQlXvOTnl3B2vmp1q/27ASB9bOmtXbqO2+8J7540rH47
 t8pJ2ZzdZSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEwkJJGRoUuHXyLvMbfLrPYN
 TsdjcuNV/mfInAyVKtZ/ZhLQoMTByMhwufexT1fr/Khdiz6bPxQKlw+cXTn9zYmD3K/eah0vkCp
 lAAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

On Thu, 16 Jul 2026 13:28:20 +0800, Li Chen wrote:
> pidfs: handle FS_IOC32_GETVERSION in compat ioctl

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

[1/1] pidfs: handle FS_IOC32_GETVERSION in compat ioctl
      https://git.kernel.org/vfs/vfs/c/d5eb51fc0b49

