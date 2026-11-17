Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794905254;
	b=zNWohxKIVp6/N9ZpuvAfabR+MDQnZ97l+El5fWbxrzCAzhiG9k26bMshceQJ6Kv831K+
	 jaZ+giz0b8FFInO5skq7akoHB4zJS+xNYoIA8jke40FhRZl+dbEPvPocnEupbAn/VjUVb
	 mF+3UNNGhVDdn/3KLbMhQ8/voLG0HCGKR3E7D5HrAiui1C4xjbn36h03vVra1o7+ad0q+
	 tbnC/Vf7i92WtVLZD6R6uFWcEVarIiBrzlyzjpet34NzmSkQOpBhhoMmTBa/qdAanwPOb
	 v4rjwBSXH6ePLsKg9FpEALPbQ3Yw8EOIYDOKhFOBbyCQhX4Vb1er8r8SptRZsKu2+lg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794905254;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=s3M1bSOBYt5gL2unmdOFOAn92UpRxf2onmyD1mml+iQ=;
	b=4rZBPZqso4Rd/mV+9VejUUKlzCJdEbx1wScKBtC4sbTyhuG1iRtNJSkjvDqIAsE0WYAn
	 y/8NuaXAR+9F6MnwkxbDvTnVkHUO48SVvioDmDEL9g8RiA1NW4M4pK0Nep24Di01M5G/a
	 sLai5gevSwh+VmZVOXwzwTBZDgHsADmwElwDfZZx7EC0j2duhpppINcCTwtMTdYLjW/0e
	 gQbOBLoJbsWoenT4YhOY57X9BX8iGwON1s7Bcaav3G3j6Ew8Gy3u4AQfsUmadGYmisCaS
	 Qh8eKY3T1SbTFSLH537Xw4n2PJnZCRtdGUpTbMd0VQBv9zODd9+SXD/PilQnC59PJKA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=paG2evd6;
	arc=none smtp.remote-ip=209.85.221.42
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54ACD606A891
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Nov 2026 08:47:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 54ACD606A891
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=paG2evd6
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-491971ac844so3743113f8f.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Nov 2026 00:47:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794905253; x=1795510053; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=s3M1bSOBYt5gL2unmdOFOAn92UpRxf2onmyD1mml+iQ=;
        b=paG2evd6MD9xh5NrI3KFfHIvZHv4F2/vrRCU9ssrPWN5wCLSTZBF23eoz4I8dCC+/c
         2ugnJY5Wxct2xzBsFpiEAthtgG0dlSHV91NMwhNci0H6Mzz+l8+LsJnw2bh89kHjn4Jt
         50/dLxzD5nqtaxJXY6wlIkg+FT0Ibf7E2dBQJdcgLlc9mykk8YCLZrbJePv45Cu+t340
         klDoQtgwpY1C81Wm1chUo9HmWscyCgQ4aOMSr3RQXcrRlou+8WjbuKgAItgYH7F819dN
         6BhWO11IagfyEvdROrCQHJv3QvWsqAuNjHVu68TEumbWmFXtNmbSKzmEeaBfWM+/+zeJ
         ooWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794905253; x=1795510053;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=s3M1bSOBYt5gL2unmdOFOAn92UpRxf2onmyD1mml+iQ=;
        b=hSH2Ted1w08uAsScveEnaOE1HCQ+tslia5IOtxeMZmePmkEknw4lnS6DD3cmg0es08
         JR6zX2nGKJ/H/OScmwolPVe6Tc92hFLOsiapAtpvjgts+y0o+hSc4Uq7q8juooNy4clW
         sibQryKMnnRfzsKKBWNPj2eJo0DIr+MYa1u1BakL9tkZZxZZc8TPVjkmY1EU9PHaGMuj
         7qz+9nwa1i6Lv6fh1lfiEVJVcKV0ZQ4LNgGxDmE5deePIVFwyy1lWvFo38VD2ExhBP2K
         QQfIvoB5Fhl3FqEO9+rLaQ8dpiT4lM7y8A7SKVSCWyd22lMFou+YO9zvER22lbIo12MR
         wQWw==
X-Forwarded-Encrypted: i=1; AL+hErEvSxO4pT6Usbt4nGb69fcvc4aPJmQa6s/959uSDjYPFdNtVf6+wt0EuIT7yy6e8J2cu7I3spm+S2aOanXC@vger.kernel.org
X-Gm-Message-State: APuU4Z/+hJ48p7mHFGQHaL5EVy0/QPNc0lmQN4dFB7h2RgCOQr+VuXnv
	qwRw+SHB7Ej2yymQQoNuac2VPGSsGE2L7YFMmbbpGIYaJVwRwEn/7eh9
X-Gm-Gg: AZFdTZe7uYliu3drzEmDifS17OgvcMl2swAqqZbq2hqBmXSA86e1BOakjqvRYUTKyrL
	BfejUZL7RRb3kgPjgHOgZkHi4C5RyrTeZkV4LDjnA+EVXYjUWG2wdpkvU4XU/6Z9/5KIByGKeE3
	DQDad3J5KeebiKrp0BtrMUIguqWaoJ8+DGIie/0SIg0ZFQWh/4u5rSq0dKxeaNPXEAVcnKvOJjv
	Puj8PySHiR/DXkHOqLSUckxEGBsYXRg13ooWI9XBIQkCl8LIcZLNWRo+wWetyFR8g+GA5QYmEf+
	CxuzESH3GZWm8GvBjUoqFGnWuHL53PvVjg+LcG0XV+lIAlDhFl06XQFpDDxLjkcxDhlb+dhniSH
	LtbQth6toWqBnthml8NZIGjll/1Php/iOzCCRnXCaUPT0Xy5a86a6IOcxg9GFuZ5TKOa6iwzkRs
	2TXBlo/acrM89YPfiRsLygGywJxsKE4/gtsbEKrhMxcM8D5zsOrkAXif+fcoXPMQieyl9lHTgvC
	s9nYj0ZQ92hXa3oQj8+L+P8jQ1Gni8KCxMwyjIZGDMImLljBJzWv5Zr9f8pUhzO2Z43j2lq2L6/
	pg/ToATOormuGNJ9EDFYtXR/MyLWavcrf8hR7M6HC+8jkkxvRV/XPz6AJzizZ/nbhQ==
X-Received: by 2002:a05:6000:46c2:b0:48f:db47:6ebf with SMTP id ffacd0b85a97d-49c729bb31fmr19089884f8f.38.1794905252525;
        Tue, 17 Nov 2026 00:47:32 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4a43775f9b9sm2739633f8f.26.2026.11.17.00.47.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 00:47:32 -0800 (PST)
Date: Tue, 17 Nov 2026 08:47:27 +0000
From: David Laight <david.laight.linux@gmail.com>
To: "Theodore Tso" <tytso@mit.edu>
Cc: Gabriel Krisman Bertazi <krisman@suse.de>, Sarthak Kukreti
 <sarthakkukreti@google.com>, Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu
 <chao@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Christian
 Brauner <brauner@kernel.org>, Gabriel Krisman Bertazi
 <krisman@collabora.co.uk>, Eric Biggers <ebiggers@google.com>, Dmitry
 Torokhov <dtor@google.com>, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] libfs: reject casefolded names that fold to ".",
 "..", or empty
Message-ID: <20261117084727.0cfa196a@pumpkin>
In-Reply-To: <avu0X5E298dHRBHY@mit.edu>
References: <20261113065332.929085-1-sarthakkukreti@google.com>
	<20261113065332.929085-2-sarthakkukreti@google.com>
	<878q2swoxp.fsf@cartola>
	<avu0X5E298dHRBHY@mit.edu>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 16 Nov 2026 21:00:06 -0500
"Theodore Tso" <tytso@mit.edu> wrote:

> On Mon, Nov 16, 2026 at 02:34:26PM -0500, Gabriel Krisman Bertazi wrote:
> > Either way, this issue is another example of why treating ignorable code
> > points as 0-length strings was a bad idea.  I'd very much rather
> > utf8_casefold would treat all ignorable code points as foldable to
> > themselves, (i.e. commit 5c26d2f1d3f5 ("unicode: Don't special case
> > ignorable code points")), but that was tried and broke applications
> > that relied on variant selectors code-points being ignored.  
> 
> Sigh... I really think these characters are *evil*.  I wonder if we
> should simply drop those code points unconditionally when they are fed
> to the kernel --- not only folding to themselves, but *not* preserving
> them when a misguided application tries to create a file with one of
> these misbegotten Unicode charactesr.

Doesn't that assume that filenames are UTF8 rather than just sequences
of bytes with everything except '\0' and '/' being valid.
Casefolding is itself so evil/impossible it shouldn't have been allowed.

David

> 
> I'd prefer to simply reject creating them with an EINVAL, but it's
> likely that will break those stupid applications....
> 
> Eventually we can have e2fsck offer to fix directories with those
> characters, and eventually we can make these characters become a bad
> memory.
> 
> The other question is what *other* evil misdesigns are in the unicode
> spec that we should be preactively trying to addressw hile we're at it?
> 
>      	     	       		   	     - Ted
> 

