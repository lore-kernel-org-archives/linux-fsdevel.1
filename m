Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793873265;
	b=R13E6+KBFm8e8ldiNmj5ydf9cj0PT+8M11179RnZb3Gp04VvcINOf7Bp9HKas5IxunAy
	 o+PfRZ4GL7kjL234SGH9i+mxTjcieIkObNVkatwWdzTzryC57gMEI5DppZrO2s7DpxcxR
	 TcZ4KDjrxDiDHWVtfEiS2Vao1LYcP9miCn+x1rJom9ejWulCF4DH5zMZGZdoZAehda4Yx
	 Hg0/qdhhLZtjxEnwW0wb7aDHGm7eTS5wCe3ic+HmNuzZpi3qWbbuigHrB87kWpEjWXurj
	 B0XHq0UlXwp2UAwd+hovBjHMOTGKsVkmF55F1mewlBH6MDGdkcd6PuHIganQhlAUKQA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793873265;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:Received:Received:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:X-Gmail-Original-Message-ID:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type;
	bh=HRfPjQi/EPajP85bp44Mrjs4W2fVG4O74jaEjdHYdtc=;
	b=4kbJKGlnKQfRQeO5xJE8qhwOW9SCaJ8sBlKDl+ZYIG78klx8ICHCIgt4WHpprPBc0Az4
	 9KsfZEyozglu5qchyn68jHBLv/Pm1+4M256dEfHh9kt9k79YE84CxpMrFQchv2cSlKM1u
	 eYA8t6WE06wFHwBFAo7fmHS6ZE1s9LPLCSFxpPwxXsRC+h7dlGJAaJYOg197hiQ2ngTbX
	 Umepnz5HtofrYji6pMsPRsNimoib4C6j2km7GGlBHqMC20dvbMQ0vnjFnknitpRUvJ63J
	 MNlUeYnSwxGQY1W3gxlV1yz5Baqyj1Gm5kZE8JAEt2qJdsgk3yn6PH39auPyI0gctdw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linux-m68k.org;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.217.47
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85F88606A32C
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Nov 2026 10:07:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 85F88606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-7cc1cf48a39so583579137.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 Nov 2026 02:07:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793873264; x=1794478064;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=HRfPjQi/EPajP85bp44Mrjs4W2fVG4O74jaEjdHYdtc=;
        b=pZKG07827B1ZDfX3DsPOBYtYq8agn+MDrhTnxhrsFpY7gr+3mkB/TPywfvK45UgVRC
         fP+evCU73vGRCxXnb+O4twd+8v1KcaxY5T7Igsch4Vy2xCmIbkRsJn9v3zlV5yuUW/FK
         GZZsCSY0BGZiv7waclt1DrveZc9mqHWI5wcEaRmeGIbSbsPdP+PSlXmbh3nQ98TL2ITI
         zcB43cGYm6qh/SaYsgEZruu32R/rsAnzLVM8Bi/r11loLTta5tpEJqaTEZs7zCgtZRjb
         y7iUEQAvQ/LIWTIvr5nHEcEYBia3MEEWjVrAdeSUlVdzNwUDhu5ud0k87p915CmKdDHi
         aywA==
X-Gm-Message-State: APuU4Z8EjgAnlNs9cW4BSCogU41Pvm1vabvQflg2UKli2aQvGyrX6V0f
	3WIjaqt1y/uA8jGyWPHgQvGnKkiNLgfxNpsCpWPVB6T6odTUjZM56yrxqvtgwT/Kin4=
X-Gm-Gg: AYBFou2lXADdUtnd9eBe38jp/KFMgL8P5uyR/eF2Ss7MYKf3ef04FnmJcW52gKlL79z
	YdO0WctqQ3Ltsk46x92sSOGJeX+1SCU3lmbCgSXto4QXjwO8qQJW1dq8TlQ+fNW5JO92onEy1dY
	UPKbegcxGxpilhNtv1ypNY1s8lcqrmpg7qj62XYBbKigouR5KIETNwRElbqxVZbuWg2WfZYIH9V
	r0Iz2cynQ4iK6J8UYwhRa6HTZ60BAEGIokULCb9wCLhAxy31UWJhy3+SAzAzm8GkXFttHbkbD76
	eIw78O+lf4fSUGwcLgi+xf3dRDuXQJvBZO/FLqrzDm0000HaHZmKv7qGgfxVHwUJ72VJHflMiaa
	KIFRcJ0LBgwsLT+TslWCI0l4vhSTOUOog/KfNqHF6bm9PYZ5jfkF5P7CTLdSy/Homd+vcALnE1a
	Xg0WqEyhGhtpcFAe8vBMk6osyFnZOijyG0MsR4nzZSgVSb8pdMP/7vgYfLltDB/rMO9tXEJ0AE3
	UpgocWlEbbrYek7O2+d0C6+fdzewXaHafuXsBUeWFpJfHmowqHucgsj5Yh0ud1uo+bKMSq1bUrk
	L/CM3JLq71fajGtc4j4tLMCcfZMuMNHXWdJ8PprZpaGss44n2XIwPrUqYT+6yWdXOeLlEdN6MJ0
	Qozz31sWYdbc=
X-Received: by 2002:a05:6102:358a:b0:7c3:a6f0:99cb with SMTP id ada2fe7eead31-7d072719913mr7038681137.33.1793873264372;
        Thu, 05 Nov 2026 02:07:44 -0800 (PST)
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com. [209.85.217.46])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7d277d13753sm3100950137.10.2026.11.05.02.07.43
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Nov 2026 02:07:44 -0800 (PST)
Received: by mail-vs1-f46.google.com with SMTP id ada2fe7eead31-7cccb2c96d0so515237137.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 Nov 2026 02:07:43 -0800 (PST)
X-Received: by 2002:a05:6102:374c:b0:7cc:1a41:20e8 with SMTP id
 ada2fe7eead31-7d07227a940mr8060714137.5.1793873263361; Thu, 05 Nov 2026
 02:07:43 -0800 (PST)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261104-work-procfs-core-v2-0-76ace653a773@kernel.org> <20261104-work-procfs-core-v2-14-76ace653a773@kernel.org>
In-Reply-To: <20261104-work-procfs-core-v2-14-76ace653a773@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 5 Nov 2026 11:07:32 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVfakapgBK6TBhO1iWX8qzvLDk8jzRS=t2MVa5G=MCUeg@mail.gmail.com>
X-Gm-Features: AclHuK9naqg5CZQ7lhJVrMhg9TNH44f-SpA5WbUGCGBsAlcoOw2midTd7doJSmk
Message-ID: <CAMuHMdVfakapgBK6TBhO1iWX8qzvLDk8jzRS=t2MVa5G=MCUeg@mail.gmail.com>
Subject: Re: [PATCH RESEND v2 14/23] proc: let procfs copy in writes before
 pinning the entry
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>, Jann Horn <jannh@google.com>, 
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

Hi Christian,

On Wed, 4 Nov 2026 at 20:32, Christian Brauner <brauner@kernel.org> wrote:
> proc_reg_write() pins the entry and calls ->proc_write() which copies
> from userspace itself. A page fault in that copy can take as long as
> the writer wants, just like the copy to userspace of a read, and
> remove_proc_entry() waits for it.
>
> So do what kernfs does for writes as well. An entry that implements
> ->proc_write_buf() gets a NUL-terminated kernel copy of what was
> written. procfs makes that copy before it pins the entry. The copy is
> capped at ->proc_write_size bytes, or at PAGE_SIZE - 1 like
> proc_simple_write() if the entry doesn't care. Larger writes fail with
> -EINVAL. The proc_ops go away with the entry, so procfs remembers the
> limit in the entry when it is registered, like the size of the seq_file
> state, instead of pinning the entry just to look up a number.
>
> Entries that take binary data in pieces, like the PCI config space,
> ALSA's data entries or a firmware image, can ask for
> PROC_ENTRY_SHORT_WRITES instead. procfs then copies in the first
> ->proc_write_size bytes and the write comes up short.
>
> ->proc_write_buf() gets the position like ->proc_write() so entries
> that write at an offset keep working.
>
> Note that procfs copies in the whole write before the entry looks at any
> of it. So a write that is too large or whose buffer can't be read fails
> before the entry's own checks run, permission checks included, even
> where the entry only ever looked at the first few bytes.
>
> An entry that implements ->proc_write_buf() and still has a
> ->proc_write() fails to register.
>
> No users yet.
>
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Thanks for your patch!

> --- a/include/linux/proc_fs.h
> +++ b/include/linux/proc_fs.h
> @@ -67,6 +74,16 @@ struct proc_ops {
>         const struct seq_operations *proc_seq_ops;
>         int     (*proc_show)(struct seq_file *, void *);
>         unsigned int proc_state_size;
> +       /*
> +        * procfs copies what is written into a kernel buffer and calls
> +        * ->proc_write_buf() with it. The buffer is NUL-terminated and holds
> +        * at most ->proc_write_size bytes, PAGE_SIZE - 1 if that's 0. Larger
> +        * writes fail with -EINVAL unless the entry asks for
> +        * PROC_ENTRY_SHORT_WRITES. The position is NULL for a stream, like
> +        * for ->write().
> +        */
> +       ssize_t (*proc_write_buf)(struct file *, char *, size_t, loff_t *);

"const char *"?

Seems like you have to drop several const attributes during the
conversion from "const char __user *buf" to "char *buf".

While at it, I think it would be good to use this conversion as an
opportunity to replace "char *" by "void *", which will probably let
you drop several casts from users.

> +       unsigned int proc_write_size;
>  } __randomize_layout;
>
>  /* definitions for hide_pid field */
>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
