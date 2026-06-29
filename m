Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 580DA38B143;
	Mon, 29 Jun 2026 05:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782711741; cv=none; b=gZkUiJ10eF01vKMzmF4ygicmMzG0T1bzLeIKXj4TUtfc+cwNVAApq8ZmjOF8TcDykziuG51akUNX0G9I4Wlu1GhTj+xkRv0rPMu1Y+UE8sbBIwusY7hj0hNVzd+CjSWGojdaxQfkKEcvEcXsmi9xEfuy7QibZTQKvXloPLLz+Ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782711741; c=relaxed/simple;
	bh=zGRlQ6EBXyxT2V1ve7hn9m4+N50rTmq0MuLll1M8jQc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fwNSiZP+TG2RHNRfaIxYs4nINbCPwF8FN2Ti1H9PamLe1MKOw6VcoPoBwZMe270sdaPMXv5JmPSHiAmQnp8i9LDQdoAAKvteCveyRmw+1I5KeYSf/nCAwAoPt9KcGxR/NOE5ujtJvUyMgBL2mXxW/XiBl29lTy9A4HKXR8X1sfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DLl40y+Q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DLl40y+Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 986E51F000E9;
	Mon, 29 Jun 2026 05:42:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782711740;
	bh=WKVL74ReC9/RSieHk5edMx6bbG7Dz62p6CxJwlh4GMc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=DLl40y+QBf8xwL4athRvVkNc73525Gn/ifIxD47zg586SNp3RNuCdP+Vb0GK1z9hK
	 Vwo4XyfZ1o0VM9n85X8hxs1tzYjTM349cG5aG1qIRNHwGQ/DGw+yBp3ggoLuQ+a4HV
	 OBqefm2ogimXSb3jKBXXoNSizUyRRCz5Jz6LZknoGL7u7C3fv4PlaYCNz3VrqxTA2f
	 9UCZFK/wWkPE4kKf78cW1gFAUbuy8tuPS+Q+v4+q+Wvb0jrkXewCmz1gFBXxrr2U0D
	 CFlTSf5oexyvDKXu3QLntzowswrtIcvFycm7ndgKYJxNr9vW2XeoIYUgbU8Yt42x9m
	 ZhchebRmO8nOA==
Date: Mon, 29 Jun 2026 14:42:17 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>
To: Christian Brauner <brauner@kernel.org>
Cc: Alexey Dobriyan <adobriyan@gmail.com>, Jan Kara <jack@suse.cz>, 
	Wei Yang <albinwyang@tencent.com>, Zijie Wang <wangzijie1@honor.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2] proc: only bump parent nlink when registering
 directories
Message-ID: <20260629054007.GA2410937@rocinante>
References: <20260613211005.921692-1-kwilczynski@kernel.org>
 <20260617-zeitig-umlagen-ortseinfahrt-1389d7457b0f@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260617-zeitig-umlagen-ortseinfahrt-1389d7457b0f@brauner>

Hello,

> > proc_register() increments the parent directory's link count for every
> > entry it registers, while remove_proc_entry() and remove_proc_subtree()
> > decrement it only when the removed entry is a directory.  Regular files
> > thus inflate the parent's count while they exist, and leak one link
> > permanently on every create and remove cycle.
> > 
> > For example, /proc/bus/pci/00 with twenty-two device files and no
> > subdirectories reports nlink 24 instead of 2, and SR-IOV VF enable
> > and disable cycles, each creating and removing the VF config space
> > entries under /proc/bus/pci/<bus>, inflate the link count of that
> > directory without bound.
> > 
> > [...]
> 
> Applied to the vfs.fixes branch of the vfs/vfs.git tree.
> Patches in the vfs.fixes branch should appear in linux-next soon.
[...] 
> [1/1] proc: only bump parent nlink when registering directories
>       https://git.kernel.org/vfs/vfs/c/552864f6ac8f

I assume this got lost?  Seems its missing from 7.2-rc1, sadly.

Thank you!

	Krzysztof
