Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30BEC32FA18
	for <linux-fsdevel@vger.kernel.org>; Fri, 24 Apr 2026 06:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777013855; cv=pass; b=fLVzXPXg/DIJLKCf7zfhwzJk2CGxAxqKZWsgSADVwvQctlEOmYqlDkW9yvTtx1YrcLC08/MPPAwYVhBWN77z+WcXnO41ig4+WtIiGJep/UNYhh0mGKVCwAEuvG4C3pWhdLh+hW4N3o6a/6XXOH2Plo//nLPT2FWKwlcYeHmq8Gc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777013855; c=relaxed/simple;
	bh=4GwIzdJUx2Kcw3exRRGxOr0HKxo9w+nymN/e/RTmPds=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Tcd/25K0PR+juigrGyJNt29jaAg7OaSq7AlVbIWhC70QaU2GhwYJfshfC2C3+VKsw2TwJ7FzNefe1qPzoat/Kn8T/XBJzcGQGHDzIo9J1CLI9l0xDiMaR0rqPK9IJf8b9z8XL6+NR2YCG06nUNULCSuMTM6YYDYiQXQqtBRgHug=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vceu4Ny8; arc=pass smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vceu4Ny8"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-671c24f23b1so10854119a12.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Apr 2026 23:57:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777013852; cv=none;
        d=google.com; s=arc-20240605;
        b=RyBML7/M70EoWg2SjNxVf2bjfA/JkHdoZs+IJI8/x9KPXsSZENdFU2MOaiYYflmnP1
         HKGmL9Tz86h/gjeza9j4c0pdRichcXudl5c+5TXFzDVUBXWxqDX4L+/NmHsYClnwbplr
         syDeJ6cTjHGOqA/zyiEtqViAAWs3t1uJFBLpS8s1C6HsbOLHlg8si6Smet54P3NYaxCH
         uPVsFZcGnLfWyYpqVOvYOhYj3uttqpbAitushCh7+TAOCEpJGbqzqW14KITNmjTlJubd
         33wmpnN+2OwOJc1+EgMdM99XiiYed9vHiz92By7XCvGj/IN+JFKAxrQf/9eCuM/2b3Dz
         j++g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1xbLIQ5Fuluw6Mpoy6KL9m+Q4rOLvVceUe/0sWgR12M=;
        fh=6iB5tNjJMvntNZ4IO1EFE3HTaWz/q2NY5+ZxsNUaXHI=;
        b=Cd1mgLQhziECwM7T4IwyMStosmM/RA/vYfpl/VRM+GTcQqpmwt7czIXYl9Ux+BrHKd
         AhfqLAl/2fWTzgBiZyvOI/tHnfhQH4XfzFDWfciW2lGral60FhW056bIzmSbCx4V+j+5
         u1i3AIwVvO/z9Enrt/3yG7Uv3chMftOy1bloTHDyrqHs1WcappqEKkaYgQqtkOgi+iUI
         d7tQwlSZgRhmrMPOksKuHYMvrT5SqiUWOLeTdtpn4oiy9+1x/drcDquWaNnV42AtcbFl
         F75YeIT66Vf3xfmHQsBkcCrporMVGSWccKLYR0KSKkzZneoRnJ7cgyAFOfVufNmQbhBp
         nZUw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777013852; x=1777618652; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1xbLIQ5Fuluw6Mpoy6KL9m+Q4rOLvVceUe/0sWgR12M=;
        b=Vceu4Ny8UZu8PbfbIEgniftLgcdI2HzgBkg9IeOIuXmIHPnIteJYqtKU4sQV0jmLiz
         lC3GOlIwWtYDlCQ7l6L1o9uAWFpkoVaDOAarneBeRRJjhajystXP17BP9/0KYxc+ssZz
         iTnyzlt27dNoBBys2Mhh+4BqWUpl0x/k7Sa74ADLZEoP0WEZChfL4RrOw6T6o71qnAtA
         S5wyo3h+OOYkD1G73vqyf1AzL2709mN0PKIccT6j8b2XcluVMuSYmdY/4S3B9viK3Hu8
         9FUbmj1z7KG+Cq391gWwBmy3ctuLf2P3jqNZ0yiM9MpBXo/gSTLjeXFTveh6hpoKaLI/
         +7bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777013852; x=1777618652;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1xbLIQ5Fuluw6Mpoy6KL9m+Q4rOLvVceUe/0sWgR12M=;
        b=gtdagLc48iBKAxLnvAZxQpUusL47razMvifLjsYaGtdLoSj85i1jSUvJSlR6R27Qwb
         NC8mEAsN7ejEAP2VZuiOqY+qpmm2WJAdu/6eJHm03aXI3k7bBOqp4QSVTK8Ukc9kXXTh
         LQW2LBQ+Gy1F8y0dxGw6V2ySr0uazrXwXJV9Xj+VpVKfoeZQ7MD/9127GPk0NmmGnwWi
         UPu8TfhcAKvir/5XJ8Q3OILiC8a2I6hywafzExBZbHJjA7Ks/tAlLxM9LeIQ7+U6LXnV
         GED7BPkSFMgUZhB101RH615DMBHw2t6otUd5y6IrtnmUg8XqVF7uUHxb/3UDzn9InQJf
         ztRw==
X-Forwarded-Encrypted: i=1; AFNElJ9R6OLk/r0fFcMBnSLSM/qJppvKL6/pCM//m6PvN7VzEBXviP6+cBk9uU1SUPfKuuktAFNi45I8OPxBPRn0@vger.kernel.org
X-Gm-Message-State: AOJu0YwJyZEEeKBniHuTr/Jp9pIFBkPj2r8tBXlH+7Hc1/hvvreuyRkM
	LlaWwj+lt285CjsCA/fWmzhB+GrHN5N99Tb5GKMgFf+2XZQwcHEqGPc8+SqhIyW0VNPi+/uAuU/
	BjX/JwT49NdiIpXe6zQWTHsXBthYd92w=
X-Gm-Gg: AeBDieuVCHnzF0CdWSSiYbd+t6wJ1K79xx8fizTWpyccz59AD7NBRg5xMszZcZvNPjt
	Br+P2qRVkNyo4ekNvqrCAL+ctHuVKDiCsFSqF5gkW68OeHRuW9aDTTZgsaiB9PqVZLU4FAztRIJ
	GEUHrM31CzCw0n66Ib0mgjYbCWmqcArH5d+gyzu35MTogJvNtuWzW67wtRU0YHvElf019DcB44Y
	5C46etLtVWzkQ61igWVagemcJizGF5sJs7gMbFu96gnkQpgHrQbcYuTvvGe+fSYcoSKQ93fZ6zP
	oZeBQ2CHjjY2jJA2w3TdxhQJTj8Z+mvMBtf16zqX+BF188fxhH6OQAyoQPWA3B0=
X-Received: by 2002:a17:907:97ca:b0:b9f:9e7a:bcd2 with SMTP id
 a640c23a62f3a-ba41a632e8cmr1588080466b.38.1777013852060; Thu, 23 Apr 2026
 23:57:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <d0c4d95b-8064-4a7e-996d-7ad40eb4976b@linux.dev>
 <wlxxrx10.ritesh.list@gmail.com> <aer0wd2Ig0hjN3R0@casper.infradead.org> <v7dhrmgc.ritesh.list@gmail.com>
In-Reply-To: <v7dhrmgc.ritesh.list@gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 24 Apr 2026 08:57:18 +0200
X-Gm-Features: AQROBzA7au-Rxnv_gU_TeRNbE7y_vZ61_PUN4YtNXKiJVY5WHIMs7q432z4NtWM
Message-ID: <CAOQ4uxi0bTwj7oCWR1iOhqzPkB94cVgh=9Prh1kHxnObuLCz0g@mail.gmail.com>
Subject: Re: [LSF/MM/BPF TOPIC] Buffered atomic writes
To: Ritesh Harjani <ritesh.list@gmail.com>, Matthew Wilcox <willy@infradead.org>
Cc: Christian Brauner <brauner@kernel.org>, lsf-pc@lists.linux-foundation.org, 
	Jan Kara <jack@suse.cz>, Ojaswin Mujoo <ojaswin@linux.ibm.com>, 
	Pankaj Raghav <pankaj.raghav@linux.dev>, Andres Freund <andres@anarazel.de>, djwong@kernel.org, 
	john.g.garry@oracle.com, hch@lst.de, Luis Chamberlain <mcgrof@kernel.org>, 
	dchinner@redhat.com, Javier Gonzalez <javier.gonz@samsung.com>, gost.dev@samsung.com, 
	tytso@mit.edu, p.raghav@samsung.com, vi.shah@samsung.com, 
	linux-xfs@vger.kernel.org, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
	"Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 24, 2026 at 7:07=E2=80=AFAM Ritesh Harjani <ritesh.list@gmail.c=
om> wrote:
>
> Matthew Wilcox <willy@infradead.org> writes:
>
> > On Fri, Apr 24, 2026 at 06:32:03AM +0530, Ritesh Harjani wrote:
> >> We were thinking if it is possible to extend the Buffered Atomic Write
> >> session into two "continuous" halves of 30mins each (total of 60mins)?
> >
> > This is painful because you've requested me, plus both Storage and FS.
> > FS has lots of space, but I don't, and Storage is also pretty full.
>
> I see, sorry about making your (and PC) life difficult here. I know it's
> a lot of planning :(
>
> I think, both FS+IO folks will be interested to discuss both of these
> topics. Do you think breaking this into two discontiguous session help
> us plan better maybe? In case if we don't have any continuous slot, then
> maybe we can split those into two.
>

I scheduled the two sessions as you requested 9:30-10:30
for FS+IO and moved Parallel Writeback to Wednesday
across the MM CXL session.

> >
> > Do you need me for the full hour or just half of it?
>
> Although I understand buffered writethrough is an FS related area, but I
> am sure a new writethrough I/O path is an overlap for you in page cache
> as well :)  So, yes, it will be good to have your feedback on the second
> part of this discussion which is - buffered write-through for buffered
> atomic writes.
>

Matthew,

I don't know why Parallel Writeback was scheduled as an MM session,
but if you think it should include MM, could you move the CXL session
to the now free MM slot on Monday 9:30, so that we can extend
Parallel Writeback into MM?

This will allow you to participate in the atomic buffered write sessions.

Thanks,
Amir.
