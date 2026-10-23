Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792755013;
	b=ZkKHtO9O5OPHUfJ5PfaSfwWwC5O2F/pFKzeBm3Tgd/U39hTMwHYPYI20BVFo5Q97QrOz
	 sHn8Ege0Khm1/HJ6MphoJbCdDslrNu22cjCQ+3v5rXMuUmgl1iVDydC/BQ4X49HIg8Dik
	 7VIJfEwTv5skt+9CNoZAysxp9jmoBIxuKfblQRd2JvmVDnwnwS6MS/AIzZCbmYOYZ1bmY
	 LlGIx4u5NY6aeirjuSJEWWUM9+MFZzdOi6UqEDiHz18yuDQuJmZSCN90olY31NYONiuql
	 kSdB+meArEwfTPrXJd5IUJ19aNLCHY2zR3910JlTtXTcI7APvYABK5qwC9Lg/9RAI/g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792755013;
	h=Received:DKIM-Signature:Message-ID:Subject:From:To:Cc:Date:
	 In-Reply-To:References:Autocrypt:Content-Type:
	 Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=aNajRywAw+zbfxslCcrq4MEVR9d4HmMekuxiOJuCT8k=;
	b=GHCM60eKi64v+E+I68Eao8S5Qgee/e3P9vIWLym3sh6oL5b7Bt2EZIUkdavetudWVUjg
	 uPkrtlk+Jy/wP/Mng/hg7J18XgnEBYvqbYJMtgsUsGlgJ5td95hIA3dYugLjizof87eLH
	 B1RQBeb526DvIrNIv+fwO93hCJoGpGlK204mrVM66IawuNnyC6fZhe8zobTw6cRnE+9VN
	 Ge0FgJ4+53NOb9nesYPwqlnWBxOJY4nS0f3lNb8nqnsWZ1K9mlS2A07PMsXD6a6w8aRIC
	 dGaVs3ODoSIk/NxV2a50mjokX8Mi0wXMJbXNe9MwVWZOT1t374AbPCMUtfkr1ufUYqg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=l63V+rMW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77A0E606A325;
	Fri, 23 Oct 2026 11:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=l63V+rMW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6137D1F01828;
	Fri, 23 Oct 2026 11:30:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792755013;
	bh=aNajRywAw+zbfxslCcrq4MEVR9d4HmMekuxiOJuCT8k=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=l63V+rMWIyCmh/4d9FxoLIt5NH9jHAm1P+6U9nTWCUz2HiFh8RUualpEuYfiu+JC1
	 YqiH7iEIHrh5zII67+WfXDK7y/DVm6BvtFY5CBd7ooX2MJPhl34eFy3VPWeGnFAeup
	 TepPoXEfMjBSLr/hM7nvzT1wBm3E7r2jacTZEdMqxjlKIkk5ZoEGHRrxUglPMeTkiL
	 iz2DtFTVfC/LGeExQx+JUrGHKlMFCYeSh+UI6baFOT+aodwpTa3nMEAobN83S3oHtQ
	 059zEXGI9iMwkqO3JlTKoa6hAtja2qyd3uPwUFX+fyycd0rOB7jRJc3aDIIio/0Qvl
	 UGuBdiFejTw4A==
Message-ID: <103f4caf1cc6bdeabd40debc34c75b5239fefb2a.camel@kernel.org>
Subject: Re: [PATCH v2] filelock: keep superblock active through delegation
 wait
From: Jeff Layton <jlayton@kernel.org>
To: Zhao Gongyi <zhaogongyi@bytedance.com>, viro@zeniv.linux.org.uk, 
	brauner@kernel.org
Cc: jack@suse.cz, cel@kernel.org, neil@brown.name,
 linux-fsdevel@vger.kernel.org, 	linux-kernel@vger.kernel.org
Date: Fri, 23 Oct 2026 07:30:09 -0400
In-Reply-To: <20261023111250.17696-1-zhaogongyi@bytedance.com>
References: <20261023111250.17696-1-zhaogongyi@bytedance.com>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-2.fc44) 
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Fri, 2026-10-23 at 19:12 +0800, Zhao Gongyi wrote:
> A caller may drop its path after try_break_deleg() returns a delegated
> inode but before break_deleg_wait() finishes. The extra inode reference
> held in struct delegated_inode does not keep the superblock active.
>=20
> After a lazy unmount, closing the delegation holder can release the last
> mount reference and shut down the superblock while another task waits for
> the delegation break. The waiter's final iput() can then enter the
> filesystem's eviction code after its superblock-private state was freed.
> This has been observed as a KASAN use-after-free in shmem_evict_inode().
>=20
> When try_break_deleg() saves a delegated inode, take an active reference
> to its superblock while the caller still pins the mount. Keep that
> reference through break_deleg_wait() and the final iput(), then release
> it with deactivate_super(). This protects every caller of the helpers,
> including the mknod, mkdir, symlink and rmdir paths that drop their path
> before waiting.
>=20
> Fixes: e12d203b8c88 ("vfs: allow mkdir to wait for delegation break on pa=
rent")
> Fixes: 4fa76319cd0c ("vfs: allow rmdir to wait for delegation break on pa=
rent")
> Fixes: c826229c6a82 ("vfs: make vfs_create break delegations on parent di=
rectory")
> Fixes: e8960c1b2ee9 ("vfs: make vfs_mknod break delegations on parent dir=
ectory")
> Fixes: 92bf53577f01 ("vfs: make vfs_symlink break delegations on parent d=
ir")
> Link: https://lore.kernel.org/r/20261016093421.90725-1-zhaogongyi@bytedan=
ce.com
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Zhao Gongyi <zhaogongyi@bytedance.com>
> ---
> Changes since v1:
>   - Hold an active superblock reference in the delegation helpers instead
>     of adding mount references to the four fs/namei.c callers, as suggest=
ed
>     by Al Viro and Christian Brauner.
>   - Use &inode->i_sb->s_active in atomic_inc().
>=20
> Validation:
>   Built an arm64 KASAN Image with LLVM=3D1 on af32da41b032, using the sam=
e
>   config, guest image, and local arm64 cpufeature compatibility change as
>   the v1 tests. The tested filelock.h diff is byte-identical to this patc=
h,
>   which is based on v7.3-rc7 (24a19b953e2a). Image SHA-256:
>     b7ad342b0020c31ab2be97ceb441ebc38c5840f023350462bb816552fd175870
>=20
>   Ran the existing syzkaller reproducers under arm64 KVM with procs=3D6 a=
nd
>   repeat=3D0. Each test had one run:
>=20
>     syscall/variant    duration    programs    wait stack samples
>     mkdirat             300 s         2028          7
>     symlinkat           300 s         2064          8
>     mknodat S_IFREG     600 s         4168         18
>     mknodat S_IFIFO     600 s         4131         17
>     rmdir               600 s         4174         16
>=20
>   The stack samples identified the corresponding filename_*() waiter in
>   break_lease(). Every VM remained responsive through the requested run;
>   no Busy inodes, KASAN, WARNING, BUG, or panic appeared in serial output=
.
>   The unpatched baseline crashes reported in v1 were not rerun.
>=20
>  include/linux/filelock.h | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
>=20
> diff --git a/include/linux/filelock.h b/include/linux/filelock.h
> index ec11cc6b4..e909db319 100644
> --- a/include/linux/filelock.h
> +++ b/include/linux/filelock.h
> @@ -530,8 +530,8 @@ static inline bool is_delegated(struct delegated_inod=
e *di)
>   *
>   * Break delegations in a non-blocking fashion. If there are
>   * outstanding delegations and @di is set, then an extra reference
> - * will be taken on @inode and @di->di_inode will be populated so
> - * that it may be waited upon.
> + * will be taken on @inode and its superblock, and @di->di_inode will
> + * be populated so that it may be waited upon.
>   *
>   * Returns 0 if there is no need to wait or an error. If -EWOULDBLOCK
>   * is returned, then @di will be populated (if non-NULL).
> @@ -545,16 +545,21 @@ static inline int try_break_deleg(struct inode *ino=
de, unsigned int flags,
>  	if (ret =3D=3D -EWOULDBLOCK && di) {
>  		di->di_inode =3D inode;
>  		ihold(inode);
> +		/* The caller may drop its mount before break_deleg_wait(). */
> +		atomic_inc(&inode->i_sb->s_active);
>  	}
>  	return ret;
>  }
> =20
>  static inline int break_deleg_wait(struct delegated_inode *di)
>  {
> +	struct inode *inode =3D di->di_inode;
> +	struct super_block *sb =3D inode->i_sb;
>  	int ret;
> =20
> -	ret =3D break_deleg(di->di_inode, 0);
> -	iput(di->di_inode);
> +	ret =3D break_deleg(inode, 0);
> +	iput(inode);
> +	deactivate_super(sb);
>  	di->di_inode =3D NULL;
>  	return ret;
>  }

LGTM!

Reviewed-by: Jeff Layton <jlayton@kernel.org>
