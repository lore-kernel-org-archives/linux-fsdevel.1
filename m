Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794293506;
	b=bE+5OSRXoLq339o7422MUyrocQJjhqIPra8tT4EzzPv/iE3ZwUmNa99wBuo+51h4CRFp
	 H7wY4Ew4d/Fgl3PAeng8Oz3qw4qjnqnqjR7tthQL26EQoArOvYS3N5UsNRPYKDBCdrvRb
	 QMekWR/yFU/k4r91vdXAM7d7cL6hemFzVLp8AalVxZO31L1QENrNsWcpx/YPnnX/L4g6R
	 kMDBdtvhhXSeBbXJ0mWqtw2hnmd/Pgx//YeCM7zmA6V9ESgTpH9A5cM1OozDKKSFFpW+k
	 punwgs16WxvucBHjMfw6VpLMDr1V6KCMtCkzztnotrHExGjrXTwueyiBUd/fjtDl4Og==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794293506;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=b/60QXV10ir+0hO0A2OQccMEO1lS0/FXObeA4/RD7Qc=;
	b=ew0T7mFHqASzzQ+BYMJATA8WQ/idY2VmsfMVPx/Z/N1HAnKBx/pXm49OE4cV6624TjUE
	 VpfdglM2BprXcsdAhySAvzTLoBIroHJ4cqA+WvMvZ2896Bqn8J/p9r5Hg3fl3jvc+4lzp
	 2YDT+C3wdtRhNDamFX9weDYHXyHQ0Ele2hm5Hzb2uzFhQxeOp6xry7BzSedG7fsenC5xr
	 CxKZGDaqYdJNAClLu7qPq/9m7Gr7/pRgmvW5rkeH5EUGW+eRkltkd0zVys53TNz+flo8U
	 KHoBeRYf7AQovzmA/xIO+i11Z79O0UGGf40PJTURELXCWZeUlSheQS4PEMb1wxhsfpA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CJpEdtzz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 391FB606A326
	for <linux-fsdevel@vger.kernel.org>; Tue, 10 Nov 2026 06:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CJpEdtzz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C41861F008A4
	for <linux-fsdevel@vger.kernel.org>; Tue, 10 Nov 2026 06:51:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794293505;
	bh=b/60QXV10ir+0hO0A2OQccMEO1lS0/FXObeA4/RD7Qc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=CJpEdtzzFGxM0SbJaeHhWwydjoevDA+1b4poj0JBEzijXour4O+NyLIxD/k+WADqp
	 xdkya6doPGQ7dBmSjoMuRmwfWEVWJnNkS4GI9gO4sNyy+fjd2xMfURxtufLuZZvkPv
	 unwf2m09qUDGPAWWQMg/qLDCj2PSt99yirbs17SGGxV5SFQC54l0UshjVQSmd20e0g
	 wHlJTkk6TSWCk4OABjAcQl9BVIM8ofK6A4hdj46gaR1mtcFcXTYv2L0ALiqMuc1yw3
	 aQOGr9+gQbroZFswm27oCon8jx0GWwuf9clWXeMv3ijYGqZRbhIRl1Q3x+fvjymYuC
	 cbFur/TkvoHjA==
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5c148d4dbfbso1465959e87.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 09 Nov 2026 22:51:45 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErGPy+Up3KwrCqP78oTlnATxipOmY/MAWZQEHbZpw9dEZHkLj4kUFp/lXImt7nd/X2bdiP0lpFnYsggkE9hW@vger.kernel.org
X-Gm-Message-State: APuU4Z/r+lC8pcPETvVXzNPG7VsLgkWf3fWH/Jex07X+sKw7aXuHoHBn
	QSkerQ/JZn+8p55+XLXcckkIgtRrl/apKkClNmS1Ycva9QbUwxi4V0skdNasoAExCwzZjrQmKVr
	pw5SZtpYrJ8uZbOhqLEi1n3OQBgNi4Tk=
X-Received: by 2002:a05:6512:b06:b0:5c1:57ee:1887 with SMTP id
 2adb3069b0e04-5c157ee18f2mr442651e87.13.1794293504580; Mon, 09 Nov 2026
 22:51:44 -0800 (PST)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261109202339.1380828-1-neilb@ownmail.net> <20261109202339.1380828-3-neilb@ownmail.net>
In-Reply-To: <20261109202339.1380828-3-neilb@ownmail.net>
From: Xiubo Li <xiubli@kernel.org>
Date: Tue, 10 Nov 2026 07:51:32 +0100
X-Gmail-Original-Message-ID: <CAOuZWzwBaz6D23pMUMs31A552QG6XxneFJ4NCnV4We66vAGmZw@mail.gmail.com>
X-Gm-Features: AclHuK-eKt8QhakcBwvRonmOn-C9kXTDESXJ2wc-n-R3dnleBA0Y5UrMHBhmWhM
Message-ID: <CAOuZWzwBaz6D23pMUMs31A552QG6XxneFJ4NCnV4We66vAGmZw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] cephfs: Don't d_drop() before d_splice_alias()
To: NeilBrown <neil@brown.name>
Cc: Ilya Dryomov <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>, 
	Viacheslav Dubeyko <slava@dubeyko.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jeff Layton <jlayton@kernel.org>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org, ceph-devel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 10, 2026 at 07:20:24AM +1100, NeilBrown wrote:
> In two places ceph drops a dentry and then calls d_splice_alias().
> The d_drop() is no longer needed before d_splice_alias() and will
> cause problems for proposed changes to locking.

Tested with a second client creating and renaming entries, and with this
client running mkdir, creat, symlink, mknod and link over its own cached
negative dentries.  With this patch, splice_dentry() now passes hashed
negative dentries to d_splice_alias()(confirmed with bpftrace), and the
results match the other client, with no duplicate dentries.  A 10 minute
metadata fsstress run (create, mkdir, rename, link, unlink, getdents...)
with a second client doing readdir/stat churn was clean under KASAN
and lockdep.

The async create path in ceph_finish_async_create() was not exercised
here: my test cluster never grants the directory caps it needs.

Reviewed-by: Xiubo Li <xiubo.li@clyso.com>
Tested-by: Xiubo Li <xiubo.li@clyso.com>

Thanks
Xiubo

NeilBrown <neilb@ownmail.net> =E4=BA=8E2026=E5=B9=B411=E6=9C=889=E6=97=A5=
=E5=91=A8=E4=B8=80 21:25=E5=86=99=E9=81=93=EF=BC=9A
>
> From: NeilBrown <neil@brown.name>
>
> In two places ceph drops a dentry and then calls d_splice_alias().
> The d_drop() is no longer needed before d_splice_alias() and will
> cause problems for proposed changes to locking.
>
> Signed-off-by: NeilBrown <neil@brown.name>
> ---
>  fs/ceph/file.c  | 2 --
>  fs/ceph/inode.c | 3 ---
>  2 files changed, 5 deletions(-)
>
> diff --git a/fs/ceph/file.c b/fs/ceph/file.c
> index 4a19a00be96f..159ec0bdf1fd 100644
> --- a/fs/ceph/file.c
> +++ b/fs/ceph/file.c
> @@ -770,8 +770,6 @@ static int ceph_finish_async_create(struct inode *dir=
, struct inode *inode,
>                         unlock_new_inode(inode);
>                 }
>                 if (d_in_lookup(dentry) || d_really_is_negative(dentry)) =
{
> -                       if (!d_unhashed(dentry))
> -                               d_drop(dentry);
>                         dn =3D d_splice_alias(inode, dentry);
>                         WARN_ON_ONCE(dn && dn !=3D dentry);
>                 }
> diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
> index cfc438b3a446..68da14fced96 100644
> --- a/fs/ceph/inode.c
> +++ b/fs/ceph/inode.c
> @@ -1626,9 +1626,6 @@ static int splice_dentry(struct dentry **pdn, struc=
t inode *in)
>                 }
>         }
>
> -       /* dn must be unhashed */
> -       if (!d_unhashed(dn))
> -               d_drop(dn);
>         realdn =3D d_splice_alias(in, dn);
>         if (IS_ERR(realdn)) {
>                 pr_err_client(cl, "error %ld %p inode %p ino %llx.%llx\n"=
,
> --
> 2.50.0.107.gf914562f5916.dirty
>
>
