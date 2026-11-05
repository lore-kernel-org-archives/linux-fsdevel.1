Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793873320;
	b=2hezdDtbtdfrbL+18hN807svIGwXv1t89qMcN++KWlEpOmp9R/UUSjadIjQSrqs2eB1y
	 8DYpYg6YKJaeoahzHp7A7O+R0W9XI+0nupq+Y6Pzm5Mq/lTGdE+U92PI1PKVMx6z+9QU5
	 VKH7lvi/zV52ctC1e+dyj2ywAq6AxJ6AA/dYHNHZ4cHMys7hkOTO3tJrIFJYtdlT7xvYq
	 LL4n8ORos0EybsYxeAnlrD0yTL8ebpd+WFQI+2NC7s2RINkC6rFXwZhXRnDwwOlrS5Ab6
	 +5A1Qkg21BMWJq3qAiRf7raaBri+L9h9USU44UR9ox6Co4iIRyzjptDrDD5sHP/ZxSQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793873320;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:Received:Received:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:X-Gmail-Original-Message-ID:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type;
	bh=Z2qCIfu1coqF5CKQo/xHkFXbKW7Y+rLlNCa31RZmxiE=;
	b=iSFSIopSAhX9Z6BA/57BZgZJMvD+N939klVWnAa8ZzcGpjVj/5YMfW1JHWSFjxAfRjuc
	 1dZ67FwPyjrxR3UXRdKCdKsIRB032p+o7XRvIbr1YTrkO72L+6xoHesEaLRiiRlmzyPwg
	 9g47HX6015aV4ecDGf9h7zCwqGJzBAhKO2wiCwW04rdSZvtcXozY/9UXFPcaz6D+ZEJVF
	 /pq4RNsyRRnrxf5ucUX6Jo1v3ZuZo7ruaXlINU1jXW0wIGS+e0l2CLCmeaXCRzq/ooMTa
	 or76vrctPKDjDkrTyMsX/Ksu7x+1vuQeEFW22v/iE1kE8IobsyIflBx+L2OdJB5LuBA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linux-m68k.org;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.222.52
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16E4160A2608
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Nov 2026 10:08:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 16E4160A2608
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-998749fe872so935059241.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 Nov 2026 02:08:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793873319; x=1794478119;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Z2qCIfu1coqF5CKQo/xHkFXbKW7Y+rLlNCa31RZmxiE=;
        b=DVzFjqk4nAGcAry4Sr2dGbX/oPQsQNuRZB2BFQ9ZT02alLuo5pXlsOR/dRFV2C+wJ8
         xig1rlQoK7TI83vh0YqcbLa9PVksih3KvjHES4un88saKOu242tL90VzLbw2qtlRB2Yr
         nA6VrJ+uLZRySqzKLzay2VZTLZR6SrqTDMD5Cu2dWjcjzRrJ6qBdRX/ounUoIJpKets7
         9jZ3hNYhuFOVehhQDL5yMBUSQj2+DSDcv4K1xr+nFYL0y2k8F1NawJE0pRGeOYwN1G2d
         xk2pqv65pSync5g6MPCWyPDVCVecWCFMzZHjXdTMLj57mpNfIe8ioGJrqRCFCLkEWlrl
         5SjQ==
X-Gm-Message-State: APuU4Z+OHp5JgPfBo61KneLlJDLb4hufSftW7LO4Z7sqIlD/KPNVpJyX
	TFxFRkJQElrERdJB/aZMZasywaTQLZi0ig/QYfrdsT8cdiG8BDUzdgI99F8JaWDvP1g=
X-Gm-Gg: AYBFou3qcRdYEdHUKI/xkkUt2I5EuUS1fQDOxogRIbR4fSgT5xDQrznKUznEhpU+YsG
	1iP/vX8lcCTf6EjfP1c8I1AoimEcTGK39FEeNM18mT1g+Rai1w7PuIl2zp5QoBNnAkTIxxodB1f
	JGmVdkeAxKtMQ0C7Pk0L90Vl5Qceaqwpe7PrCQDsoRN7UxIc20aMJn26lvBJBXn63SoBP9ilw78
	3ZqorgKfWZKZg6P/AQN3kxU4eN39kMKb3FqMZfB7Qk+30lGThj7LNGWbS9rd9/9S0Zfs0Zql8EZ
	5rnEHANYL9dQvJD4GzS6wgPIet82BBbPc4+FnUbDwTurwl8F0VWrm2qFaJa3QOle2iWFP1v+g2R
	yvbzJ4ian8sYj/5rxt8eXj402+xg2mwo++JfM4x875nTk7dheJs+MnUEC22UGC+3GSxEkcRknih
	qbhNuUdjZCyjcgh3EhDQ4JXuJkPN2fTMxvfFczHrQegIrnd/d4WmpF6YDyXy4MEfsJoIQQXcjjP
	kW/gBv79KZNXAy0Ly/H6x4mXQV1IVBldaBkoQq3WUAq6a34mFR//N+dMOUR7yq5RfoO+zccvnGQ
	96cgQzESDaBrGG5A/zDKEJZtS+zDhChYBoW8ewzjuT/dPZ56H8smkSz0j0OYWSSe9g==
X-Received: by 2002:a67:e70e:0:b0:7b2:f3ff:6b34 with SMTP id ada2fe7eead31-7d07277c9e4mr9197483137.1.1793873318990;
        Thu, 05 Nov 2026 02:08:38 -0800 (PST)
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com. [209.85.217.47])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7d26fdaf4efsm3543762137.5.2026.11.05.02.08.36
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Nov 2026 02:08:38 -0800 (PST)
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-7bec5112765so1033377137.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 Nov 2026 02:08:36 -0800 (PST)
X-Received: by 2002:a05:6102:5494:b0:7cb:bc5e:7d9f with SMTP id
 ada2fe7eead31-7d072bb3829mr8787869137.11.1793873316184; Thu, 05 Nov 2026
 02:08:36 -0800 (PST)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261104-work-procfs-core-v2-0-76ace653a773@kernel.org> <20261104-work-procfs-core-v2-16-76ace653a773@kernel.org>
In-Reply-To: <20261104-work-procfs-core-v2-16-76ace653a773@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 5 Nov 2026 11:08:25 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXAk9CwoXpak8+EQjdvJ2Ab9fo1bvj_D5GqBzXB7urEUQ@mail.gmail.com>
X-Gm-Features: AclHuK_D2R6ZzQFy7DOLUQHC3VotRoglnOuhbtIFU-Oniz4UMRG_6kQUnblEqeo
Message-ID: <CAMuHMdXAk9CwoXpak8+EQjdvJ2Ab9fo1bvj_D5GqBzXB7urEUQ@mail.gmail.com>
Subject: Re: [PATCH RESEND v2 16/23] proc: let procfs copy out reads that
 don't go through seq_file
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

On Wed, 4 Nov 2026 at 20:33, Christian Brauner <brauner@kernel.org> wrote:
> proc_reg_read() and proc_reg_read_iter() pin the entry and call
> ->proc_read() or ->proc_read_iter() which copy to userspace
> themselves. Like for seq_file reads and for writes, a reader can make
> a page fault in that copy take as long as it wants and
> remove_proc_entry() waits for it.
>
> So do what kernfs does for these reads as well. An entry that implements
> ->proc_read_buf() fills a kernel buffer of at most ->proc_read_size
> bytes, a page if the entry doesn't care, and procfs copies it to
> userspace after unpinning the entry. The entry moves the position like
> it did for ->proc_read() but that only sticks if the copy to userspace
> worked, like in kernfs_file_read_iter(). If the copy fails halfway the
> read fails with -EFAULT and the position stays, where
> simple_read_from_buffer() returned what it had copied until then.
> procfs remembers ->proc_read_size in the entry like ->proc_write_size.
>
> Larger reads come up short, like with kernfs. An entry whose readers
> want all of a large file in one read asks for PROC_ENTRY_FULL_READS and
> procfs fills the read in pieces of ->proc_read_size, unpinning the entry
> in between. A piece whose copy fails ends the read with what the pieces
> before it returned. kexec-tools treats any short read of /proc/vmcore
> as fatal for example (cf. [1]).
>
> These entries are read through ->read_iter() so readv(), splice(), aio,
> the RWF flags, kernel_read() and io_uring work for them like for the
> ->proc_read_iter() ones. io_uring's nonblocking attempt gets -EAGAIN
> though, like loop_rw_iter() gave it for ->proc_read() entries. Neither
> the allocation nor the entry can honor IOCB_NOWAIT, and io_uring would
> take a short read of a record file for an unfinished one and glue the
> next record to it. So it retries from a worker like before.
>
> An entry that implements ->proc_read_buf() and also declares a seq_file
> or one of the other read methods fails to register.
>
> No users yet.
>
> [1]: https://git.kernel.org/pub/scm/utils/kernel/kexec/kexec-tools.git/tree/util_lib/elf_info.c
>
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Thanks for your patch!

> --- a/include/linux/proc_fs.h
> +++ b/include/linux/proc_fs.h

> @@ -84,6 +91,15 @@ struct proc_ops {
>          */
>         ssize_t (*proc_write_buf)(struct file *, char *, size_t, loff_t *);
>         unsigned int proc_write_size;
> +       /*
> +        * procfs calls ->proc_read_buf() to fill a kernel buffer of at most
> +        * ->proc_read_size bytes, PAGE_SIZE if that's 0, and copies it to
> +        * userspace afterwards. Larger reads come up short unless the entry
> +        * asks for PROC_ENTRY_FULL_READS. The position the entry moves to only
> +        * sticks if the copy works.
> +        */
> +       ssize_t (*proc_read_buf)(struct file *, char *, size_t, loff_t *);

As for proc_write_buf, I think it would be good to use this conversion
as an opportunity to replace "char *" by "void *", which will probably
let you drop several casts from users.

> +       unsigned int proc_read_size;
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
