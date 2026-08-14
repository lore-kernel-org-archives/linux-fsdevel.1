Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C580B46C4CF
	for <linux-fsdevel@vger.kernel.org>; Fri, 14 Aug 2026 12:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786711383; cv=none; b=r1rbYPPzTERg59UujYr0f4+LQu9q4a6aXUsfgwmuJz3zBoloWZxqS2+BruVkUgZFavhjyPhxJBjrnDxTMggsUBxgbsnGe/lhfXQsHtxDL9fwETX3eNYhDMJBV2KFxTN3MCbLdCJAKrbkpdxz37GEBWr/1wV17ED7rQrGu1xCA60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786711383; c=relaxed/simple;
	bh=YsXKrU2V14EOOwNRMzXWg2RnA6RSWoUHPKpJRV+vxmc=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l4P4Sm8n4aQQCXzsTB50AnnVjYD67YA9GqGIqaeUg+BMVN9ZlXTGmtPJH2guIv5tmDRdGVSg9kqe9z4qktE3W7+4BWAcreV+8JgdyFbp/HLnNjPjkJwRetsFSE9Qhs+bdIxJKOipoStZKqHuv6kL6A2KRptsw4y5fkHPWqISPxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A0gbeVp9; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A0gbeVp9"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-38ec1402b05so767633a91.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 14 Aug 2026 05:43:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786711381; x=1787316181; darn=vger.kernel.org;
        h=content-type:mime-version:user-agent:references:in-reply-to:subject
         :cc:to:from:message-id:date:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=GROTtVEhO+sxIkIUN+C4wkQjV/TpVr5EltjZRDElHMY=;
        b=A0gbeVp9VYnaPslitwmK2gKA7wIvIi5/lZPCe1d5gPRv+mhK1ndINVuWofw5Kjjqaq
         3ma2rUiOwV0fLpNXE/ZJrcd/GA7GSh/YP6F5AJhfUDsT+BdvyzRswjKvPyXpaOwxHt1T
         sTr/mtiXOA9dyqaGPSiHnDgA63znkAOhkHAZQsx8V1FrSleQv0vqfzFjH3qv3rUBkPOb
         7WhS0nqLl0T2HrtMUzzybfh4Mmhx40Qsqx+CxRN/0jT8vXwi9rTxoYP8zt5AkiNEbi+V
         kd9GoCaH9oN4x8+KnFsNwLu0QvxMo+5zISQtVxxJc8XzItZ7ft3BpbsmAhmKEVxc+5Aq
         7/tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786711381; x=1787316181;
        h=content-type:mime-version:user-agent:references:in-reply-to:subject
         :cc:to:from:message-id:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=GROTtVEhO+sxIkIUN+C4wkQjV/TpVr5EltjZRDElHMY=;
        b=ktufNDhAixkIXhJBfGQP+vCeU18JtVZuLfthJ1fu4tGL2Juz6XOVpgaf6S62rkcxhV
         oxR359xZrOpfBYee4oXsOWfVhGkq17AuJ4JjzwI++DCKFeC8N4wyTU+Sx/9pnQ7qz2TR
         RyDvN0iU33u5zstKeZPqPDH53cHbhRv4j8GG4NQ34+E7qvREDAZZX+GfkGkpxetGKVfV
         ZQXmdjlJtgE+0aal5W71iBf7uJRNWzD9DILUcMD/nZaw6gENu2+XDB4qZv64f0OtKtdf
         bXle+ZiXMlgdFqkofx02lCIyCAizE62rm2aHenmCXfAmN2g/JQ+XaKKNhtMs7bg1/gxx
         Q0GA==
X-Forwarded-Encrypted: i=1; AHgh+Rq5ej4zA6Zsu1bYrx21xp7rkYR6hrRwBY7NfnoMwOgLBof8kQGfBAHy12r71M130GRS04bdh62/HnDKD22V@vger.kernel.org
X-Gm-Message-State: AOJu0YzD5r3IUE93Dpj3j5OZdlKIzFI4jwdW8CZb7gJRrsJVEGgeQTM1
	EI8Lsd7ygyPwVgbv3CP+VkJIZANKScf7JK5BZfYFDUuz47lanTCvrBn+
X-Gm-Gg: AR+sD11ss7MgTmmJGYyKJjBVt5/bChLfy90TDgOE7k9RNnr5p65aL/w5xDchTYp3Equ
	fU5i9gkf5ptwUU6sjUhAc5Mpkgob6D2fHWMaX/D8C5SWPAAXF7VQOLJU+WgGfIJ5ekMLv7saTBd
	42Y5v6nmlqUuPmt4Bu+v4xZ2ckacRrjGESs5HbK2gk4i8W/BRdtoRJjoG8FLR2eNQ0hnAfLG059
	+Q5FHjCpA9xvwVaqxlYxUoAJxs+RGGpxVPsTJ+8bT4sdoiAI7XkYCt/olx3WqoOuRTYs6Ua8t3F
	FqqwD9yrcfR6U6Mg2W93Gkexdn+6C20caRy/juz6FbvLNGNPqFvAVyWpPrVAwKauyUGgXbqrWNT
	F6lNrCAhRq2hESZ4t1Ml3TT+T8ysJJWGftQPhiQgxrpORuABGvVMtkgrnoWJU98KCWo5T2GZdLM
	xQrxK5YP8CJ4qLBhgzbZn91gKjs1PFo49gH07UAdjgAOLKZJBNRz7qut8wV9Z/Zct4CO/ptNW+g
	4S4G73YuZds4PiCH6H8nkmoX2+M6TfPNokPm5UgLSPDzNORYMm8gxKgfM0iDqDSQwBMs1TeBBZT
	9QEJ9Q==
X-Received: by 2002:a17:90b:3842:b0:38e:524:8797 with SMTP id 98e67ed59e1d1-3933b89a285mr4743746a91.13.1786711380964;
        Fri, 14 Aug 2026 05:43:00 -0700 (PDT)
Received: from mars.local.gmail.com (221x241x217x81.ap221.ftth.ucom.ne.jp. [221.241.217.81])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-394eb7539d3sm2774290a91.15.2026.08.14.05.42.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 05:43:00 -0700 (PDT)
Date: Fri, 14 Aug 2026 21:42:57 +0900
Message-ID: <m25x1crhym.wl-thehajime@gmail.com>
From: Hajime Tazaki <thehajime@gmail.com>
To: ljs@kernel.org
Cc: daniel@thingy.jp,
	gregkh@linuxfoundation.org,
	linux-mm@kvack.org,
	geert@linux-m68k.org,
	arnd@arndb.de,
	willy@infradead.org,
	jack@suse.cz,
	akpm@linux-foundation.org,
	liam@infradead.org,
	vbabka@kernel.org,
	jannh@google.com,
	pfalcato@suse.de,
	linux-fsdevel@vger.kernel.org
Subject: Re: [RFC PATCH 3/6] mm: nommu: fix an issue on map request to /dev/zero
In-Reply-To: <an3COKVbgQKdY52d@lucifer>
References: <20260813063401.1786548-1-thehajime@gmail.com>
	<20260813063401.1786548-4-thehajime@gmail.com>
	<2026081355-remold-sterility-84f9@gregkh>
	<CAFr9PX=zC8GnxwrR=wTwA4xQq89cHYpxZWooS+-=Q-WuNbjanQ@mail.gmail.com>
	<an3COKVbgQKdY52d@lucifer>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII


Hello Lorenzo,

On Thu, 13 Aug 2026 22:29:38 +0900,
Lorenzo Stoakes (ARM) wrote:
> 
> On Thu, Aug 13, 2026 at 09:43:37PM +0900, Daniel Palmer wrote:
> > Hi Greg,
> >
> > On Thu, 13 Aug 2026 at 21:26, Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> >
> > > Given the age of this issue, I don't think anyone uses no-mmu systems
> > > anymore :(
> >
> > There are a few of us using it for hobby stuff[0][1] and there are
> > apparently people using it for actual commercial stuff.
> > There was a session about this at LPC 2025...
> >
> > One of the big problems for nommu seems to be that everyone is
> > convinced it is completely unused and totally broken. :)
> 
> No, the issue is that nobody seems to do any testing or contribute any code
> aside from at least Hajime (thanks Haijme :), and possibly others (forgive me if
> I am missing people's names here!)
> 
> There's been situtions where nommu has been broken for a year and _nobody
> noticed_.
> 
> And yet whenever nommu comes up people always seem to pop up and say how
> important it is, then mention a talk etc.
> 
> Well if it's important, test it. Test the tip kernel. Report bugs. Contribute
> code. Any or all of it :)
> 
> Meanwhile we in mm have to _constantly_ fix stuff up in nommu because it's a
> total mess and has real maintenance overhead.
> 
> Having to account for legacy systems that make no sense in 2026 when you're
> trying to make improvements to systems people use, or not being able to do
> certain things, really grates after a while.
> 
> I mean if you don't believe me git log mm/nommu.c. This overhead reason is why I
> now co-maintain it.

after spending more times to look at code, fixing issues, finding
other flaws, etc, now I become to understand what you meant in past
emails, when you're saying a more maintainable way of implementation
of nommu.c.

Since I wish to use nommu.c in future with the latest kernel, I'd like
to contribute it for, let's say, refactoring the nommu component which
mm subsystem currently has.

but for the moment, I wish to start with introducing test cases from
very basic checks (which is in the [6/6] patch of this series).
Without such a base, we may not have any chances to improve this nasty
situation of nommu component in mm subsystem.

# this motivation also applies to LTP (linux test project) which
  currently doesn't support running tests on nommu platforms (I've
  already started).

And also as I mentioned before, ideally the code should be maintained
by people who use it.  And if I claimed that I used/use/will use
nommu.c, I wish to maintain this, or at least wish to help to decrease
the overhead of maintainers.  This series is a very fist step toward
this.

I hope it clarifies a bit for your concerns,
-- Hajime

