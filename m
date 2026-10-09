Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AF674A99A3
	for <linux-fsdevel@vger.kernel.org>; Fri,  9 Oct 2026 10:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791542415; cv=pass; b=FG+3UlnNAdZIi2lES2PgMFcEn5tsndGtaMjt+FcDszibPxzB4oeVnl7ICB8QHTRdl8pl7oNY+tmqIoEkgCCogpAEkV8VVfm8JwylD+LIPTHRaH9a9uNR5bEYBJy8N5p+K6vJYWRYIT0St4Qx/Qvv1W0NHH3h6zAv+Al2lbRmmkg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791542415; c=relaxed/simple;
	bh=TdmxEYfYtkSXgsQopCBGSZ8pT5p6msP1oRfZOE4Yi+A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fHV7CxLzqdLnpO4MyCLSwUuM5xCIKdhXnYQK5xm3z67zJ7RYHCgw2wQJwD3mAx1+P6GM1wpQWiMBVHOXKzOQy/NIePfm4586Q3OzB3lnu4/c/0BDGZOdDiBpcIGeov2MouI9S8wQ/IBNvc2Ug82Pr6+AjbQYy66xGh3Py49oD34=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=DDA3cB0o; arc=pass smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="DDA3cB0o"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-534e6545939so51053761cf.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 09 Oct 2026 03:40:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791542412; cv=none;
        d=google.com; s=arc-20260327;
        b=jppFNX8aEzbaveqVlWW9W+rvdBDt//qMPSfsEkM4IN5xaIg9gGjRX1LSbu7IPLA+kU
         gSqkG3OMllrU6i71TKAoWXxOq/iKD3APgGliM22i7vzW7ZbbKaQTGjEHXMEAzywNAwCn
         LICDl58fJNTYRCQ7rz1GCRJVc5nBtc3uchcMCx3CnNu/j42kRmc1g8kwaobkcRo3UhQD
         98Kx7dnfQKq1jBj+KPWuAkuph+aZPLQEWyYqaHWBQV/v9umuLZJ+ypyuTES5YokGBgWK
         vxp4iQSGb5ePko5DVLU4n3bGmBWSAesl03nhuZCPuaf49zriYv0XCPDV6J/ipd0bucCA
         ERUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Dj6hvZEw0Eh9ZS8EwZEyRVpYOqz/OSg7EGiwmx0le9o=;
        fh=VNprpeCLKP+nHPiQM2YadD36as1HgKqIIIh9LOe39uo=;
        b=hMjrovTcViIs7iBvbfzluvs3n/MNoAxVmFF6m0bol1zTCfUDA/0wdZzCag7k2o4nmA
         jZz6Rz04ZbtIkljng9OkSeVeCjbIRdt9ZMmjZ4F5oXX5TnisWnKQkRJ0gaZ2iNcidA9L
         HP6U07W/DMA8TrvE4RVxDCYiUZU89/9Uu7t0LysF8HGgnep6Pb4NNJyvG3Szw7EPoI/u
         jz/Iky1e3kybElJw+f3hJNfUh0Y9HiC5MPoSRbkamqbgu9yv1TQNEek5y/mv1V57WISX
         dc8mQQ142T+r6zv4GRbsK39cRuxhIGZEFkVBvyZ8eELMI+b6eh0GTvx470Jt3N78XUD2
         ZGYw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1791542412; x=1792147212; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Dj6hvZEw0Eh9ZS8EwZEyRVpYOqz/OSg7EGiwmx0le9o=;
        b=DDA3cB0o0DC13qJYpeL+4/H1ljU1MtVA9XxLQkxZeSgo33uuIJueHOkp9Eg3a+E1AO
         G2uFyIbx4RYgCNHtGFHxJNySbUVdY+YQsgsCDHJ7+xosLGHa/HpUco9XXgWzI3l5m50x
         aOpNr1KWp6XoaeEOM/DLUge8b2rVpwhPYGFVA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791542412; x=1792147212;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Dj6hvZEw0Eh9ZS8EwZEyRVpYOqz/OSg7EGiwmx0le9o=;
        b=EzI9762yRUpTF76GJxcLLorYDCj3EbBrIUOQOTqgFS5/vwbPCVOWj5o+7lVQ98IRpM
         /Egre6BOgJhm9oY8VBAtKz4zbRC5iEGQdtR2uV4zbWyI2GfLHSR1Wdneq0x8exxw424B
         q/N5MT4ExDWXYE3cofs/GPNWlGHTEDRivbWozCxP3YAKwJkccwVFtHFgYk8oGdLX8Nsq
         nV2d/L0lB2JkZVoLN09NBm8eVNfSpDvUDYDTRhbrRGCoMDvk9nvQCUeTHc5o/J+QhX2C
         KDwfswa9JRI/plCIuIdeCXoPMyzjn4PHJbZJuJwHDF5kaGIRBBBhgTZS+d2AsL26w/Nq
         YmJQ==
X-Forwarded-Encrypted: i=1; AKwUvBzvW7iP+ZkVJxIsoJLBst6R08khYplPaST9W74KlBzBnfk/9TwnJkmP9UK3s0G7oaUVFR/3lkpjshB9oA3N@vger.kernel.org
X-Gm-Message-State: AFuF++nmizsvBY9K8XVRib0xyO7zMxjy279jjKuSWwXjPsBEFyoMeHR9
	XNogtRRKH16De+n9MhOyTvc42EXhKqCaFH6cz9fnHwrejt9ikLX9NkCs/x28Rh9iyNqUBFDPCve
	J1k5f+tgi2OCOxn0mWHvcJk0YUx9gbxvYqbk5xEcUhg==
X-Gm-Gg: AYBFou0shpkp5uAp/80UO8LN9UnnU1Lsn+0MZbJx8JednZXcfG7PLJUU7OUqqeSPPIZ
	zKQ3CNkYeG/ji4JUVOxxFGD48Y6bttbL7N2GxIMva/RILlS2kz5xdTxDWWp09Iy7mbb9Ztab/78
	7X6tQvezXfYHmOrsWtHI2/OLv8QJ0P4S141zmjNhkPmJTYiaYA6vKUmaxa7Xz2EpVUO5bElrN5P
	mj9ZGBpt4Ouh0+D5RKAMoVWl0g8/XFC+Xpn1LU+BZqG9yvP0sjGUiifN08S/jv/Nvj/XP5xY26D
	lN0LggPQh1yb3I1SefG2UaX0b4Ju+MVsDNuzZ+onwIB4vk/5CzrqOBV0YnVaPo+XXogkpQTrWiN
	84ESS+SzP/uBC
X-Received: by 2002:a05:622a:54b:b0:533:6f90:9e7e with SMTP id
 d75a77b69052e-5359fa918b1mr20240541cf.27.1791542411710; Fri, 09 Oct 2026
 03:40:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261001150935.655979-1-mszeredi@redhat.com> <asQcBebepPb9CXzS@groves.net>
 <CAJfpeguEUTYk9m7g2gZTMui0yFDYWSGL1SZ9PvoYiCqjDmHp9A@mail.gmail.com> <asZcsPT-Q8qga0SU@groves.net>
In-Reply-To: <asZcsPT-Q8qga0SU@groves.net>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 9 Oct 2026 12:39:58 +0200
X-Gm-Features: AclHuK9bZ1vBizXVx85EODvHCHAG09uRctj1VxFiQmSS5BJHJIYfB0DeoAwYH60
Message-ID: <CAJfpegtZvQsu6gD1-zXvmELcu1-93ZKKEdKHMXqHzChgd_TXKg@mail.gmail.com>
Subject: Re: [PATCH v2 0/8] fuse: DAX device based extent maps (famfs)
To: John Groves <john@groves.net>
Cc: Miklos Szeredi <mszeredi@redhat.com>, fuse-devel@lists.linux.dev, 
	Amir Goldstein <amir73il@gmail.com>, "Darrick J . Wong" <djwong@kernel.org>, 
	Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>, 
	Alison Schofield <alison.schofield@intel.com>, nvdimm@lists.linux.dev, 
	linux-cxl@vger.kernel.org, linux-fsdevel@vger.kernel.org, david@kernel.org, 
	willy@infradead.org, brauner@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 9 Oct 2026 at 01:00, John Groves <john@groves.net> wrote:

> Fewer fields is nice, but it's on the honor system that the server allocated
> large enough strips - since strips carry the chunk_size rather than their
> actual size when CYCLIC is set. IMO it would be an improvement to add the
> chunk_size to the header; then the strip sizes could be validated.

Cyclic maps could easily be generalized to not require a fixed chunk
size.  Giving a different meaning to extent length (strip length)
would break that, it would no longer be a CYCLIC map.  It's an
un-generalization that has dubious value, since the strip length is
implicit in either the file size or the parent extent length.

In other words: make the server validate the strip size, and all will
be good.  The kernel really doesn't need this information.

> So that's a bug. I've fixed it locally and will share that in the next day
> or two. I also needed to refactor your patch the famfs user space because
> it disabled ABI compatibility with some older versions of the famfs kernel
> that I'm still supporting users with. If you can wait to patch that further
> until I share an update, it will be cleaner on my end.

Yeah, thanks.

> Having said all that, this topic seems to recur and be contentious - we are
> working on tests that can demonstrate bottlenecks - but my current ask is
> that if I can offer an alternative approach to rbtree that is better on
> paper, can we please use it?

If it's not adding complexity, then sure.

Thanks,
Miklos
