Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35369329E44
	for <linux-fsdevel@vger.kernel.org>; Tue, 27 Jan 2026 06:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769496076; cv=pass; b=ROeUZvCpRQNvXvBXaNWKZpjAHAgw8sHuS4of7bx+EHv1e32ObJ3+HIV0cdwykTUJAsKlPvthrTbrvnKOy+sjnMYOk5zxn5ZwDXLvpKA1vc2CSU0WnaFkCBAgjBUInSvc/WJJBHGDD7DavEqd9uoUkJcPsshNhsuc8J2F1dNgu5w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769496076; c=relaxed/simple;
	bh=UMiOIo0AEhI+Ah5+oKBr97SiEAtqyx7d+chKwMjJfFg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=avDK7XBU/Xo9W2383O3jcRTiDHb5M2Y14zRBe+nqeVHEkZudyzMIYQa6sUOqNxu/oh0Ihh0P3j4gjtp7HQbjFZSFRjkMZTGmql7Ctql6Kb6U5fNtA/F2s6taD2Ij6/ALIs+e5v95blFuvMUdDgPWChb5TjQi4xvYEd+A6lVmXys=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=OTlFECy1; arc=pass smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="OTlFECy1"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-81f4c0e2b42so2690149b3a.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Jan 2026 22:41:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769496074; cv=none;
        d=google.com; s=arc-20240605;
        b=T393yAvtkgLdgUaFZEmWnS/2fo5CLASfM0OHuth+mO0GtFzVubLntMwJNSA0J2RAup
         7RxtkgfDr4ZuT4zj1iN0nL0eUdxgCadpRgdEX/gXlXVER3LC7E1ZHVjN+ViEcIJixzsi
         n8kmQF3/q8sZNb/L5lV/NpjgzB+NvSZlqMRVC6vYL2ha27OhTY0tQPJnHNa/6XwH0a+X
         0QYkCl4g++gDxiNeulMUnWqwOWrKCozRNZkMFKAXeQfqqQXQyNmTeQtFOABTZJ6lK5tt
         sbphpFJmWPzaTYEi40+shmcKNnEVYSgOSW4+W3tjpe25oiQmUWGW+jN3JbarDdZ7efv0
         7cmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=UMiOIo0AEhI+Ah5+oKBr97SiEAtqyx7d+chKwMjJfFg=;
        fh=Qw0WmD3rMe+Py5cnvpOhtngckDwae1dlHS0vpNAj5Ic=;
        b=CUL/oNa0FQWo8GdU3/ouw8rvxhyKpcdlCIk3IUsFGIyxlSXTh2WjuBOGz+C1TPbv44
         kyBqcdxUKYlOcQ9ZBsWvJ0bFaGyeLufD4SU8nvfvXCm7IG6INTVRazaDLve0CTsMU6nm
         QmYpSNpNhvmmPYbFEM8qr/iFIpC0Gz3ykkNu0wPwhqSOq8IkOpE2ojFx5n0cmSVcLoB0
         1Ebnrrx6KAQAhUeQIJjxtoqAfRVZYAfvRX8QuKI519fv/KQD35kO+P0/4nJsCEfMqrCK
         S/WwdHL6ioSxxAAriFEe6vvNHZIB3T+w/e/aZZTiLnLFmFqDfXpiGkF9n1OM/HZaB1AA
         TLaQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1769496074; x=1770100874; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UMiOIo0AEhI+Ah5+oKBr97SiEAtqyx7d+chKwMjJfFg=;
        b=OTlFECy1bBYFbbkkDqqwVwrV/UmPkJCjbDwHIhEZGPIDDv7n7N7K4LjY1rbCpwpdie
         w3q6tgar/N9KAtuxXhTKvXw49XHWlUs3V0IggKX63L1GMSiqqXzL83WgHMG9U9RMYkGr
         fK7VkfXZzeTagmuMoGnpwYXJJGUPwRjrNAs5Q5WTNqpVBkEPqVhPnzdoCcmKUqiSyx+x
         q7gE+IrnM027qkRybEbyVoakk02zrG93ygaQaQeSvzFcb6dEoaUcgexUpY62V6kqqeqE
         W9bPp0MwOlFZ7o14Zeq3rZXTkZ+OnEXwG5NimExqm9evOzuwUibvxUgmxF8UNHiHUlMW
         Z3MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769496074; x=1770100874;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UMiOIo0AEhI+Ah5+oKBr97SiEAtqyx7d+chKwMjJfFg=;
        b=galCgtKXUn/Urk/l1bSj9HgQpnuVfbrEinWZmnK11PWxDjx35xZalmVIzIC4YoW9lt
         bEYduln+eSGGnbqGLL7sVE79LyWkz0nH5QRBcBkbdeIBeLvckz5ibdv7RhcugEVmqWz9
         obBHO/4bsUqJIfQ7vY+uqakJeO1g8L84bDRQQsV3YIFx8a3o1KnxxF0nKPdNEt92hf/K
         zANy17ey9kB6MDF1ozEFTItuFA3okudHZrsrsmYbeE9xjxeIW17U5OBnl4pcmEHfOIQq
         2EaASJXO/ItllHpVb+hQ06P0kJsBu4gxa35iaL176nY+fDfbF7kM8chZwhWuXRLYBcwc
         sG7g==
X-Gm-Message-State: AOJu0YyWe4wCuzIV+m8uji+jT3sY/ys1Acmkv1tjH9UoFfmcavDYoUfC
	4/frq8sJ7z394yn3i46ky1QmsrB9KFw6Zk4z+ydWORYB/306xXZCJr47M7Tc2QPZpzTLGoz5EXZ
	XD1ypPeaN+ohUrMnQSb9Sdan4ZuJMtY+eOmJvtb3+Ig==
X-Gm-Gg: AZuq6aL7oYHAH7a8yf3yVs/8VXf86QqrBwBHN9XDRDInuqhvWpm/cOkBUI/TBgQslUY
	oH0NS9VYtp3PrXx5gMovZ7gB91oXgYNZ6/cpBu59zR9tZfb8EHAA9CjdNXqyGW7qDKb6x8rRkR3
	NrpUH14wjfWmvBZy6VPwidwtODuE2rsY+UAZr2LQjpNpZPJVna+lTPEkRZT5QHre4bWHMI+NF3V
	X6JYNpxkcCd4iScop8jWSEL/O26gIyzKkZTZEMh2hg3jL28IC7FR9rlgI/5i76towqsTQ1qax/k
	+RGQ+2/wXQGA
X-Received: by 2002:a05:6a20:729e:b0:35f:4e9d:d28b with SMTP id
 adf61e73a8af0-38ec62dddbdmr767168637.18.1769496074380; Mon, 26 Jan 2026
 22:41:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251225111156.47987-1-zhangtianci.1997@bytedance.com> <CAP4dvscqk1Z2M_aJtFYh8_RXGO_LUjsDuXFamfkitaPuce_qEw@mail.gmail.com>
In-Reply-To: <CAP4dvscqk1Z2M_aJtFYh8_RXGO_LUjsDuXFamfkitaPuce_qEw@mail.gmail.com>
From: Zhang Tianci <zhangtianci.1997@bytedance.com>
Date: Tue, 27 Jan 2026 14:41:03 +0800
X-Gm-Features: AZwV_QgixoDuFLni-c3QR0pvQAE0AsGvGmn2iaieTes_nB2xA5JR24cdowbA7vQ
Message-ID: <CAP4dvse-CJcSqVWWZmy1uJ-OFyOz5ztB7SGHt+=1FkA-LG9gzw@mail.gmail.com>
Subject: Re: [PATCH] fuse: set ff->flock only on success
To: miklos@szeredi.hu
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	xieyongji@bytedance.com, Li Yichao <liyichao.1@bytedance.com>
Content-Type: text/plain; charset="UTF-8"

gently ping...
