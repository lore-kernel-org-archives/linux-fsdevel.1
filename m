Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 211263D6CC3
	for <linux-fsdevel@vger.kernel.org>; Wed, 15 Apr 2026 08:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776243441; cv=pass; b=fEa16da5kPhcJ7SA6ikOzjeRUPwm+sKZEoIKl2xme5xRSXVtekK1pYjaVfAzIBfbHkQDGO6OYn0KElBYMcWW4ALCrCNOE/zBVz2rdZ8X/E+Ond7bUnKTsLYGx7On5jD8Tn4X5gfZPqj76Q4iA6T8CaEij/re5xXWUA+UI1PatAM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776243441; c=relaxed/simple;
	bh=zZYtyxzFk/f/aBbXqwafBi1lDEMUVHJlRs1FsBDxTcc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NHUzuBAL2kf7X2pZpweduiqGBRYVXEx8zHtbdLmlxpUKqzuSO5qohlB/Y2Be+VndtWdeD/LJg+i2R97FZncd6cfEQVi/tM971wYFpCoo2Tz1vPmThG+R8SJyIOZZXBqzI+kgiBLvPl92ABUpdEbj9x1wVlUF5ASe7CdvgmVW4pM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=B/Dr3QHk; arc=pass smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="B/Dr3QHk"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-506a747448dso51358951cf.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Apr 2026 01:57:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776243438; cv=none;
        d=google.com; s=arc-20240605;
        b=e2hgYZDH1t/iYRvHZqpTSFHwGj6eJjJ1PBuQ9mkIdiIDgTYHoj0tDmBYTpCrgVSahh
         DE/dzUr3KitRAYymMKnvK0whOGSSvfZMlwf6+xDWv477bYVXLpqM++rSEb9QRUZCUr2L
         pgJN5DwKnZSuGwDqWjgcqA1r1HWoxR+sMoUCTBMSeKp1okPdVHYDLzHwLmA/3iMojnv/
         n+H6YQZWgsTIeJU0B50jqotgwF/Md+6Z1H9/pD9UgvW1hR+7MZxWPMqnloIXjDbc7oKX
         KZQKuqPnV3j/Jf6jYwkO9k61502cKvEm/nX1VFpnouUo7aLO22Vx0OhcwPaYbib+Vo2Z
         1AtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=1K50PrXkHzV3G2hBT2az5kpQZDgGSB8kie6wcwLv364=;
        fh=D/JntbjEsmnqAg/VqqY/XGMvjG9jDFLxhQy7prHfYLs=;
        b=GouZybD6cOa/TAn5x2SKwg3qNPmAj/uLyuj+JwMvPsb7+vu4MYx9qwEtY5YQNi4N2j
         cHu7zReDQpwWnKIBzjDXjQzFeOPbW3YgWdwExb1nLDUAWz7CLq2SSW0eEMNkso+8uqmo
         pwcBmADpVNj+RDISyOV/xDoW8Bc+uC90tQwBHNywFH2L1KaKE64iSIkdbuxte1ibQfO/
         mzTzvimUjeX4PoSeBk7Fl25pEQtNdJOHOqMZ3AP98PTtDYxiDjTR0/m2BgDv3N/chvAU
         i7jv2P2Iq2Uhd4Ak17UrXnnAaozK4o5r0Fo1+l65Lqh4VAV5sYqsRombHwcn4s0UAGzE
         26UQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1776243438; x=1776848238; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1K50PrXkHzV3G2hBT2az5kpQZDgGSB8kie6wcwLv364=;
        b=B/Dr3QHkhbP8XyWnEenix2jN4PnO0K/kbuQBlRBlXGdpkelr5iJwbpHxdRnjSLN4h1
         Pv9ZZYxWSsJclMaKdZLRaJzquEYcgZUTXIbbzcJls1Gyx74A1LrARH5gyeUqZ7MNV5EZ
         wNqh+J3xsfokVCeS3lTt5G3LH1xXmYPpsbt/8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776243438; x=1776848238;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1K50PrXkHzV3G2hBT2az5kpQZDgGSB8kie6wcwLv364=;
        b=XbedtZEO0HddjPlmdBCkNIY5WAcvIfeUdAhU2PMBMFgjV2rVAmTPBSrTGBceiEuSh9
         soAEvFDzFYXsz/fIFGsHDzbX2jtAz45jQj2zKUv6Aqx26U6ADJBVNdLWZ8M0/4KXIR0X
         WPHCmrp4fiIyiCxjSqN7JQTHDBPS7muTdNrJKGvUk5nADN2M1z9ZlV2aekjvKybaBJ8R
         UhKRmLDmTRNMUmU+ep0xAFWYLDIFKi+FqN9uvvG9pmwLi4mIE9/Nhsx0zhTy/Gg3mDUI
         s8sujowue1hbwQ1oayJ988pf3VPHYXSl1y/nadcSpcJXsCl1SP/TE1WNHdHAX8brlUJL
         WyGQ==
X-Forwarded-Encrypted: i=1; AFNElJ8vkCYT4dn28yaqnArg0HWhANx7kF51neaMxk7u8rafLqAVSwVc23LbTj/JMnYjAAM/6kutyNf6MeRLOPIN@vger.kernel.org
X-Gm-Message-State: AOJu0YzXCX06yr6kjBzKNGyPZzLxRrw3FULfd6vHxoo9gJmL6+CObL16
	JIMP+g/5vy2+55f5e0aY+mb2cGg0AZQ+IF/63vCMRw8a6xZWKyW6qctPqCxyFjRWNUmPDAbdJdQ
	nXXiGBypuw6OFxSCGFpXeuJIYOQ8D+qTS9WuLZ4WL5w==
X-Gm-Gg: AeBDietu1igRq7+tHuNv4q6nsWj2IFKpRCIi9MYL3AJCIPCaNdpcxynQbtCP3yMcqX3
	fNvSnaGfgNlikwyOar3AqBBLKkbD2W5kfHxsZasXpk3hDofNYvEJhs0zBDVaEM0gobHFijegKvW
	aDHWbYAPR1CkaSb4UgXL6f+C+PnXGI48hpNaW/MNVOC4nFfn8nmEXZSxUR/8axv/cpcEtbVO+Kw
	DMvpn8UBcMrWl7CQ4AI5qljMpWV4ii3t4dBA5i24TLuGC0xh2l93agcj3r/olla/+30ChuQ5NV6
	xfJYgxLz0af6kgYWS7sEg1Q80Bsuwtow6RVm6KkHcWFgqok=
X-Received: by 2002:a05:622a:2485:b0:50b:50bf:5bbe with SMTP id
 d75a77b69052e-50dd5adbf6fmr287758411cf.22.1776243437803; Wed, 15 Apr 2026
 01:57:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0100019d43e5f632-f5862a3e-361c-4b54-a9a6-96c242a8f17a-000000@email.amazonses.com>
 <CAJnrk1ZRTGWjNzkMxS3UkeZMmrpadJDtWKontMx2=d-smXYq=w@mail.gmail.com>
 <adkDq0m5Wt9YhJ8A@groves.net> <38744253-efa3-41c5-a491-b177a4a4c835@bsbernd.com>
 <adlBcwJjLOQDAR65@groves.net> <CAJnrk1a06zkUmXW5EFiUmgAoFauwtzsYvnotaPH0ifVtyh7iDQ@mail.gmail.com>
 <CAJfpegvVTcV89=q3L326aGQjhduBcv7PVg5QKftGLjNZmCLmaw@mail.gmail.com>
 <ad4_jFsR951c2Mtn@groves.net> <20260414185740.GA604658@frogsfrogsfrogs>
 <ad7MC5Em4l72nJ6u@groves.net> <20260415001558.GH604658@frogsfrogsfrogs>
In-Reply-To: <20260415001558.GH604658@frogsfrogsfrogs>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 15 Apr 2026 10:57:06 +0200
X-Gm-Features: AQROBzCRCfD21Ej4HAHDpxm8vYkUzgtnq-yub_KzWJ3NjPcdpwmvfwFukwnxXxw
Message-ID: <CAJfpegsEMQTwLP04L-EftdqNJrz2saBnK0Li6iZ9=5iiNa2arg@mail.gmail.com>
Subject: Re: [PATCH V10 00/10] famfs: port into fuse
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: John Groves <John@groves.net>, Joanne Koong <joannelkoong@gmail.com>, 
	Bernd Schubert <bernd@bsbernd.com>, John Groves <john@jagalactic.com>, 
	Dan Williams <dan.j.williams@intel.com>, Bernd Schubert <bschubert@ddn.com>, 
	Alison Schofield <alison.schofield@intel.com>, John Groves <jgroves@micron.com>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>, 
	Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, David Hildenbrand <david@kernel.org>, 
	Christian Brauner <brauner@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, 
	Jeff Layton <jlayton@kernel.org>, Amir Goldstein <amir73il@gmail.com>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, Stefan Hajnoczi <shajnocz@redhat.com>, 
	Josef Bacik <josef@toxicpanda.com>, Bagas Sanjaya <bagasdotme@gmail.com>, 
	Chen Linxuan <chenlinxuan@uniontech.com>, James Morse <james.morse@arm.com>, 
	Fuad Tabba <tabba@google.com>, Sean Christopherson <seanjc@google.com>, Shivank Garg <shivankg@amd.com>, 
	Ackerley Tng <ackerleytng@google.com>, Gregory Price <gourry@gourry.net>, 
	Aravind Ramesh <arramesh@micron.com>, Ajay Joshi <ajayjoshi@micron.com>, 
	"venkataravis@micron.com" <venkataravis@micron.com>, 
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>, 
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, djbw@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 15 Apr 2026 at 02:16, Darrick J. Wong <djwong@kernel.org> wrote:

> Oh believe me, I had much angrier things to say elsewhere in 2023-24
> about grueling slowass reviews.  That is, indirectly, why I'm now
> working on /this/ project. :(

I've been there too.  Which is not an excuse to be an unresponsive
maintainer, but that's unfortunately exactly what seems to have
happened.

On the positive side, I really appreciate the energy all of you put
into improving fuse.

Some of the reasons for the lack of progress:

- Fuse has grown, and I don't have a full understanding of it, even
some of the core.  Getting older doesn't help, I'm sure I would've
handled this better 20 years ago.  Currently working on some cleanups,
progress is slow, will post the next batch shortly.  Cleaning it up
helps in multiple ways: a) I get to know the code better, b) adding
new stuff becomes easier.

- The fuse-iomap change is HUGE.  By line count it's some 40% of
current fuse code.  By comparison, when fuse was merged it was
3.5kloc.  It doesn't mean I wouldn't like to have it.  On the
contrary, I think it's a very useful feature and would solve the long
time issue with having a way to mount untrusted fs images with
reasonable performance.

- There's no such problem with famfs, it's relatively small and self
contained and I'd consider it ready (barring any roadblocks on the DAX
side).  But the famfs specific mapping interface is something that I
never did like.  Joanne offered to fix this, and I totally agree with
her that we should not hurriedly add interfaces that will need to be
kept for ever (yes, sometimes even API's are deprecated and removed,
but it's much much more painful).

How can this situation be improved?

A dedicated co-maintainer would definitely help, not sure how it would
work out in the fuse case.  With overlayfs I think it works nicely (at
least that's my impression, not sure what Amir thinks ;)

My experience is that face to face discussions at LSFMM will also help
move things forward.

Hope this helps.

Thanks,
Miklos
