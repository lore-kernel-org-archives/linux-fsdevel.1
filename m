Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794931105;
	b=C058qGyckZJbz/vOsEhlTJS6oX+yWFqwmrd1Ps75RHrWPZTkKFpn7UIRTuNgiAngT8rg
	 rJqE+SVth6xbEHrHcVVkMFaFFiFLbq4ry1bp3YfKf9C1DofA5Dcxu6PyYFmAtfKb+lApr
	 DiFZB2G3LT6cPJiRsjdtQTy6JNWOTzawPfAXPXDyPZMn3z5qHd/0DP93AW1J7OyffHylI
	 E0Ld03QpNK2Eh3eZLuHvbFacl53cxOGBxvhtAcezmo3GeJ9WFYF+r0P1p2KJhaHwHM/6N
	 iRqff9Dl/05WwUlHO/KSVS23xAogbEbKD6bKhJAN62okHc9VFXVeDcJAg4e0iCwI0RA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794931105;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer;
	bh=aCpl/gwZ9pA2lFvW6F4A3IwkXPu9MrJE3LgToB0jW/M=;
	b=ykdn8JQRAr2PfWQBi1zUxkoPUB00PYNQpellyU7fEg/FDuSAIc9VcBis2RM0ht0waYJ5
	 7p7GFiovr/z/sWiUt6doh2z188I1me5u4rXAdcsjhE6T9FkkbxCIr/16HJNohnx2AVX7g
	 Gymw1OBxQ1dZF1n8GRKLi5BODDE3L+rQAgodV2yjZI3IiulW2yhZp7449TRKMrA+uxhJj
	 s8vVN0PpXbDZUqq2CLugR5z3ZDH1yYfZT4yBZHu8Qexd6W61+K97VtEb3K2RoY1Ywxo+9
	 zxdrBbOYIxSoHJ0xRNx7wdvaxV2qXed7S2pljzSKQqN4u77NlfOG5c4XIhyNfqoOGNA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aEmn4Eo+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0505E606A32C;
	Tue, 17 Nov 2026 15:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aEmn4Eo+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C9171F000C4;
	Tue, 17 Nov 2026 15:58:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794931104;
	bh=aCpl/gwZ9pA2lFvW6F4A3IwkXPu9MrJE3LgToB0jW/M=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=aEmn4Eo+bkZxGaV+lsSCVHtdjJdho+25ibHcvAR5KacETiRdjmmBlZcyPh5SVEmso
	 iAAojLwE018WQTC6zWnXNnm3BjUP+Qj16PVzEEgqJ2OGXteeOW3/Fbft6sEvcWaOO+
	 J0A3kjT2y7dgyru/OBf4QfDCU6FiKMZ6MNESL0ZAF0ykDnUcac/ZIHRyxDx7/aFyfD
	 rIAges5AafkwvzPrJbsqnwpbKsyG5BzCjVLXndDhNmA4OVGvlgm/453GnenVXk0DbO
	 Go4nxAi/GSiKP5NBHo6kxd381znY35h+HOl/cscqEILWflsS6iFDa5LnJDqU/VbLn3
	 0kyJes6IlY0vQ==
From: Christian Brauner <brauner@kernel.org>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Tejun Heo <tj@kernel.org>, Jori Koolstra <jkoolstra@xs4all.nl>, 
 Meta kernel team <kernel-team@meta.com>, linux-fsdevel@vger.kernel.org, 
 driver-core@lists.linux.dev, linux-kernel@vger.kernel.org
In-Reply-To: <20261111215058.1837351-1-shakeel.butt@linux.dev>
References: <20261111215058.1837351-1-shakeel.butt@linux.dev>
Subject: Re: [PATCH v4] kernfs: allocate inodes and dentry outside
 kernfs_rwsem
Message-Id: <20261117-osten-renitent-gasheizung-276fafa42fab@brauner>
Date: Tue, 17 Nov 2026 16:58:20 +0100
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
X-Mailer: b4 0.17-dev-04696

On Wed, 11 Nov 2026 13:50:57 -0800, Shakeel Butt wrote:
> In the Meta fleet, on 6.16 with the kernfs changes from 7.4 backported,
> we still see long cgroupfs stalls:
> 
> - oomd and below waited 72 seconds in kernfs_fop_readdir() while an out
>   of memory container created cgroups.  They resumed when the kernel OOM
>   killer killed the container's workload.
> 
> [...]

Applied to the vfs-7.5.directory branch of the vfs/vfs.git tree.
Patches in the vfs-7.5.directory branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-7.5.directory

[1/1] kernfs: allocate inodes and dentry outside kernfs_rwsem
      https://git.kernel.org/vfs/vfs/c/5c1ca763748b

