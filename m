Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E37C035AC3B
	for <linux-fsdevel@vger.kernel.org>; Tue, 16 Jun 2026 14:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781619735; cv=none; b=ayjoEb0E0QY5W08XG1wihmyhVlVEKjlQSbq1nohhitakUY+NhKwy/E8FD1e5uFNTDbous3c13pj9mjnBPEUWqB83B/RK/PBptBMV1uMfmEeAvOy9TPG3ycxrs3sPzfcByfivlCywy9l82sRubYgEgIDNLIET9CPDgdJHESb2SH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781619735; c=relaxed/simple;
	bh=CA5nnvkspGUyTEG8HxXRVVazyc5v2cKfqM0DPMwJ6Iw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tS1gX2vZSv1g40S3PPPc6opxFOmbza6IpjRQIg6vSHFT0r2Sg0XiXomVmXrS/qzSqoaslTekb500RSJYDj4GkNMT9oXgFlHnjp96lkcZUdcwzBpJyvS0ATq48ROFGwczWrs0XxmO/7lx/zcdfCykbQ+GuudZju6zrJqi2Jyf1rE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=srcRDnwH; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="srcRDnwH"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-490ace40f4bso43686825e9.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 Jun 2026 07:22:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781619732; x=1782224532; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=hlgJdoH4I+7g281+Nqd5PThHYlDh2fBtSR189+cjOCE=;
        b=srcRDnwHagNIDelp/dm360BkJC4+dNV59gqeTl1AAIIviuS3XRUu4JQ3xkeHejlNWb
         IJ1B2yAF/s5XDUjoIlx6CCCSYY4N1N083X7NpJqb/8fAYybeF6m1EYvawVdzTEDXfSUs
         d1xKj0asBeHYcU1ls1SgHEJBEEvKCR6B4h7GViYpniOuqY4sVkjHDxAodu9Fuap2+sTA
         GdH9f6WwBkUC44HNlnhkOOS0rNmHnT/vI1Y51rXfgLi7RmwOmxmxrT052lHXX9cI706C
         Ihs3DEdqXlNlNvm8lFyqU7edMrzfz+nc4w2iZKOqBohbV1y56aSJkqhKM+85xyOwSit5
         sImw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781619732; x=1782224532;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hlgJdoH4I+7g281+Nqd5PThHYlDh2fBtSR189+cjOCE=;
        b=AyTqOXxeoOxlcZrbPVt1/1/2Utaw3xSk3wF95huCUk90qeNUJc5eZ6S+6YxD9m3l8n
         CNX6xzCOeigHjHw/qrDQyHW169lywBqeyA7wrtD47iAVQfy7PddMgCwGysAkaV015hMR
         3AO/ejYJt1rny8tVhO9B7KqPznB9KVHoEAG7tsfWRFTMeJd0vVQhyuu6Q8isni9oZehT
         K7Z6blC2e7/d9jOFIaIVUs6ekCRRLTvKHu9RNFEXPjtLf8rlPTI3GIRKLbjMfUAwN9h4
         YycV5yLufUKnPktl5Q96ZtvpnALu7XTfcOzrqM3ACMHj4nLOpsm7/gmQfv5PC5Jku0s7
         EN4g==
X-Forwarded-Encrypted: i=1; AFNElJ/IGlzMnveXz/rgIfjBtQMNR9/qbc5H8DvqyYN0Rwdn5FkujZkg5kPXc6XZuUMIPsXnI/c7Ujg+lhS2SJCl@vger.kernel.org
X-Gm-Message-State: AOJu0YykHM8PttsKbbVfsaKJAIcsCsF6TqPmtRoL2za6+MPKVgZLU0SG
	dEUXktbdxPzM3J9//JN212iLSgLxrHPEvBMQmUDe2vCcYNjkF+gTp4CG
X-Gm-Gg: Acq92OHDeT/MmSre4PiY8O2r63qUI08nDEdI/TjWeVorU+lQnInnOLwJa0CsRoAoGLR
	J51Pgxim46ew3+6DapTkNTZMNM08FEqMkwo0aLnKjJdRLD8EJiOFCEj1GijgyMwJmkQG18XWhx2
	vU9g1H8UKpPF9enGojWga+uzFSzcJpMmvm0NiLjwA8W+RTkVmgX1Msa6mqTQScNQSsGObPfnqDB
	A5jAnoorFlwx2zzCNjM0D42KANMo+JJdFRPh0MREnrnc5P/gCwpv54jckpNxRI07AUzhLAWanBy
	aCxTwlVbaNLfxk9LOdJztBaRkPwYMPuKa/kzPkQk7d32xOj+GHbE45LaTLD3McBih0tZSfKUJ+9
	KcheOsbgar9xFlH1NZxtFmgtOLF6LWS4pAxRzxupTn9iFlDsjNZ3SoXJ8hYVUnYbabDqerUErip
	DxRirZXqCwMF2KuRpmdfevHeB0Eb4eEY/WCzbQSUW4Bn12FlrN8BHdl881qhqncdLhwDHzUPu2I
	eRUk2WmvClFiyHI8hU=
X-Received: by 2002:a05:600c:2d0c:b0:490:58ef:cea7 with SMTP id 5b1f17b1804b1-492200dce50mr128613795e9.22.1781619731860;
        Tue, 16 Jun 2026 07:22:11 -0700 (PDT)
Received: from [10.128.10.215] (195-23-151-163.net.novis.pt. [195.23.151.163])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4606f2ce361sm43051695f8f.31.2026.06.16.07.22.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jun 2026 07:22:11 -0700 (PDT)
Sender: Julian Braha <julian.braha@gmail.com>
Message-ID: <b3c2fecb-0aa3-4ab0-b7a1-c8b9985e028b@gmail.com>
Date: Tue, 16 Jun 2026 15:22:10 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Ironic visualization in menuconfig for NTFS_FS vs NTFS3_FS
To: Xi Ruoyao <xry111@xry111.site>, linux-kbuild@vger.kernel.org
Cc: Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>,
 Hyunchul Lee <hyc.lee@gmail.com>, Mingcong Bai <jeffbai@aosc.io>,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <cbe95c15d2760f6fce8eaf207c969ce8fd3703aa.camel@xry111.site>
Content-Language: en-US
From: Julian Braha <julianbraha@gmail.com>
In-Reply-To: <cbe95c15d2760f6fce8eaf207c969ce8fd3703aa.camel@xry111.site>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Xi,

On 6/16/26 10:24, Xi Ruoyao wrote:
> Hi,
> 
> In the Kconfig for NTFS3 we now have:
> 
> config NTFS3_FS
>     tristate "NTFS Read-Write file system support"
>     depends on !NTFS_FS || m
> 
> It basically means some sort of conflict between NTFS_FS and NTFS3_FS. 
> But then menuconfig is apparently puzzled to believe NTFS3_FS "depends
> on" NTFS_FS, and put NTFS3_FS as a subentry of NTFS_FS:
> 
>   │ │    <M> NTFS file system support                                     │ │  
>   │ │    [ ]   NTFS debugging support (NEW)                               │ │  
>   │ │    [ ]   NTFS POSIX Access Control Lists (NEW)                      │ │  
>   │ │    <M>   NTFS Read-Write file system support                        │ │  
>   │ │    [ ]     64 bits per NTFS clusters                                │ │  
>   │ │    [*]     activate support of external compressions lzx/xpress     │ │  
>   │ │    [ ]     NTFS POSIX Access Control Lists                          │  

This looks like a bug in menuconfig's behavior, as from
Documentation/kbuild/kconfig-language.rst:
"If a menu entry somehow depends on the previous entry, it can be made a
submenu of it."

And since Kconfig treats 'source' similarly to C's '#include' (the text
of the file effectively just gets copy-pasted in), it's like the config
options in fs/ntfs3/Kconfig immediately follow the options in
fs/ntfs/Kconfig since the sources are back-to-back.

You can test this by simply adding some other, unrelated config option
between the two 'source' entries that doesn't depend on NTFS_FS or
!NTFS_FS.

So, anyway, it seems to be simply ignoring the '!', and just treating it
as a dependency.
And you can test this by removing that dependency on !NTFS_FS, which
causes menuconfig to stop rendering it as part of the menu.

I think your workaround is okay (there are other similar 'NO_' config
options in the kernel), but it would be better to fix this menuconfig
bug.

- Julian Braha
