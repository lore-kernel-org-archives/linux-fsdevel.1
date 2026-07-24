Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1747B44A708
	for <linux-fsdevel@vger.kernel.org>; Fri, 24 Jul 2026 19:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784922042; cv=none; b=enBtDqrneY0LRtwbtqO0nNlP8jFcDh2nXYl7w8S2GFoVZiyq3f9RpKyv6H4F4QeMg0xHeTEx9KxYredNByAnhaBpHlxuK8yo5JI+7tlay1DvoEEa/g/muTxuwbMkTZMvk6o2qZdldKLJWai5aK7vu9uQC27alcpfOOkXi+f+ia4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784922042; c=relaxed/simple;
	bh=lfuQHVKHY/BqWWar8zdelMf5JmJ3LKpeXIIe70En4NI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=R0XRozgVWpNPvDvCc3KG19umaIfGUT6VyKL6NBNq89fnVaYPDGDTf+5mQh7zyISVrXtUzzvH5h7q3lXf438d+BXHWVZw17gnTC+7thzm7ICCIJ0nIrt5BbHNj/2mqTFChvEKUjran2bqcho+9rdp8MWgkQZPGi3+wkg8vEYeOEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b=apmcXQNL; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b="apmcXQNL"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-81ed2a06b9eso7464217b3.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Jul 2026 12:40:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20251104.gappssmtp.com; s=20251104; t=1784922040; x=1785526840; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=lfuQHVKHY/BqWWar8zdelMf5JmJ3LKpeXIIe70En4NI=;
        b=apmcXQNL9zwHY5AJRV+oAWO0TO8RkGHWYLti5xnvpAoy98VrVYfuBLRCZeL9R8EqTy
         Jigop7mwF/qTL39we3b/v4VnaJW1bQRm0Nl53txuWHZXkFrTmNMczySgw+rawb9CaMKf
         F1EDiHZD7pJ2KNgCOSMLWG5kumnEOrDnIDc5dMVTkYvRedCtoWny4o8SoAnE/Vgsp2Wt
         9REzavX90hEembH2PCvaYZ8NN2E6VIpgNtkA2gfp2jR+X3HgMr9nA7hwxiy5t936KOlM
         m5g5zd8VLyOO+VVy0aKMojd55G8r0LghqckyyGMhdR0scwQjrSIhMVgWEjjJ9B3vsGjv
         847w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784922040; x=1785526840;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=lfuQHVKHY/BqWWar8zdelMf5JmJ3LKpeXIIe70En4NI=;
        b=hqSzRUZBFrpqvuX3EHAEnknoXrFzHfGQMyybM7ml0uL1QX2Z6qB57hQ9k0LKtV1vDa
         /X+NAj5GbKpz6Af2VQhtj6uj12Vp60qXH/LwcmmNVWS/6TVReTnaur7uCvmk3f031X9i
         shxxzBmMcidkXgnW8knpzPPlvHoKUyxI2GhicbS2tbbFVJrwh/pulYBrZjtcARo1FDw2
         US7OXxRk/sWjxOxla8UPCP76REIHVQY9aX6Z9LMMZev8WOLhinjRrsVnPoSLBCwF/0DK
         bfuf+U947RFAa2prTEgRBFfbWCvo0cpvKo6Huyl1xL7Li91pUQvp+GsFz6JvLdXt8/Re
         C8DQ==
X-Forwarded-Encrypted: i=1; AHgh+RocKlBkgd4FIWldD9NPSqfGvEcCL3tt/4vs2LFbOFvMhjo7xZQTdEqs5NS4rFWsldVRkHYT7VWJF3Kzg+lO@vger.kernel.org
X-Gm-Message-State: AOJu0YzrhoX6QaYRZqoJf7IvjFSQaf6zGHoc2kTu6hRx7Xwh322/ob5L
	YmzrL7AVt9ecdtww7yvNBBf2yxIGU1/AlYQQT7O1Q10lQ+6mKKHYag4ZmMas56IZqA3Fh5ycaCd
	tX19+uK8=
X-Gm-Gg: AR+sD11oIenicFpaL2ipppuvqy8NPNUKHRXgps2jyX0hhcrcQ2a/4EISrHWvzwjQRRk
	UP6dKlVo51zQCRA8V/AGySA0IPdWuGuBJbkL+p0+95SEOi9G3LhWtSUQpjM9GLC6Sm5Z65itIpS
	m59G69NbwaOURMsfAVv5WdAYC9eWaCe37aYfl3qhok67utjN9ehpxcqYWU+lJaotMWlP4+iCesS
	fTGblgj+pklbdB4VY8YLuQ5soZGRpCYH4P5d8GMaKb8ek9CvmPjniYmZ8iyUEn0cIcZqGch2DbP
	kloaIzQeRhdCMGoca20q9JmOy6nnRB6ZIVYlAN6Rde8+tnIEe7jt0/BWgLy53xGqzTLGP9Ld9G+
	4mF7qZeF/uqDhkX2gR5dzd3FVp++SqWSWn9wer8Ic3/N9YMBc2mTjOODfr4cSFpIUbDVVuxfy/J
	CWI/3cLxsu/6DMCu52J5ro8k8KboE5mXUjHi0igXprq4jVFMxFKDy6s2U7LgvLtZCVUldGMaIKr
	w4xwAkjrWOAjhk3pr8lHB8gwL8VMJRp+NbWMUaDQPaazVtmvgPgHAOxdIuqOhOO0CFli5Pk2CO2
	eryf5Q==
X-Received: by 2002:a05:690c:2784:b0:80b:a6a3:937c with SMTP id 00721157ae682-81f4c181032mr30434467b3.20.1784922039982;
        Fri, 24 Jul 2026 12:40:39 -0700 (PDT)
Received: from ?IPv6:2600:1700:6476:1430:62ee:74f6:cfbb:28e0? ([2600:1700:6476:1430:62ee:74f6:cfbb:28e0])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81f65770c91sm5165167b3.2.2026.07.24.12.40.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 12:40:39 -0700 (PDT)
Message-ID: <f532f95937e8a5123ac07a796bc5aff40c2ffa40.camel@dubeyko.com>
Subject: Re: [PATCH 3/6] hfsplus: take the bitmap page lock for allocate/free
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: Christoph Hellwig <hch@lst.de>
Cc: glaubitz@physik.fu-berlin.de, frank.li@vivo.com, 
	linux-fsdevel@vger.kernel.org
Date: Fri, 24 Jul 2026 12:40:36 -0700
In-Reply-To: <20260724052931.GD4181@lst.de>
References: <20260722213759.1360225-1-slava@dubeyko.com>
	 <20260722213759.1360225-4-slava@dubeyko.com> <20260724052931.GD4181@lst.de>
Autocrypt: addr=slava@dubeyko.com; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (by Flathub.org) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2026-07-24 at 07:29 +0200, Christoph Hellwig wrote:
> On Wed, Jul 22, 2026 at 02:37:55PM -0700, Viacheslav Dubeyko wrote:
> > The hfsplus_block_allocate() and hfsplus_block_free() kmap
> > the allocation bitmap's pages and modify their bits in place
> > under sbi->alloc_mutex, but without holding the page lock.
> > That leaves the read-modify-write of the bitmap bits
> > unprotected against a concurrent writeback of the same page,
> > which can read a partially-updated bitmap word or race with
> > the dirty-bit update.
> >=20
> > This patch adds taking lock_page()/unlock_page() around each
> > page's kmap/modify/kunmap section.
>=20
> You are still unprotected against concurrent writeback, as writeback
> drops the page lock before writing the data out.


Yeah, you are right. As far as I can see, the sbi->alloc_mutex is the
main mechanism of synchronization of access to Allocation File (block
bitmap). And I see that hfsplus_sync_fs() doesn't use it during
filemap_write_and_wait(sbi->alloc_file->i_mapping). Probably, it should
be used there. Let me double check it. What do you think?

Thanks,
Slava.
