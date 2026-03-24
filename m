Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52A9A3F87FF
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Mar 2026 13:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774358542; cv=none; b=V8Ce7XrFsvfcAMIO27mlMdfXzZAbj5uTaJW2GACi445FIzDTUqfg9c7eaWTBzst12jBmRe/9AZuT8bl7V9ybYo/Lcu/C9+26RJlHe//pOh1tZf8Opu0Tf0JkgrEH87oHtQrTlRO3ThUpmy7Qct7hYCkwozO3M/MCXph0r2GnZbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774358542; c=relaxed/simple;
	bh=t9i2FcqYVnQkYcg1EgHY8fJjJXyYMIpx3kAo2BSrOQ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pd4JYpHPYFWOnlMp2WfAMWFty7OHyPNLzUQ9l9oahetpMvf+xqN1ezQ58jIe4aOQYxcjgw/cGBFnPaJ+zLXaxzZhG35h/FWaZwVvvm1FkIqc3GaJnUq3guhN1rBTbsjSpx/hJM0o3GI8v5e/ZBjFLITYzi8gR7KKdYV96ZaQtYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bQZxuYYA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bQZxuYYA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774358539;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gZiGwuGyoycCds41LQfUcfqmxmZw8CRaCZwYydV96AE=;
	b=bQZxuYYAVDHXNBl8rcX70ctBJ+8S2VQLvScSa+VnG1+LtHm1f2cGkLhJX3id+DjGOXKeWQ
	Rpa37psI29/8kFmFLIzwOiWbnFFEsqd9DTQRF/XTH7GAjMmopg6ELACvWvLSxOlMmWbI50
	+AlGTnhjVCyk1FDLnQ977n6CgZ4GmQM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-232-qHV73fmmNIKE6BfdK08_sw-1; Tue,
 24 Mar 2026 09:22:15 -0400
X-MC-Unique: qHV73fmmNIKE6BfdK08_sw-1
X-Mimecast-MFC-AGG-ID: qHV73fmmNIKE6BfdK08_sw_1774358533
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 55E8B189AF38;
	Tue, 24 Mar 2026 13:21:53 +0000 (UTC)
Received: from localhost (unknown [10.45.226.125])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3DE8219560B1;
	Tue, 24 Mar 2026 13:21:50 +0000 (UTC)
Date: Tue, 24 Mar 2026 09:21:49 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: jim.harris@nvidia.com
Cc: linux-fsdevel@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>,
	Max Gurtovoy <mgurtovoy@nvidia.com>, Idan Zach <izach@nvidia.com>,
	Konrad Sztyber <ksztyber@nvidia.com>,
	German Maglione <gmaglione@redhat.com>, hreitz@redhat.com
Subject: Re: fuse: buffered reads limited to 256KB regardless of negotiated
 max_pages
Message-ID: <20260324132149.GB668717@fedora>
References: <20260316145435.BA2542605C3@ubuntu.localdomain>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Et/z3TIa3d3p1+0X"
Content-Disposition: inline
In-Reply-To: <20260316145435.BA2542605C3@ubuntu.localdomain>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12


--Et/z3TIa3d3p1+0X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 16, 2026 at 07:54:35AM -0700, jim.harris@nvidia.com wrote:
> Hi all,
>=20
> We have a FUSE server that advertises max_write=3D1MB and max_pages=3D256
> in the FUSE_INIT response. Buffered sequential writes arrive at the
> server at the full 1MB as expected. However, buffered sequential reads
> are capped at 256KB per FUSE READ request.
>=20
> The cap comes from the BDI readahead window. bdi->ra_pages defaults to
> VM_READAHEAD_PAGES (32 pages / 128KB). For sequential access (e.g. cp),
> posix_fadvise(POSIX_FADV_SEQUENTIAL) doubles the per-file readahead
> window to 2 * bdi->ra_pages (256KB), producing the observed 256KB
> limit. A 1MB application read() results in four sequential 256KB
> round trips to the FUSE server instead of one.

Hi Jim,
Thanks for sharing this issue. I am CCing Geman Maglione and Hanna
Czenczek who work on virtiofsd and are also becoming more involved in
the virtiofs kernel driver.

> In process_init_reply(), the kernel processes the
> server's max_readahead response like this:
>=20
>     ra_pages =3D arg->max_readahead / PAGE_SIZE;
>     fm->sb->s_bdi->ra_pages =3D min(fm->sb->s_bdi->ra_pages, ra_pages);
>=20
> Since bdi->ra_pages starts at VM_READAHEAD_PAGES (128KB), and the
> kernel sends this value as init_in->max_readahead, the server can only
> decrease readahead -- never increase it. Even if the server responds
> with max_readahead=3D1MB, the min() clamps it back to 128KB.
>=20
> Other filesystems set ra_pages or io_pages based on server/device
> capabilities:
>=20
>   - SMB/CIFS sets ra_pages directly (2 * rsize, or from mount option)
>   - Ceph sets ra_pages directly from mount option
>   - 9P sets both ra_pages and io_pages from maxdata
>   - NFS sets io_pages from rsize
>=20
> I see two possible approaches and would like feedback:
>=20
> Option A: Fix the max_readahead negotiation
>=20
> Replace the current:
>=20
>     fm->sb->s_bdi->ra_pages =3D min(fm->sb->s_bdi->ra_pages, ra_pages);
>=20
> with:
>=20
>     fm->sb->s_bdi->ra_pages =3D min(ra_pages, fc->max_pages);
>=20
> This uses the server's max_readahead response directly, capped by
> fc->max_pages for safety. I think this is backward compatible:
> existing servers that echo the kernel's 128KB value get the same
> result. Servers that return a lower value still reduce it. Only
> servers that return a higher value see changed behavior.
>=20
> FUSE servers can opt in by advertising a larger max_readahead in the
> FUSE_INIT response.
>=20
> Option B: Set io_pages from max_pages
>=20
> Set bdi->io_pages after FUSE_INIT negotiation:
>=20
>     fm->sb->s_bdi->io_pages =3D fc->max_pages;
>=20
> This matches what NFS does (setting io_pages from rsize). The
> readahead code uses max(bdi->io_pages, ra->ra_pages) to determine
> the maximum readahead size, so a large io_pages would allow larger
> readahead submissions.
>=20
> This is simpler since no server-side change is needed. However, it
> bypasses the max_readahead protocol field, making max_readahead
> effectively meaningless for any device with large max_pages.
>=20
> In both cases, fc->max_pages is already clamped by
> fc->max_pages_limit, which for virtio-fs accounts for the virtqueue
> descriptor count.
>=20
> Thoughts?

I think this is a question for Miklos. You could also send a patch with
your preferred solution to expediate this.

Thank you for looking into this - it will be nice to remove this
performance limitation.

Stefan

--Et/z3TIa3d3p1+0X
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmnCj+0ACgkQnKSrs4Gr
c8jBOQf9HEkry8G9etUqvqR1fTAUppE3mag7kK38F10i4tpLBnpT5i2L+N6I0VQR
Ne7cn/eF2YzWbvAcE1YksT38s2RaI5jwIJlbLaXCdwu/TbObLL/FUQHhxPF8zkI1
ChOlVAdhoe+mr97+cZynoR4t4OgEn58Z7KB80d1MLCnjn+yJIeDlHWAzgQ+vhcIu
PnYtBGh3vZ/Mdglmzf275oE/4utyvirvSMFr2SvUcuANXRJJ15FJIpZR2I8Amxof
BtbNyp2oKisE5LXp+g7Jyd7XB7CQlPB2xArmBlhPF1XDWa/EZJ00viCsdZ9yDKvX
4dVCyQKEB/ihpEnJ4n7c1K459M9tOA==
=49TD
-----END PGP SIGNATURE-----

--Et/z3TIa3d3p1+0X--

