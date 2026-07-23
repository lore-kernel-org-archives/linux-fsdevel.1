Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B64684C9004
	for <linux-fsdevel@vger.kernel.org>; Thu, 23 Jul 2026 17:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784826353; cv=pass; b=oXO/CuHsFCJfLva1EqzF1eGpgsJRejWFgTmJKrWgj6zE57c0qWkBf+dppbhELID0fSvclnyFoZdKygX7R3ty2OLuKFVVuy236qvoPWux7gKaFwH/OXom0iK+X4n5RppqWFwH9DfAxKAGIOaK85Jzhv98qnhAU7K/qBqsv9B+png=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784826353; c=relaxed/simple;
	bh=gm1y3HjSbfjetP2qj6SkQ/PvAerOiP935sq/jHQIUpg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Qt24NUt2FA4FLRxNbag0V6t7ZhHbZGsKLxZwIhkmFqfBiPEJ4NjY1ua5iEI4nA3DRoHcccn/KjYNewHUS2MICGUR3MS4HX0YwOMR8f9BIMRHRTIJNr6FUBuwl98HlIwoUUVss4KvM3V1PXjuE95zMf0gFqVhERKmgI7UPt+BpTU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l8pkA7oJ; arc=pass smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l8pkA7oJ"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-69c5f6f7a40so1828334a12.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Jul 2026 10:05:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784826348; cv=none;
        d=google.com; s=arc-20260327;
        b=Ikg3WxKeLRp0ica0TutXEUypssS+c+O2PdxEp9gOnmHoiZENrlnk8dRvaqcy+urm77
         CpjeSydRisC0sLyAV6pvOlBLluK+h892QQRVbMBbuAO1zW9kTA/i5ZfzRV1VyFc9DsFo
         f97x+1X6KIdCpWaoEPO6CPN1r/8MEPL5+NIdr3xUnHAkKBly5oQa5gzQoXCJRXF5+V1S
         9owkTH9b0vq3zGhDVo2TXqDiXtXQFTxD8j60fZQM8Vw3chn2iEVI9HnFHJPHZ1in6kjj
         RbMvoxPIrsRK5qSst/cWPIthJwT3h/jCDlB/j83fRDORY64NB4eq58QIUeyHuRegdWp9
         kYOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=gm1y3HjSbfjetP2qj6SkQ/PvAerOiP935sq/jHQIUpg=;
        fh=5mS5YKEuI+CeksJwFx1BjJlnlmW45SLFVJOoiF+IhlQ=;
        b=fUX/eJqHjn1tZCtXfe3bQtNnnrYxxDPkiPRNHTOy0jphUe/31urKUUEDyAroRcbWDD
         M0zjjavOx/74z3Er2OMtzRqxBCNJWIJayzQQYKwqeMylkhMR4JOIwsa0l6LycYkGDKR4
         otb7w9jNGEUClrPny3jslJvnBf6zbstIpKhcQz7JUtS9+UdYw/Wb53ZXhc7y9xeaSNGs
         zVf9Orfg5JDTr886FYDEXVm5q1J1GOt5218jLoOUwQnYdhG3WmxpL2xgfcb2rt7aIvFR
         6dVTWoh4EUMxe2xQTa+5zB2Y4gLGNyMdAeGv1BA5Iqa97jyqZp060dNUmie7Lt9IWdR7
         71yA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784826348; x=1785431148; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gm1y3HjSbfjetP2qj6SkQ/PvAerOiP935sq/jHQIUpg=;
        b=l8pkA7oJLih8TzuvTDGh7j0dMOl6Eb9Nrun3ybHk91qSM1/ZqamVq51elv79Ndy4aN
         L4+7SrUjtKtmoGwa1tNEQxBxhuWfYLqVZwNrhC81cIf7IR1JoLsJZ1znekQ/5tZrvHQT
         M1IvSMRdCj29VDkj0qw7igjvkqLE8fVDl5sdnQrGoXo14i8HrALrM0LPwQCIxY8u3uPg
         y86xoHXl1TJOzQYuCunnpAnCcpNVXX/P0WDUKNre1PTW3TtLNrKUYMUAMjOEQUN7fwqk
         9FiLydcKYQpgYmvsHWElZNb9x5pvHnfoXzL7wbr1bKgxb8J16ovuFAZezrsKvJL/OK87
         JR6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784826348; x=1785431148;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=gm1y3HjSbfjetP2qj6SkQ/PvAerOiP935sq/jHQIUpg=;
        b=FAP9S+40uETq/QyLlJGBTJ/yE47px4fRvSZc7FR+ImRBcKZyprWKKLW3zXacWG1kSP
         O0R9ubAlRwIUXrCmaomYkO6GwtdyRus/Hc0f5AWjvxsrVCX1SyEWmxqVCGhczIyh1Uyw
         k6z2XbzGe2+yDw7wxcwgDC1acoU5l37qx7Bpa9fh/k4pUf2Jz3540bBysFtg/SAm46Dx
         NnsTIqyj/P9+zWqzeKKK3WTEmVCP1/+lYD8sRHMWwEYe4HQy0bVNv45Nw5ADnXuX0220
         HQ3dfAlp2cqZussaFi1JIOFyLnT8avc6Nl6NCUYiBDrctfK6BXSK8dcfDDpgfah5Y1Hr
         aK4w==
X-Forwarded-Encrypted: i=1; AHgh+Ro7647lQCrWZZI8qmDBg7gbH2F/MSrRbUMnxYlRj0GZZhpMrAgOFzJTkQ7zPEfvTYKo6fJqs0GmNhPvtku9@vger.kernel.org
X-Gm-Message-State: AOJu0YxUjAzoC8ydZSjrY0N6mGbi5jQ2SXpujovr2Gjp+g5ZiSRqmQUU
	/xmXru2SCFC/Zm3wzPckSltR5usRvqKHoF8O2bgOeyeqVcN+0snR7AzycyYvN8nmfZ7eD7z4Brm
	nTmwl6xu/6rcnWoJEzwJXPfVSu4yjiw==
X-Gm-Gg: AR+sD11F5PtDbSNlF+0Vve+NXCx9/VNS23BGBI1kNQksNbZSODd6Jbk8eApUJr1HQR6
	sajvMdGbFa5yb1OYkSIiry4vaJxlA0zHdVqvNTTGFo/BAgBxBgRTaNu7pgnrEXMz8LUTJU9FAfl
	fdGtZnWxjGT8YFSf9kWhN7TMAN7R1XsKoMcVQp6Jkrld9G6nsT80iYY3y6j+Q7h4Ea0k8Mf0405
	OHLR5y+nQ1UJuZLqD6wCHsJktX2BZ2X0azz8/6EjI9JyW8HHOLBokJ5SuGD6YjJbDkv2UvUK5MD
	nENNwc5FqoeSgD0377wYeITb/FbKVOOrFVsV4cSiKv8=
X-Received: by 2002:a17:906:9fce:b0:c16:a9e0:d5eb with SMTP id
 a640c23a62f3a-c1c509a83b2mr202122866b.56.1784826348034; Thu, 23 Jul 2026
 10:05:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260723145000.116419-1-hch@lst.de> <20260723145000.116419-5-hch@lst.de>
In-Reply-To: <20260723145000.116419-5-hch@lst.de>
From: Anuj gupta <anuj1072538@gmail.com>
Date: Thu, 23 Jul 2026 22:35:08 +0530
X-Gm-Features: AUfX_mx42CjHuGi597hWO-eDmQkzzqIKaOn08um8jFHZz68xIGpeWOmFM7SNP0w
Message-ID: <CACzX3AsOLiKnG=spMY5uHOJX06QB759HY6fh7Z+=zBgjwEPfZg@mail.gmail.com>
Subject: Re: [PATCH 04/22] block: handle nogenerate/noverify properly in fs-integrity
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Christian Brauner <brauner@kernel.org>, 
	"Darrick J. Wong" <djwong@kernel.org>, Carlos Maiolino <cem@kernel.org>, Tal Zussman <tz2294@columbia.edu>, 
	Anuj Gupta <anuj20.g@samsung.com>, linux-block@vger.kernel.org, 
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Reviewed-by: Anuj Gupta <anuj20.g@samsung.com>
