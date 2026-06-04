Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7955E3FBB62
	for <linux-fsdevel@vger.kernel.org>; Thu,  4 Jun 2026 09:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780563974; cv=none; b=B/drPvSNTvOIbVfeJKnhxz4FWijdKBERuweBzCyxbUOqMLmwDqdCZjytdE09BjutEK/YlNqFZKLkXsXEf+OACpp6p9rPOITfwVvcmNsea42XbBrfp7/OEdjBxeKGcHc0k1iaeFP+BhfIDmLudQGpW7QQeQuR/7bt84O+LwjkzBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780563974; c=relaxed/simple;
	bh=6nC4qMmpp4fUyVsAFDYujq7+sxNujf5CGEPAWJHIlFA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TKEniNDDVFmEv4xpjSUt2r7Z3MwPXdFpcPbXmg935mGsTjApdJcKqYt3/0nuyG3SK5VuOq5DQO8AXCpnwQOm+o2kpUJSIJjKeMvKI6EYI5DsGd/oIoFp/Oppp29yMIVUTQdn35pwho1Mw9+J1P22Oa5U8ty0+HfT27CASrM3+3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z4Qk/eMs; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z4Qk/eMs"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-490ac357c55so5396225e9.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 04 Jun 2026 02:06:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780563972; x=1781168772; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EdFuwsES54dFvGT6zPCTaZ+yF4K8AlHGY+rBuqBIdh4=;
        b=Z4Qk/eMsRQn5NaOl5EnL49h5mkIDXCd6CVB06Y3pkNHIQBrrOz07RC4i9WNJ7soZ5V
         ZwZnlbdEhstvH16TCDK3NLc3IDK022X024ITEBaBP7leRrZPYvIKM0a2oZgI8eLPi4hf
         l6bUS8EAAbKpENkoLhJlvpJaE3SPEuYNQtAyuGwu5GFaav3z27CJASM9RViLgvZnE9iX
         HnaGV4X3VncpchGb6vO7ALPLhi36EY0JNacWYHGwLG7HcXBXRzq/C0S0jLJRDSq+IYgB
         Ameqbmz9JWPN6B5sTwrZ27N7L7FPN5xbYHLpuQPyHE4EtAIwP41vpiRcH1y53BQ25zuc
         Uo0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780563972; x=1781168772;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EdFuwsES54dFvGT6zPCTaZ+yF4K8AlHGY+rBuqBIdh4=;
        b=if1UWksw9Uq6OK9v1F5Coj3mV/46K4PPILz0dndEeBiLv53Tb0qveuzUt8ux3IU16Y
         Y2D0vYRMIlIEBXDnPR2xA2AmCzXuXq2oI/KdXxyjCO1MWipoFvTH/LOSC4dENeTL8b1I
         +EmJ/bKjoz2ZpUn+t52aDHDCYtMysRyKc7E4+zl/DVUz9koR+UiuB8wfSrFgVRqw5e77
         JKqTKejmyYxtuMXF5kCTO8hUXnNU+Cx77JOwRsh0PiOvhxC2vu+dQueU6w4ryKvuQzJt
         4+Z3znOLaIodvYTs8f+TnXlz8Ybx2QNBqinGUUnn5WH2cC7tko8T1v+bQ+yPvwR6TkfC
         RJMA==
X-Forwarded-Encrypted: i=1; AFNElJ/DoNFdHS9K95ViUEnhPIM8ww3CCcxd2ZkzopPPw2WfuHFn9Rf7uajMnkZKsZK2PQg/TVqd6WxpiZRsBhV0@vger.kernel.org
X-Gm-Message-State: AOJu0YyRM2XbWtuYDDWzHe7zWHy6I5Z4xPR10wlZLrJ1DsOpyriVMNmQ
	T4U+aslzWWUrgQwhh9qBfoZtcI7x0x4bGGmm1Eb/QU2PebLFUV0koAShCdK7kSK8
X-Gm-Gg: Acq92OHZLCktbUDSMU+DdRW05DuVpzsL1nbDsv2zYnhX53n4wUM/xjqWxRN26doABCm
	KRNhL/Of9tYxK4rxPNgiv4KZYuIv5ot9pwIp+uZbjqRANaOanHK9R8Xk6Uo9NboZXFDZ8wvtJGm
	Wf3P4EQLsKDWBUtEhwPlpZS3TobnlHJMpwX0z7V7ijPAMe8fex7aYVij1Rdvy0kGfZnqsF0COoK
	ALY1siIC6PU9QfwFyO4/Mdv+kunOX53rAa8cpF+HOl2ldaqkqRS2v6R306xydCR4WuGvlbQMfQf
	USbVTnUEMIBy0YzqK5Rz709cikMFEVRkHcLAvA8t3/Yv3t6SnP5nCcrBuZN2MDcqNSL2T6E7KWg
	Zh5UMpNr65F+/nMoist1nz5aVAhNMk7Z/9GCwHLFB8Wjd8Ps/hLHXEUxVkEWUIS5k6ziiznNHjW
	ythOjiHAv4Mr8/qOJUD4BToCjoCNFSCTNJJipGZS8oMlNQmZ8rx6uFy9QKmf5KPUwnCDvZJBImF
	g19h9G9SA==
X-Received: by 2002:a05:600c:8184:b0:490:5cd8:d213 with SMTP id 5b1f17b1804b1-490b5eb44f8mr113527135e9.15.1780563971711;
        Thu, 04 Jun 2026 02:06:11 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490b7e6c774sm70203515e9.1.2026.06.04.02.06.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 02:06:11 -0700 (PDT)
Date: Thu, 4 Jun 2026 10:06:09 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Askar Safin <safinaskar@gmail.com>
Cc: metze@samba.org, akpm@linux-foundation.org, axboe@kernel.dk,
 brauner@kernel.org, david@kernel.org, dhowells@redhat.com,
 hch@infradead.org, jack@suse.cz, linux-api@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, miklos@szeredi.hu, netdev@vger.kernel.org,
 patches@lists.linux.dev, pfalcato@suse.de, torvalds@linux-foundation.org,
 viro@zeniv.linux.org.uk, willy@infradead.org
Subject: Re: [PATCH 2/3] vmsplice: make vmsplice a trivial wrapper for
 preadv2/pwritev2
Message-ID: <20260604100609.6b37f500@pumpkin>
In-Reply-To: <20260603211736.755139-1-safinaskar@gmail.com>
References: <f919874c-065e-48be-ac5b-300c4ab86d4e@samba.org>
	<20260603211736.755139-1-safinaskar@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  4 Jun 2026 00:17:36 +0300
Askar Safin <safinaskar@gmail.com> wrote:

> Stefan Metzmacher <metze@samba.org>:
> > Why is 'int fd' changed to 'unsigned long fd'?  
> 
> Because preadv2 and pwritev2 take "unsigned long". I want vmsplice
> to be as similar as possible to preadv2 and pwritev2.

Something needs to ensure that the high 32bits of the fd get masked off
on 64bit systems.
They can be non-zero in the register that comes from userspace.

-- David

> 
> > Should that be its own commit if the change is desired?  
> 
> Yes, possibly. But this patchset already got to next.
> 

