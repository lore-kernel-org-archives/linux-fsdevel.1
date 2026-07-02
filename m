Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D20B30D3EC
	for <linux-fsdevel@vger.kernel.org>; Thu,  2 Jul 2026 18:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783017994; cv=none; b=MxICQoBYB0TAOdUlgijUjOFWrkqqHvXFolGKTJC9Sw3A8GJ17B1XxdkapIsmt3e+JReLUjvZR5iG6Fn2YCtFsCsVEhHO5gBwIM678qow56LaJrficoSSiuf/sBiKyTw58fgaMfrrL5fe6LFZeYBnPyI+/sTvxOs473yKsGxi7Ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783017994; c=relaxed/simple;
	bh=eEfxaVDeuHg/2O86tGs17Sc/sYUDZxKDGC64ZP7eDt0=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=pWjMPqor4pBEonD63dduTwcgXCQQjH3xp3EYSSwzpuE8dtqbVasI+gMFhT7sob/FPAWFSc/ynb94ZQi5VJIulRljEb1qMBiuOZ1Lw6/91iFBzv2DfjLRwaY0tNW8wBMLiNUnZnnLcl/5N4E1VqN0lY4aLKQQaFW9pacFc3K4Q1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dilger.ca; spf=pass smtp.mailfrom=dilger.ca; dkim=pass (2048-bit key) header.d=dilger-ca.20251104.gappssmtp.com header.i=@dilger-ca.20251104.gappssmtp.com header.b=eHrxH70q; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dilger.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dilger.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dilger-ca.20251104.gappssmtp.com header.i=@dilger-ca.20251104.gappssmtp.com header.b="eHrxH70q"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-37fc01a7835so1697214a91.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 02 Jul 2026 11:46:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20251104.gappssmtp.com; s=20251104; t=1783017992; x=1783622792; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=VEx+Ou5+j9qUkh59LaYDmj5XVpjw59xEgpgRSs88k90=;
        b=eHrxH70qCWhTLR0AUERi07EsCpfeIupO2LXrNDFQepR/MCF1/lhjK+kDfc2ss/C9Hs
         jjK3KLXRieG0DpM+FNKFhUNGOQnmY9DrP5MSOtoy9MRJAULk0ZEgTeOBNqD3QnsI8MY8
         ipNk0WPG/lOSZGTgY7A58YIyrQSpb9yc1RjwFPfRAwZYpvVp6r+ShEOVmg/M6pOY9rzX
         YfFyu2HdKdYk7ZyDSKyAd3TMzgQxxMsMPbT4w41JVto4/mQyicabktEPRyI2mLYy7SIv
         PTA7xKHN6em8q/QCN6dn8cMG+LdSZWcBVZkrWZIG/a4O66gR0DLx4ezTlHcdOhvB/tED
         6SXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783017992; x=1783622792;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VEx+Ou5+j9qUkh59LaYDmj5XVpjw59xEgpgRSs88k90=;
        b=kxVCJQeRn8VyqD87czckgftCwmjyl2iULE9g36kPZQPjvqFYEG4qr+WGyRe8die5lN
         48IEBwFiECGp6TZbKSZ/n7h5aYmT7VxSjgwjYvHUMYJzj6aITr2NNlPI0i2RQ4bQZq9n
         qE0lV0xanZMeG6wtiGDrxgzZnaHjuzDEcdYkjrq0wW2skxTtf8c4INBaEO9OeWF+PyV2
         skkCuaMrqM2aluZecwyd4iZpnpAKol5rWboK+7FE28gEpAyCbSgjJOBcdbQkxva95vnV
         r2Sj4SJd6ZZ/8GxZ9ZK9fqPkNSDTB4PLk7EpFx75cKtWqd0zAsgnjYALViOVOWGXfVYC
         VJWg==
X-Forwarded-Encrypted: i=1; AFNElJ+3EAJBhNoGt4XmY++n+mSsZN7E8ANNxqp6MAZqypSviSLEblB+a8FxG8+O+NQgyK1tGi9x64UNYXoivenR@vger.kernel.org
X-Gm-Message-State: AOJu0YyJlqcUT7/BDQyPlRU6o4dZ6Qq6nTRLYll84/0RrKEqfAEnUxsm
	zCSno0ZNHjnjJzEgp7vVz7TA8mREtuqEZS9Zoec2AGdkFf/F/TwHYdMnnulJNIK6XzM=
X-Gm-Gg: AfdE7ckogvqugXvhlH5DhKNYhTUuUd3kZSkFaAQ8bFkXyzVnr3WK/MpcMxvBQIcZtTp
	1pAa9q7qEvyTx9fJ3TpHQ8QNaD+ZsW9mjzhi848JVl9/DFABGjcq9qcn7nY3A4irYbb4lznLvOp
	fHldAXzttCb/FbQ7kcl45a3lgotpxb/GtxYKS/UWq9s6nBGKTJ83hoaihy2IDCLsgGE+U2sHjQb
	H4G/I70epkZnjoGbC4i+yxduYYGV+otn5HXv4NtSx5A7KHFFder7ju0a9RCg0nFLE02N2j+306T
	0+c272dFghVjhibdxlg1e+UCe3EKdXCzfxf/Y7Gd90jHEmnGbs4D9c0vCrwnmoq8n3rE2I85EVa
	ykNn8gcfBtn7jZtdqg1pa+9QWefA5c2vLjb6wR2Y+n5WWc7Dy1xLYFWmAcsAKgvfDH5Huqxzy19
	KVtgK7o+GLQ1FwUWEPcMwfchrCe7Cy43rhu7ALlC6WRoko+cKWUp0aPqesuT2Yu9Mnxi8=
X-Received: by 2002:a05:6a20:2d2c:b0:3b4:b24e:27a2 with SMTP id adf61e73a8af0-3bff4258cf8mr7186870637.31.1783017992494;
        Thu, 02 Jul 2026 11:46:32 -0700 (PDT)
Received: from smtpclient.apple (S01068c763f81ca4b.cg.shawcable.net. [70.77.200.158])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c9e921cd139sm1593095a12.23.2026.07.02.11.46.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Jul 2026 11:46:31 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.100.1.1.5\))
Subject: Re: [PATCH] Documentation: remove the requirement for LLM attribution
From: Andreas Dilger <adilger@dilger.ca>
In-Reply-To: <87cxx5l900.fsf@trenco.lwn.net>
Date: Thu, 2 Jul 2026 12:46:19 -0600
Cc: Greg KH <gregkh@linuxfoundation.org>,
 Jeff Layton <jlayton@kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Justin Stitt <justinstitt@google.com>,
 Lorenzo Stoakes <ljs@kernel.org>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Carlos Maiolino <cem@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>,
 Jori Koolstra <jkoolstra@xs4all.nl>,
 Krzysztof Kozlowski <krzk@kernel.org>,
 Brian Foster <bfoster@redhat.com>,
 Christoph Hellwig <hch@infradead.org>,
 David Disseldorp <ddiss@suse.de>,
 Mark Brown <broonie@kernel.org>,
 Jani Nikula <jani.nikula@intel.com>,
 Jens Axboe <axboe@kernel.dk>,
 David Hildenbrand <david@kernel.org>,
 Vlastimil Babka <vbabka@kernel.org>,
 "Christian Brauner (Amutable)" <brauner@kernel.org>,
 workflows@vger.kernel.org,
 linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <7C39A5C8-EA03-4C8D-9BE5-5097101B71D6@dilger.ca>
References: <20260702-aidoc-v1-1-735572dfb995@kernel.org>
 <2026070224-unholy-commode-cf45@gregkh> <87cxx5l900.fsf@trenco.lwn.net>
To: Jonathan Corbet <corbet@lwn.net>
X-Mailer: Apple Mail (2.3864.100.1.1.5)

On Jul 2, 2026, at 09:13, Jonathan Corbet <corbet@lwn.net> wrote:
>=20
> Greg KH <gregkh@linuxfoundation.org> writes:
>=20
>> On Thu, Jul 02, 2026 at 10:32:48AM -0400, Jeff Layton wrote:
>>> We've had this requirement in place in the Documentation for several
>>> months, but it's becoming clear that the signal to noise ratio from =
this
>>> is quite low.
>>>=20
>>> 1/ It's not universally followed. While many people do try to =
attribute
>>> the LLMs in good faith, not everyone does for various reasons.
>>=20
>> Then let's move to get people to follow it.
>=20
> FWIW, in my experience, simple ignorance of the rules is one of the
> biggest reasons why so many people fail to follow them.  When I've =
asked
> docs contributors about the source of their work, they tend to come
> clean, apologize, and add the tags going forward.

It would make sense IMHO to address the ignorance in the most expedient =
manner,
namely by telling the *LLM itself* to add this tag when it generates the =
commit
message and/or reviews the code.

This could be achieved by adding a statement in "AGENTS.md" in the root =
of the
source tree to this effect, or telling the agent to reference and follow =
rules
in Documentation/process/coding-assistants.rst regarding the =
Assisted-by: tag.

Cheers, Andreas





