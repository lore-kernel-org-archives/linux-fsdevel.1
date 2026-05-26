Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 411D73AFD04;
	Tue, 26 May 2026 16:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779812162; cv=none; b=kIFwBOrceL0NzQFq/CTzEbQa07vc2tIKCWzeJjt//avoe/ODwfLtUZlHhRix+Ju9GFpeTc6iBQ8mwAuTqoCFLa8nmAy1NMzNQ6DmvqetEfaa8vWtrt0rVOcoVjM3fGz7tFpZ+i4BH4TbcF93GfGb2rvMMg8xbm4TYwBQ/QIPI1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779812162; c=relaxed/simple;
	bh=AU5W7YCm8SZxyBiqddzqQ0xr8L2My1HGCDYV50ol5T4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=skQcjtHIH7aDm1bXnnlAB+2ekJszUPtGPqqTPl/+2NwTyJKUvl6RWRcFTFhD67WBuuZQia1j+goWFlBGs2hQFKGVQiK1Ii55VCtCF46bMm7NSRZXfy5oVA98dvzr0Kw8tU7JC7JpWihcSm8olpx4hHHEWzMWP9GcIEGdyesZrA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=Q6cRBbjw; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="Q6cRBbjw"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
	Date:References:In-Reply-To:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=gkfx1feHM/Syhm7ZE4JCj12pIfIcNwyIct1CVIONKGE=; b=Q6cRBbjw0rbFxQmf+kKtxiItWn
	Tgt8cZNkZqmb58PXlK4E0aQREoFqv4ohymWA2jTZK5I+mxJptNQKS0kwq1ZaSVpLsN+yRGSYj0zzY
	v55LwyO/6O7u4mg0MDQUiT7H5F401tvQhq3GBKw3dkE/N9dpv1vIyA+b922DedVvDcqx7QciMARCz
	8EDY9beEdh1p6J+bprMSaNBxIoqGBAgc97i+PKYBCyUfYuYLy5Gbn6IM1Sgq02sK63cJj4Cu5OIZy
	31HrKVyTbAZeba0iFDJkU7lCRsaBJRx/wJs+2wWypKTRSSwugM2SohuXqE0h7IEp/ePqcwKvYo4qm
	CzCKrgBA==;
Received: from bl21-120-122.dsl.telepac.pt ([2.82.120.122] helo=localhost)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1wRuRh-008Vnp-UP; Tue, 26 May 2026 18:15:57 +0200
From: Luis Henriques <luis@igalia.com>
To: Miklos Szeredi <mszeredi@redhat.com>
Cc: fuse-devel@lists.linux.dev,  linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fuse: add fusex filesystem
In-Reply-To: <20260429102058.1362965-1-mszeredi@redhat.com> (Miklos Szeredi's
	message of "Wed, 29 Apr 2026 12:20:57 +0200")
References: <20260429102058.1362965-1-mszeredi@redhat.com>
Date: Tue, 26 May 2026 17:15:52 +0100
Message-ID: <878q96kuyv.fsf@igalia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Miklos!

I'm not sure if you have a more up-to-date version of your patch (or
patchset, as you mentioned you'd be splitting it).  But here's a small
issue I have fixed locally a while back, when I started playing with
fusex:

On Wed, Apr 29 2026, Miklos Szeredi wrote:

<snip>

> +static struct inode *fusex_get_inode(struct super_block *sb, struct fuse=
x_id *id)
> +{
> +	struct inode *inode =3D fusex_iget(sb, id);
> +	struct fuse_statx_out statx;
> +	int err;
> +
> +	if (!inode)
> +		return ERR_PTR(-ENOMEM);
> +
> +	if (inode_state_read_once(inode) & I_NEW) {
> +		inode_state_set(inode, I_DONTCACHE);

inode_state_set() assumes the caller holds inode->i_lock, so we will see a
kernel splat from a lockdep assertion.

Cheers,
--=20
Lu=C3=ADs

> +		err =3D fusex_send_statx(inode, &statx);
> +		if (err) {
> +			discard_new_inode(inode);
> +			return ERR_PTR(err);
> +		}
> +		fusex_set_attr(inode, &statx.stat);
> +		fusex_init_inode(inode);
> +		unlock_new_inode(inode);
> +	}
> +	return inode;
> +}
