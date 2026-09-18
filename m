Received: from kylie.crudebyte.com (kylie.crudebyte.com [5.189.157.229])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CC854D596B;
	Fri, 18 Sep 2026 11:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.189.157.229
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789729775; cv=none; b=aiAt6mnuaKEkFrFiQBHHapbdlMkH72LQIPyTVGySHFuiIJulcJ1YglT9SNjNstUGSa5JFkpZ7B2eVOUStkRHVVF35TIv0M6ECcHAGUEtU9/5WGzsdySyEKcNhDa791aJy6ZpctRQPkBjibowOVwI/96+/vsTdUHQFTcfpfl5yVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789729775; c=relaxed/simple;
	bh=wPex7Gz6Zi2+0MAAyzO3hqm82EvhQzGEV/lf4dhdaEQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WAP3DbcpMsJdxcBVCO469pCq3RuB0QIeVvgD0WxfDiwq8h+SNoLGg3WMU27VQ16u6Y854VOqCXn01SZfuN+UICjmX8uMUC7RxPX2Une9sRm3t4O9ZfAHQzdxdkKyEJpvj3iaH7+ZBP///nPxKGQaR4IvqxG6tu1jl8H6XNrmMnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=crudebyte.com; spf=pass smtp.mailfrom=crudebyte.com; dkim=pass (4096-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b=viaRIcgO; arc=none smtp.client-ip=5.189.157.229
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crudebyte.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="viaRIcgO"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Content-ID:Content-Description;
	bh=KyVfLIv8LfyBESUG2HwXnqZk5YPplJBe5BSCAe09mTE=; b=viaRIcgOOO70g9Jb7vAp6rjWAb
	ZOnQvEVpONNyJ5TjmNVFRrT94sIMPf1gT4bzL7JF2X7hxsbVirPbgIJgAzKH4RZgiYMiP3WIlydu4
	fV0EBB+1jsJB3arZNHv5o4ZnX1HmoRlG8pQi8poj5y/PFa4sbw0UIdNvd9/qVk/YMFAZ04ezOQqRA
	WJCvkaAub5OdCDS+T3V9TSxa4JGGxULviZhZK8pPsLuNGBSOFAeHW9DkxYQAc82qVboOX4D4CVomT
	INURGxcK2vmZ4X2FqLP/hGSLHam0ZCkWmuf3EeJDZTqPoJeceNcw6A9t3gUSOcjVSNbTpxTaAGbIF
	i4cOj2nvgr0W5Ex6Z4FXunzpTFpFtBMqeYKi4zPiwL5ez5Oc9bBzQkFtAknpLNl0es2YyHllr8wd3
	GKtRn1DzHGLPSvwcugAf5LSU/HEAjAmJNOKsA77wmRnJTU/cL/mkeyC3OD3qnKyaC4BUiZGMt8g0U
	+dJlrxY+/YCmpaoqr0jNP9DdCMksMpR/ZI917zRXKZnURXyq32kV5uYNKlol3/L7eBKBdseJLQork
	jMpXB7yzvL+GZ4UTeTjq1qJt04ZERaD1QJ1IcAioAMFYSf6RFfWOcOXjOyWGOy9qOwBg6eKqXMlv/
	hc3eEr+zIg4zEaU8Uj/GYMF/TXrMMrTmcBCuPLkjg=;
From: Christian Schoenebeck <linux_oss@crudebyte.com>
To: ericvh@kernel.org, lucho@ionkov.net, asmadeus@codewreck.org,
 v9fs@lists.linux.dev, Haobin Wu <853555@gmail.com>
Cc: jack@suse.cz, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 aneesh.kumar@linux.vnet.ibm.com, willy@infradead.org, dhowells@redhat.com,
 viro@zeniv.linux.org.uk, brauner@kernel.org
Subject:
 Re: [PATCH v3 2/3] 9p: skip directory entries with names longer than NAME_MAX
Date: Fri, 18 Sep 2026 13:09:25 +0200
Message-ID: <6304983.lOV4Wx5bFT@weasel>
In-Reply-To: <20260918024851.51229-3-853555@gmail.com>
References:
 <20260918024851.51229-1-853555@gmail.com>
 <20260918024851.51229-3-853555@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

On Friday, 18 September 2026 04:48:50 CEST Haobin Wu wrote:
> The 9p wire format carries directory entry names of up to 65535 bytes
> and nothing on the client checks them against NAME_MAX. Since the
> previous patch, v9fs_dir_readdir_dotl() passes such names straight to
> dir_emit(), and the VFS only rejects names of PATH_MAX bytes or more in
> verify_dirent_name(), as -EIO, which again fails the whole getdents64()
> call.
> 
> A name between NAME_MAX and PATH_MAX is therefore returned to userspace
> even though every later operation on it fails with -ENAMETOOLONG, and
> POSIX requires readdir() to only return components of at most NAME_MAX
> bytes. Nothing can use such an entry, so skip it instead of returning it
> or failing the listing, reusing the strlen() result that was already
> computed for dir_emit(). Log the skipped entry at P9_DEBUG_ERROR, the
> same level as the strscpy() failure message this replaces.
> 
> Suggested-by: Dominique Martinet <asmadeus@codewreck.org>
> Link: https://lore.kernel.org/all/vz5bum547fqyxf5z4m3x7tuqkuq52jlopm65t7hvynqeulh7i3@2t4wnhfxs7qv/ 
> Signed-off-by: Haobin Wu <853555@gmail.com>

Reviewed-by: Christian Schoenebeck <linux_oss@crudebyte.com>

> ---
>  fs/9p/vfs_dir.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)


