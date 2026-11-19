Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795124763;
	b=YmQSs7cjebqlkZSOJ94TU6PuwUkEZRo7pT0K68Av5KwxQV6KfkAIbB8a3vqBbl5iNZne
	 aVlLh3Qw48gsLFw37SBqcT9wjEphj80B4wQ5LHpYfzzXlGVflgzbS7VbXA1fThFlv/pRm
	 iuMG+VxGV8/1hu9ihfK+D/1S1DhFYRz52P6936/vEu+MkBd/o7aWieWe0p+nGMgYRSY+n
	 Z26kYCcfhdcdoqRljI8Vp0eBBxnGaq42SaeHX9og92ex6bmvsP3tnr4HTWS0QOZOjw4zm
	 WALTWeAUyqiKrBUnJtXNR7iHt3Hn1WLyQQNSjY3AvbcqRSD4VBhzL2hoiNNcZRFvMTg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795124763;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer;
	bh=LD7e5icEELUXR79fUI67ReC613behzJKu96n4HSddDw=;
	b=r7+QDLk/wrFx2K6Kex+GIzYikiK6BeuzHsGCizhwTHlwmIo+Rzguxv14+gUwrsAq4goo
	 QZ8zRHiZVR6doXVvXL+/icnSf5Ywz4IdMmqKfUpvOewjAf6mY0Xt86vanoSkRr2iy8k6D
	 4t3xCjf/rDOpIhTpILGFWKrx7BCoKO3Zl6jolblu2uF8NmuOW+Bw3Vb/RynGmtz2XDSD4
	 rs+IZ/ri/hdMl2/6CB/GfEduiGSpXfV4f6uK+s2GVO2KDB4yq+6uYcCGN9locKYMxfk+x
	 qwsnJupimfLu7VH9WJ+FVS2Ijtmse4F/AcZmH1rOgB+R+FUywT/9a8HYRPnD1+X/6mA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RyFEf7gw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30555606A325;
	Thu, 19 Nov 2026 21:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RyFEf7gw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C6D61F000C0;
	Thu, 19 Nov 2026 21:46:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795124762;
	bh=LD7e5icEELUXR79fUI67ReC613behzJKu96n4HSddDw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=RyFEf7gwAAYhNQwFcVrhSXImzRYF72E/VCUuhXxjicSRIOQhmyHBg4HDpI0rLbQc1
	 QIo9g+o6cma+E3PWn2OS6frrxMTnSo3jzilRAxKryBzynnyBX93qNKq4E5Kj6rCABG
	 wyFcbFDUTv6FFH2muzpaAoDuvBZtC3OPcqQtvHqWSuWFub4KJaHSc9449abvAtmW31
	 WU3byVb6Fi8u9WWzufXmW1CcCDl/ZtX5wFEZqp0ISIRIS0tyew011zw8XQvNgz9Y/Z
	 fZhvkUFUjvhPiCLpfKPaSInEQ3MaNyhmi2bQFLEfn+zKxYXWBTXpYtEFWSTBgPGYxr
	 0AEEd53Ga6LSg==
From: Christian Brauner <brauner@kernel.org>
To: viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org, 
 shao.mingyin@zte.com.cn
Cc: jack@suse.cz, josef@toxicpanda.com, linux-kernel@vger.kernel.org
In-Reply-To: <20261105221032737LKGdHz8FE-EFnNwJuw0N9@zte.com.cn>
References: <20261105221032737LKGdHz8FE-EFnNwJuw0N9@zte.com.cn>
Subject: Re: [PATCH] mount: fix statmount() and listmount() on empty mount
 namespaces
Message-Id: <20261119-vervollkommnen-wegbegleiter-depesche-bf7b33b3e21a@brauner>
Date: Thu, 19 Nov 2026 22:45:59 +0100
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

On Thu, 05 Nov 2026 22:10:32 +0800, shao.mingyin@zte.com.cn wrote:
> statmount() and listmount() on a foreign mount namespace fail with
> -ENOENT when nothing is mounted on top of the namespace root.  That is
> the case for an empty mount namespace created by
> unshare(UNSHARE_EMPTY_MNTNS) or clone3(CLONE_EMPTY_MNTNS): its only
> mount is the namespace root, a nullfs mount, and no rootfs is mounted
> on it.
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

[1/1] mount: fix statmount() and listmount() on empty mount namespaces
      https://git.kernel.org/vfs/vfs/c/dab56031dece

