Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DBD021638D
	for <linux-fsdevel@vger.kernel.org>; Mon,  4 May 2026 15:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777908617; cv=none; b=YhT82VQ3jsfTqLIGZPi6RKIIi+dNZMi8q9F3WfvN4mLcld7EYGUKZAUMpRmj6FDiBONTXZnayCgE0pDsKhoF8fc8MxhwzA9KCjTZNSIhdE5l9H/JE6gMyViFzv82WdLhP4gqkXMoImzpFTvxCPeGsqlE4iAbiYkWAI2gfYb66g0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777908617; c=relaxed/simple;
	bh=6QwUQCcZs6tvnhRhV82Gt4iwhALrIcfYYBRUBpS70Xk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rl6p0gUqxibx7tIPeS8hmm9jEaSyNbFvNxfSF7VLbEXtP6nmghkOueZyxNW/rxIbaQoYamqp/rTOuvH3LN7wjJeBKTsbrR4Rd6fwPtwjo/wvDm7vrhXxO+lskNES1rC5CghiSzJ8tZc2gAFMebsjS0TOX9LD7Nllew6wzwaM9T8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KRCydiHt; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KRCydiHt"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-488b0046078so34723645e9.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 04 May 2026 08:30:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777908615; x=1778513415; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JTReAJBRtrEN050pOinCvG1qLugpFlFxRiDBF5vEgm4=;
        b=KRCydiHtndzdGf5TkyPWPK008OR44tmdTzRSw2JTkci3b8zxWdo6LUsffiYnvHOIHZ
         byvbAFU+RxD4lCtq0X+S2IM4H0QbB6OZMCBxc7pin9y6EX+SuPXA5gMhhWyeXfpWAAV2
         Ks2/rvJXblg6QPna/4dBmIaDduBtVsMUv7M+b8K74EgNRC5F6jdMSS0X6eDO4NIB2O8E
         FByWC3qNVSk5GNL8bwbGWbQyiohl2FuRsikc2DbQXJqAFZMniHDWsJjhrCZRbrQpJSz+
         eFYbBUm/AxpKp0NDVg0mO4O7XcgZ22nVwUnW81OZx2sRwS1e6QUjjoB+WkcRsrYrQtxs
         dBJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777908615; x=1778513415;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JTReAJBRtrEN050pOinCvG1qLugpFlFxRiDBF5vEgm4=;
        b=gMXkqTvhgwqJQppK415Q0xrd8qdKhoy88heayHDUN5fkiSEff8WH05PI5UP5nc5Gvp
         6q+hyWfYKhwybjIEcpYlTy6U4lJrDFeIVLyDHb8Aw5eKI/CJTTbE8c7TlFzE1h7QOuOZ
         Qoop6/REvpJrHMzB/Ce+9B/OEueokhJ5veOvbdUU7SEPrwsqjN2GCAW/cdR1YBwdKRiY
         HxfPmqQv8WeuDITxuZ6GuHa7fIhgp6DXIbn5LDV7HOmacUnGH9L9O8b8agqMhRWxhVlv
         nFfWRSjzsdQgj5Ib7CQyJZcwe9beETgyuoCtWWwNk9HP2ExvLKHTE+y/eAWtgTENCoam
         2njg==
X-Forwarded-Encrypted: i=1; AFNElJ/nvlUzQ5MrnaLyOVTCCsWUKUF6OL9M3V6NzUUYYRze6Yocsada6tEBflwOoO4TuKBHpXgIgfjbfOWExuOL@vger.kernel.org
X-Gm-Message-State: AOJu0YxYOmXkJ9qAh+13qjBwL4AVE012uw/c0sCG5J2Tn6p3IhqMlrMw
	STPvV4MA78NkUe+/xv3TWq07mjO+35MzgePX24/0h8Ek2LXAHrUSbPLt
X-Gm-Gg: AeBDieulQqfGOiKgpiA8ZU2Od0zFs6v+md7nMCnKqEwLu00w3fHCqJUsD7qo7XNDCwu
	Bmb85WJWyzqgr2N/CQdTJ2RkFfw6FkmvUZ3FO3OA4X6EkS5HoWV6Ni60eE7or6rVrdXB/mvtf5/
	Sk8FLZTT637bvylmOoWhZml00aFxixtP5B6wqxm/hmBpKFfqgwlI2avw/tAl9T3UZ+eH33YIosW
	b+fi5TN3A/EwyHSFRD6HgMGRv94Seuykok2L4UPQBoO7rUDN+JRhRtsh5+HuMiCT5hi2jh4DkQw
	Q3FQ/O8u8tClLFmo1kseQJPkfh9jJRe1mbv22OIMOWm07OEQhdQhUzVHEqf6BhgqzSiqJdu8HVP
	Cwab67Q1SDN3n3JMxqRjtDsK9tqSx7gI71mWL6iJSYya1EZg+M22bDST/QLDTO1UUGufUatl4YA
	S0Hh/2zhvRXRa7KMcH+FTry67xyhz4pNfP/98c/hqB3XLQI5tuZGSBRYtOTo3/NVMZLUjph/09F
	pLPBrdm4vQ1XdUgXp5WfHWK
X-Received: by 2002:a05:600c:4f91:b0:489:1ba8:5be9 with SMTP id 5b1f17b1804b1-48a98676b26mr157938505e9.29.1777908614504;
        Mon, 04 May 2026 08:30:14 -0700 (PDT)
Received: from fedora (185-147-212-251.par.as62651.net. [185.147.212.251])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-44a8ea7cfd2sm25250825f8f.2.2026.05.04.08.30.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 08:30:13 -0700 (PDT)
Date: Mon, 4 May 2026 23:29:55 +0800
From: Ming Lei <tom.leiming@gmail.com>
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
	io-uring@vger.kernel.org, linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
	Nitesh Shetty <nj.shetty@samsung.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Anuj Gupta <anuj20.g@samsung.com>,
	Tushar Gohad <tushar.gohad@intel.com>,
	William Power <william.power@intel.com>,
	Phil Cayton <phil.cayton@intel.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH v3 00/10] Add dmabuf read/write via io_uring
Message-ID: <afi7c-VUJWOLlC1m@fedora>
References: <cover.1777475843.git.asml.silence@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1777475843.git.asml.silence@gmail.com>

On Wed, Apr 29, 2026 at 04:25:46PM +0100, Pavel Begunkov wrote:
> The patch set allows to register a dmabuf to an io_uring instance for
> a specified file and use it with io_uring read / write requests. The
> infrastructure is not tied to io_uring and there could be more users
> in the future. A similar idea was attempted some years ago by Keith [1],
> from where I borrowed a good number of changes, and later was brough up
> by Tushar and Vishal from Intel.
> 
> It's an opt-in feature for files, and they need to implement a new
> file operation to use it. Only NVMe block devices are supported in this
> series. The user API is built on top of io_uring's "registered buffers",
> where a dmabuf is registered in a special way, but after it can be used
> as any other "registered buffer" with IORING_OP_{READ,WRITE}_FIXED
> requests. It's created via a new file operation and the resulted map is
> then passed through the I/O stack in a new iterator type. There is some
> additional infrastructure to bind it all, which also counts requests
> using a dmabuf map and managing lifetimes, which is used to implement
> map invalidation.
> 
> It was tested for GPU <-> NVMe transfers. Also, as it maintains a
> long-term dma mapping, it helps with the IOMMU cost. The numbers
> below are for udmabuf reads previously run by Anuj for different
> IOMMU modes:

Plain registered buffer is long-live too, which raises question: does this
framework need to take it into account from beginning?

BTW, inspired by this approach, I adds similar feature to ublk via UBLK_IO_F_SHMEM_ZC
which can maintain long-term vfio dma mapping over registered user-place aligned buffer.



Thanks, 
Ming
