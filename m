Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.145
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795467010;
	b=oVtYDo6HHHZLYh65EsVZT0q3HlUE0Qyl5thSAMN7x6Jxgb4g4W6phF1A/yn62N/sbn/X
	 78kkGOANrihNjty53nM5Qapg4SDQyLJ2YOK7ASo+tNfoCwM379W77hpJv30wKkNyjbYnx
	 cAyvqkQDkz19P3CclKqSfXiaZc1gmBBh5ljwpYdzYxqGAJpd/bZcuVM/s4MZ1/VuK0But
	 Yez0dQ1Vdd2UcTbpMvV7CKjaN7nuKglLOLyUCG2xbORXf/u+KR7exu3OVT6c4jCGiAFc+
	 6+KjxE4Cw+1rzknWW+BsYt+sjiIb30bNN1QqXvJPMDihTWiq6Dmf6w4FsH7k/sIDTgw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795467010;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Content-Type:Content-Transfer-Encoding:MIME-Version:From:To:
	 Cc:Subject:In-reply-to:References:Date:Message-id:Reply-To;
	bh=XdGuj14JivFE4i4DvwEyEUhQpv7EglQuTFrr91oPQkM=;
	b=zW3x50nmJ7xw1CPZLjqi0vLkp8OQtcvvkmMZyL/MT5vmlkthZsBbgARE5apwzPM5/DYY
	 W3sCvk+ZP+YMbZICAObdn+uyw2dVxWifYK/4lCIKC1TS2X9kmMB2ajRIDOzpj+MsHEnlE
	 2SPIuZxpDYhIC6gUDBF6W3yy+lrXyw80NAZVB/+GLxlSEBC0iASnk/fI/HdEMmF6kjRhZ
	 pZmcMfYTf20XHcShQjWHWCrkveOuJdYAoKlSvPx+yQpLEpI0sCO2dYi3qZ1liANcj1+op
	 ofkHvlOECTIsIzXQqXISUorNpgkEcCNk0yUnVHS5hue0ywQ7XH1baDm/dhwkTgRM+tA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ownmail.net;
	spf=pass smtp.mailfrom=ownmail.net;
	dkim=pass header.d=ownmail.net header.i=@ownmail.net header.a=rsa-sha256 header.s=fm3 header.b=l8OAoPxm;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=j6NtaO8W;
	arc=none smtp.remote-ip=103.168.172.145
Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49560606A327
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Nov 2026 20:50:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 49560606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ownmail.net header.i=@ownmail.net header.a=rsa-sha256 header.s=fm3 header.b=l8OAoPxm;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=j6NtaO8W
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 78939EC2006
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Nov 2026 15:50:09 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Mon, 23 Nov 2026 15:50:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm3; t=
	1795467009; x=1795553409; bh=XdGuj14JivFE4i4DvwEyEUhQpv7EglQuTFr
	r91oPQkM=; b=l8OAoPxm0DOO4CYkS8lAaIx+w9dez28k9FDvQB9fOugQigk5LQi
	sONVIGf2A+Ds1NmQMhxTyO1KFLv/aMYsWOVm8GDu3cjL+w4sYvKX0DmqPms8ynGJ
	SObbRqtyIWTQqyr5DmFjEUAEHMJaDYd/CnnAvAJU34W5ejSoPnppFKWlHBDIaqUa
	InkBtIdi33O4S0NFmJsFbQ1DzvqS7QYhpgaSrxVg1OCkU7AHskIabJTzA9OVS1zE
	qTbjzugItFDz3BzED0soyzNQnDIFuy2fgqeCF58IG4lraVjsff9pcKzGpThTjc4T
	gaAftBBCEXkD50SazQc2fOL75/AdoVoqzJA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1795467009; x=
	1795553409; bh=XdGuj14JivFE4i4DvwEyEUhQpv7EglQuTFrr91oPQkM=; b=j
	6NtaO8WZzZR4Q7Md95Z2QngI5YGYSDJPBAJzu2RJ76OPNlnNDGEAHkZZyGPbdmzj
	S0fBF23NAzxvAAv7Nj/bCFS5jAOWBX5TbczoC6F8D//O98lxJ3zF8TxOWNR2f6tT
	fxOSR1pVEdGvMImjET/OtNDmx/gRpqkA/pUStbA3v3z2mhFVxK/bmXDVox123ld3
	HC/nI/gug3HtanXEFTLoADEjF9w93yFdfWIUnpW0aFKcpLwlXu4ck98JlHKnVUY8
	GPXRnACkm/4SNOJRNJPm2pKFHkUutkUzgtL//58Xs7jXmi7hoQwry28t2HR0TSY4
	cqWHvbwoijo+UUYYZsAHg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=ownmail.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795467009; d=ownmail.net;
	mf=PG5laWxiQG93bm1haWwubmV0Pg==;
	rt=PGxpbnV4LWZzZGV2ZWxAdmdlci5rZXJuZWwub3JnPg==;
	s=fm3:rsa-sha256:Wy7DvFUwfGs+YpTBHfE3PTWjmNKV5Ihw9PNUNcH9NoO543+
	aikrVhoaoJ4TJ2Rr8zk2uISAg0fZwBDvF1qLam1dT5WkmBA/oJjM8WSmElI4pdXW
	CfrRC54NKp9KXDuzPTA6njGr8TOZdmKXcg8Rd6wq5DCm5Ibki7C+WiC9mE5WXnJN
	f6+esynhCt6rPT7ne/xHM8mi7DNk0iH023EnbhDZKRrLoOnQ/jptju+v9nWPllzl
	GB+qnfq5fWVTLrGBnPqzD80+VlQaiTV7pfnaOvvFbd2wVAWsy5j2m1/SyYLqUtMa
	flBujn60Yq0y+fNvFohtorGCrnnEFnSO2MANNPw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=13;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,reply-to,
	subject,to;
Message-Instance: m=1; h=sha256:r2bmrhO5AyKuom5DkudHbPdXHfRk2ukJbNIMmzO00EM=:iAWz9bv9M8LxSKkRXrJ4G/5DHm/VNPBvWn7AH8fgc0Y=;
X-ME-Sender: <xms:AKcEa3i2IczRl68wYSoGby509U4fb_Q592ctZHHErFRnRrLkOGkjmQ>
    <xme:AKcEa1UyvBjmz_5WVx9d-2IyU2JitQEKsIEwy2RkxxpPmcJ_TPK3rcZNSLNdFG4U3
    ZeaF9VmtHDjLw3dDCoB75vNBzU7rDa9oaGTbmNO-O6ZCeZ1CI4>
X-ME-Received: <xmr:AKcEa7vQ5FTil5DXy6v8VtVYhw3gK_WHhO1ftDZptA91AF-ArmQ36IPE-u10bBfOe9iH0CA9v_9ZDETKFYnR-KW--Bw6eDs>
X-ME-Proxy-Cause: dmFkZTGqT2d7PT4cYV+CVfmiuNk2dRMM8KfAbINTQ7Jwk9RRwOM7RSfyeb8cklpkBRfhA/
    c1c/sBHBW2ukGKF0t0WAsKhHmO3swLz41i/ftF8/A1nfc6iaGmHFk8NUMTq//EiJoe0naU
    n3vVa1eAnHowCzV2fNQpZ/XFsLe+7bc2Sb2A0ABTUeiAZPEK5MeaHlwRb4luQBX4J/x6dk
    9XDOS3BLiVEcx2rP1T2O5vPNlPkGc9RlOJg+H+jGvU0MOmCLQ1mIGQJ6E6A+zNti8wPIQa
    AgxZCr2cDGTlyON3hdpQACsCubdrEMvVuy6WtY0avlT6LUPF/w5w4D8deL6Q++sdd9AQAq
    7QRGeYbWkZOK4Vf1lY7xz7AojqrjALIsM32pW+LYVG8V7j+IZofEm8NMMr72QeTeitvmTY
    v9+YIAWWvNBd1KKQgdhRRxVMZuHRqEsuTHrCIS7FO7RycOaAsu870NjILH+YjUTtXecgsE
    QPhb2wlfSOqd2bdqQ6OdwbrgaPbvAHfRgQvKKVTq7C2mM8d9JB1VSP6DxY0/jzMgerixkT
    n9SpbzSxqQ2/P2jZuHBiZRNiPkuh0HLe5xAeID6GlIendhKYV/pIzBft9O2SnSLzrmmivQ
    Mw528q7zXA9N/BYupWR2MtmwF7s3zrnm6vja+iIegcFZF6pFWwUC4K3mt/ZA
X-ME-Proxy: <xmx:AKcEa2-JFPq84vpXJRYfhTcYj5QrCuCV_wq7oHoqkyTyPA_2WCte8w>
    <xmx:AKcEa7vbsSiMOGx8a-nmxe7FueqVJKneNPazYGrOVZCjnwjN_kAC6Q>
    <xmx:AKcEa85X9fTG3ZYAUfPp8P2-XAD9ze0j43_ysngsEHSo5IY1YiEN2w>
    <xmx:AKcEa0O6_yO0VwMBZVwmMfDMOl9Ozcxl63G1QZTbldZCnFZSOXSauA>
    <xmx:AacEa8UWFllbqKAIRjZu5kYGGHpjhehbfweYwDVJsGxSuSuQfDYEC09j>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 23 Nov 2026 15:50:03 -0500 (EST)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: NeilBrown <neilb@ownmail.net>
To: "Christian Brauner" <brauner@kernel.org>
Cc: "Alexander Viro" <viro@zeniv.linux.org.uk>,
 "Jan Harkes" <jaharkes@cs.cmu.edu>, coda@cs.cmu.edu,
 "Jan Kara" <jack@suse.cz>, "Richard Weinberger" <richard@nod.at>,
 "Anton Ivanov" <anton.ivanov@cambridgegreys.com>,
 "Johannes Berg" <johannes@sipsolutions.net>,
 "Namjae Jeon" <linkinjeon@kernel.org>, "Hyunchul Lee" <hyc.lee@gmail.com>,
 "Carlos Maiolino" <cem@kernel.org>, "Jeff Layton" <jlayton@kernel.org>,
 "Amir Goldstein" <amir73il@gmail.com>, linux-kernel@vger.kernel.org,
 codalist@coda.cs.cmu.edu, linux-fsdevel@vger.kernel.org,
 linux-um@lists.infradead.org, ntfs@lists.linux.dev, linux-xfs@vger.kernel.org
Subject: Re: [PATCH v2 4/4] procfs: drop parent lock for d_alloc_parallel() in
 iterate_shared()
In-reply-to: <20261120-visier-dortig-gutachten-7a478b74ea10@brauner>
References: <20261117000115.1433875-1-neilb@ownmail.net>
  <20261117000115.1433875-5-neilb@ownmail.net>
  <20261120-visier-dortig-gutachten-7a478b74ea10@brauner>
Date: Tue, 24 Nov 2026 07:50:01 +1100
Message-id: <179546700150.1728055.11008903897238791275@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Sat, 21 Nov 2026, Christian Brauner wrote:
> On Tue, Nov 17, 2026 at 10:55:01AM +1100, NeilBrown wrote:
> > +	if (child =3D=3D ERR_PTR(-EWOULDBLOCK)) {
> > +		/*
> > +		 * Need to drop directory lock, which isn't really
> > +		 * needed here anyway.  As rmdir never happens in procfs
> > +		 * we don't need to be concerned about S_DEAD being set
> > +		 * while unlocked.
> > +		 */
> > +		inode_unlock_shared(dir->d_inode);
> >  		child =3D d_alloc_parallel(dir, &qname);
> > [...]
> > +		inode_lock_shared(dir->d_inode);
> > +	}
>=20
> I think this can deadlock.
> If we're colliding with the failed lookup because the fd was closed, the
> task exited or the sysctl unregistered then the  dentry is unhashed and
> d_alloc_parallel() hands us a new in-lookup dentry.
>=20
> We then retake the lock while still owning it. But the VFS waits for
> in-lookup dentries with the lock held, e.g., open() with O_CREAT:
>=20
> P1: getdents(/proc/$pid/fd)         P2: open("/proc/$pid/fd/5", O_CREAT)
> proc_fill_cache("5")
> -> d_alloc_trylock() =3D=3D -EWOULDBLOCK
> -> inode_unlock_shared(dir)
>                                     lookup_open()
>                                     -> inode_lock(dir)
>                                     -> d_lookup("5") =3D=3D NULL
> -> child =3D d_alloc_parallel("5")
>                                     -> d_alloc_parallel("5")
>                                        -> d_wait_lookup(child)
> -> inode_lock_shared(dir)
>=20
> Both sleep uninterruptibly.
> A shell redirect to /dev/fd/5 is enough for P2.
>=20
> I don't tink it even needs O_CREAT. Any queued writer like a mkdir in
> the directory or chmod on it plus a lookup_slow() of the same name that
> holds the lock shared and waits on the child has the asme issue.
>=20
> And under /proc/sys/net it doesn't need a failing lookup either.
> proc_sys_compare() matches any in-lookup dentry but after the wait
> sysctl_is_seen() rejects a dentry from another netns and we get our
> own.
>=20
> d_add_ci() in 1/4 gets this right and finishes all in-lookup dentries
> before relocking. So I think procfs needs to do the same, sm like
> (UNTESTED):

Yes - definitely.  Mustn't retake i_rwsem while holding an in-lookup
dentry.
Your draft looks good.

Thanks,
NeilBrown


>=20
> diff --git a/fs/proc/base.c b/fs/proc/base.c
> index 5f9ec52..d30f877 100644
> --- a/fs/proc/base.c
> +++ b/fs/proc/base.c
> @@ -2105,19 +2105,19 @@ bool proc_fill_cache(struct file *file, struct dir_=
context *ctx,
>  	struct inode *inode;
>  	unsigned type =3D DT_UNKNOWN;
>  	ino_t ino =3D 1;
> +	bool relock =3D false;
> =20
>  	child =3D d_alloc_trylock(dir, &qname);
> -
>  	if (child =3D=3D ERR_PTR(-EWOULDBLOCK)) {
>  		/*
> -		 * Need to drop directory lock, which isn't really
> -		 * needed here anyway.  As rmdir never happens in procfs
> -		 * we don't need to be concerned about S_DEAD being set
> -		 * while unlocked.
> +		 * Wait for the other lookup without the directory lock and
> +		 * don't take it back while @child is in-lookup: lookup_open()
> +		 * waits for in-lookup dentries with the lock held exclusive.
> +		 * procfs never sets S_DEAD.
>  		 */
>  		inode_unlock_shared(dir->d_inode);
> +		relock =3D true;
>  		child =3D d_alloc_parallel(dir, &qname);
> -		inode_lock_shared(dir->d_inode);
>  	}
>  	if (IS_ERR(child))
>  		goto end_instantiate;
> @@ -2137,6 +2137,8 @@ bool proc_fill_cache(struct file *file, struct dir_co=
ntext *ctx,
>  	type =3D inode->i_mode >> 12;
>  	dput(child);
>  end_instantiate:
> +	if (relock)
> +		inode_lock_shared(dir->d_inode);
>  	return dir_emit(ctx, name, len, ino, type);
>  }
> =20
>=20
> The sysctl side needs the same.
>=20
> This also has the same lookup_one_qstr_excl() problem as the earlier
> patch.
>=20

