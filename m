Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793642351;
	b=RycPjNfn5RxEp8VWlqb0E+TaQqrbZmrpZY1X0SXeDoJ1dmEKvdbofk0Y6Re4sLJrvr60
	 z3dEs15QmvAQQ5qxPaGI7eaD2ZLAj5WZf78trISkRSBtsg8X8uipTsTRHG66bVk7cpghG
	 3vAZWVFRleW4O6rOQZu8NZJWB8OZvDghWLt7vuKesWwwbvyQmGfz+oKgMz6A1qQxSsYTf
	 LEVdp1mki0bmWsSnVC4G2HbhHZQUuzeDqIRBSq8z/NkKLYgY0X8NGvsQ+13y2cWxD6TuB
	 qgFqSorUqAF5C1ePuPe/qBfNyYUMB0CmvIzvgg2mT7kNU1Hz9UwTlcMU5eELwhrQRVQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793642351;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:
	 X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=/vXXDZI2TLqXD/tqTZGHj/cF0YcMq0fXP1TpWYkM2ME=;
	b=WPORP5D/gI3B3CXhzatxbELXFcP5zDaU8dmdkzipJjoB2iof+NoWsBn/zPRD++xktSsy
	 fGVEJsLM7Wd2pJbvfOCz3C/l1BCqOEl7XuIPF3s2FeLFlTBOyLQQiAZUDxZ/V/a+sosnV
	 ReNQdn6HBFpBAQQpEDG8gzGQB1uKwP5P7W2aEC97y30LDhDm0+ovSkuVqAJnrLO5sDdFi
	 vj+oVJ/4kdeH0qhjwH1tiLLnsoUxgtP3zY1uv/MGliFR2dx7lWHdEhP62Fj+ldUtNW+s6
	 4YNS3se3vBbjTodsqlB3vynRBgZmYDfymgO2ztV37EG86S34Xkzl+TzQgh78fzf7Cqg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linux-foundation.org;
	spf=pass smtp.mailfrom=linuxfoundation.org;
	dkim=pass header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=aouHlxWM;
	arc=none smtp.remote-ip=209.85.218.49
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62A2C606A5AA
	for <linux-fsdevel@vger.kernel.org>; Mon,  2 Nov 2026 17:59:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 62A2C606A5AA
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=aouHlxWM
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-c169ae1cb26so692086766b.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 02 Nov 2026 09:59:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1793642349; x=1794247149; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/vXXDZI2TLqXD/tqTZGHj/cF0YcMq0fXP1TpWYkM2ME=;
        b=aouHlxWMUL6SAbi3QYhgL+Pi27xch3vqijYHrleac3XLnRRGf6dHA1CVnDwcLHADyR
         H8OewP4y0qrB1tue7MWCFFN744xPBOgd7NwkMkr2zVkhK1ww/ACHhlySQiMj7x4SUgtZ
         qKc8GDZGVk24htNLJIt257tofWuQgOuHb/BpM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793642349; x=1794247149;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=/vXXDZI2TLqXD/tqTZGHj/cF0YcMq0fXP1TpWYkM2ME=;
        b=RLbNEMpykg905CL5nrh852YLA0OE5PPNf8dsIPa/hopU3G/VeHxX26970/Glxvr+2F
         VO7M9sOdxBbGtTsMgPDqbC7EBaX4aGvODgIzkn8IulC50NXUcTMIX5y6ZCsdzIkOpTDe
         zLYQtvbLujND9hVXZhpxSyY/BAHV9aa/730nshY6ProtG7brYmaoQdVeDTWdIyH58j1H
         AkZ3doNnohYOqMMxRCXH4Ku8DeM/KW8vT4ZbIWP6gYR86sm77IaVImO32p1f5/Vlir2x
         SW7QNN+TCTFbZFFIkQOokM1NtyhItEe7ii5cmH350ZX8n1zqE/Z7l+wTUbNoVyUPAT19
         m9RQ==
X-Gm-Message-State: AFq9FYIKm/VqOxyqicq1SWOUjPx2YF9KzW14KzB4Nw2zw64jOW9iSyx5
	a3wH4v75pkIy0nur0Cf0GyiUuGYAtdpEkoYlHgVKv+LoRkCKkfT3PKl46OwVE7Ya68ka5xgc9/a
	reW1wnAY=
X-Gm-Gg: AYBFou3xDSsSGGvz10YzuvuDJB0xetlxxJUGuPOGZecIxqxNfjqklAfmcwU1jnS83qT
	8GxP1/Mv3HU/mGNarGvRhWyCy8aYn560qPPhINVw9c2VfLpPuP8jO4HBCXO61GpwOBBcbvOQfkF
	jZvqpK+WXMah99V3j217iTzL0q/Io8iyh9F6EEZOxs2yu98rkaXHXGTwXbYQF1bzyPu3YMWSpU+
	MRrznwA25nQV3kNSQASKCJdB5jTzU09XnMTB1HYguVtJTRnF39GonaFd0d/tzlTK48jyJ9gBeWU
	RkpTdr3ftGwOvUA+4KJ8NvYunT9zSu6+BaeSfvJhIxKTOt3dFs9NcnHFUexoPr+ZYlgBbN1i9s6
	5cz/d3YrRGpoZBKG/rKOqs7Rg7IHx9N93cpq3/uIDxdXwq/xia8oRrPgqKyR3tiEubIBdoXLJfg
	zu+oHhJ8sEULomF92LfcwO27pj0uEAxmN0jK1x8nvVxFIgTLlfjzum/RqvDDvV3LTIlteuF9ADb
	dNAqmUR3iL04e/aPqVx6FZq1pZ77rWxxNyYF5qAkmEam67Kh/7WDNo3x0SbQSeJ0ae8LcOLURmi
	tq7U9PJeYp1NEqZ8mQyDuKQywyoTdABeMLJPhPVzoH9NF/CLVwZ8sdU3Z2EypP92/vV8ntSNJti
	uWg==
X-Received: by 2002:a17:907:3e90:b0:c2e:62af:b6fe with SMTP id a640c23a62f3a-c4ca7a42386mr952564666b.8.1793642348840;
        Mon, 02 Nov 2026 09:59:08 -0800 (PST)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com. [209.85.208.52])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4cec16444dsm11943266b.77.2026.11.02.09.59.08
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Nov 2026 09:59:08 -0800 (PST)
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6b1aa27963eso7716049a12.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 02 Nov 2026 09:59:08 -0800 (PST)
X-Received: by 2002:a17:907:d94:b0:c2d:c80e:8366 with SMTP id
 a640c23a62f3a-c4ca7426f6emr874452266b.0.1793642348398; Mon, 02 Nov 2026
 09:59:08 -0800 (PST)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261102-work-procfs-bugfixes-v1-0-59422ed3e465@kernel.org> <20261102-work-procfs-bugfixes-v1-1-59422ed3e465@kernel.org>
In-Reply-To: <20261102-work-procfs-bugfixes-v1-1-59422ed3e465@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 2 Nov 2026 09:58:51 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiSA7-mqmAjTQDaU7UjUyWt0TxYwXHafL8ZAPudy+B_uQ@mail.gmail.com>
X-Gm-Features: AclHuK_qZTBVsLQIdymgRHScSFenC6XsGggUDmcuOugjrSTbuVkeASUmC_hYPZo
Message-ID: <CAHk-=wiSA7-mqmAjTQDaU7UjUyWt0TxYwXHafL8ZAPudy+B_uQ@mail.gmail.com>
Subject: Re: [PATCH RFC 01/38] PCI/proc: don't truncate the position of config
 space accesses
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
	linux-debuggers@vger.kernel.org, Chuck Lever <cel@kernel.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 2 Nov 2026 at 06:22, Christian Brauner <brauner@kernel.org> wrote:
>
> proc_bus_pci_write() truncates the file position to an int. A pwrite()
> at an offset like 0xfffff000 turns it negative [..]

I think this would actually be better with rw_verify_area() just
checking a per-file maxbytes.

We already have that logic for lseek and friends - using that fairly
hacky combination of s_maxbytes and !unsigned_offsets().

We should combine s_maxbytes and unsigned_offsets() at file open time
into f_maxbytes and check that not just at lseek but in
rw_verify_area.

And then things like proc_bus_pci could set it's size limit in one single place.

Hmm?

                   Linus
