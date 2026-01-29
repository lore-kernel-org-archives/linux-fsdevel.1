Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B453137F74A;
	Thu, 29 Jan 2026 10:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769683771; cv=none; b=MncTYfvMCoVj1TgpQQEQJ7ZU+irhZV4EUgcTa/pwkZaLPi6IhKXjyczjPVuX8XNqe8GGBdp+ywN4oFrRRP7CgiQf5xSVDNp6XHB313xf6QsdKLf6Zs+zkyRa+Ygv5nnsuuXMis0bnmytjn1O0ufTRapfvV4eslQh35MEhHJ15oU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769683771; c=relaxed/simple;
	bh=jjf6U+aNszTfB0UVxCbn9ahIqQSTAYTWbd0r5N28E7o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GmqrG1rbRxdNWHkWKQlqdhu2s7RDc6K8YTQZ+O624T36LQ8WZlmFEOG++5Ozpnu94g4WT0PagqZPFhhZ9ba2YfOtXK+qf08Zf6daWCHqfxv3+doSZrEUWNcDggzo2hjdPU1DESB1QhSN0rYuAfgVH0MAgnkKMlvfhsNOtX1M6eY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s5z0VVmL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s5z0VVmL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4B97C116D0;
	Thu, 29 Jan 2026 10:49:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769683771;
	bh=jjf6U+aNszTfB0UVxCbn9ahIqQSTAYTWbd0r5N28E7o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=s5z0VVmL+olA9dnqCNxPhRmPK2ALjW8d8CNoQ5aZ/6ToUeuPTt86nsh4LeuFs7TBI
	 wsV+OAkNaL6wvEHdSBKANweKy6DQbKSuVkDku4WyCTWxf8Sywn4ctXDThGBHPCBv93
	 Awt78P6K2fw4dcYsSnGGUntS5e13MehSk7K0lnNLFlg4CX27qejSNV9IFfYSUo0oDg
	 RnZGjwhQt5WJ7NqhJbQNxPOmAXTERcNU2oCa72KP6tqZ9sB+aytpu0pRYA5Qnema4Y
	 xBGG2FJcRhtfl8iTp0yzUf3S66tkzCfdCtn57Ez68rAZt0F4n/acrwS7XgajcOCbjm
	 CPhJz1SVr4H1g==
Date: Thu, 29 Jan 2026 11:49:26 +0100
From: Christian Brauner <brauner@kernel.org>
To: Dorjoy Chowdhury <dorjoychy111@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	viro@zeniv.linux.org.uk, jack@suse.cz, jlayton@kernel.org, chuck.lever@oracle.com, 
	alex.aring@gmail.com, arnd@arndb.de, adilger@dilger.ca
Subject: Re: [PATCH v3 1/4] open: new O_REGULAR flag support
Message-ID: <20260129-siebzehn-adler-efe74ff8f1a9@brauner>
References: <20260127180109.66691-1-dorjoychy111@gmail.com>
 <20260127180109.66691-2-dorjoychy111@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260127180109.66691-2-dorjoychy111@gmail.com>

On Tue, Jan 27, 2026 at 11:58:17PM +0600, Dorjoy Chowdhury wrote:
> This flag indicates the path should be opened if it's a regular file.
> This is useful to write secure programs that want to avoid being tricked
> into opening device nodes with special semantics while thinking they
> operate on regular files.
> 
> A corresponding error code ENOTREG has been introduced. For example, if
> open is called on path /dev/null with O_REGULAR in the flag param, it
> will return -ENOTREG.
> 
> When used in combination with O_CREAT, either the regular file is
> created, or if the path already exists, it is opened if it's a regular
> file. Otherwise, -ENOTREG is returned.
> 
> -EINVAL is returned when O_REGULAR is combined with O_DIRECTORY (not
> part of O_TMPFILE) because it doesn't make sense to open a path that
> is both a directory and a regular file.
> 
> Signed-off-by: Dorjoy Chowdhury <dorjoychy111@gmail.com>
> ---

Yeah, we shouldn't add support for this outside of openat2(). We also
shouldn't call this OEXT_* or O2_*. Let's just follow the pattern where
we prefix the flag space with the name of the system call
OPENAT2_REGULAR.

There's also no real need to make O_DIRECTORY exclusive with
OPENAT2_REGULAR. Callers could legimitately want to open a directory or
regular file but not anything else. If someone wants to operate on a
whole filesystem tree but only wants to interact with regular files and
directories and ignore devices, sockets, fifos etc it's very handy to
just be able to set both in flags.

Frankly, this shouldn't be a flag at all but we already have O_DIRECTORY
in there so no need to move this into a new field.

Add EFTYPE as the errno code. Some of the bsds including macos already
have that.
