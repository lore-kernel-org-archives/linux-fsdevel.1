Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C32183CF696
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Mar 2026 11:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774438890; cv=none; b=ruKY2G8tsjwPRKac/1P7UE5mLOBDsdmcCmnhPeONl/sjJz+DWlsYQq1cBBiDlIhbYnX7bGbPnKOMPEXAY34KbT6xm8OqnL1lYLss+Reo40UmSGPfePn4XVUkemg6KQlBcTXFkxr1V5jIPUeMLcBlR6Ji/s8j3C6DYZ24AfpNgCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774438890; c=relaxed/simple;
	bh=ld1uLQcQ3wX/aLoEZ5yp05fFuiyLeeDey5H16fj3er4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UOehyJOraVJFK+N+lGLzoF9vI5J0MsV8ZTmJPuJMSOb6FNFfbR/Ga1oXBj24qIewMFbOqyYbjeXPmHs+occ7D5cv69Flkt1A5WLYw8JjrH3jWWrUc/HH38moQFcyMbQ10+W4IbWKC75qUmxG0uT3IUYoRWIXztoou6pzEy2SbRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DDvTXjRC; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Wtu0JiVD; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DDvTXjRC";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Wtu0JiVD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774438887;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1xEylKt1sFxQZZ3xBGKJ8RdOSFC0up8CAh1cSzczQVQ=;
	b=DDvTXjRCLDCCS4trYcp+pAVduQSGMylrjzsH78P8FZzdUJvyiV8Qe63f6ett9xA89J7oem
	GgEPuSI1XNTz764Cuc7E5mLW+I9RUtzbsVY6M7F5VZsZTlSMIR+ompFNA9pAdRyCTJKCXI
	aHwYnV4lpkn6MhZRP+U6f+CAHgqci/s=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-635-h5nqpGG0OZO6_f81IJ01kg-1; Wed, 25 Mar 2026 07:41:26 -0400
X-MC-Unique: h5nqpGG0OZO6_f81IJ01kg-1
X-Mimecast-MFC-AGG-ID: h5nqpGG0OZO6_f81IJ01kg_1774438886
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-439c54e0f6aso652402f8f.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Mar 2026 04:41:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1774438885; x=1775043685; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1xEylKt1sFxQZZ3xBGKJ8RdOSFC0up8CAh1cSzczQVQ=;
        b=Wtu0JiVD+ZOnT8ETY7g0l1DNXcvTd6DywMQLr7hyIW1CO08TGRi+GNMzqixlDsdJRn
         evo01Jx/JvjGV2xcuVSPl8G8gzr8uDz5BV7BI06o9xCV7hU0tIijYgduj7dnV7gqb33W
         HMIDfexok6vAjCZ4n7eyruOrA+GKKYec8uV1he8WsbyeA8hIkiWSoNsVs+iQcmOyby4A
         XKHmYnkZoa/MRTLcfWGONxYkUnaM/+7s5cqgNsC+ZoQxS4/JHwDHea9xQA/URDgwvPH2
         p1P/ocOm+ERXwthsQV2plkzwM2cUJuEJW/cYgPFL43T+fZu8rqYjt6oVfx0vN1yR9e5F
         Bmzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774438885; x=1775043685;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1xEylKt1sFxQZZ3xBGKJ8RdOSFC0up8CAh1cSzczQVQ=;
        b=TndjBfEIfU0oYO5Rwcxmi3u8rxgdvmIGSVJsNpglVp8Js4IMv2+ddseBFX5AfpXtvM
         0wnWu2kjdTURt8vGIItQiuM1/G3IHiBSMCSFFcAc+EbU6qk5hNfdiElnhiBYw/8emz8E
         vKBO1HgKpedQ2oamSWeMb+mtwoXUp71xfhYIUFCik4VWo/OhbVLP2OKjQ+eNssutIJZS
         dP9ycv7zW4l9cQV7M6AJXoI1HUaWL8MT3CG0zrOQPLrgIcSxPU1QieNy8NnafPlNeSaL
         XhkiIlNBQKS+xCI4Mek4RUD8S1ER5xiZFXra8Ad8MtlnvMnco3I1wdJ7YFKxLucwqg56
         PyzQ==
X-Forwarded-Encrypted: i=1; AJvYcCWxYh87mwK31aJDlS8x0iCKGOr/3FaWQq7Gln7api3b6KcgqIigR8hraDxE55nrzQ72iG1xXy4c4ryGQ4aR@vger.kernel.org
X-Gm-Message-State: AOJu0YxC2dNTn7tST82vMSKB0WIxjrgh5rA7lBtTdIVpXfDPFilB5wqh
	mkgir1XQaW0G37Zy5KwLDoWitCTwU2u/IwwcxN52YYGBAC/hxyDuR0zWp2+fMrb2M2zKqTUB4m/
	tcdm43nxIV9LaE25U6AApAiKyhY5XUZS1lkX9OBA5MSOGoOP6dcQxIlfZDDFV4zsbECNIQbxwC6
	yg
X-Gm-Gg: ATEYQzyiluCLDEswdsNwOTS1yCwMdT6CrlOrTfohYjqSl7alMKJlTmbfirJmYWXMy+0
	k/PAmjaHT9/pHOVkGjK2PeiEftcApYwvkqfFp7TR0vzGWoYFf9V85TRZ8JZjpt0Cb+1VpmNawUv
	cJelnq0/DggOQiodr8/Xs3rp/RBSqi6LfZ4bu4kxNb/jsBd4MELYDAevkW8Ql/GX63PslHxSAta
	KyVGAyGMUMMSl/e7g9SyFVi/aLZvrV0Pp3qXFvOpCMVAqfYfity/1HGEHpYtXzHDF+LNucdvuRs
	26Vj5t1gB/iXOeM/i0DidzCmHrCcBGy57z0xUQhxkCVugQKoRi4bwUk5RDAJu+QnQrz6Y/nYDmX
	nZhXVG24JN0HW3g==
X-Received: by 2002:a05:6000:2a09:b0:43b:425b:ec3f with SMTP id ffacd0b85a97d-43b80526465mr7202975f8f.4.1774438885303;
        Wed, 25 Mar 2026 04:41:25 -0700 (PDT)
X-Received: by 2002:a05:6000:2a09:b0:43b:425b:ec3f with SMTP id ffacd0b85a97d-43b80526465mr7202929f8f.4.1774438884770;
        Wed, 25 Mar 2026 04:41:24 -0700 (PDT)
Received: from thinky ([91.245.205.131])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b6470c239sm46289550f8f.27.2026.03.25.04.41.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 04:41:24 -0700 (PDT)
Date: Wed, 25 Mar 2026 12:41:23 +0100
From: Andrey Albershteyn <aalbersh@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Andrey Albershteyn <aalbersh@kernel.org>, linux-xfs@vger.kernel.org, 
	fsverity@lists.linux.dev, linux-fsdevel@vger.kernel.org, ebiggers@kernel.org, 
	linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, 
	linux-btrfs@vger.kernel.org, djwong@kernel.org
Subject: Re: [PATCH v5 01/25] fsverity: report validation errors through
 fserror to fsnotify
Message-ID: <3lllvimldwcgi7crh3kgwy3a5z2ng2ugcka52ab47o5mwx4dnu@xyzbelhykn7n>
References: <20260319170231.1455553-1-aalbersh@kernel.org>
 <20260319170231.1455553-2-aalbersh@kernel.org>
 <20260325075402.GA952@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260325075402.GA952@lst.de>

On 2026-03-25 08:54:02, Christoph Hellwig wrote:
> On Thu, Mar 19, 2026 at 06:01:48PM +0100, Andrey Albershteyn wrote:
> > Reported verification errors to fsnotify through recently added fserror
> > interface.
> 
> Looks good:
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
Thanks!

> 
> Btw, would it make sense to enhance the interface to tell why the
> data vs considered lost?  i.e. checksum failure vs

> (part of) device disappeared?

isn't it something filesystem should report even before fsverity
gets the page?

-- 
- Andrey

