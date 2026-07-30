Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0748144C51F
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 Jul 2026 16:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785428267; cv=pass; b=odAe8iksPqiyFTp1egFMme9bp8kieGsnnDYMzY2zHQwrCQyXpmrYxOmxNNs/Ba6OpgLnQHhTfgLLZzy8UIKzzG9uyiSEj9btzWgDQEyXcRwxH3iAHwMSqljnAQDLyE+TrLcFN7dFukPKM/cAKNSzl0mtFTrNlNswMmzxyPGnmm0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785428267; c=relaxed/simple;
	bh=y9uL8axv/bSBp1hJEk9/5EREqK5uThhZ6LCPv7JfjT8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pjUKAFxKyQff/YqcllRibFAwd2WEYDxHDgauwOWWgH3eiY/tBIc2UICZ2BzEBAPIi/UhzyglUCVFcP2wG/pZHpreo3cCqXYiTOnwC2MMUmpNIRY10U7qc5sUB2eGw8qlz0rTDztEz9BUPZUvZ3UzSdaEQy0D9aOZZiznEXTNMxg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com; spf=pass smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=MqCUIO9y; arc=pass smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="MqCUIO9y"
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-451ef88519aso7736fac.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Jul 2026 09:17:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785428264; cv=none;
        d=google.com; s=arc-20260327;
        b=DVVcWojHUsfzyxZL1lAiBEBYEw7ruiMvBCnitDXDm/0PcFOP/WJZ+FvuqWLKskpcW4
         vHSbUuqJRqpuoIFxhUgwjFPeJ8EI3wCADMhtAw9LtBHB8Xyil+rjSYduUATg6AjXCNDB
         bx28AKyjOcVpr0J768YEbmLS4FZ1eHQWbzrx4dZr10oWiuyJ86RW2y2hafspcZGC5ipr
         ik/kdlM5LJ5naIBVAKSMGpJWMqsNFncOQm6dJytdnGFLPnqDL8PWTDY7HYGmaVxmXIe3
         tSfpiPg/779TrzGilwwhavl6cIEeWrQD12UbaEQJTZoHcwLCuWrV2+vKQikb/xfipvnz
         Y1bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=y9uL8axv/bSBp1hJEk9/5EREqK5uThhZ6LCPv7JfjT8=;
        fh=iz7b5GjY6RyUdrX+GUTcTfcbPQP9XlkRSshdwPdvn5M=;
        b=WrzYctMdi/bNwbpmq2FfEpjRC/YeRcRn2zjjsVNp/YCCjHgmKmEMxkQFuR2e8qHs5j
         EXPZiPrjG1zdi5HFFtb92reiH8c+wOtG7bZ+mVm7EjeVpHF07cw9nIs0ffuaOZ1IiFkC
         6te8YL527dtTXi1H9PnZvm/vKGiVpjKtMNUr0cn7taasAzpNvFQqdGT6gvtRVlCIcdcE
         Htzx3HZDFxl+YYuqkPmLvIywTPalOf9EndTcxIWTknx+20xBbIHhNGz1ziWc/hFGjR7z
         P57aKPt72OgAjCm+vIEECBw4mFjVYDGWfr/IFed5HvzMQS706/pqyHRaPb3YFhXDrtfL
         z+iA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1785428264; x=1786033064; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=y9uL8axv/bSBp1hJEk9/5EREqK5uThhZ6LCPv7JfjT8=;
        b=MqCUIO9yyYJwHrMDdiejiNqcDHA+nR86bfqK9iKWYUvi4dsxosqLK1HYtjLP+5hW70
         k5P3caMtPDuMcCd+Q73b4jXiKqkWofjW7ZGye0Gp8XbL+MuQteuqTWNusN4S1MOtLD4h
         f043KR8DclrbfQVIx1LIlJafF4mkqxY53CJGgcgKSlzzpPwATxfWrBB812Z2bO/xO5EC
         elYoFSb15ifUMJi3Yt6rGgvVTnyac4gvXe8Q5aNLZI3twpMmhH335Lq9BUPv5Oxu/My9
         v6K4aHa0gm3jyf/WIJFeYkP3hvhEKOXplgljdRIOV2CPW6euwywntOV8pDIXxSVXpgaz
         L+fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785428264; x=1786033064;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=y9uL8axv/bSBp1hJEk9/5EREqK5uThhZ6LCPv7JfjT8=;
        b=iDz7dvpWzFxwmyk5LP7joxz7rhKkv628wdTo172gr6HAdaLkxVveT8XO7eyICn4PkE
         7H44wRB+a2/y2ywEUpbYQ85ae6zyHBfv5qk1fXcbK2OLX6H3ggjlF/HppbXpjSBC3VbO
         TCVl37MYKIIMMhNytIsv4AmlN+dSlmN3tBWomKvcMMGIIcd73ZOZnvBIlmcBMlGuRWtO
         IzP1+p+QF/FakwuoAHFxMzBAnQMlSrYh3Nc1KZjSnlfUGufHifXtkfdmDq45PdTaYfRm
         7Mu89wzA6j5Zrju7o1h/GZv5Cx4zzszuMr8iMEa8FZg553LgIieASshUg9TskQ/RT4IF
         pcYg==
X-Forwarded-Encrypted: i=1; AHgh+RpCZCrlAJE62rAKWK2d7YwqXUBWIJ36KSIc1xIYEjWFEl+PG1EHnjMtHX+gTvXNQdHjG5Ya8vpcZvbzUceC@vger.kernel.org
X-Gm-Message-State: AOJu0YzUh3fGReFsJ43FXtJRVira7Ul+/jc5FlH/YrUa8pitL45v6l1y
	NY8o9MSHHwBIgzVUa/rlIW6MYdh2cXTUvysL1IMa76tdx85xYViyQ8QO84Bs+UxUtV6NN0Pt3p2
	ZX0FnLOMUZMd7/zoYDlijh/HSaFlMsaJxaaX7fkGeYg==
X-Gm-Gg: AR+sD10wfKLPyU7Dq2O4+tq1+NQzxG4WDSQX4EhnythrJs+YI2xHGfYrI+iGC8bXvOP
	DC6fnkWCNSylO7ANyPFdq84lGKi/loMGnlh4u/0iGvgEN/UA06lbU04ZxhST7aipW9YF4H88BSB
	eCwCBQI48e07vFYK6igAQchRE7scsoYZYm1wpUdnEQvOn3j3DU82UcvREjutOWoU4E1HsDbrV1t
	BBjQuQP7Tp+IoeMpaug1y0xIdm8DCPZotoiVjJpHRu7rm8aNYfuw7ruuhH7Y0qETlomS8ZTJb9B
	mzyBa07njCCgWIp3QI1PC4NGsaRqaMHlXQNr9tneqt4j
X-Received: by 2002:a05:6870:610c:b0:448:8595:1e8b with SMTP id
 586e51a60fabf-458dd203cc6mr828125fac.4.1785428263717; Thu, 30 Jul 2026
 09:17:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1785274111.git.asml.silence@gmail.com> <19e5c945ea8114320c10f7951d19197d48b59249.1785274111.git.asml.silence@gmail.com>
 <CADUfDZpwF0jp2e=+c3w_NjWPbnQ858bkSD731M6+x27jzgcJiw@mail.gmail.com>
 <CGME20260730104131epcas5p4b52720519486f7ac774c317923a79c81@epcas5p4.samsung.com>
 <de4ec386-42ba-41c3-bcbe-1fe8b2f71ba9@gmail.com> <09134617-6d9e-4963-9319-1855e88a4df9@samsung.com>
In-Reply-To: <09134617-6d9e-4963-9319-1855e88a4df9@samsung.com>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Thu, 30 Jul 2026 09:17:31 -0700
X-Gm-Features: AUfX_mzVuCLkHKoQjKU1BgpL-X0Ty4OF1wEt1trnCKGouEKw-m3DZTMxHTHiuQw
Message-ID: <CADUfDZoVUHMWK0KBnznB73o6Vg+iQBBzJE2NmF1Tf22Zvh4=Yw@mail.gmail.com>
Subject: Re: [PATCH v4 08/14] nvme-pci: implement dma_token backed requests
To: "Anuj Gupta/Anuj Gupta" <anuj20.g@samsung.com>
Cc: Pavel Begunkov <asml.silence@gmail.com>, Jens Axboe <axboe@kernel.dk>, 
	Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org, 
	io-uring@vger.kernel.org, linux-media@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Sumit Semwal <sumit.semwal@linaro.org>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Nitesh Shetty <nj.shetty@samsung.com>, Kanchan Joshi <joshi.k@samsung.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Damien Le Moal <dlemoal@kernel.org>, Alasdair Kergon <agk@redhat.com>, 
	Mike Snitzer <snitzer@kernel.org>, Mikulas Patocka <mpatocka@redhat.com>, 
	Benjamin Marzinski <bmarzins@redhat.com>, David Sterba <dsterba@suse.com>, 
	Ilya Dryomov <idryomov@gmail.com>, dm-devel@lists.linux.dev, nvdimm@lists.linux.dev, 
	linux-btrfs@vger.kernel.org, ceph-devel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 30, 2026 at 4:36=E2=80=AFAM Anuj Gupta/Anuj Gupta
<anuj20.g@samsung.com> wrote:
>
> On 7/30/2026 4:11 PM, Pavel Begunkov wrote:
> >>
> >> I wonder if it's possible to perform the PRP list page allocations and
> >> initialization in nvme_dma_buf_io_map() instead of the I/O path. The
> >> NVMe dma_pools are per-NUMA-node linked lists protected by spinlocks,
> >> making them significant CPU hotspots. If the dmabuf registration set
> >> up a contiguous DMA-coherent list of PRP entries for the pages of the
> >> registered buffer, any command using the dmabuf and requiring at most
> >> 1 PRP list page (i.e. length <=3D 2 MB) could just set its PRP list
> >> pointer to an offset into the dmabuf's PRP list.
> >
> > Possible to an extent, predecessor patches tried that, I left it for
> > later to keep the series simpler. I guess chaining won't work in
> > general case.
> > I mentioned this to Kanchan, Anuj and Nitesh before, they were up to
> > playing with nvme optimisations in general, and since sgl from Anuj
> > is ready, maybe they already have a prototype somewhere for that.
> >
>
> Right, I have prototyped the PRP list optimisation before. I will send
> it once the initial version of this series lands, to avoid adding new
> review churn while the rest of the series is pretty settled.

Sure, landing it subsequently makes sense. Glad to hear it's already
in the works.

Thanks,
Caleb
