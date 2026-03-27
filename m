Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFA2D381AE5;
	Fri, 27 Mar 2026 06:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774592478; cv=none; b=JGzK/FKQwb2hDwRFElqPXC20FonvcjbOovQB+ntVTVYOJ8lUgeXnlm66tco+1mNd2R4WgYVXD3QU6tBQ+5vMux6IPYSkmK3IhUNzREz2UbBFUqKHRd9v57WB5pcAyjvhP7F+n+27d2m4bSz92BHaMxdpL7osKuNwffXPV1aZmO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774592478; c=relaxed/simple;
	bh=B0CS6VMK6yu8SS3Ll3zB5+Ug5K3QTZMIWKcuUV3g2lg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H90Bou2qripgO4wNLW8covu5NUVXxWCjwuTxvTo4J43W6CdMjkSqCmpXrfXGQzkf2nZswNRwQLRDPD8sn02C2Wrsx1plVM5/OJpPNqwaAg+n4HhJT4swvN6uKcAq4X3mFS+tpB5mN1c/q3bvAfZrLiUnA/nEvcL5JEfpxNwi3Io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com; spf=pass smtp.mailfrom=cyphar.com; dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b=j+Ujf1pR; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyphar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b="j+Ujf1pR"
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4fhrBC0vmfz9v34;
	Fri, 27 Mar 2026 07:21:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
	t=1774592467;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=74/MndzYv3zae0IzJiR8zEEmYnfy9ZzdY4+LCdZzxIQ=;
	b=j+Ujf1pRvXqmgTEhY1Qwk23Z5zucsBdYiRE96RHxff2hmExTztRmuihXth7QLaUlHZcigi
	GQ1ec/8GTrqrwcgxzakzeLldH4bbGYc60s0Vk8hHUaisVkEZgh1N3Un6FpnxNcrXDLMCrO
	J8ZDHvuOJJGI+CXQMtItI86oWvaG2KVxMIo2qDjcF0CGCAe9h5DPalcsmwq8kjMcd/Bmvw
	ukOmmyDy/FR9CZ42yHGrjO/ZVAXz02Jq6VRAKg3BVpwMX5cJQkbhKcksJQ8VINzFpFb4uB
	KKD7idRUn7UyQtb9GogRJBTraref0ZV1FPiqxNrMJ+5oJU2VC74BwuVYBv/DFQ==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of cyphar@cyphar.com designates 2001:67c:2050:b231:465::202 as permitted sender) smtp.mailfrom=cyphar@cyphar.com
Date: Fri, 27 Mar 2026 15:20:43 +0900
From: Aleksa Sarai <cyphar@cyphar.com>
To: Jori Koolstra <jkoolstra@xs4all.nl>
Cc: Jeff Layton <jlayton@kernel.org>, Chuck Lever <chuck.lever@oracle.com>, 
	Alexander Aring <alex.aring@gmail.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Shuah Khan <shuah@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Mike Rapoport <rppt@kernel.org>, "Liam R . Howlett" <Liam.Howlett@oracle.com>, 
	David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
	Ethan Tidmore <ethantidmore06@gmail.com>, NeilBrown <neil@brown.name>, Oleg Nesterov <oleg@redhat.com>, 
	Penglei Jiang <superman.xpt@gmail.com>, Kees Cook <kees@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@kernel.org>, 
	Amir Goldstein <amir73il@gmail.com>, Namjae Jeon <linkinjeon@kernel.org>, 
	Mateusz Guzik <mjguzik@gmail.com>, Wei Yang <richard.weiyang@gmail.com>, 
	Bala-Vignesh-Reddy <reddybalavignesh9979@gmail.com>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Andy Lutomirski <luto@kernel.org>, linux-kselftest@vger.kernel.org, 
	wangzijie <wangzijie1@honor.com>
Subject: Re: [RFC PATCH v2 2/3] vfs: transitive upgrade restrictions for fds
Message-ID: <2026-03-27-tweed-frozen-omen-inventory-YVLIh6@cyphar.com>
References: <20260326182033.1809567-1-jkoolstra@xs4all.nl>
 <20260326182033.1809567-3-jkoolstra@xs4all.nl>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="shyxwjfbequyutje"
Content-Disposition: inline
In-Reply-To: <20260326182033.1809567-3-jkoolstra@xs4all.nl>
X-Rspamd-Queue-Id: 4fhrBC0vmfz9v34


--shyxwjfbequyutje
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [RFC PATCH v2 2/3] vfs: transitive upgrade restrictions for fds
MIME-Version: 1.0

On 2026-03-26, Jori Koolstra <jkoolstra@xs4all.nl> wrote:
> Add upgrade restrictions to openat2(). Extend struct open_how to allow
> setting transitive restrictions on using file descriptors to open other
> files. A use case for this feature is to block services or containers
> from re-opening/upgrading an O_PATH file descriptor through e.g.
> /proc/<pid>/fd/<nr> as O_WRONLY.
>=20
> The idea for this features comes form the UAPI group kernel feature idea
> list [1].
>=20
> [1] https://github.com/uapi-group/kernel-features?tab=3Dreadme-ov-file#up=
grade-masks-in-openat2

I had a version of this in the original openat2(2) pull request many
years ago[1].

Unfortunately there is a pretty big issue with doing it this way (which
I mentioned in one of the changelogs back then[2]): There are lots of
VFS operations that imply operations on a file (through a magic-link)
that are not blocked. truncate(2) and mount(MS_BIND)/open_tree(2) are
the most problematic examples, but this applies to basically any syscall
that takes a path argument. If you don't block those then re-opening
restrictions are functionally useless.

It also would be really nice if you could block more than just trailing
component operations -- having a directory file descriptor that blocks
lookups could be quite handy for a bunch of reasons.

I think the only workable solution to block all of these issue entirely
and in a comprehensive way is to have something akin to capsicum
capabilities[3] tied to file descriptors and have all of the VFS
operations check them (though I think that the way this was attempted in
the past[4] was far from ideal).

I have tried my hand at a few lighter-weight prototypes over the years
(mainly trying to add the necessary checks to every generic_permission()
call, and adding some more generic_permission() calls as well...). My
last prototype was adding the restriction information to "struct path"
but that would bloat too many structures to be merge-able. I was
planning on looking at this again later this year, but if you can come
up with a nice way of getting a minimal version of capsicum working,
that'd be amazing. :D

That being said, while my view at the time of openat2(2) was that we
need to do this at the same time as O_EMPTYPATH (and my tests showed
that this was a backwards-compatible change -- on modern desktops at
least), at this point I think it'd be better to just merge O_EMPTYPATH
by itself and we can work on this hardening separately and make it an
opt-in sysctl (with individual file descriptors being opt-in-able as
well).

[1]: https://lore.kernel.org/lkml/20190930183316.10190-2-cyphar@cyphar.com/
[2]: https://lore.kernel.org/lkml/20191026185700.10708-1-cyphar@cyphar.com/
[3]: https://lwn.net/Articles/482858/
[4]: https://lore.kernel.org/lkml/1404124096-21445-1-git-send-email-drysdal=
e@google.com/

> +const struct jump_how jump_how_unrestricted =3D {
> +	.allowed_upgrades =3D VALID_UPGRADE_FLAGS
> +};
> +
>  /*
>   * Helper to directly jump to a known parsed path from ->get_link,
>   * caller must have taken a reference to path beforehand.
>   */
> -int nd_jump_link(const struct path *path)
> +int nd_jump_link_how(const struct path *path, const struct jump_how *how)
>  {
>  	int error =3D -ELOOP;
>  	struct nameidata *nd =3D current->nameidata;
> @@ -1181,6 +1187,7 @@ int nd_jump_link(const struct path *path)
>  	nd->path =3D *path;
>  	nd->inode =3D nd->path.dentry->d_inode;
>  	nd->state |=3D ND_JUMPED;
> +	nd->allowed_upgrades &=3D how->allowed_upgrades;
>  	return 0;

Way back then, Andy Lutomirski suggested that this be done via the
magic-link modes. While it is kind of ugly and in my patchset this
required adjusting some magic-link modes, it does provide a useful
indication to userspace of two things:

 - What upgrade modes are available for a file (this is useful for
   debugging but is also really necessary for the checkpoint-restore
   folks' needs). I did this with fmode (and exposed fmode in fdinfo)
   but I would not recommend that approach at all.

 - It indicates whether the kernel supports this feature, which will
   allow certain programs to loosen their hardening logic since the
   kernel implements the hardening for them.

   For instance, most container runtimes now either make a copy of
   /proc/self/exe as a sealed memfd or create a read-only overlayfs
   mount to re-exec /proc/self/exe so that containers cannot overwrite
   the host binary by doing a /proc/$pid/exe re-open. See CVE-2019-5736
   for more details.

   Indicating that the kernel blocks this attack would let container
   runtimes disable this hardening on such kernels.

Maybe we should at least change the modes even if they aren't used?

> -static int proc_exe_link(struct dentry *dentry, struct path *exe_path)
> +static int proc_exe_link(struct dentry *dentry, struct path *exe_path,
> +			 struct jump_how *jump_how)
>  {
>  	struct task_struct *task;
>  	struct file *exe_file;
> @@ -1789,6 +1794,7 @@ static int proc_exe_link(struct dentry *dentry, str=
uct path *exe_path)
>  	put_task_struct(task);
>  	if (exe_file) {
>  		*exe_path =3D exe_file->f_path;
> +		*jump_how =3D jump_how_unrestricted;
>  		path_get(&exe_file->f_path);
>  		fput(exe_file);
>  		return 0;

This should restrict writes, for the reasons outlined above.

> -static int map_files_get_link(struct dentry *dentry, struct path *path)
> +static int map_files_get_link(struct dentry *dentry, struct path *path,
> +			      struct jump_how *jump_how)
>  {
>  	unsigned long vm_start, vm_end;
>  	struct vm_area_struct *vma;
> @@ -2279,6 +2288,7 @@ static int map_files_get_link(struct dentry *dentry=
, struct path *path)
>  	rc =3D -ENOENT;
>  	vma =3D find_exact_vma(mm, vm_start, vm_end);
>  	if (vma && vma->vm_file) {
> +		*jump_how =3D jump_how_unrestricted;
>  		*path =3D *file_user_path(vma->vm_file);
>  		path_get(path);
>  		rc =3D 0;

This should also restrict writes (this is a similar issue to
/proc/self/exe and is harder to harden against, the primary defense is
just ASLR...).

> diff --git a/include/uapi/linux/openat2.h b/include/uapi/linux/openat2.h
> index c34f32e6fa96..fc1147e6ce41 100644
> --- a/include/uapi/linux/openat2.h
> +++ b/include/uapi/linux/openat2.h
> @@ -20,8 +20,14 @@ struct open_how {
>  	__u64 flags;
>  	__u64 mode;
>  	__u64 resolve;
> +	__u64 allowed_upgrades;
>  };
> =20
> +/* how->allowed_upgrades flags for openat2(2). */
> +#define DENY_UPGRADES		0x01
> +#define READ_UPGRADABLE		(0x02 | DENY_UPGRADES)
> +#define WRITE_UPGRADABLE	(0x04 | DENY_UPGRADES)

I'm not a huge fan of how this bitmask is set up, to be honest. I get
that you did it this way to make it disable-by-default but given that we
probably will want to add restrictions in the future that would break
backward compatibility (imagine an execute restriction that blocks
execve(2) -- adding the feature would break all existing programs if you
follow this scheme).

It probably makes more sense to do something more like statx(2) -- you
pick the restrictions you want and get back information about which
restrictions were supported. This is similar to what I did in the old
patchset too, though it didn't give you information like statx(2) does.

--=20
Aleksa Sarai
https://www.cyphar.com/

--shyxwjfbequyutje
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQS2TklVsp+j1GPyqQYol/rSt+lEbwUCacYhuxsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMiwyLDIACgkQKJf60rfpRG9lQQEA7f/4GrHExneRKFlkqckO
DBuU40Iwi+6n61mFIie1168A/09bWoZVoRT4SIONO1EzPuwYQOKbd7kY0hZOuaqH
FLkK
=V4Mg
-----END PGP SIGNATURE-----

--shyxwjfbequyutje--
