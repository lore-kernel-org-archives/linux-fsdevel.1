Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793823118;
	b=4I6nfoQIUxeKz1gCyLZzOBtawqQnZ/BJrcBTTzFkIUFLx7tODuOoggcF2WYSLzAnpJcX
	 CIDpoDpT9ClcVpxdoCROTZsQqvY1GoWR7W4w6szMh/y+Pz96ww7ZZWIwMBMUMccEI2aJY
	 zNUWr/6XCahuLKQ78l4tRB/bSDAEfO2EMF6vC1gA8XMXK+Hn24Fx/nNERzYxnGGC7cVPB
	 KHmCyhDx/K1CKXvmnO0GtQP82hewxUJrloJdh4qhP958zi5ayRQNtvRitVkoxENdPnd+n
	 PeIpZNqLe+nclMjAFenmUbauQHt5XhUAeCNEX0skxCzYx4DQ6pYLUQKQs+qe7kUYpSA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793823118;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:
	 X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=LCqiLHf1DIbfKNXx3ccWkvqxBhOdwo3yYkazQxIGarg=;
	b=aMAwP4pD+3pqxwFJeqwsL8Iw/Xwf1uCsEL8Ba4jRxJBTu8tcPeDqMBRDMjv9KBXhKAR2
	 N/dYC75sGwfO7jy1MPUVwrgZSZm87koHP5hXz8WwAT7jCyrZz6N+qn/6EkFbP8YCjjnhH
	 cikb6uU4CZU5pgOLRDhWFjJGa+/bK4PzN3mKQgk8F5XpGOdTsNZ/PV5iNqCM4S5VZeSdJ
	 9xOIGTJ7+w/08WvpWiQCftuUoaRt3T08jsRj8BNHOJ/mk6F5f2sTCJCtQU8vD+ELzoh4e
	 9Whi3m8M4ZB8JyjSNZtJtORToPTy7Ehlaqai49/iPbl/P5SA0AZdWuXHAy9bAI2YDWQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linux-foundation.org;
	spf=pass smtp.mailfrom=linuxfoundation.org;
	dkim=pass header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b="AU/PGjqZ";
	arc=none smtp.remote-ip=209.85.218.54
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7817607F2A8
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Nov 2026 20:11:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B7817607F2A8
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=AU/PGjqZ
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-c418e215671so167646366b.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 04 Nov 2026 12:11:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1793823116; x=1794427916; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LCqiLHf1DIbfKNXx3ccWkvqxBhOdwo3yYkazQxIGarg=;
        b=AU/PGjqZ5KOnE4pqE9mxcsxxB8F07j8lbkAZ0zVRWLpf2yp+CH6bXPMA870Zyc7VSf
         Sa0hhJ3WY61wc1iHiylFELLS+Zy4ttf6Z/n8Sgnf/wWZlgkj5NPBIZ7nPMx9k92B/pCB
         qgwZbt1sTb1NviKHx+sb4c8q1V1DXv7Xm6mgg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793823116; x=1794427916;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=LCqiLHf1DIbfKNXx3ccWkvqxBhOdwo3yYkazQxIGarg=;
        b=mi3lg9rvr4+fWlcANEj1pCcPIYXs/8DXWq+0F3Fj0yu2dLG6QPY1hHjZGOnR9b7g2i
         aU1n+RabTnxsu6nZi/F7yOQ7wzY2YMMak2xCrMOMDCoG6YMeORYwQzjwgpQ9Hp3llFaE
         qy9QEVO2Kj+XIJ0TeZ9tcG6tQef0ppvagbafVIydp6r/7W7EpGX2F93o0ISXH9rLCrR3
         I2MA95IIK/UXwEXTD5MZDliZcump+M8N0s0fKH//DtK4s8C1iMLItU9qh+p33l19DjQO
         qWZx+OIXSXpiFN6hsADw+tLDDUrMBxSRE/AXbqBCjK73t9AAFn2pInyiQ2uinJwfvAIe
         QSAw==
X-Gm-Message-State: APuU4Z8zKH0BL+QSflrSGMuoC0EeLSSmZ/tiGAjBK/Y4A+C9dTKG01k7
	cJ1qAKXxlUEWUrRebj89cSR9+TVo2tw6eKCG9YdUH2hiuSOve+Xu/BwplF/mGm5ZFSwbEdb11gk
	1mb4+sb10jg==
X-Gm-Gg: AYBFou15l8wTIs/gobjoHg5/Smelp2hxkJxOj3y9AXgvRp4efiGQJ6Ee9TRM4tS2BjX
	5KSrxSdIrreiL7AcyVDVsnK0UJhb0ichg4YsEd5y1vonJWTnhgZhFpx8pvB+8y1oC/GpClwKf81
	tlwxRdXXeJi3/HKAUoUBOHL8cF+FA1NdYQH3NUEaJ5eIO7sw1pSuqHX7omCC2togMTI3oDpFjqy
	s3Kn1z7gKMRXF54WAirlCckM2qdePqaQ5gQbuIHc6SPUUnaWo9r/bAhgjvLhPy2FIuqe0oAt9BJ
	Uy1TDXLcCcD78d6dX8OKgluzgz6YcKiGD0hc/3Ih6tSGRc0CxiUMg2DKrgaclMciEuKOLGB0gXR
	rNTpmz/lOL5zSg8O61KYMtESJYZBb+ycLx0JjACbUz//EzXxXvfQusDXT0AAv1RuJ0NkCPOv8Uj
	UrfIO9klnch+Ah78MWdzO0uVVqOxUiI7wORn110CSuDWUbznFL36VCODhuQubBRC29vPzuirFIt
	ah+3z5BF1Rzqiu7W89VC6VTsQcO7bS9H/i2GFs6un3XvPcmGvgvK2aDzejHaz1Gzr9fMZuAKAPA
	OfCF3PMCu5DinFxq546HHxXnwuwMsgXea1ZM5bZkU6FgAQ/mQ2e4MY25D5V/cMxGedUuxwFRUel
	fpQ==
X-Received: by 2002:a17:907:9603:b0:c42:73df:933b with SMTP id a640c23a62f3a-c4ca7a55a33mr1520025366b.12.1793823116067;
        Wed, 04 Nov 2026 12:11:56 -0800 (PST)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com. [209.85.208.42])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4d0e444950sm108426666b.40.2026.11.04.12.11.55
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Nov 2026 12:11:55 -0800 (PST)
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6ae14eecc64so1562346a12.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 04 Nov 2026 12:11:55 -0800 (PST)
X-Received: by 2002:a17:907:60c8:b0:c49:a4b1:9cb1 with SMTP id
 a640c23a62f3a-c4ca795fa50mr1973235866b.3.1793822725121; Wed, 04 Nov 2026
 12:05:25 -0800 (PST)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261104-work-procfs-v2-0-b45cd5789ac5@brauner> <20261104-work-procfs-fs-v2-0-319e0f9a8aae@kernel.org>
In-Reply-To: <20261104-work-procfs-fs-v2-0-319e0f9a8aae@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 4 Nov 2026 12:05:08 -0800
X-Gmail-Original-Message-ID: <CAHk-=wj9Y9NcOesBBm+jhPjYa7qO00fD7g7uwX+H-k0-R2difA@mail.gmail.com>
X-Gm-Features: AclHuK9j_YIgrwhhpWOlnull6heAULBd4dgTqoOhUQQjFm_MgoIgrL1vgPfefvI
Message-ID: <CAHk-=wj9Y9NcOesBBm+jhPjYa7qO00fD7g7uwX+H-k0-R2difA@mail.gmail.com>
Subject: Re: [PATCH RESEND v2 00/30] proc: convert the fs, kernel and mm
 entries (Part 5/7)
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Jann Horn <jannh@google.com>, 
	Josef Bacik <josef@toxicpanda.com>, Chris Mason <mason@kernel.org>, 
	Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>, Eric Dumazet <edumazet@kernel.org>, 
	Thomas Gleixner <tglx@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	Jonathan Corbet <corbet@lwn.net>, Christoph Hellwig <hch@lst.de>, Greg Kroah-Hartman <gregkh@suse.de>, 
	Joel Granados <joel.granados@kernel.org>, Kees Cook <kees@kernel.org>, Jan Kara <jack@suse.cz>, 
	Jan Kara <jack@suse.com>, linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org, 
	linux-acpi@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org, 
	linux-um@lists.infradead.org, linux-wireless@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, netdev@vger.kernel.org, ntfs3@lists.linux.dev, 
	platform-driver-x86@vger.kernel.org, coreteam@netfilter.org, 
	kexec@lists.infradead.org, linux-pci@vger.kernel.org, 
	linux-sound@vger.kernel.org, netfilter-devel@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, ibm-acpi-devel@lists.sourceforge.net, 
	jfs-discussion@lists.sourceforge.net, linux-alpha@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-cifs@vger.kernel.org, 
	linux-fbdev@vger.kernel.org, linux-hwmon@vger.kernel.org, linux-mm@kvack.org, 
	linux-sh@vger.kernel.org, linux-usb@vger.kernel.org, 
	samba-technical@lists.samba.org, sparclinux@vger.kernel.org, 
	linux-m68k@lists.linux-m68k.org, linux-doc@vger.kernel.org, 
	linux-serial@vger.kernel.org, linux-atm-general@lists.sourceforge.net, 
	Takashi Iwai <tiwai@suse.de>, linux-input@vger.kernel.org, linux-raid@vger.kernel.org, 
	linux-ext4@vger.kernel.org, linux-modules@vger.kernel.org, 
	linux-debuggers@vger.kernel.org, Chuck Lever <cel@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 4 Nov 2026 at 11:49, Christian Brauner <brauner@kernel.org> wrote:
>
> Part 5/7 of "proc: move procfs to what kernfs does", on top of part 2

Christian - way too many patches, re-sent much too often, cc'd to way
too many people.

Nobody is going to read these repeated resends, and all you are doing
is clogging up peoples mailboxes.

             Linus
