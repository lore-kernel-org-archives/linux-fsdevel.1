Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20511380FD1
	for <linux-fsdevel@vger.kernel.org>; Fri, 24 Jul 2026 13:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784900078; cv=pass; b=DVXMJgS0LX9KnwlgHdu5Jhz5LaOG6RRtEWroMRi3ti61QnzzFfdxGUe5cexx580nyQZL6jW5mJXCDeZsi75imb/eJmgvAEV85dnF+1UivR72kl4vHV+WFQy4aJiKOnX242hZQTUituq4s1+udWvgGZV3UgRws0Tys0Vsu6np5mg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784900078; c=relaxed/simple;
	bh=gm1y3HjSbfjetP2qj6SkQ/PvAerOiP935sq/jHQIUpg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rosc3uxKF06nN+R/8outsXL4C6Ux4KYk/f0s2r4L0UGXMs2U5n7xv13ooTQD8bJ3gK4J/OUGsfivtwFCBqtQx15JpIuI2ViU8k5HbRzKgep0m8erIWktCq6pch7Plk2DR7rr0jF7qvu/nMVIgtmG1rwhh+tVxNg365wx02w/cSQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VpUbj/gx; arc=pass smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VpUbj/gx"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-c197f968b3cso67559666b.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Jul 2026 06:34:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784900075; cv=none;
        d=google.com; s=arc-20260327;
        b=DlCw6HZxY2kivDIBLzrbt3l+O9Bu9efEpD/Po2U6IySEWWBTYAY8ZvYCsdYgsEe0Oy
         7DsZR0+DXRpgNuNUQDOqkWgp9dJbz+6PlU+cQvSH8+8vNqqDvM5RztX0z3p6JQupOytZ
         Ro6MRaTnFcKE9BBASy6Qf3tDbxGWHzqbAunBGz7DAbhdXpjB1xvG0x8QGL+uIP0OV7LQ
         R0c0PP0RPDStJ0fx112vkheVxCTmkNxgv21YH6jYqUQm+CiaF/SGA+GUOV9W4O5K+9Is
         mTUDLbAZuDUPmVBZBvqyApKNFIZ+wWkUXj2gkpsck6mTKoBVQVNMawohgzDnzOjwrZP8
         4fjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=gm1y3HjSbfjetP2qj6SkQ/PvAerOiP935sq/jHQIUpg=;
        fh=MeGZOqWwJZXl2oHDd/qb8sphvh3H65JOUwNsD47yM4E=;
        b=VSZVyLCO7xuHwqBGCXIH5+Y3U7aVICV2M3YXZm3qiHmds+ekJfHF6LzEgklNCVS4RJ
         T8u7HCmCSkyz8+WzpHqWyorJZ0MVgznTALo62O6yJK8mcaXMz3cGr2QIgtzVr06t44Fu
         jfAolGSXWtJNSg+ZHTh11h/R1Kyn6j6wvHMTiOSClNQD1/5IgWpbwZkfmxP+R9UY0P0s
         +R50J9fGZv2MqSy9zY3RMmnA/doVvuZLtWNWY64oYwgzSzKHyrIfMqQ4G5buuB2quCxS
         SkFa/3w7WuF/+UOGTOYL47NjtJac+tAnvykW2sjuUElpZfkpPM403eJeBPiq1PtiNTgE
         sc7A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784900075; x=1785504875; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gm1y3HjSbfjetP2qj6SkQ/PvAerOiP935sq/jHQIUpg=;
        b=VpUbj/gxPfu2RJKKVmjsZsjVpFXa4JvxOTc/1TcRNMnnNVefaCvfqx2/odkO9g0NTh
         CnsiBs4DgQ48FWOpJDSSiPo0E6xIq/kxYpQsS4Dbv3aZurShT/W+A9qHMjEDVCTojNe5
         5zf79qnNQjhwS1zaVKbawSHze1NF4okyEJHHH4ArW6N3YMjavlI7eyMl+xOpiqmxLb2E
         NKJ06T7BITwLjVRs4DNk4bAi3fEzM1kirP5LYLY2pSojTlhlTzeIY2DM5oDjrSJ0zXy8
         zsPTuXchjV6bQkcVQAf1IJmIjWs6rbLpwnX15kRDf5kjA369ONxgdH7bmD2X4GrAZEig
         ECZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784900075; x=1785504875;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=gm1y3HjSbfjetP2qj6SkQ/PvAerOiP935sq/jHQIUpg=;
        b=Wv+sfZY/XRaMaXGBrPq/gLDgTvuo98IXmDmuTMZuc6EiACmBC2Zc1EBwajXKWBmBsE
         tGzAT5ayprEIGopWST/pXfLcZlFSzqgCdMW0P6n+JS7HgHYXFggoQOcLXEH1ddzRpt5A
         xWZ5I9fFd41BkWVOlM0qOio/8t3E4nrOJPEmWLgtOUzYEVMKnfInnBJzSrUkF0+PdjbW
         KJ+DL9ZpWT66xYiX7MFyzXBazf1f8oiYv4wmQgCBBxX2+5QV9l2gdlyhGkuGiZwXg0zS
         3H5PBVJtDCr45MHP8RU3q6wRCku/NafiX0gG7Fd+1TJTP+nf4mcc4V5qvPbkq/ao7+2J
         7x8g==
X-Forwarded-Encrypted: i=1; AHgh+RpYbS75F9azBjxmIGT2C5iODtIUP+sJiVAL8NADk410oTbr6LDsv/n6E6Ow/04GV6aRV6rqJzbckkQM9uXh@vger.kernel.org
X-Gm-Message-State: AOJu0Ywq12zmaudkibgY81Xh+btheepvYEoOlsY4czVZE8xKk6IdPkWh
	oX2XvykIZ31F7PfnUGY9cM5tbaI+JvcBEF28LuKAjM9u/bJ68zQdOtUbgGaweiqpudnqaj/eyqH
	sjujvjTyoYNASGsMyZvFfGUqeQJDkhA==
X-Gm-Gg: AR+sD11KkzNlZ3fqm+mI6ZWdVznVQrQ3yhRDsBZtEgU0xKnikbMmctZk6+u2SyfX2Yl
	S/6C+nYpnKrMt341qjL8omytRbrX+ajfw5d9bx6UIdMwoRk6zc+JOzJlfcS7rUs3MZuLocuMYWd
	hkdCyyLPpqvzDRbWea+kSzhJSifv6UQOv5Gu4Tie6+JpNsm+sQLoWm/Nxh56U9GI1R0Ku10ds/1
	SSdQpjYMmFW2CulTQhgGiSU/A1nHUkT+mhhtwtbD4PvJL9vLhrHwhg1SiN6a7+NY8Snk5HCAviP
	iF534n/YZAWFky9+wahWCMTTGt2s2FgH/+A=
X-Received: by 2002:a17:907:1c13:b0:c12:34ed:da14 with SMTP id
 a640c23a62f3a-c1c50b6671cmr294192966b.64.1784900075121; Fri, 24 Jul 2026
 06:34:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260724051001.202741-1-hch@lst.de> <20260724051001.202741-5-hch@lst.de>
In-Reply-To: <20260724051001.202741-5-hch@lst.de>
From: Anuj gupta <anuj1072538@gmail.com>
Date: Fri, 24 Jul 2026 19:03:56 +0530
X-Gm-Features: AUfX_mwWTg42HDw4aWDghBP51qdfXyDKkMoJixeJkgq6b4QcQa_tMbSOXy-DN0w
Message-ID: <CACzX3AvJUPUhxCPgqOW6zSF2exawYG_okkL3xAEd=s2g=EDd3A@mail.gmail.com>
Subject: Re: [PATCH 4/4] iomap: don't free integrity payload that doesn't exist
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, "Martin K. Petersen" <martin.petersen@oracle.com>, 
	Kanchan Joshi <joshi.k@samsung.com>, Anuj Gupta <anuj20.g@samsung.com>, 
	Christian Brauner <brauner@kernel.org>, "Darrick J. Wong" <djwong@kernel.org>, linux-block@vger.kernel.org, 
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Reviewed-by: Anuj Gupta <anuj20.g@samsung.com>
