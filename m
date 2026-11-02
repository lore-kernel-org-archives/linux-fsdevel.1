Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793638462;
	b=qua5UF6w8mWoKNaODEv5dAdXMQwJfL19cuyVAGlqEBzOROYN7Afe9mMU9oEAdOuj/TRh
	 l8NpYnkjGIgNdS6HQSP3bcVENx20oIgB7OAqyHElMDeOpxVwB35V+5NbxZVb8ies5lchm
	 Bkut/pGrJg+19t9cZ+nG3tUQkR0KR58bKvDwUCAKRfnn/zPDjhbs+WxrvfNueKiksBxW6
	 p6ymRAR6bdOCBo6A6eV54BnIKgNaiF5QbmXMZYtq4/dEnFsyigGKeNpQd/IcSu2/YKnQx
	 WHVQcLUYTv6WfOlyY14bwBfQ6YgOLRg2g+WLiu+sS1HT/ie5el2aWORgOehbV/zefcg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793638462;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=cXGpRKvTAGjhS35rMqsnLDspbuP9bTvBPAEuRyBbB1o=;
	b=4hbm2aznaBy44ixBop+T87+bbiAZcChNO3qeaS8UfqeYv+pKmq06bBIukQUsxs8u3SMh
	 wRmfbdumZ/aMFU8bj5bv41RXkrVfhq5petJ9nd7NSVr2XA8EGttnAofgeXi1qmETDSVAp
	 nsoihBrwC9fREXl6UJWNbFrAlRcp2dKRg7bM9I5e1kprE/YHLJ2oldlrob14VR5S/zF0C
	 K1uq68mKpD83hT9/9RmKTtHPkwR7sonSb01/2QbrrsRaQBkzBfcDFLcbZaLorPMAjnYbq
	 xHG9vYrhPRaiFAFJWhNB5TuH8YBgXKndTwFWjMRVxA6qEkd3NadAWKzDu0J+XcfhoCg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nttAKpmy;
	arc=none smtp.remote-ip=209.85.128.54
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A53046079077
	for <linux-fsdevel@vger.kernel.org>; Mon,  2 Nov 2026 16:54:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A53046079077
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nttAKpmy
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4a2167bd087so27287645e9.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 02 Nov 2026 08:54:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793638460; x=1794243260; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=cXGpRKvTAGjhS35rMqsnLDspbuP9bTvBPAEuRyBbB1o=;
        b=nttAKpmylUtdq9jMTN/wbrVcLpFRXXlqGRnKAcR5A5N0R5njWywda5vUwbtWjv1b7W
         59xbEJZ2JJxmymRaCR8i06GVZVXBLNiisCoOlUWv7pfttM52v6fh6SIk9AHXpIJDBJyB
         K1v4TVQgfNPuygiU3b/InKbqYwtBsXcaPIst9yGjC2C3nIMelz+4DaN4UvJ9AbA1SpFL
         eJWTxBmYCAj1+no02fN+QGay7pGQvw0yOXA2L3jyhVpqN1ayis1XC63DRSotXOW8ULXt
         yhXK/sGczParDH3XfD0OECKkD2ibrRdl3oz45aoI8olmbtDcsTCeNObmHS0YVdneXQNk
         9X8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793638460; x=1794243260;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cXGpRKvTAGjhS35rMqsnLDspbuP9bTvBPAEuRyBbB1o=;
        b=FBxl/ng5VNmeghYsJxyCMwvbux8DJQiiBGASI+jWMMw+ZZ9ZSEDkTHOeytXo5yBNKq
         Ii96Giq/lp6NW4ym4MMYHCKWc/1Cib3AKPmN+kQIzt5OwCU+CEEHt0Qv3ccmEyCWZElw
         nipOLKjldTWQxzGVP9HQ6m/xNBGUEBVq5dZEwKk5zeSik41YiO1qLxWbmyn/NTGz3K2W
         XArJielq1YX5Bk60Q6dy2mM22HwxsT19K1yv3eAN5a2Em7kKcph+MwbxmoGwRWY4rgdE
         YLL8aYH8xbq2ol59+CVhPxpza3CAlAHDDCHhM1REGTa9k28EdU8Cu/2VSnotsBcrUpIM
         AGnA==
X-Forwarded-Encrypted: i=1; AKwUvBwmnbiFR1tz7pGTIYJma6wVXtUo9pTBybirCgTP01uArjqNR8VhYNqCg+0fAIra/BXIYOcqUulydGxzb7az@vger.kernel.org
X-Gm-Message-State: AFq9FYJ6pFEylv61royWxATVxxb9YxLJJmcMNcFqEOYoAr5Of/EfXp/W
	MOma/uAMOrNa07FH+FEWlvpFkTMIRk18n1cyOlD7+3J69yXLc6nxBCAv
X-Gm-Gg: AYBFou3P3q8Zv6qLxLts0mc/K7/xNI7vw/I89E2QRSqI/H1Aei+FxIc7EmSbl+yTDS8
	4Yd5vAEmqMd/5rY2HGS1jbkhr3zYmhDMrd6Y08U79z8Yoq5mlwcHjQ7KUjH5uxdrPMZanDB0p1u
	qGPPM1lSkjtax713cZrMpZ0T6xOpppmxvdT6FrA7sLSOdaqsdpkdH9m7mrbJ5L1TXCQCNd02oLv
	TRaGs4zBQxs20liydFsO+29vkH6FjgN7YeF3oAXX/PqOzWPbamIVze+fZZMvNw6L1VynRO60T0q
	CJM0AHDLLyn19km8iNQpef14+nPgF2L7gipfMA2LKe3PdkAw2dEs7UW3F6jfaw9JNEZMsvw6kkl
	VazSrbV+Qje8hRxvGiuLv3uL5J/y7FXsgtknTBXT+mQxDUjIJhbbcmWs+OieyoXKzeaRevhnI0Q
	3YuHETeBNIruQKLN1yQA4Ytg5j0764m7H7smCZYj98jx6MDIL8y0TH8+khJvQVqn5rIPdgy/7nA
	I2IJR9SeBDMy5YLa0bnhZMIkWvq3CWhvR0zOIM88kzTwwPjMOeET6KrKFIKGpqYFFWoTfQzwtw/
	pRkqrGw4en2a7uJpmvSHLpMmIK4OMwqHQPXansYftkrV0l7zRaQ5j/5acfpVfRli
X-Received: by 2002:a05:600c:8b46:b0:4a0:4a8:d444 with SMTP id 5b1f17b1804b1-4ac18c73238mr251157985e9.33.1793638459968;
        Mon, 02 Nov 2026 08:54:19 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71ba2415sm21483649f8f.50.2026.11.02.08.54.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 08:54:19 -0800 (PST)
Date: Mon, 2 Nov 2026 16:54:18 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Wen Yang <wen.yang@linux.dev>
Cc: Joel Granados <joel.granados@kernel.org>, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 00/39] sysctl: replace overloaded extra pointers
 with typed bounds and context
Message-ID: <20261102165342.79fc1580@pumpkin>
In-Reply-To: <0316f664-d98c-43be-92af-13c30436727a@linux.dev>
References: <cover.1793204511.git.wen.yang@linux.dev>
	<20261029105837.2f8bee67@pumpkin>
	<0316f664-d98c-43be-92af-13c30436727a@linux.dev>
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

On Mon, 2 Nov 2026 23:40:40 +0800
Wen Yang <wen.yang@linux.dev> wrote:

> On 10/29/26 18:58, David Laight wrote:
> > On Thu, 29 Oct 2026 00:34:39 +0800
> > wen.yang@linux.dev wrote:
> >   
> >> From: Wen Yang <wen.yang@linux.dev>
> >>
> >> struct ctl_table describes an entry with data, maxlen and, until this
> >> series, two untyped misc pointers in extra1 and extra2. Those two pointers
> >> have accumulated at least seven unrelated jobs: a fixed bound, a bound read
> >> through a pointer on every call, an object or namespace pointer, a small
> >> integer cookie encoded into the pointer, a lock signal, NULL standing for
> >> "no bound", and a value the core itself casts to unsigned int while
> >> validating a u8 range. Nothing in the entry says which job applies, so
> >> readers infer it from the handler, and the core gets it wrong where it
> >> treats extra1 as an unsigned int.
> >>
> >> The numeric half of this change is the direction Eric Biederman asked for:
> >>
> >>    You can still save a lot more by turning .extra1 and .extra2
> >>    into longs instead of keeping them as pointers and needing
> >>    constants to be pointed at somewhere.
> >>
> >>    [...] I don't see any reason why you want shared
> >>    constants for such a handful of things.  Especially when
> >>    it has proven to be error prone in the past.
> >>
> >> min/max are plain unsigned long members, so the comparisons are ordinary
> >> C and cannot be confused with a pointer. The shared const arrays that only
> >> existed to give those pointers an address (sysctl_vals and
> >> sysctl_long_vals) are removed as well.
> >>
> >> The tree already records this direction. fs/proc/proc_sysctl.c documents
> >> extra1/extra2 as "extra pointers usable by the proc handler routines" and
> >> carries:
> >>
> >>    XXX: we should eventually modify these to use long min / max [0]
> >>    [0] https://lkml.kernel.org/87zgpte9o4.fsf@email.froward.int.ebiederm.org
> >>
> >> This series completes that TODO and removes the comment.
> >>
> >> priv is this series' addition: the same pair of fields also hides handler
> >> context, which a numeric bound cannot express, and keeping it out of data
> >> is what removes the restore-before-delegate pattern.
> >>
> >> The overloading is also a memory-safety hazard. The obvious alternative --
> >> keep handler context in data and restore the value pointer in each handler
> >> -- needs an original_data field in nine addrconf and two devinet handlers;
> >> one missed restore turns a user-supplied integer into a write over a kernel
> >> pointer. nf_log reaches the same problem from the other side: it replaces
> >> data with a local buffer inside a single handler, so data means two things
> >> within one function. This revision removes that temptation instead of
> >> managing it.
> >>
> >> The core is not exempt. sysctl_check_table_array() reads
> >> *(unsigned int *)table->extra1 to validate a u8 range. That is only correct
> >> while every u8 entry happens to point extra1/extra2 at an int or unsigned
> >> int; a long bound, a context pointer or an encoded integer would be read as
> >> four bytes of the wrong object. No such entry exists today, so this is a
> >> latent class rather than a live bug, but the invariant is untyped and
> >> unchecked, and nf_log already encodes an integer into extra1.
> >>
> >> The refactor is the first five patches; they define the replacement
> >> contract and prove it covers every entry shape the tree uses today.
> >>
> >>    1. min/max hold numeric bounds by value, and priv holds handler context.
> >>       The range converters read min/max whenever extra1 and extra2 are
> >>       clear and keep reading the pointers while they are set, so existing
> >>       callers keep working while they migrate and no parallel handler API or
> >>       renamed symbol is introduced. Signed handlers read the bounds as
> >>       signed longs, an absent endpoint is the type limit rather than NULL so
> >>       zero stays a real bound, and a run-time range is refreshed before
> >>       every call. Registration rejects priv on a standard handler.
> >>
> >>    2. The debug test module is converted to numeric bounds as the first
> >>       user.
> >>
> >>    3. KUnit coverage for numeric bounds and the handlers that consume them:
> >>       full type ranges, one-sided and zero bounds, entries without backing
> >>       storage, explicit handlers for arrays and members, and rejection of
> >>       writes that would partially commit.
> >>
> >>    4. KUnit coverage for run-time ranges across the scalar widths and
> >>       jiffies, run-time bound pointers, sibling bounds, typed context, owner
> >>       derivation, bool, registration lifecycles, and simulated per-net
> >>       duplication.
> >>
> >>    5. KUnit coverage for priv: a standard handler must ignore it,
> >>       registration must reject it with a standard handler, and
> >>       re-registration must keep both the value pointer and the context. The
> >>       same patch moves the debug module's dynamic-value entry to the
> >>       data/priv shape.
> >>
> >> On the CTLTBL_ENTRY_* constructors: I kept the naming and argument order you
> >> suggested while reworking the series. As it turned out, no production table
> >> needed them -- the converted entries read naturally as designated
> >> initializers -- so I have not introduced them as a public API in this
> >> version; the KUnit file keeps an equivalent constructor privately, so the
> >> tests stay readable. I still think the public version is worth doing, and I
> >> would be happy to send it as a follow-up once there are real users, so the
> >> API and its callers can be reviewed together.
> >>
> >> Everything after patch 5 is migration and adds no new contract. Patches
> >> 6-32 convert the remaining users and derive owners from their backing
> >> storage. Patches 33-38 move handler context onto priv, one subsystem per
> >> patch; each of those files is touched exactly once and goes straight from
> >> the old pointer field to priv, with no intermediate data-as-context step.
> >> Patch 39 removes the extra pointers and the compatibility read.
> >>
> >> The parport conversion illustrates a concrete problem with the overloaded
> >> fields. In the base tree, registration overwrites the spintime minimum
> >> pointer in vars[0].extra1 with a port pointer. The range handler can then
> >> check a write against data from struct parport instead of the intended
> >> minimum. Moving the port context to priv and using numeric bounds also
> >> corrects this existing bug. A separate fix can address it independently;
> >> this RFC does not depend on that fix.
> >>
> >> Entries that used a *_minmax handler with neither extra pointer relied on
> >> NULL meaning "no bound". They now state their type limits explicitly to
> >> preserve that behaviour when the pointer path disappears. These include
> >> aio-max-nr, acpi_video_flags and nmi_wd_lpm_factor.
> >>
> >> Owners that can still be recovered from data are deliberately left alone:
> >> ipvs, neighbour, the fragment reassembly handlers, vsock, mptcp, rds and
> >> smc keep using container_of() on their backing storage. priv is only for
> >> entries where no such derivation exists. Mixed placement in data and priv
> >> was considered and rejected because it recreates the guessing problem this
> >> series removes.
> >>
> >> Relative to the base tree, the final state removes all 841 extra1/extra2
> >> assignments across 123 files, removes the shared sysctl_vals and
> >> sysctl_long_vals arrays (21 references), and states bounds at each entry
> >> (~574 new min/max initializers) instead of pointing at constants. The
> >> sysctl ABI is unchanged; the parport spintime minimum is corrected as
> >> described above.
> >>
> >> The cost is 8 bytes per ctl_table entry on 64-bit (56 -> 64) and 4 bytes on
> >> 32-bit, because priv is appended; the range read path gains no indirection
> >> and the migrated entries no longer dereference a bound pointer.  
> > 
> > Can you remove the little-used 'priv' parameter by making the extra
> > information just follow the table entry (nested structure) and have
> > the relevant functions use container_of() to get the outer structure
> > and extra values?
> >   
> 
> 
> Hi David, Hi Joel,
> 
> I reworked the context side of the series so that priv is gone entirely;
> and the final tree has no per-entry context pointer.
> A small helper recovers the enclosing object, but it needs the slot
> index from the caller:
> 
>    #define sysctl_table_container(entry, type, member, index) ({       \
>            static_assert(__same_type(*(entry),                         \
>                                      typeof_member(type, member[0])),  \
>                          "pointer type mismatch");                     \
>            (type *)((void *)(entry) - offsetof(type, member) -         \
>                     (size_t)(index) * sizeof(*(entry)));               \
>    })
> 
> The reason plain container_of() is not enough is that the core keeps the
> table as a contiguous array.  For
> 
>    struct addrconf_sysctl_table {
>            struct addrconf_sysctl_ctx context;
>            struct ctl_table table[];
>    };
> 
> the handler receives an interior entry, and
> 
>    container_of(ctl, struct addrconf_sysctl_table, table)
>        == (char *)outer + index * sizeof(struct ctl_table)
> 
> for ctl == &outer->table[index].  It only returns the outer object for
> index 0.  Passing the index explicitly keeps the original registered
> entry usable:
> 
>    static int addrconf_sysctl_forward(const struct ctl_table *ctl, ...)
>    {
>            struct addrconf_sysctl_table *t =
>                    sysctl_table_container(ctl, struct addrconf_sysctl_table,
>                                           table, 
> ADDRCONF_SYSCTL_FORWARDING);
>            const struct addrconf_sysctl_ctx *ctx = &t->context;
>            ...
>    }
> 
> Shared handlers get one wrapper per slot; the common body does not need
> to know its position:
> 
>    #define DEVINET_CONF_WRAPPER(attr)                                  \
>    static int devinet_conf_##attr(const struct ctl_table *ctl, ...)    \
>    {                                                                   \
>            struct devinet_sysctl_table *t =                            \
>                    sysctl_table_container(ctl,                         \
>                            struct devinet_sysctl_table, devinet_vars,  \
>                            IPV4_DEVCONF_##attr - 1);                   \
>            return devinet_conf_proc_common(ctl, &t->context, ...);     \
>    }
> 
> Single-entry tables simply use slot 0:
> 
>    struct devinet_forward_table *t =
>            sysctl_table_container(ctl, struct devinet_forward_table, 
> table, 0);
> 
> 
> The series is 20 commits over 134 files, with no priv at any point.  If
> you would prefer a different shape for the helper or the wrappers, I am
> happy to adjust it.

Certainly worth thinking about for a followup patch.

A different option would be to pass the array element size when adding
the items.
Most code would just pass an array of 'struct ctl_table' but instead
you could pass an array of a larger structure that started with a
struct ctl_table.
That should let you use container_of().
That might even make some of these patches shorter/simpler (I just looked
at #33 (ipv6 addresses) and it is somewhat convoluted.

David

> 
> 
> Thanks,
> Wen
> 
> > David
> >   

