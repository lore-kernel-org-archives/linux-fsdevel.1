Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2A163603FB
	for <linux-fsdevel@vger.kernel.org>; Wed,  8 Apr 2026 02:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775616863; cv=none; b=CLpd+llc+hyRpSpwWlQNgMyTTjbC6Scea+5+Ic9b3ISL3RT2C7xhWut4TTB64V/NHhLFIGsha0hpp9VekEOGXft+/r3TbGy1S6rZdRiTVYfBzB7z2pVs3rDz3g2sd89aSbmuFFFfH/XYD/woPIa/aVzPkBkptgRjG9OVsF5519w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775616863; c=relaxed/simple;
	bh=/LsGG8fyDJdk0nB/2+CPab2G575SfdRCyYn3V+orZ2A=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=BJ7+ImTxqNzjOqoYOSPrkUNiumWZ2CzBUPsXyq/IS99nK6oTW66iQhNymjYFM6xpQ23l5MhAcBVgJ0bofYxZUNldjeiDLyutWetFIjQw16T2ytK3FPfrF2kgVlCrIn1LVgH5ou2WJwm9CX1RlTz1hIclbmevLIydu+vj3tM+9Wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HDECuNUg; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HDECuNUg"
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-408778a8ec4so3495306fac.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 07 Apr 2026 19:54:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775616860; x=1776221660; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=JEL13xtDv41LlRYS3s5MQx8Hg/AYy31h+VDDos6Ewbs=;
        b=HDECuNUgEY4GLVcPPwocvCWKrkA706UFEP75EXT9y6qQtAIK45KpNfxJS+VIm/rU6G
         /ysUjupjsSDJATagvLPjZXg1kacz1dcmtIZAlpHQJR4D/sbY5YKAv1xATfEvHhW6/+gA
         oyXvG5nue/VD5RbubONewrP+iFftZfEDCa0ZghtKjH9fFNsuMWHqVPFJMD+eLq51T1mE
         Qicn5G0xhmJqMwB8qTdZGeZBndJb1813PLvsQC6foaoq5pX8rP3C9qUG/xySJfP/F+my
         JQepLQn3YqFxAOV1auhCvfesnYcYIQhVYOLh84C2KyHJgeYYglCfrAek1WYFnMXI2xDE
         8BTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775616860; x=1776221660;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JEL13xtDv41LlRYS3s5MQx8Hg/AYy31h+VDDos6Ewbs=;
        b=NoTgE/O/7bhgqGo4eH/tZA2kxXuaN/dzM4Z21bwA/u+1yRBVqKGvTGxP3cPkCz6/av
         G0FoiNlxsn/IUYNzd6M5vA/TGqqF7Fzm9eKkh3vUiAvpqwkPi6KQMvQLr08HDfHWJA+5
         iONbTW6nc/si+O1+3MmJciFCUZw+mIra/sv8Hk3bQQ5T9+bTXfknJqK7Xsx2CQZUrpDA
         oFwAIfYo5Xm3DKC7Cn+9DGEuR/Ig6yOYdYVEHKdsrkCGq2ql//qiSozs4jk17hWp9+zZ
         bvcRDsVXM6Aw2kOMqEosm2b5BKKxMM8BBGa1+7tOPIaApT/4o4TC9w0EYJ6NgOo9T+q1
         XEzw==
X-Gm-Message-State: AOJu0YxlVbWZgvqBFZhmu7mPs5tymDt3pdW9Ne7XMEEvKJVPacuumDgv
	nn3Y0+pb0nU9rIK1I9kdpZ5j2XyVsX+hMRSeVSKzz3XyJI4dkQr+TxPZujJRl0k2
X-Gm-Gg: AeBDiet2Z5PY0ouOiEY8fY7/hTl63+5nxnT/ZFMiHiyjdQp52MwUwLmBDNpLNseUaEJ
	G3FwJcoLVvzflkhJhD7A9wQCWsKkSAyp+00SCYIeuSMFvU7un6zt54VN8IE1xUPxY+iZLa06o2k
	8kTQpvtQSKP6v4NPKkz4/f38WWtWTgb4vQiVAuxBfsM4vUQK8//FYXH5kR3X42sJSxSl/R8+SF4
	2vNyiNY0bopCcUaq89LVxZZ3za6VA4wJwW1HS9kZ3nUDPCktdGg/JMUC6TN5DpY2n4bLrkx76jd
	L3W+NsKZXN6bwaET7/dWyu+6Cnl6rYB9suxyMBfuhmag8t5/tq+WGtY2Sotm3xfKnsn79ycLhbg
	0XkPDL9BeidwMClBuhYRPxn2zTx997vOmUJR1tJQ8CMUDFGstP+Xsauxo10PGamLYN93ki3nG5Q
	bhpFMysLRqJFUhjdKX/t4kUxKAvJMaRe2d2z0JGCd7F6kyphrZChgabzw1Wzj29JPG4PgA45hKG
	svNRPl/
X-Received: by 2002:a05:6870:174f:b0:417:a84c:4d8c with SMTP id 586e51a60fabf-4230fd7c2e8mr12144349fac.15.1775616860346;
        Tue, 07 Apr 2026 19:54:20 -0700 (PDT)
Received: from [192.168.50.127] (c-73-5-99-191.hsd1.la.comcast.net. [73.5.99.191])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-42356d581c1sm6893598fac.4.2026.04.07.19.54.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Apr 2026 19:54:19 -0700 (PDT)
From: Sean Smith <defendthedisabled@gmail.com>
X-Google-Original-From: Sean Smith <DefendTheDisabled@gmail.com>
Message-ID: <92e61267-eb24-4f94-b9a1-e009b5e00d65@gmail.com>
Date: Tue, 7 Apr 2026 21:54:17 -0500
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 0/6] provenance_time (ptime): a new settable
 timestamp for cross-filesystem provenance
To: Theodore Tso <tytso@mit.edu>
Cc: linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-btrfs@vger.kernel.org, dsterba@suse.com, david@fromorbit.com,
 brauner@kernel.org, osandov@osandov.com, almaz@kernel.org,
 hirofumi@mail.parknet.co.jp, linkinjeon@kernel.org
References: <20260405225442.GA1763@macsyma-wired.lan>
 <20260407000558.417-1-DefendTheDisabled@gmail.com>
 <20260407233618.GB12536@macsyma-wired.lan>
Content-Language: en-US
In-Reply-To: <20260407233618.GB12536@macsyma-wired.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/7/2026 18:36, Theodore Tso wrote:
> Yelch.   This is so *very* non-Unixy / non-POSIX / non-Linux.
> 
> I understand why it's convenient for your particular use case, but
> rename(2) is fundamentally an operation which works on directory
> entries.  We don't copy over extended attributes, or Posix ACL's, or
> Unix permission mode bits, because (a) that would violate POSIX and
> historical Unix behavior, and (b) because rename(2) is fundamentally a
> directory entry operation.  This is despite the fact that it be more
> convenient if we didn't have to copy over things like extended
> attributes, ACL's, permission mode bits, etc.  So you want to make an
> exception for ptime?   Yelch.  Just Yelch.
> 
> 						- Ted

[written by Sean]

Finding an alternative to using rename() to transfer ptime between
inodes during atomic saves seems beyond the scope of what I can address
as someone who relies upon AI agents to review and modify code. From
what my agents have been able to explain to me, the options here are
using rename() to transfer ptime via the kernel, or using renameat2 to
require each application to manually preserve/transfer ptime. The latter
is, well, the phrase herding cats might be an understatement of the
difficulty involved.

As an individual, I don't see how I could convince every major
open-source and closed source application developer for Linux to code
their application to preserve and transfer ptime. That seems like
something only leadership in the community has any chance of doing, and
even then, that would be a very slow-moving process.

It also doesn't solve the immediate needs of increasing number of users
who are trying to ditch Windows for Linux. Windows 11 has pushed one too
many people too far, and they, like me, have had enough.

Maybe senior developers can find an alternative to rename() that works.
I can cross my fingers and hope. Discussing matters with my agents we
couldn't find one. The need for ptime is very real, and the code in my
patch gets the job done, but a solution that respects conventions
requires a level of expertise I don't have. Perhaps in 4-8 months when
my AI harness is more mature and smarter models are available we can
solve this.

If the rename() code making atomic saves work prevents an upstream
merge, I understand. It would be messy adding ptime to the kernel only
to have it disappear anytime any unpatched application modified a file.
Avoiding such failure modes is why it seemed necessary to take a kernel
level approach.

Additionally, the reason an xattr ptime isn't a viable solution is
because applications do not reliably support xattr transfer. Thus it
would not seem likely ptime would receive better support.

I can patch every application I use which is open-source, or I can patch
the kernel. Rational analysis requires that I patch the kernel.

I'll continue using the rename-over approach in my own system, and
maintaining a github repo so that others who need it can patch their own
kernels. As the phrase goes, it's better than nothing. If there's a path
that respects conventions, I'm genuinely interested in guidance.

- Sean

