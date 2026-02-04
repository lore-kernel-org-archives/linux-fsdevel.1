Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AA3540758A;
	Wed,  4 Feb 2026 13:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770210063; cv=none; b=Sdel14oEW0+46BLutoOpkXRs4p0gfIwvzC//9VP3yZX8jzY87zFjyWzTs6i/E8KSGJYfq2+lTYzeqMtok8ztUD5T+FFfG07WSMCbPO/g9wFPekoJmPSgcduqqr71b/oB+yigM94ZxURup+v1PnIKRDapVfpbDsKfn18djGkDmkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770210063; c=relaxed/simple;
	bh=yWHavuZhVnobrvDzZB5WR03rfGaWTx6aPnNFoVuKdfo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PAttUO440fyH7W53blZPjfVrYBg6vacXyYbnpyQDIuVsOTbiMNhHu+E0eAX4OxwcUbh0y+VxFoiiYVhMeN1Oy5l/IHeKlpbiLvWg1zPYImX2IXMXQDddpAewG0UKYSM/cjaSvqra67dHHEbkTk217vegrNCuAijYphAviBP1tVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jGy6oB2v; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jGy6oB2v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFDD0C19422;
	Wed,  4 Feb 2026 13:01:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770210063;
	bh=yWHavuZhVnobrvDzZB5WR03rfGaWTx6aPnNFoVuKdfo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jGy6oB2v+3OBcOSP3MXjv3EBG/MA3ltf9wTrE2QWvMGd35VjFeOmTtF0xuaPqPKuY
	 Kg+J50wA8GHrP5SyEQdkxp0ecCOiJc5+U/HGzUo5tWffLMWKfzA9FpaFJON0g47CGp
	 lmzv9DMYaKDRlH19mpiS85LzuBYmb9Baf1iyoqEhaRYR0WzrRmTpmoXwHnLqwDtuVp
	 8WJIZfdjla05d8k7ShjrMspeydj3CpNkgYpzT112VRs/qpGZu0WPweoW8gYXZQqarv
	 8jthGhyw/scnfk8bnsSm9aYujfIYzfDicHS84z/TAPU2qLjNpEnOoHkZRGK1LX6bbX
	 LFuxp99sfpSGQ==
Date: Wed, 4 Feb 2026 14:00:57 +0100
From: Christian Brauner <brauner@kernel.org>
To: Askar Safin <safinaskar@gmail.com>
Cc: amir73il@gmail.com, jack@suse.cz, jlayton@kernel.org, 
	josef@toxicpanda.com, lennart@poettering.net, linux-fsdevel@vger.kernel.org, 
	stable@vger.kernel.org, viro@zeniv.linux.org.uk, zbyszek@in.waw.pl
Subject: Re: [PATCH v2 0/4] fs: add immutable rootfs
Message-ID: <20260203-prost-lorbeerblatt-abd2df8c83bc@brauner>
References: <20260112-work-immutable-rootfs-v2-0-88dd1c34a204@kernel.org>
 <20260201195531.1480148-1-safinaskar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260201195531.1480148-1-safinaskar@gmail.com>

On Sun, Feb 01, 2026 at 10:55:31PM +0300, Askar Safin wrote:
> Christian, important! Your patchset breaks userspace! (And I tested this.)

If a bug is found in a piece of code we _calmly_ point it out and fix it.

> I tested listmount behavior I'm talking about. On both vfs.all (i. e. with
> nullfs patches applied) and on some older vfs.git commit (without nullfs).

Looking at a foreign mount namespace over which the caller is privileged
intentionally lists all mounts on top of the namespace root. In contrast
to mountinfo which always looks at another mount namespace from the
perspective of the process that is located within that mount namespace
listmount() on a foreing mount namespace looks at the namespace itself
and aims to list all mounts in that namespace. Since it is a new api
there can be no regressions.
