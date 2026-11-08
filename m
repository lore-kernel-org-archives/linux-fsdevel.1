Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794164398;
	b=2bfU6ItxWUPWzydBYGr1wEfjI5xMRlE1FNJX1yviDIpjXxfAHU3bUh25cdTps3Pl501F
	 qTQTqkrClUuRDIEqoRIJkF0DDJQdRWyD76xoUnZIwicUPhvukMD5GfXfhxSaH4ofIT0qV
	 DEmnnufKTPhKfT1Sc3W7d/k4CE4T+2lrW3lqDSvWPAdQXTX1UkUvpPi8+DEjYDbMeT7s8
	 KuXBV4FkzoqY8ajZJkdAAhQY5O97nKyPZyambMCXOgTpJiOWg6nJ2xP6ouGnsD7gwCMLV
	 NmkmJU/2ypvDyOD+BIbYvGMSm89+nXDSxoOYdR9tsZK7CjsIKZfnGR8WQVloa91be6w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794164398;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=JLhUwzup1lwefYy8NOOFjthYnrByVfTsqIe79kkV+Lk=;
	b=QaZFTjQVD1w7lTYzL7NxTjhK9kkJ2wgo2KH9+2tPkDfRIPK1LlXZIjpLr/bTmzJ3O++z
	 mYmXLa/eGr1wD2U1q+pa21tbCf5TvL5/bD1MmzsWrOQYbG8J2tRe+WIxEjuUt5m5UTDrW
	 ntYpATzrWNe7wsR9+M2d0FmiI7/tOEyzr+P/T/qHTpPr7QMctoGFcRti4U3FI8VS0IwQK
	 vMTcWZ15W+Y8Lc/DJTpuMiL6vV4WGeBaHzOuhB28bnLuczHHx9yBJd4lvoI7EvXLSp16J
	 WURxiK7GWg2ahOEnq21yb6Z90HefGzoNnRcaWUC2LsdiZHHQIgzz0SzWe2UuxvgRq0w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XrEUEgHU;
	arc=none smtp.remote-ip=209.85.128.54
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A2A0606A339
	for <linux-fsdevel@vger.kernel.org>; Sun,  8 Nov 2026 18:59:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3A2A0606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XrEUEgHU
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4b79502c27aso1791385e9.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 08 Nov 2026 10:59:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794164397; x=1794769197; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=JLhUwzup1lwefYy8NOOFjthYnrByVfTsqIe79kkV+Lk=;
        b=XrEUEgHUwv+lt2Z0T4RzlOQuYT1yMbnY/MJrtF5HY2pc8m0ujKE+1IGJbqc3A1SsPJ
         Pz+po0Wh7ECcrOl1hyNdZBme+OsO/r11IeCA1lW9KMbstFhlOkC0Hm7Ef+TTavGsfrDk
         7T2AE8nlcorDhYFpLo0KTCt4xOv09AacMRilfH2h4PS2mZ0iBReAF8XAcgtI3iT+qlRY
         EJQPYUIUlDRCCjadf1+24R8V0flZyhCZpLCroCVsidoQ510350k4POOaAcSXgGRrBTWF
         rbpUnz5O6K0TOR8uz/zwLHiObwDAqnCJFWP0+ssCNYCBYnXJwQ2yMfUqdKkv6ro/lp/q
         XMaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794164397; x=1794769197;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JLhUwzup1lwefYy8NOOFjthYnrByVfTsqIe79kkV+Lk=;
        b=QfWpF56Auvg4uFZviqun5wEwrtJ8I3xcfWCYixaS8aDDxTlvbqSnxYXD4y5/ghCnag
         pPKNomOFX9wRKsjq1blfRt+vXC6Inadp/vxopGlCUP76oIh+MRF79OeQAHlBlb00jGen
         fk5CDhZoen4apJPv6vq/QEjOeB0Jd6NAjASZStFGErr4gnJdjAJNuEjus374fdHVnW/+
         Twjxi2QWXJ3XmrskP85mTJiIkR9cHJyc3SgF4zOVPI1/xcnOjfsAeFAAFacCyvkPJ3X/
         vEAqqsSoiG/C9pz2abet2uuBkRXuXBXVTZ6poR7PXFUuJiTRaukOvxFzE8WjJIgYCMGN
         EvUg==
X-Forwarded-Encrypted: i=1; AL+hErG4JFcKV82sj5oZFbPlSPTCB5+6ocSUAWutzZLMYaMhKBnMg/AaNP37CFl3j7bwmmfrqs6LSZMYe9YGnaCc@vger.kernel.org
X-Gm-Message-State: APuU4Z+FgOGjzPLm/3Ujn0wGaGB3m5cWZulzRqqnu6SNO7tt6phDOKQn
	TzYaOw6DU+nZdEHXaB85QjoXbE/WAy3URHSaeh2KPkKyUilUvoYI8VmA
X-Gm-Gg: AYBFou3XBdO15ozI5QE4dQ/Y9pErYwVATBtLR6wz4TMF0TXbjkER2aEzaL2lsfg7eEz
	wtYFJA3MmTg+wxUFBvmVhkleWMk2TKNC+bOLVQJDkSPrxUdl1gU+7zmkvfpx4odVe6AmclqJbH/
	zo1aWk4zEpRs+DQyhIjNzdkOcdIiKljoyzjiWNqb2Wa+1z4suYC+tuIx4gGJ9BRXlV880MTDZI1
	6CJ3r/CjhHP4rhQjt9kZqn97Bfif8S0InNICgC1t+ydCADI/9Bn1Gx2698rbIKVHcVuv8zZ6ZHi
	ZlvMWWODtL0s9tFlYKSyfCufaUUapVUUXcXhjqHO7CEbeKYpjSmEuuMi3219qWEGHXZ02qeZmXy
	mTMHk8M3VdRuFL8QgxtoGKjg6UrVsl8lWhaMZ0J5etlJkfo9KliXx+cE4H0NJw7Ag4wgMNbjC7N
	iR6kP4qOBzpCmLKNNnMFiZIyTJa7jbITPH0eOZC+FB1Rr9cXSsZgqoyIOS3ewMaae2tJSN2ullS
	saV8i0HkxhiQsIhTHWlkLoTn9SJN32scns7zFHMfYcOboTgsmBj33YLMFmuhXradUC1/3pVgRRG
	PF/WKTkyB+9IAhirHKhj5AYKUbbAo6hqr6/Sc6Rafsdm4DbmjIJaAuJWkquNUUKY
X-Received: by 2002:a05:600c:468f:b0:4a1:7e77:c382 with SMTP id 5b1f17b1804b1-4b960d9b170mr35982125e9.5.1794164396406;
        Sun, 08 Nov 2026 10:59:56 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b7efb1f3acsm185228445e9.14.2026.11.08.10.59.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 10:59:56 -0800 (PST)
Date: Sun, 8 Nov 2026 18:59:53 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
 linux-fsdevel@vger.kernel.org, Linus Torvalds
 <torvalds@linux-foundation.org>, Jann Horn <jannh@google.com>, Josef Bacik
 <josef@toxicpanda.com>, Chris Mason <mason@kernel.org>, Jeff Layton
 <jlayton@kernel.org>, NeilBrown <neil@brown.name>, Eric Dumazet
 <edumazet@kernel.org>, Thomas Gleixner <tglx@kernel.org>, Al Viro
 <viro@zeniv.linux.org.uk>, Jonathan Corbet <corbet@lwn.net>, Christoph
 Hellwig <hch@lst.de>, Greg Kroah-Hartman <gregkh@suse.de>, Joel Granados
 <joel.granados@kernel.org>, Kees Cook <kees@kernel.org>, Jan Kara
 <jack@suse.cz>, Jan Kara <jack@suse.com>, linux-kernel@vger.kernel.org,
 linux-nfs@vger.kernel.org, linux-acpi@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-s390@vger.kernel.org,
 linux-scsi@vger.kernel.org, linux-um@lists.infradead.org,
 linux-wireless@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 netdev@vger.kernel.org, ntfs3@lists.linux.dev,
 platform-driver-x86@vger.kernel.org, coreteam@netfilter.org,
 kexec@lists.infradead.org, linux-pci@vger.kernel.org,
 linux-sound@vger.kernel.org, netfilter-devel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, ibm-acpi-devel@lists.sourceforge.net,
 jfs-discussion@lists.sourceforge.net, linux-alpha@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-cifs@vger.kernel.org,
 linux-fbdev@vger.kernel.org, linux-hwmon@vger.kernel.org,
 linux-mm@kvack.org, linux-sh@vger.kernel.org, linux-usb@vger.kernel.org,
 samba-technical@lists.samba.org, sparclinux@vger.kernel.org,
 linux-m68k@lists.linux-m68k.org, linux-doc@vger.kernel.org,
 linux-serial@vger.kernel.org, linux-atm-general@lists.sourceforge.net,
 Takashi Iwai <tiwai@suse.de>, linux-input@vger.kernel.org,
 linux-raid@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-modules@vger.kernel.org, linux-debuggers@vger.kernel.org, Chuck Lever
 <cel@kernel.org>
Subject: Re: [PATCH RESEND v2 14/23] proc: let procfs copy in writes before
 pinning the entry
Message-ID: <20261108185953.28054fb3@pumpkin>
In-Reply-To: <20261107-akteur-gemieden-eckdaten-21304d085e35@brauner>
References: <20261104-work-procfs-core-v2-14-76ace653a773@kernel.org>
	<CAMuHMdVfakapgBK6TBhO1iWX8qzvLDk8jzRS=t2MVa5G=MCUeg@mail.gmail.com>
	<20261107-akteur-gemieden-eckdaten-21304d085e35@brauner>
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

On Sat, 7 Nov 2026 10:48:35 +0100
Christian Brauner <brauner@kernel.org> wrote:

> > While at it, I think it would be good to use this conversion as an
> > opportunity to replace "char *" by "void *", which will probably let
> > you drop several casts from users.  
> 
> So I tried that too. The thing is it drops exactly one u8 * cast in
> ntfs3's label write. 

Since char is now unsigned that one isn't even needed...

David
