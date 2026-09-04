Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D66D41684D;
	Fri,  4 Sep 2026 09:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788512517; cv=none; b=QErOaZOC5FPmsDXv3hWJT9MbAUE39yhGQxSlY8t+QYlYRfSHJ3FVG3W9pSfrv5v9X9Y1EaCdxzeHLLUdq5DpIXgj8noQrgO8ek8yEu10Qb3fWeXqLhXBSbs170NmZ2Bw2Og0BH3fZqaK/N25KH5N1vgiSkB5LiwNbbEnfCg/yco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788512517; c=relaxed/simple;
	bh=WQoSG4b3Ouo65XMO7TDhQbxrQF0m9wMueLvYe3q7JMU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=BRx6izH0qza+VslKjwpP7/izAlEipQI7qw8Ew+OMUT3zPsGzWBsJx4oWI9ekuIfYYxFTwISq/St4azLz9PJg9FdHF4sVgRaDN0qq4ckZvQxPp+IdL8XJDwWqKhvomSNkPsAkTp62THiwqNAyQrLeE77qIgEA5jtKbK2vVBpxiZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G/fm6smH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G/fm6smH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 987301F00A3D;
	Fri,  4 Sep 2026 09:01:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788512515;
	bh=b4SvkYUGKZe08RNEUuNl/WjXv7B/27kWP68bJNEm/Uk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=G/fm6smHFgoEkYcJbS7FboHBsCHSvMKZKRJnsLnl4YMwRMi7EdbWlW8URZgu8hp60
	 91B1mgrLDBG3o/ts0O2nSQJ0lMUILAHA/2woQxpZ0TPhCZeWg9p2qyUD2E/FAmXMFe
	 ghD87nX0JnJAS72/WgK4rSkd5TWsOZkG2EoML3x6J1R8TDleyKl7g22xdzmsmBFUsR
	 e8CZIN9XL9FYyj7RD6lPvPorPVLcvyH9UXrqASqmjyGsSzIulonTPoG4oVfx/tcZeu
	 sjAulaI4vqN69pRp36SUPNiQLsv8PQRwZB559pEGnpjTQTII57R8IF5sIdfk2w3M3y
	 nou0Azp7UFpNg==
From: Christian Brauner <brauner@kernel.org>
To: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 phucduc.bui@gmail.com
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260828092734.600911-1-phucduc.bui@gmail.com>
References: <20260828092734.600911-1-phucduc.bui@gmail.com>
Subject: Re: [PATCH v2] chardev: check return value of kobject_set_name()
 in __register_chrdev()
Message-Id: <20260904-samstag-lieben-gepaukt-2bd3ff7b8afe@brauner>
Date: Fri, 04 Sep 2026 11:01:49 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev-db0b7
X-Developer-Signature: v=1; a=openpgp-sha256; l=938; i=brauner@kernel.org;
 h=from:subject:message-id; bh=WQoSG4b3Ouo65XMO7TDhQbxrQF0m9wMueLvYe3q7JMU=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTN6mRwfe6w9EZUn3/xVTHb00WHDZNfSbMFV35ZJf3nc
 pfFjG23OkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACYi5MjIsG/B/puljuvchUQu
 dTzhjJaepOykn/xzs3TgnqTd/x02HGP4H582RW41U7ND40S3MyvUpW69n3S9/cjiDfZKOj+qbV/
 68AEA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

On Fri, 28 Aug 2026 16:27:34 +0700, phucduc.bui@gmail.com wrote:
> chardev: check return value of kobject_set_name() in __register_chrdev()

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

[1/1] chardev: check return value of kobject_set_name() in __register_chrdev()
      https://git.kernel.org/vfs/vfs/c/e0bec04067a9

