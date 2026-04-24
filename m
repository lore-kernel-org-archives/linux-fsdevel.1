Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84AB22264A9
	for <linux-fsdevel@vger.kernel.org>; Fri, 24 Apr 2026 06:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777011617; cv=pass; b=J0g7Z2iWDyzMtQdigYk8Jl9k2I4FV7TAhvEQweOoPosaIkCowZQSGlTEgRhljUDVff5A0GblWV7TRMldERIigo2UJHSM4x6MmIUowpTD4Jj3OcipGIhZ0xhwkX+O71dB4buKFeFLNk/FI8a3WePS/fRGPSvkpFWkghUQy+9dVMg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777011617; c=relaxed/simple;
	bh=PaFyE7ndfL0ohzdx/jY8C7iuc7OPf9ZY/aOGta7YR0E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TkEEfFB0sn+48vKShgumEUvilXtW5sFx0QHFsJCusB6OzOsd9HDHrrLVB4RglHg6qK4S/UZifeA3NgN+bNL4Y7wvEJ7t5UMwmRA7/quv1a4b4BsXvjTzC7h+/4mizMP0KINBwUE8b5ltJUbgk06D7EKhLEF0efz+cN7tlNjKH9U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WY6Y7Jih; arc=pass smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WY6Y7Jih"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-676e62faf2bso5186011a12.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Apr 2026 23:20:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777011615; cv=none;
        d=google.com; s=arc-20240605;
        b=OqGruIUioi+htkahFxgzEAvXmJm7tFuIXlxONwVQf8RrzJVtPAhCpM8v241oJKcRKF
         6M9E3aekc4KbYH6OETPZFbfMGYch+o12npBBzXL/NFNt4nmAzsBFk7f3ZUpxtx9HbJoW
         voR6G0sZAUBFdB/gXng8HC4Xo0IqeI7JL++MUh8Ie7ADhSxQ67JXfAKfU82Am7+yMTcU
         /PxualafNzX/A00QnA04xI1jLkOo/hHq9YhOrtc4t1QQ/fYC/bLkQJookTvcEmXJ+FuY
         mjxELsdnCMhvLDDesscneXm3eHFkKSI98OxByvlaabD4cnR/6Z69dENxVFO8zawTf9Nx
         YxXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NHT+ZbrFQ1d6JCVRomWC8t8Safh9vXTXuXoPxJbXGH0=;
        fh=p8uMagBhg4f++PSb7UUhj5aRK1xrNbdU+q3nHOS3BZ8=;
        b=ksp7ol7qMkQ+g2JB4PdN89HnSm486xDBGgBjdUAje1bZbXcYaeE5rOHzcnqeIFA2zK
         9+C7dNluHGdH8ACu0F1A5sxROoquwalE9eS+Fguon7YdxB+6bfEAoEewE7mGpbH9+4W5
         V/Sz4+9aR75H5y7C7NlgHkLD9KgvSDeOvWeQoZy2mngLze7jvMdFRZTreHXfUn7ZzMKK
         tXeYFzAAENhwNU1EJNPeZB6y+rULQYh7qLDenxRu9NrSVzQ12y4zGM6PDAJtoabOVeR9
         s+PJUNjXufeK2AYo/1PSQtVoR+d1/xt7p6spztd7v8PBi9KC8dy+cl3J649T31eXOUx2
         Fahg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777011615; x=1777616415; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NHT+ZbrFQ1d6JCVRomWC8t8Safh9vXTXuXoPxJbXGH0=;
        b=WY6Y7JihzvL4kLoIIfcwPV0CYQnnzBDcYRo61v8Wf9XPhC8y6vWoHOrYF0XI7l0Laq
         vif8mtRadsGMuYXHcMP8XbKW6ri4glYPzR854snW84eDVPbU6jJ4sd7R7vSqf+mrZN6q
         jToGH4PPGVOY8lp4s2nXpxRbOMKTbTXQT7ENFgCtmpdltT+S+e9GuEoQKvIet3N0iLzZ
         Tu2PuD6wKfEao3IwzV3S5etUDDr9qArcaBwDm5e9+WjodfnjfZBwgGesd6raNRFJNefs
         XKcL9zVdk6opc6YD+jB/m/AYtWX9C+F7N9pyicLl04Jzmj//ZlH4Ar15Un9XeXhCSS2d
         m1XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777011615; x=1777616415;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NHT+ZbrFQ1d6JCVRomWC8t8Safh9vXTXuXoPxJbXGH0=;
        b=OOPEgdLGXTPCGAY45q6JZedZLaF0GpuN8zIJEPGXPutZdm9yDEOVWAtflhVe/2uWE2
         681GbR4RLnLZbTIof1WZQAMgW562ksjWa/ajwnaHmZA5LYEP7bMFGsOV5r3pPCv4sOl+
         m4ZxZAeKA9Il9Vu/SKvzstVXtLynrS3bHpukql8Fe8Y+22xYPr3TXhkqEBnLt50e1Uum
         DdEDeOyNdbZLzAhMmxIt/KxGSALOgUx/9WVQCWPnrLWtgvyXv1JLhopg/4hAlM8GQhCA
         IXenPsnQfoM+NsGklLiQgvbtQ1NAVYlvay4DM+zAJItv/X98MJaL2ITZBaG4FLRYDPfD
         GBiw==
X-Forwarded-Encrypted: i=1; AFNElJ9krC4J/Z5AbINDIfJl3R/33AlmdnT+8k4Z6JPd0QKF/WxHzCzOsUpvl2Lssfpeb6bn1CUSE/Q3ujwUaNxI@vger.kernel.org
X-Gm-Message-State: AOJu0YwGFfoPuaJmRXgDiKFeVOLHxd5TzuAbL2HA/XRlfyiX7hawimMQ
	Vege2fIA6KT0AKpXS8BGZoLKP4bWMWrMpw8KgsxUd7YSBybsNoY5Jjrrh8z7/tYhwGWC1o1bRym
	WdwpHe6CPLvUhJMkgPryggeGk3wChdRM=
X-Gm-Gg: AeBDievRkQwZISVZXo+gxA3xo3IBvq+iAD8pcjgvOqE5ESwZtQOU2MFR2z/LrYV/YqR
	q+3YuM0CcqjhRZp3KKrbxiTd3QMe2TXvgtyoV2Hzb9ZYeDWuNNreCw9/jWzCmHSKMX3g7ZCDLTG
	TmGXzV+n4pbwBmed0cbT1+YTsPecE3WfuNtEaGEZqqtnBvN6TxAGqj04WHMkTnClLPQY3ajFZr3
	V3UlpS3pmMqQ9Gs9BBdgTkqGpIf2h4i2RclWmoim5iUi1i9HqCbj648cDyf345OGTzSzIObxNue
	pvj9jUlwa0Oi08/kzxoo5UD4K3cNdJbk/TD6nTBb2Gw++9SGgw==
X-Received: by 2002:a05:6402:28c8:b0:677:270f:6f4b with SMTP id
 4fb4d7f45d1cf-677270f7f6cmr3673799a12.1.1777011614631; Thu, 23 Apr 2026
 23:20:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260421020932.3212532-1-liuyibin@hygon.cn> <aeikm2e5Gh5reJ30@lucifer>
 <bc514883d6154420b3cfde4ab25a20c7@hygon.cn> <aejzSsiXZBK1emv7@lucifer>
 <a96c20b74b874248bc0cdc2b926a43fe@hygon.cn> <aerhh_tzSs5XapUz@casper.infradead.org>
In-Reply-To: <aerhh_tzSs5XapUz@casper.infradead.org>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Fri, 24 Apr 2026 08:20:01 +0200
X-Gm-Features: AQROBzCMZgHVIUyd2eInZGYwOMcnSg29XnDK8mRT8aosN_mcUyOqAAyW9pt2pWQ
Message-ID: <CAGudoHGnOMj7O0P0pttdgdhGnJq8+Nv3_91x8kEAT5wR_xDmgQ@mail.gmail.com>
Subject: =?UTF-8?B?UmU6IOetlOWkjTog562U5aSNOiBbUEFUQ0hdIG1tOiBBZGQgUldIX1JNQVBfRVhDTFVERQ==?=
	=?UTF-8?B?IGZsYWcgdG8gZXhjbHVkZSBmaWxlcyBmcm9tIHJtYXAgc2hhcmluZw==?=
To: Matthew Wilcox <willy@infradead.org>
Cc: Yibin Liu <liuyibin@hygon.cn>, Lorenzo Stoakes <ljs@kernel.org>, 
	"linux-mm@kvack.org" <linux-mm@kvack.org>, 
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>, 
	"Liam.Howlett@oracle.com" <Liam.Howlett@oracle.com>, 
	"viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>, "brauner@kernel.org" <brauner@kernel.org>, 
	Jianyong Wu <wujianyong@hygon.cn>, Huangsj <huangsj@hygon.cn>, Yuan Zhong <zhongyuan@hygon.cn>, 
	"jack@suse.cz" <jack@suse.cz>, "jlayton@kernel.org" <jlayton@kernel.org>, 
	"chuck.lever@oracle.com" <chuck.lever@oracle.com>, "alex.aring@gmail.com" <alex.aring@gmail.com>, 
	"vbabka@kernel.org" <vbabka@kernel.org>, "jannh@google.com" <jannh@google.com>, 
	"pfalcato@suse.de" <pfalcato@suse.de>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 24, 2026 at 5:20=E2=80=AFAM Matthew Wilcox <willy@infradead.org=
> wrote:
>
> On Fri, Apr 24, 2026 at 01:08:35AM +0000, Yibin Liu wrote:
> > On an Intel Emerald Rapids server (112 cores), run the execl benchmark =
from
> > UnixBench with the command: ./Run -c 220 execl
> > Then perf top shows:
> >
> >   91.53%  [kernel]                    [k] osq_lock
> >    0.50%  [kernel]                    [k] rwsem_spin_on_owner
>
> OK, but does this represent a realistic workload?  It's pretty easy to
> construct workloads that hammer on particular locks; the question is
> whether it's a relevant performance bottleneck that customers care about.

This is a genuine problem when doing large-scale package building.
I'll say upfront I have extensive experience with this crap on
FreeBSD, I did not run it on Linux myself, but bear with me here --
while FreeBSD is in doubt a less scalable kernel, Linux demonstrated
to be suffering from the same problems.

Say you have a box with a core count of 100 and get it to work
building up to 100 packages at a time. Further, even if you use some
form of separation from file-system standpoint on userspace level, you
still want to share the common binaries to reduce memory + cache
footprint so you at least --bind them. Then you are susceptible to
contention issues at least on paper.

Granted, building a pig like chromium scales great because it is
written in c++ and almost all of the time is spent in userspace, with
forks and execs of the compiler highly spread out in time, in turn
putting very little pressure on the locks.

However, vast majority of packages is very tiny in comparison
(literally a few .c files) and this is where things go south as they
engage in exec frenzy, looking like a borderline microbenchmark. The
primary culprit is configure scripts, issuing an idiotic number of
back-to-back execs of short-lived processes (notably sed, but also
grep, rm and others). There is a lot of evil in makefiles as well.

I don't have numbers handy, but in case of the FreeBSD ports tree we
are talking about over 10 000 ports which on their own take few
seconds to build. Since these are largely single-threaded, if you have
package-building machinery which can saturate the box, you easily end
up with parallel builds matching your core count. And when they engage
in exec-frenzy for the duration, you may as well be microbenchmarking
it.

A sufficiently pessimized workload is indistinguishable from a
microbenchmark and this here is an example of one.

iow this is a real problem, but I don't have specific numbers for Linux.
