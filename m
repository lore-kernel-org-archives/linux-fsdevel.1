Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793372752;
	b=NmmLwgNeHvlYyby5lD8Gkp+oy5R0s8AI1zVjRKTFk/GOWhFpphIlioE1Xbbb0OngSKRP
	 kfIjdDE5uPZQkIQf79F1Lji5D86o+UPerGKkEvem2f+Lzhmnywb+5gi9Df/Y9rSVwf3+G
	 x7SOB7mtlv0oU1eveqtNcHT+oi6CS9speBBCBafHREI34kQNZOIqAQEGqh5V4cDNIY22q
	 2ML4BwaAr9rOhCIULXFHJykJqlkGE3O21evN1xen1kWThL8kP4ZHoY2etOCnD7GoH8HSo
	 PWOxOjKPDwGh4hdR96t7H7Tw9qDlzeGl8BjIrGSK/cv9ZAr/wsWDzvzXlOU1wBjqkQQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793372752;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer;
	bh=rONTTf00guka6C08arxhYtoEmgvuzcgAuBpsoflC61k=;
	b=EVnoiSXJurf77J9YK4F8bqVvk4zWvYio05Wyc9bpVsmFwYjiTRB4epqD1zJ++G6DShOc
	 cyZeOBUoR8BFwk7tn8KpnhH9SatL7V413dFgcz7O3KHMZaJb8VY7bQeceZPcTAuXaOKDS
	 Sy4cF/gebaAeAt0Hzcs+JbIAtR1HMDg4/uShvXmJfcvofLsp4GbRryokl1fvU2XE7pjj7
	 jkVESyoOWLZEi1cwVXMQZ1raho/y1H7WaCkX0D28Irn9IDRIIdmJd4PVNNenekW7ekwHu
	 spbdcB28xBTrNCawGMNOC9hLzP5ZRbnZ/lhYzi604K2KcOn1uQPfKWVjVyqVP84VE9Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LfdKMrp0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8291B606A31A;
	Fri, 30 Oct 2026 15:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LfdKMrp0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CC9F1F000C1;
	Fri, 30 Oct 2026 15:05:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793372752;
	bh=rONTTf00guka6C08arxhYtoEmgvuzcgAuBpsoflC61k=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=LfdKMrp0qJfKRyhpJ2yALdvMGcT5DS8Q4cv0WPdUIMSfV68+96x5tttAMVYt0aPAq
	 w+x/9pSXLyqjyva4eRzwcZMoRQKSJ8MKXf0Nbcp65Cxv0yYVqCPRgOgWP6mRd3ze8e
	 2q2gL6UJLGHBb4MVJFUcYoFTwCTiZ5utXgSkkwUho3v/jrcbEP/ASSATGIbSEpKbdU
	 sDopQdF8pczi4ovdFxruVS55mR2/zjrhqlmSQ1M3CGuQX7E5zuYrAriAwUWNH7PuxB
	 hjZctAz+RBwSyAdy8ebnRiRNbiYVVZ4FRvbOKSL6ltHnljlMZ4HDOx+fxYesRBHXwk
	 UvQnHZsLbm4bQ==
From: Christian Brauner <brauner@kernel.org>
To: Jan Kara <jack@suse.cz>, Jori Koolstra <jkoolstra@xs4all.nl>, 
 Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 syzbot+8420e667af06b1709c00@syzkaller.appspotmail.com
In-Reply-To: <20261016115851.14276-1-ngocthang2710.1999@gmail.com>
References: <20261016115851.14276-1-ngocthang2710.1999@gmail.com>
Subject: Re: [PATCH] minix: reject rmdir of a directory with a corrupted
 link count
Message-Id: <20261030-befassen-nutria-testverfahren-dafd5721eb3c@brauner>
Date: Fri, 30 Oct 2026 16:05:49 +0100
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
X-Mailer: b4 0.17-dev-ce4c1

On Fri, 16 Oct 2026 18:58:51 +0700, Nguyen Ngoc Thang wrote:
> minix_rmdir() calls minix_unlink(), which drops the victim's link
> count once, and then drops it a second time for the "." entry. An
> image where an empty directory has i_nlink < 2 makes the second drop
> hit drop_nlink() with i_nlink == 0:
> 
>   WARNING: fs/inode.c:408 at drop_nlink
>    minix_rmdir+0xe9/0x150
>    vfs_rmdir
>    filename_rmdir
>    __do_sys_unlinkat
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

[1/1] minix: reject rmdir of a directory with a corrupted link count
      https://git.kernel.org/vfs/vfs/c/fc9577079df8

