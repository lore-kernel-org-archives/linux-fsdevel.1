Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 375FA3264FD
	for <linux-fsdevel@vger.kernel.org>; Fri, 12 Jun 2026 04:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781237331; cv=none; b=BlBYfhGJ0vZV5VUNJpqY5Tt5s5vXAQZDhtf56Ie3sWFboAJhO9NzLXZB1FLJPzo2SLhVP+51xBEiyeHJKTV/mYTzqGQD8EBgvNgoGZwnxcGAF+/mK9m+Wkq1PBJXgYSYLHaiHW6klO3cTQmeVBieIS8Rwq1jl1x7WAJgANnzIiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781237331; c=relaxed/simple;
	bh=Z88EbynAt2V5UsKpSMxwaQax57cdOaW8qR9h1m9fQ/8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XsZesrmDD2f8IR20nNLIwk+1GPDiZu0dSVCBCH7g43tZ07rpgGgvPrPMBu9JqLb3wJ80JtC1ENTl4qOdLS7th+Gw627/fTAwNAlNsR2vbglGkQMyLYIfgjCyueEOY9Gk9qEgZgnQrHRjiUHlqOVQWQeHJZassGQep3hH9F4epbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b=MrlAxAN/; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b="MrlAxAN/"
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-39677c434efso4649841fa.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 11 Jun 2026 21:08:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20251104.gappssmtp.com; s=20251104; t=1781237328; x=1781842128; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Z88EbynAt2V5UsKpSMxwaQax57cdOaW8qR9h1m9fQ/8=;
        b=MrlAxAN/g2ATThjAirOg9BKIl0ceVdKDHpuKbGUxCIDaQQCd0AX/2ag+lRrzzTlEyh
         oZmji+b4L/oFj17cTFS7SoNUrzm4YcvoBD7c17gEMY1/tFsZy8EYycZbSC4NuDtzd9+1
         uVaj/m/vPZoh/ht6RAOWns3w/AiOGJZGEYOJPMYgsGA3kDYPq7/1Z0yWEn3K4IHl6QQC
         1reH9/YgzhEDW713pawoj6qNDvkVhc4MfSsHBtdSZrD4ofgwlnlKJ97Yq1CN8DxfNp/N
         oRgFqkmDTgKXjV8skwIX1SmSkM4Y7Tjj0G1e8ZQQVED8WZ+tr1bxWAiI9Fyeqzg/bFIS
         tgUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781237328; x=1781842128;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z88EbynAt2V5UsKpSMxwaQax57cdOaW8qR9h1m9fQ/8=;
        b=sa/NKZ2R0OTgV8dG521xNv0WpKCdOdeZV6cfK2xRi1mSL/yNekfo3FyOwHjJHjb2H+
         /2OQc2Iq3SgFHMlsLmQMesdwURce5v1j1oAc9xMNenGUoSVTk7zRuLcBwmmGYSVI/6AO
         GG0kCt3QUlTlfMzGS8Di1tf7NuU2KTes9FJCbga0zAYVT2K1c48RnCq+/J/tSF+UXpL6
         VOHxR5RiJWoDHeqm6HaoKF1llYn+mUgX7yI26F6xm8i1ZCr2GFHSfQcKnhMTQjy4xIjY
         +2lExly5fnf2wllKS3GEz0vrp0Pa4fhbTA4h2KqgEe5h2isfaSRvrLswpC5wFa0lxXsj
         XRYw==
X-Forwarded-Encrypted: i=1; AFNElJ8IWnXFKtEjRZSskedo61Lk6rpvuPpXids3HrDGlIL5+ZfldD5p5Q6OnLbxD+IacAhC64xSOPQK0xohIf7V@vger.kernel.org
X-Gm-Message-State: AOJu0Yypd+ExR/gSfsmxTXocQJDHXvCsW6cniC0xcByaqm+9NlLOd42J
	U2998CTLeHR4BdClFYErUwNe4VSGF4yVwTGvOPsniZkL03mkLcUB4Yql/rI5NG3gTy8=
X-Gm-Gg: Acq92OFNqEpEhP+L93J2nkupdCs9Nth1dEP8X7gmp/BU95ahA7Ypfq0Ml/2wEGfhms0
	+dZ4xetJjYT58fJAnK2gYfiJ686ufAsMFmPuPbuxByc7ytdWc5sWJlkjOEfgOIC6UhkNZIqGQYY
	65nijBKQm49xonZTEiOneBjnXV+mbIElXkRlDwP+kuNGYx2KKA2IjpE3avOAoCIiEEjPaYl4brD
	/ewZ5L9Iguib/gn31FhZby78ay4+PcIwP8XUuWCxAF96t3Lb1AJgEB+A8J88KfpNBgJF+FIZdR8
	c/JHeGxCh6kb/kdrGdA7UYx1y4KulADi2NkQZpUTyCXf+Z/2+tf6M8mtcheM+M3eZ3WgvvlGwtY
	9LbtFi94Bdf9gU9/j2b8zUPrh7oAjGDyyCBDZsi+DPZC2tvXKPD4UHhrOM2BihmT7acust+NkGT
	RVIiUvIO6YXyzfXpYEn+lumqn4F4YELoOX9Q7ZRPnR31rFQJl/mip0vD47D60Xq2x068I5Q59sW
	qzseO0Pb92EZDgabUCyos2G4zEzMwcMw+1zduoOl9WlJ5qc4w+FDVvg
X-Received: by 2002:a2e:bc26:0:b0:396:8d0f:249b with SMTP id 38308e7fff4ca-3992b014b2bmr3407441fa.12.1781237328489;
        Thu, 11 Jun 2026 21:08:48 -0700 (PDT)
Received: from [192.168.1.246] (broadband-95-84-186-252.ip.moscow.rt.ru. [95.84.186.252])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-39929f5683dsm2698121fa.31.2026.06.11.21.08.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 21:08:47 -0700 (PDT)
Message-ID: <37a3b01c9513c1b5b129bea3cc081afd7217f21a.camel@dubeyko.com>
Subject: Re: [PATCH v2] hfs: return -EFSCORRUPTED instead of BUG() in
 hfs_write_inode()
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: David Maximiliano Hermitte <davemadmaxxx@gmail.com>, Jori Koolstra
	 <jkoolstra@xs4all.nl>
Cc: djwong@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	syzbot+97e301b4b82ae803d21b@syzkaller.appspotmail.com
Date: Thu, 11 Jun 2026 21:08:47 -0700
In-Reply-To: <20260611175753.1410325-1-davemadmaxxx@gmail.com>
References: <20260611175753.1410325-1-davemadmaxxx@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (by Flathub.org) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2026-06-11 at 17:57 +0000, David Maximiliano Hermitte wrote:
> Hello Slava, Jori, all,
>=20
> I wanted to share one additional diagnostic result from our side.
>=20

We have long multi-months discussion of this issue. Please, double
check the email list. From my point of view, the issue needs to be
fixed in hfs_read_inode() + hfs_brec_read().

Thanks,
Slava.

