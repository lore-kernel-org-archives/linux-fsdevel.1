Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=209.85.218.47
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793122223;
	b=xkKwtia/2cECp08aIsuX0+h2fC8oJa/abxiHdNLmekkdhkjRd2K5rRQeVkdfaV+ZTwXz
	 eLhryLZhCdp0RVpMZadsuZrWQ87Jhb6ijpw9XxQTmAOw5yxppAIuFAZNo30PxX85VxQ3S
	 GDNmjoO/RFyHL/m13UaRUFIuuSXUaIUf+IIeVXDcAqcWXjCVveQZ7/mrUkZoxvTzjO69p
	 Wq29pCntirzkCu54eCUjOGHtSJ9eTbIjYXJnuruzVvprYwijBzIJd7fysGli5goYyf4D3
	 07eSfYpdVGdg/T+HaKebzS0uzeGkHJfa2S6WzijiJxJ6//Y390P2kBF3JMn2jlfWAcA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793122223;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=7gQ+97vReKa4toS9130cb0MEUCUe5fofr2ehSKz/dNw=;
	b=Y/gZfhp3+xes6mr8lXzY1X635Cao5SnhQp3hcytrI/picHAMpmpjNQCGVo8icUGW5t72
	 qJyhZ5coG/zwNHe6FziR6tNGGYftfuwfamMzvrJLssMJDiQP4UZ3xHTxvouFyF81xA/mh
	 Rl03dqmE0Eut/m2zJ+x8R+tVVQKP+tudAJqSuy4MglENHcRGOMMyeX+a2uYqcBXrQNaAP
	 SWem2oEOhGxAVRk+RFp8ZUUb+E56Q/0Rf3tws8zGT/CB3vUu0AHtP0qppsQ5F5eaMK0t+
	 9uY/uQfrrObXgNomiePzxa1tCvf9h3GYEd0WX4gkpv8PO2FIRUk7CSx3nvHeCmqRjTw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=AH5XVSYu;
	arc=fail smtp.remote-ip=209.85.218.47
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E801606A322
	for <linux-fsdevel@vger.kernel.org>; Tue, 27 Oct 2026 17:30:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8E801606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=AH5XVSYu
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-c49b431f022so10356666b.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Oct 2026 10:30:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793122222; cv=none;
        d=google.com; s=arc-20260327;
        b=jTg6Fnts6nQXGjpilWWYP8dDxMG8zLyA2bZYNlsFD8UjFSIfGlEvwF7ZcMpCiC+iys
         dCzOg0G3x/L1xDmf4yVb2wZ/btoqt9CDtZEwP0L/EVDG3BeU2s7vfnGRuTKgjBk2sAzr
         BAH+ohOx28iD8g4O1JlvkyhUgC0VtB3zPuSKpb3L5fIXYUhp6uTCd+soi/Gsbqa7nTJe
         0n+BpzEU/SxnfRZRvon0wta1PLiARyr8M1v/UDdl6kt6jGJA+9vEqMg2lCI0Lm7Wn9XK
         MDfu6ooKyaa5C0fYQyb6EPUswJVBEyXkOg4oGhhWDfti7R1esewGNyagUT0g3RbHxlFJ
         3URA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7gQ+97vReKa4toS9130cb0MEUCUe5fofr2ehSKz/dNw=;
        fh=v8pK/oaSJ3wFzTImMIdmDhLvT4ZEnxEywBOlW6ScGbY=;
        b=hGVMqwtLnNWvymTFwsCOLkdT5nu96G8r+F1Ux397e2nPSyGXQPwI8gn6nJOncxjz4Z
         VxJqPecqtNiK2RpxZjsIFyXZemv6I3QMzTN/KCH7EHItui9USa1osbhK3qG806Q4qVY+
         0Rs5IPkjCOOkEWsS5FIx4GyPNT3MICTRSQZS7VVcXzMd/OX+BH69ORN/i4LFGKvcZwgM
         bAWOCcU36w7zYAi3mynwLWkljKgoezaR2xcNuCtUpIFHEGyC8FspnkYxQFqIZqkC0rDc
         D54tHUo3ZdsJn/+uhCJ8PP8lzl+A3Auwl2dyCd1nIPMLYZ1abhtYEoT+vtHJwu6++5bt
         QWvw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793122222; x=1793727022; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7gQ+97vReKa4toS9130cb0MEUCUe5fofr2ehSKz/dNw=;
        b=AH5XVSYuq6HUx6QejcrLzJHXiZbWI9DboIxOz+yByNgh84gxZAIKBuzZHV99EG6rqB
         sL71z4Wm6MSPA3Nnza0i731ilrImuFj3jUTow6hkS/0r7bYzxQobbOzdeIyt6ASGeEbF
         yTa0PHt944q+HSgG6NrCVe3wZJYFAVwhpzaLqX011nHEVLqO4I7UJy1zd5cfMTXQHdaA
         BSUKBBxl7R08MamwKyO7Ss8mI2wGFLi7Y2RxS2XZ75lMQCOMaDZ6YNjy/Um35SI/BQEx
         H9A/IMXo16KCWMivgQdBOKUL0g+UWglSQzebhEs3U4Ckl7bH2Y72gGHNDHSXACje/sxH
         22yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793122222; x=1793727022;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7gQ+97vReKa4toS9130cb0MEUCUe5fofr2ehSKz/dNw=;
        b=puh8mz7m1YXPT15/59iJDnPr3PKNarDqPQw18k/kADKU0Gtbvh3TFOuBUF/Xhzv+OT
         fxnm/LHdthUv5qPMJlGza1cUPvTb36qdKc4Rz8nhTGgR0xh5wEX7W4Y2RA4vLEGyd5vO
         OgbBPECq4jHJXkKBpLZ3favvC/yXy/wxDVHF3E1GVRVENtYrDTwnWA3/I8YFWBuiouhY
         oBDBhZE6vLb++xuNvJ9j99d0YejNcPhW9e9gLhzBUYcYEL6h6+Xie89/Om06TzXI6O/H
         OP/KjaQWnEF7iq5d7MuKyRbaNJ/hURh7PXpTOafuyAJVmXS+X2CkDVg548U0xT9p6Ifa
         3bjQ==
X-Forwarded-Encrypted: i=1; AKwUvBzRzRAUUASA9rS/tTpCKfirXysp8KbLKyfDX+52AvMIM9i3+TOrBOYSv89vQ4lKZKYR3r2cPzorpDaWVzoQ@vger.kernel.org
X-Gm-Message-State: AFq9FYK4Ixgvst/cw+JQwpEkUoVvsXgJh3F8MLTr9RQdv4f2SqLnnJjV
	Jq1cYwwl4HBFc1EkmvOaeD6I8iBsyxzn2N63O+OTNOqSP78AlGAkTdka9xQ8TLdFoVdZPOXWdaK
	MT3PYdzVMUATPFtCS8aWCViweyOxnnx51bHbEwh2n
X-Gm-Gg: AYBFou1KVJuoUzr+3tCVdwuK0rlyCEcRk99/ZDVQYyYiDit/t4r/Q3E/sgsvObzhgaG
	PNpfQ++dDoZTpzgd18fRaQIIkiTrXGT62DGXdj3+IxXEHt6ChaBZYNdX3l3fLZf/PDSN18L7/TN
	/Cf75x4W4NVM4KwSpNaNd/cQQdOCMafwdbKfxhfwhjYjhHig48ecNtCvHr4xsXSRfMf2X3bNRS8
	4jyshJA7OIZ+r+fKh6a/AioINRZRKR1H5WYmUo7BhYtf/prZI6D8+ikekRnRn7oASJmIjggRDr+
	6ZUh15VW/CBBBLtk9nJ2sOeA8JGMEB7rAUFiyp7jeBmuKNsVXEnNhGdykKAeQkDhwJ8k69QjZ+n
	kYRK7H8TyThSqIOQfmGp7+TwGOZjG7nloBwz7Qd5fCvOqrguubg+STud2FMjCBolQ3imEpmRT0N
	wJqImCD1MR019Io8IOAhCl/dcDCy5EcoWVQemIiXxhBS8jiX/pW5i7NYy+AqJRI3w5sOzYYcHN6
	fWYfBW40JL6U5Fp5V4LRK6XPMBL+HiF4A==
X-Received: by 2002:a17:907:80c:b0:c46:6a50:40c2 with SMTP id
 a640c23a62f3a-c46bdee2675mr1178260566b.39.1793122221137; Tue, 27 Oct 2026
 10:30:21 -0700 (PDT)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261026215226.3713941-1-jthoughton@google.com> <14f5f919-55bd-47c6-a1c8-6f1445cce733@app.fastmail.com>
In-Reply-To: <14f5f919-55bd-47c6-a1c8-6f1445cce733@app.fastmail.com>
From: James Houghton <jthoughton@google.com>
Date: Tue, 27 Oct 2026 10:29:43 -0700
X-Gm-Features: AclHuK_V7ZmMdE83iy-wOvaliSqHMUcbKVcnfqQwnRgRgjPYRFDHKTZOMwXOk5E
Message-ID: <CADrL8HXQdzcroeGN-ACjyy-jSAdBNHiT1_BCVVe0P+Y8ZueiyA@mail.gmail.com>
Subject: Re: [RFC PATCH 00/10] uaccess: Refuse and warn on user accesses when
 current->mm is NULL
To: Arnd Bergmann <arnd@arndb.de>
Cc: Andrew Morton <akpm@linux-foundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Thomas Gleixner <tglx@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Kees Cook <kees@kernel.org>, 
	"David Hildenbrand (Red Hat)" <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
	"Liam R. Howlett" <liam@infradead.org>, "Vlastimil Babka (SUSE)" <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Jim Mattson <jmattson@google.com>, Jens Axboe <axboe@kernel.dk>, 
	Pavel Begunkov <asml.silence@gmail.com>, 
	"James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>, 
	"Martin K. Petersen" <mkp@kernel.org>, David Sterba <dsterba@suse.com>, Chris Mason <mason@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, kvm@vger.kernel.org, io-uring@vger.kernel.org, 
	linux-scsi@vger.kernel.org, linux-btrfs@vger.kernel.org, bpf@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 26, 2026 at 5:13=E2=80=AFPM Arnd Bergmann <arnd@arndb.de> wrote=
:
>
> On Mon, Oct 26, 2026, at 22:52, James Houghton wrote:
> >
> > This series comes out of a set of bugs that were found in KVM where the
> > kernel can sometimes write to a random process's user memory[1]. The KV=
M
> > fixes at [1] are still required, even with this uaccess series, as note=
d
> > by Sean here[2] and below in this cover letter. The beginning of this
> > series includes fixes for similar bugs found through static analysis
> > with Claude Opus 5.5. I don't think any of these bugs are more severe
> > than the KVM bugs[1].
> >
> > We hit one of the KVM bugs in production, and it was challenging to
> > debug. This series makes such bugs, where the kernel is doing uaccess
> > without an mm, much more obvious.
>
> Nice work!

Thanks!

> > Such an access does not reliably fail. The user portion of the address
> > space belongs to whatever mm happens to be lazily loaded, if any. If
> > the access faults, the fault handler refuses to handle it and the copy
> > fails, but if the page is already mapped, the access silently reads or
> > writes another task's memory.
>
> This sounds like the problem depends a lot on the architecture,
> and to what degree they implement lazy mm switching. If an architecture
> makes all user pointers invalid for a kernel thread, this does not
> actually happen, right?
>
> E.g. on arm64 with CONFIG_ARM64_SW_TTBR0_PAN, the page table base for
> the current process is only set in user_access_begin() and would
> not point to any task here. Without ttbr0_pan, it should be
> covered by cpu_set_reserved_ttbr0() turning off all user space access
> for kernel threads.
>
> Should this perhaps be addressed in architecture specific code
> instead of in a common place?

You're right that whether corruption can actually occur depends on the
architecture and config. I'll write a note about this in the v2 cover
letter.

That being said, I still think the right thing to do is to have the
new check(s) in common code. Instances of improper uaccesses are still
bugs, even if no corruption occurs.

> > =3D=3D The New WARN =3D=3D
> >
> > The rest of the series makes the generic uaccess helpers WARN_ON_ONCE()
> > and refuse the access when current->mm is NULL:
> >
> >  - Patch 6 adds uaccess_should_fail(), which combines the existing
> >    should_fail_usercopy() fault injection check with the NULL mm check,
> >    and uses it in place of should_fail_usercopy(). This covers
> >    copy_{to,from}_user() on all architectures (including the masked
> >    user access paths, which never call access_ok()), the
> >    __copy_{to,from}_user() variants used by KVM's guest memory
> >    accessors, the user-backed iov_iter copy routines and
> >    strncpy_from_user().
> ...
> > The checks are deliberately limited to generic code. Accesses
> > implemented entirely by architectures (get_user(), put_user(),
> > clear_user(), and direct users of user_access_begin() or
> > masked_user_access_begin()) are not covered. Please let me know if the
> > new check should be placed elsewhere.
>
> I would think that user_access_begin() is a more natural place
> for the added checks, as this should be called exactly once for
> any function that accesses user space and also stays out of the
> way of the copy_from_kernel_nofault() etc.

user_access_begin() isn't used in a lot of places that I want to
catch, including the KVM case. Roughly:

  kvm_write_guest_cached() --> __copy_to_user() --> raw_copy_to_user()

There's no user_access_begin() in there. :/

I do think user_access_begin() should have the new check though, so
I've added it in the v2.

Thanks for the feedback, Arnd. :)
