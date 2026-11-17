Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794944367;
	b=BHoIcpLkrjwj33yXhBom9q5gaHjzR/Cu+l1534tc3CI5rqxhKpWeC003by3p9ldZ/HoQ
	 M4FyTGS5yEJnxfLDc87iiRriShFg57alpm4rn1NRZV/Q6iAepU7iG4i+V+E/bHebJTMFm
	 wiO8c2wfTbJQ2aBjW+O+jg4dRGmjkAO9swfpgFsLkOumCkuQX0A8A8rDy5S6rCUEwQblL
	 X2lH8X5FqOQn0mtFPTnCYvKz05AYpf2jPsuKbTOAKJCRw83ywMKRLea/zyfienl9JTOFU
	 fYMz2Libr23WqRjZjlktJ/ybSKcxN3gsq6EeI/QN2yVhQgG+jgWcL/lepWFmAb5IiRg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794944367;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=X24LLs2RrK+lA3rnWmeXdxswGXkvA2QXv3w3PC5997A=;
	b=tjazlTTHORyKd93Ad4f0muVv6MIo3YDdXE0LDQuJDz3JElUM9rf3jZpgSgwLeW8VJKfY
	 Q7sofniiuX94kIkER3radLLorPutINzOglWWhJSX7PkF9nLRfqlPEAV/97vbbH14Peyxy
	 yWq+3wuhVNZiO1DUASU8vGbzKZTGxIXg9TsqzTTeP6p7UYiYz8hzlQG9hKSbAN8gLvJcB
	 JgbXYAiUEB8lm9ZyRtW+fF9utnCD5PKGzVMEy9V6DPchWAXxmJkUDRqGVsdgvvLOK4WY3
	 p40wjZYGJXIxqA+upSHCN12bMboDvVyU0uHhfZX4nqbQPJeXCPfjNcrt9HjW/VntcJQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="buqZ4+/B";
	arc=none smtp.remote-ip=209.85.221.46
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F7E6606A32A
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Nov 2026 19:39:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3F7E6606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=buqZ4+/B
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-490d59c3f0aso62763f8f.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Nov 2026 11:39:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794944365; x=1795549165; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=X24LLs2RrK+lA3rnWmeXdxswGXkvA2QXv3w3PC5997A=;
        b=buqZ4+/Bo9e+N24UUPYC17NFKAdU3HfgJsD6u3noM8uJiz3iiLUQLrQBL+vSAdZ/Ra
         WfwGpt1XKwdl5lYtJsKqbbK5BmFxy75q3DltcusAgIVFGfLOkyDgk8d74cha8JP30ISD
         BMGD7+qjDyXsPM1hS6JILeVssoE1Ff5GR46SCwdyMIPpXR1uES33HO64Dm4vnBC2ECVp
         up4jkuUIywG2HoR3dVY+Gmq2TINJ7632YJ7jQ2EijqYnIQihOG9GQhXHiIjk6wcwnuIF
         ny691NFOEJ0w072ZWJjLPFA176HpyPJp0C9HxKvn0htH4bFJ/G9P/PXHNYb621/z98dj
         f7Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794944366; x=1795549166;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=X24LLs2RrK+lA3rnWmeXdxswGXkvA2QXv3w3PC5997A=;
        b=bgMaF7bRdNSnaeBzYF9ZNWyn9HWHR+8B+y7XY85QE5MNfYrM1autWXWjF1lD3x5HdF
         sOxGEG5R+kOeRpIVZR7E5fSu197MPjWSEuzbzsCIEgep2Yb3NmSsw2LaBHW93HLC5w4I
         QhOZGz6j0bRMsmof9CmkkKgxWy13nsbq0WhQdfm6lTUfbpsLqnAeiqqxgAS4/4ASMG39
         uFowpj49OC2XpcPvAO5OxxJ/o95geO+pJIz7Td4lKnXzYNhhckLSfuN1BCfloKxW1Qwv
         Wyr/CT/fhc6t5Wk4kfycGNB7sjC6EAkpD9xIcTxVnzLeOhSd2U1Zdz5KS7Y0ExGtqkuK
         KpgQ==
X-Forwarded-Encrypted: i=1; AL+hErHi2GqBIq+myjgpTzeao0PK5GmlnQWorQK7Rp0o6fu0zeVWgBLVXK4F6u4u7wAOTkTiS5qBkukZBCpjQ4Zj@vger.kernel.org
X-Gm-Message-State: APuU4Z8pYWEnjRWV0zn/rmP8Q7MfIOchpcBlzKUEtDcgGUUaMoUOTIHn
	VKWVcrOznUpeJHWgJVGSzo1I1Rkosv1xz1+XDdct8/Phi3t2/MEO7rh+
X-Gm-Gg: AZFdTZchSSrHXnXRHWYe9mxXoiW2SEmNMGmC7V433fdP+zrNy5ljJ4FakIfQ8jG1Y0D
	C05ZZ0vlEOMdb9FxjpKg0JUB4GMxXME2Mjd4Sb0cfQIwPLKpRSilT+Gsntv7TjIe6A2es3mvcxK
	Iu8T9OxM0wRil7lMcLHhtbB5/iOtcjhiUHPuwCyagK9GdeYhkf01k3gNmHPg/oR+nyd3v1M9cZw
	Rzd5/hJ10ZVSFCAI6P2nLeOc9NBxdPhqCy/Ew5/VnGPOTABfArb1mpazhxcJ8c15113BIUADjkh
	NlAdz/XFqz2dL5vCkJmUv3Vy+8yFzKBKMLOjv6pofxzpsr7pqJDszOktTRP6Jr/XXX+d0ooXIVL
	g1jTk0lkzhYjfEKloXtko4X0j8wXbNUsrmXc0rFP9249y9p/cJOJH6gE0Yi6zjoxTASm/PLm3yL
	2rAkvW9NJ6F9fuOhJ05FE3vwjd6KT0xtVu7toOGli6SLtH0eQqosl4D5uiHXqvCe0n7uFuwvl2P
	MZXmhEam5e1Lk884C7YylGQmpAggV3KVG8bolFPpf4+rgOcsXca5wIvPMFy7tBou3stvUQJ41S2
	+CKxaRgbg6UOceI+DC7e4XMqULt3hUXD/AZssqW60GYX+YXkUe/IW5+xEQYF4wO5aA==
X-Received: by 2002:a05:6000:200c:b0:48e:bf0:352 with SMTP id ffacd0b85a97d-4a6346da7e2mr1023911f8f.5.1794944365440;
        Tue, 17 Nov 2026 11:39:25 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4a656c1145esm424374f8f.52.2026.11.17.11.39.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 11:39:25 -0800 (PST)
Date: Tue, 17 Nov 2026 19:39:23 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Theodore Tso <tytso@mit.edu>, Gabriel Krisman Bertazi <krisman@suse.de>,
 Sarthak Kukreti <sarthakkukreti@google.com>, Jaegeuk Kim
 <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>, Christian Brauner
 <brauner@kernel.org>, Gabriel Krisman Bertazi <krisman@collabora.co.uk>,
 Eric Biggers <ebiggers@google.com>, Dmitry Torokhov <dtor@google.com>,
 linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] libfs: reject casefolded names that fold to ".",
 "..", or empty
Message-ID: <20261117193923.795e6129@pumpkin>
In-Reply-To: <20261117175917.GO989762@ZenIV>
References: <20261113065332.929085-1-sarthakkukreti@google.com>
	<20261113065332.929085-2-sarthakkukreti@google.com>
	<878q2swoxp.fsf@cartola>
	<avu0X5E298dHRBHY@mit.edu>
	<20261117084727.0cfa196a@pumpkin>
	<avxe5v6r1C7ZG7E2@mit.edu>
	<20261117175917.GO989762@ZenIV>
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

On Tue, 17 Nov 2026 17:59:17 +0000
Al Viro <viro@zeniv.linux.org.uk> wrote:

> On Tue, Nov 17, 2026 at 09:54:32AM -0500, Theodore Tso wrote:
> > On Tue, Nov 17, 2026 at 08:47:27AM -0500, David Laight wrote:  
> > > > Sigh... I really think these characters are *evil*.  I wonder if we
> > > > should simply drop those code points unconditionally when they are fed
> > > > to the kernel --- not only folding to themselves, but *not* preserving
> > > > them when a misguided application tries to create a file with one of
> > > > these misbegotten Unicode charactesr.  
> > > 
> > > Doesn't that assume that filenames are UTF8 rather than just sequences
> > > of bytes with everything except '\0' and '/' being valid.
> > > Casefolding is itself so evil/impossible it shouldn't have been allowed.  
> > 
> > We would only do this if casefolding is enabled.  
> 
> Which is to say, on any distro kernel.  Besides, it's not just a matter of
> filtering that dreck out on getname() and friends (syscall boundary won't
> do at all due to the things like binfmt_misc opening files, etc.) - you'd
> need to scan what you get upon ->get_link() as well.

I also hope it is a mount option?
So you could cross mountpoints several times (in both directions) to and from
fs with utf8 casefold un/supported while processing a single pathname.

> > For better or for
> > worse, it's better than what it replaced which was this terrible
> > wrapfs hack that was a trivial to trigger deadlocks using fsstress ---
> > which was even more evil.
> > 
> > The other way we can deal with this is that if case folding is
> > enabled, we change the VFS to call the case-folding for incoming
> > filename *before* it does its special case checking for '.' and '..'
> > if casefolding is enabled.  
> 
> That would penalize every pathname resolution, whether that misfeature is
> stepped into or not; hash_name() is fairly hot.
> 
> '.' and '..' should be recognized only as literal octet sequences 0x2e
> and 0x2e 0x2e; if some misguided filesystem decides to treat something
> else as equivalent to those, it bloody well ought to recognize and reject
> that something else in its ->lookup() (or ->d_hash(), for that matter).

I remember when "." and ".." weren't actually special.
You could have great 'fun' using the 'link' system call to make them
refer to unexpected places.

David


