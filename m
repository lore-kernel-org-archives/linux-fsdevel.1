Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=170.10.129.124
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795047921;
	b=YTcpyJh7cdaCjKMAbOVzWsptvXUyrNtOdHnC4zrE6iuEeS1ye37RsVdtca+olOgxHi8p
	 HnZ9Z/KpUP8HyngFDv704xyyeQuF1Kc6tFFz3DJRA8Z2bvRXiabSVKI5jli+gg/d7wCMN
	 vLQQvX7cgeCvCxhtkUsWNmOBuughIeppZrF+ypfnVWW9q3fWoCGSNNvUMdS0TkbVJBmw1
	 6ZiqqpL7Ksze3TekitvWpRHG1aRsC0toEjus1tVhNPhfIkqq5PLDNRRZZcOxVQWjFnEM1
	 qxar/CNUbyIAhBL1RNJEh4uhZgvKnmmcQ1vAYKhdpPI7XskAW9H9+7oB9qhWsB02ZYQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795047921;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding;
	bh=M4+iI66pVBP+4vibL3T75xrw5k3lOfdLMjtLDFVvV8g=;
	b=rUWVLruQXHvHusQ+ZsB2U+eKftDV0icNxdOwWC3S/2d6opodQW9IWlZIoijWSlbb0vHX
	 NYTvG1zbzxIm/6N51xigV/THpQGRmYxW8cU9G0wP3fdo4M/PHcmMmaEF7ZcekOnbkfQvz
	 9oDiSABVJhQgm/iiBp4K/QaNP8ZllbLMa9XbWudNQNZ27spWgwIWZM5wIJrFXTilYPpKX
	 9aNp6FnGaH2+y/2CU5FLlXJfsx54qqtzXouTNsafJzmoM/Kh96s0VhUgNLjlBatuQem58
	 T5L38sMOYsPiYWQIHCjL9m2+FydboKYAaLJEnV64/ZXGHRlcsq47NRf+4527azL00Hw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=figiuMqN;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=cFVw0AE7;
	arc=pass header.oldest-pass=0 smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 545F060A2606
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Nov 2026 00:25:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 545F060A2606
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=figiuMqN;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=cFVw0AE7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795047919;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M4+iI66pVBP+4vibL3T75xrw5k3lOfdLMjtLDFVvV8g=;
	b=figiuMqNPSbJSC+rppKYW73jTrxg0F5RFlFTF8isncIxQMPE1WxN7Bn1FHZTvLkpofJq4d
	7m420J1xkEdKbn3Rcx5/MaC0RJqvUstWY08DU3pgmjHol80seQFiw6J/Lwkk9/s2t1SRbD
	9rIFexGnSFloom9KDpPKlHqDR/WtULw=
Received: from mail-yx1-f69.google.com (mail-yx1-f69.google.com
 [74.125.224.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-437-mQuuzsyYMG6zG7pLRdzNgQ-1; Wed, 18 Nov 2026 19:25:18 -0500
X-MC-Unique: mQuuzsyYMG6zG7pLRdzNgQ-1
X-Mimecast-MFC-AGG-ID: mQuuzsyYMG6zG7pLRdzNgQ_1795047917
Received: by mail-yx1-f69.google.com with SMTP id 956f58d0204a3-67c041acd09so2332014d50.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Nov 2026 16:25:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795047917; cv=none;
        d=google.com; s=arc-20260327;
        b=sJFlZzVr8NVQP6UmIP0LNH6cfHDZZ8pFUd3YVM72m5MDXbEF1tjaGOunTYdS7x10kX
         VmjGVp0NMRK3L1/FpdmHS0qThJMS8KYdi6/7SDLDxONAT/8HImMuWTSsgNDzIa8+IQHq
         vhCDZ9KxNco/nTzDnNKufQcrFjf3IytkacShaaaXG2zyuXL5pzOX8N4MXih9QG6etaiS
         vU3/qKXRSMEP1U6vD5iYwCfAwOK+pc4AMDzqzTE5lDmCLQFXa4hNTHxbQAz8jNYIbFhi
         R+88YyOByGw+mUIWJDEIMLOfkOMjd4CkP1PIGZegt1wxyb2Cr0bW1ZY4vB904+6mySzU
         xgGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=M4+iI66pVBP+4vibL3T75xrw5k3lOfdLMjtLDFVvV8g=;
        fh=tF73TaAFP1cCSR+l/vtg/Jz7Cf7duuKHVJ+ypWGnmow=;
        b=glB7gRjq8JpoH0ntDDgD/y7EDXb3axYqr0heDuI0E8Q79MVhAAwtVB6MULgqxdDRIC
         sZU90y48MI6Ns8Tl4iWxoVn5QYPfHeLnrnehZH1DeFIHgD7DFFVrje36WRx3pYKWGKDH
         QnlEz0dLu8zVA4rLks5McYpPePB6ezzCmK4hX45RzvPkS4YBNeSRzhOyrYhiPrEfC/7U
         z4qIPet9l+C+owsAlP49AatqTuuCnXv4KFfwVR/1o3fLvi1l2Kb9rvvLoU+5JsU8a0O2
         2BCG1L4b+JE4BVv7/xj0wAedyrJUKQgNs9HJzHmUfD2et0vBptDoVLOlFU4Q08JTFYhS
         WjEg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1795047917; x=1795652717; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=M4+iI66pVBP+4vibL3T75xrw5k3lOfdLMjtLDFVvV8g=;
        b=cFVw0AE7k4Sx3klhOI+hIwBtN7pzKUDLCwxIvf1GwEfUyqXl+PBjIT0RRQORJGI2M5
         cr2BBRmZtSCGNDYE5TPt41nwQkXbpYRg+5nucbc1EyR77axD55D/rR3B9wEO/uO+mByo
         19pL3U/soO/odNlWuJH9T++t7gllhpBDYBkgbumJk/d3GIiLVhUTgGFX/u2cI2o7FltH
         /behdt6HVdhB8gjxhLqdWz+ZcLdeAisVvcqYEqfwiIRg9p2BYheknbhM2KU7DM5iRlJe
         R8KwC8LwBJEykAvLNnC6BIN3sAPeAHyzoBlzurMX0iFs/hlpJIP9XFKvRiilgYXmDhGt
         x1Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795047917; x=1795652717;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=M4+iI66pVBP+4vibL3T75xrw5k3lOfdLMjtLDFVvV8g=;
        b=18ybEGyfVzOtL30ccx8JhCCsJH41n5DjcHF2nBeYHUylBLjxlWxk7w9LooMV8jJJQV
         xfAT/3JFq82FNcG/G+csP47sKIHorFUSalSnQVCvD9apw85JvKczUhR3P+pFeVXcfrWL
         M3O/hrWvvPkJh4RGjF7XWnMtLu8Q4BLXUk9HOAPOKTm0u5FwMpdqQRapGQU/g5xK05T7
         qv0Tb0Qm+sEmyXfp+Sg1R3IiaOMcJyFZZZA4JeIXpPQmGimD41mMA972xSGdcLFwllPI
         VLXgu8JM9oiMXgNEA4T3vUYarIk3yuHXgsoLjt/v9VDl6TRCMzJNIC5MAE2wHeGKPORZ
         XkuA==
X-Forwarded-Encrypted: i=1; AL+hErGzv+NYNvygSsfxIOwD0NQRJeqZM0Vc0t/I924rPQGJZbrlqA1bTHMXX+QtJJQFWPyWd6kYBoqYkaVE9KeT@vger.kernel.org
X-Gm-Message-State: APuU4Z+j3M0jxjxJqUgAGESvLWuRTaa0m6w+r5XGpOxd/yICZqEhx4IO
	1KPxH/TNHSsbIinl37UCukHGJD+0ehkzX/4U9N2WRf6UtPQysN9rusuzH7jo7x3JcrphULgLzGF
	LSDU+7oTK7tAp5VFzGNidtb6v9ROKdhPwXOkhr4mrFKY9IZhX3HmI4eZH7UM8+NUMk7xG6U58ZT
	4R5os+5837DCuLV9VhU+nX7Sa+iPIHHWU3888tTS9YIQ==
X-Gm-Gg: AZFdTZcIrsArFZ1NwV3553XmOuoqXvjS73tKUeaetK40lDp6FKHYFOmawUkUdzEfgF6
	PjYMbDzQl9E0ovXcOaWCOD/XZ0FjehCOE8h8zn749faiZ8DYalBC7YO7w9diHpiRxnV4f4V5L+P
	gRl8xKo9GjhDSOVwSbJXibF4rvytq32LN4UrMDdZ+RzonDVaE0xGd/P0aIgR/7sxEensqW4h8sL
	4gVI8IdLaoOxUc58JKi3N2pkliCcAYlfFe8xRqtyURFJw==
X-Received: by 2002:a05:690e:1553:20b0:67d:b309:a247 with SMTP id 956f58d0204a3-67dd3f89d1amr1300396d50.81.1795047917453;
        Wed, 18 Nov 2026 16:25:17 -0800 (PST)
X-Received: by 2002:a05:690e:1553:20b0:67d:b309:a247 with SMTP id
 956f58d0204a3-67dd3f89d1amr1300383d50.81.1795047916923; Wed, 18 Nov 2026
 16:25:16 -0800 (PST)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261116171044.6938-1-jack@suse.cz> <20261118145941.1063127-21-jack@suse.cz>
In-Reply-To: <20261118145941.1063127-21-jack@suse.cz>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Thu, 19 Nov 2026 01:25:06 +0100
X-Gm-Features: AclHuK8SUbQZgISlLcenRaPXTNhazVJfuhMt4GCT6fjiABD73HgWRuB83sKw5Dc
Message-ID: <CAHc6FU7qgJ1R-bz2icUyQTQFs7_mKt=tat-ut66K-cgn-uet3Q@mail.gmail.com>
Subject: Re: [PATCH 08/13] fs: Provide inode_or_folios_dirty() helper
To: Jan Kara <jack@suse.cz>
Cc: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, gfs2@lists.linux.dev, 
	Mike Marshall <hubcap@omnibond.com>, Martin Brandenburg <martin@omnibond.com>, devel@lists.orangefs.org, 
	Dave Kleikamp <shaggy@kernel.org>, jfs-discussion@lists.sourceforge.net, 
	Carlos Maiolino <cem@kernel.org>, linux-xfs@vger.kernel.org, 
	David Howells <dhowells@redhat.com>, Marc Dionne <marc.dionne@auristor.com>, 
	linux-afs@lists.infradead.org, Miklos Szeredi <miklos@szeredi.hu>, 
	fuse-devel@lists.linux.dev, linux-block@vger.kernel.org, 
	Chuck Lever <cel@kernel.org>, Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org, 
	Eric Biggers <ebiggers@kernel.org>, Jaegeuk Kim <jaegeuk@kernel.org>, linux-fscrypt@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 18, 2026 at 4:00=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
> Provide a helper function checking whether inode itself or some of its
> folios are dirty. We'll use it in filesystems instead of direct i_state
> checks. Note that this check returns true also if only timestamps are
> dirty when lazytime is enabled.

This is confusing. Can we just say this here?

"Also returns true when only the timestamps are dirty."

> This is what users really want.
>
> Signed-off-by: Jan Kara <jack@suse.cz>
> ---
>  include/linux/fs.h | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 025f5d890689..f602deacf953 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -2228,6 +2228,13 @@ static inline bool inode_is_dirty(struct inode *in=
ode, bool datasync)
>         return inode_state_read_once(inode) & mask;
>  }
>
> +/* Check whether anything in the inode itself or its folios need writing=
 */
> +static inline bool inode_or_folios_dirty(struct inode *inode)
> +{
> +       return inode_state_read_once(inode) & I_DIRTY_ALL ||
> +               mapping_tagged(inode->i_mapping, PAGECACHE_TAG_DIRTY);
> +}
> +
>  static inline void set_inode_metadata_writeback(struct inode *inode)
>  {
>         spin_lock(&inode->i_lock);
> --
> 2.53.0
>

Thanks,
Andreas

