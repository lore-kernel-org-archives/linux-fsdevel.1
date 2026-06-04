Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F1C73A48F6
	for <linux-fsdevel@vger.kernel.org>; Thu,  4 Jun 2026 15:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780588411; cv=pass; b=llytJBcoTsSQv1hfGSULbO2lt2vbu6e+ML5JNraIbL/XPIrC/0nlNVpSvie3wCeL6n36OaK8pMaIENKtdoAVgcnT1ICDOgPgSXrDfa2ocd7ToJvXfBdRncOyIA0bwsZGl0+GvqtkfKiq74vV6WZpCx5LuU9bHD9VqDIsQd6fap8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780588411; c=relaxed/simple;
	bh=DHE3qIm1NUuqilEHDVEIKI0Gv9gNlT3AX89YAbcKkxE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ePOBgFihLf5GTixdZwIgovHAZ6dtvx8SjRTcUXwVFT+rpsPxePWvJpVZJISHRpI/H3lUG1z+qdAqkuzli3mYS3xS4p6ceTpdMpAi9BQsRQz8NUyWlnOE9bji5tXqtPfUPbFUqiy0xxkEvYc53kDGblriR6x5iEaIIf32nk25dnU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net; spf=pass smtp.mailfrom=amacapital.net; dkim=pass (2048-bit key) header.d=amacapital-net.20251104.gappssmtp.com header.i=@amacapital-net.20251104.gappssmtp.com header.b=Ki36pezf; arc=pass smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amacapital.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20251104.gappssmtp.com header.i=@amacapital-net.20251104.gappssmtp.com header.b="Ki36pezf"
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-3967726bc47so8461291fa.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 04 Jun 2026 08:53:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780588408; cv=none;
        d=google.com; s=arc-20240605;
        b=RM5GWQ/w5ZY2MdJm/C3b6WH0R3qHYNKx9jiH+yK1QkfRIeihr8zxs8cH5Gu3fQEIwR
         FcjUx2UWzRqFM05MC9f4fxi8+HEF9xp26i/XFeVC4PMAft/Q4FoCTpqigw3KL3oApTFC
         ECM7gYg4mb4DDOqL5Xq10LPTTlV6eVqCmd2w1VIqzvGDdAIc+p6GMflN2EobFvIHXqV1
         YnwfSfYHaa4MhXRIt8TMpWVwij3XTIQ9UBCZrtQD1INwx8aWAIHmC9UA/17QvxlhK5rh
         n4bdpxp0Nh6M2XdVqg8hJ7FfZ37nyBpbVJCmowLSq74jjH8dhnmeYH5FZ8DfHBm8HxGw
         RDkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=B6H/bsprACHYwfP1VnZci/atvKi9rC7jAoAwzWHNDIk=;
        fh=6bRgpkLV6M7P+A4qPePnCa3QL7KySDInLKUqIs3PgX8=;
        b=KFuSbfCbtawyUBK1eHfc3i9U4rfiLHEdGCsmzWxmPZzbffmfCUEYcuPlgVK38YfTig
         pBsvsCD1kSRycZz6HBRhmm7YfW1g31nbm1lWhbB9qtzFf0jPfBSdqsR2MMACOWvsBA6I
         gI/Ou2rnvpDxtnGCb9gx2ONbgPtzJYZRXr+lxaJg9Wy/oXwC5VRUUugMKusMGv715vbS
         J/4CRdAT+nU2gh9yP4eMrUHFR6kIgaUdhNdVLvKnv1DQxe4r/fTC4pCy3M4Q3r+yqOma
         awucrEK1q6o6YLZcAaqQdzAX4yj1Kwu1DIOtxQcHlaEhcUPme/uN8TKOKbYRxKmNcA4I
         fwuw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20251104.gappssmtp.com; s=20251104; t=1780588408; x=1781193208; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B6H/bsprACHYwfP1VnZci/atvKi9rC7jAoAwzWHNDIk=;
        b=Ki36pezfroNZ00TWgwOyv1bhwKzyXoVErW730CyWzm5FcG5SFdoDEJgmBWIeqbxWZk
         lXgsrP6YEQQyRBw67qTfBjwPT2XA0XoP3rDmxLpgxLZrGwOCIEd5bgUc8RuYI7kjsHPm
         sB6k397Sg2oYiCFyaHPFJQA7mAtq4wYrrJMRSEeVouy/rgYOjFUSOrGp28doHVbths0S
         H3YVmcETocR8ENK5pVeBF+alXPKsa3wDZ806XR6FLMn62lvKn8tKdSDIh1PENoyDLm5+
         +E86ZOQAkJig7e4pqjpW4RqfQDKF91Ghp5SoCOjeBe+v8+kTC3LF0ieeGLqf8kS5nD7n
         Aq1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780588408; x=1781193208;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=B6H/bsprACHYwfP1VnZci/atvKi9rC7jAoAwzWHNDIk=;
        b=o82rN+7kAVdn2GRNEzFmYzl8+6Lglz6jADC7TM8KqKBb51YcEGNnlwolHeWQgXR8YY
         px89AoE9TCgiF+DP0LC8heW/KWBb4F4E60X8fuomTlYlXM+1wCpFkuzJc4zHsiPN5g6+
         GUGUSx7B78i/eHWEuQbeVn+WotaHDyEontjO3Aq8Ji7uUXb7eiSy82S8KP8Z0qRPYnbn
         ictaR774Nd6q/VpcoKHx+x1z69lHvocjt7s5/r+hAa1Cu7lJVeaRwuJ90tCGVyn9S1s5
         Jy1cTGEjk47xQQAc6HlyCpj1/P54qM0jWpUhNhNNFGKF3GcYn7P7v/TPIij6dEezBent
         LJLA==
X-Forwarded-Encrypted: i=1; AFNElJ//PrQANLrd1niObj+Xvhg1tnncSk6LNb9GTORNU7Z40JLNJcFfuhwg42K6W3r2OFhsk3znKshLQKVDf0I7@vger.kernel.org
X-Gm-Message-State: AOJu0YwkFDXijgycW1S1ILHfraErYPKntVkU00gJkElehSM7SuRcUXoi
	/iiL7eINSgfO8in3BG2zKgbJSsQKydA4VoKzZxIMAF8KBRK5Ht1/0kE2V7D4hADVg17KYEfHrCI
	wR89YBIcrX3+8qNYGZNYIl2UJdcw5py5Pex7ZT3lH
X-Gm-Gg: Acq92OG4oUAySSVE2n8y9Dp69RtGPH0+gOCz0wuc1294+EV30cTpfFFSNIBkkVRIXi5
	Zyi1B9pz1zyA2rZ1bkvCfYt+n9n45lJ3buzhuzJ6DHB6JchDBNnSYkEuqjIAAJqsNYqJfa99tVC
	DPBjPoRO3qXQFVsNj8KUUqU3gHCmKjTU4Przw4C/wL9/yc/aSXzYhmXlAjXcANnQwn78soeaLrv
	9wwoEASA05/mPgNcvDERubtWpq/ZiU1iKB0voWTT5yUUKBWuxmmpWR95M0KAjdnT9Kl9hD1nil0
	DSGpRXhXMbzFHySAlEWkpVVc0A==
X-Received: by 2002:a05:6512:3186:b0:5aa:7126:c63c with SMTP id
 2adb3069b0e04-5aa7c0888ccmr2415181e87.5.1780588407521; Thu, 04 Jun 2026
 08:53:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260531010107.1953702-1-safinaskar@gmail.com>
 <20260601-enthusiasmus-canceln-anlehnen-0e62317a9784@brauner>
 <CAHk-=wifX_rrDjRGnDnOqE-usptAukuXKrmuPuVDP5bOCBWzGQ@mail.gmail.com>
 <20260601173325.GH2636677@ZenIV> <20260601160455.2c187574@gandalf.local.home>
 <20260601172825.a51a588ec1c32617a0e12d78@linux-foundation.org> <aiEb8CTM-ovMIq7-@1wt.eu>
In-Reply-To: <aiEb8CTM-ovMIq7-@1wt.eu>
From: Andy Lutomirski <luto@amacapital.net>
Date: Thu, 4 Jun 2026 08:53:15 -0700
X-Gm-Features: AVVi8CcFmOEXliFqkwckAyyy2jg3Zlvf93FEoWWD2xBje7cN4CAoI605l5f9FiY
Message-ID: <CALCETrULMixRGJyGqAAujW7RN6PP2f_Orn2Y_0hpPMjRqQnY7Q@mail.gmail.com>
Subject: Re: [PATCH 0/3] vmsplice: make vmsplice a trivial wrapper for preadv2/pwritev2
To: Willy Tarreau <w@1wt.eu>
Cc: Andrew Morton <akpm@linux-foundation.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Al Viro <viro@zeniv.linux.org.uk>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Christian Brauner <brauner@kernel.org>, Askar Safin <safinaskar@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-api@vger.kernel.org, netdev@vger.kernel.org, 
	Matthew Wilcox <willy@infradead.org>, Jens Axboe <axboe@kernel.dk>, 
	Christoph Hellwig <hch@infradead.org>, David Howells <dhowells@redhat.com>, 
	David Hildenbrand <david@kernel.org>, Pedro Falcato <pfalcato@suse.de>, Miklos Szeredi <miklos@szeredi.hu>, 
	patches@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
	Jan Kara <jack@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 3, 2026 at 11:32=E2=80=AFPM Willy Tarreau <w@1wt.eu> wrote:
>
> On Mon, Jun 01, 2026 at 05:28:25PM -0700, Andrew Morton wrote:
> > On Mon, 1 Jun 2026 16:04:55 -0400 Steven Rostedt <rostedt@goodmis.org> =
wrote:
> >
> > > On Mon, 1 Jun 2026 18:33:25 +0100
> > > Al Viro <viro@zeniv.linux.org.uk> wrote:
> > >
> > > > On Mon, Jun 01, 2026 at 10:17:23AM -0700, Linus Torvalds wrote:
> > > >
> > > > > TLDR: maybe we could ghet rid of "f_op->splice_read". *That* woul=
d be
> > > > > a big simplification.
> > > >
> > > > FUSE might be interesting - fuse_dev_splice_read() and its ilk.
> > > > Communications between the kernel and fuse server at least used to
> > > > seriously want that, so that would be one place to look for unhappy
> > > > userland...
> > > >
> > > > splice-related logics in fs/fuse/dev.c is interesting; another plac=
e
> > > > like this is kernel/trace/, but I'm less familiar with that one.
> > > >
> > > > rostedt Cc'd (miklos already had been)
> > >
> > > Thanks for the Cc. The tracing ring buffer was specifically made to b=
e used
> > > by splice and the libtracefs has a lot of code to use it as well. As
> > > reading the ring buffer literally swaps out the write portion with a =
blank
> > > read portion, that portion (sub-buffer) is used to be directly fed in=
to
> > > splice, providing a zero-copy of the trace data from the write of the=
 event
> > > to going into a file.
> > >
> > > trace-cmd defaults to using splice to copy the tracing ring buffer di=
rectly
> > > into files to avoid as much copying during live recordings as possibl=
e.
> > >
> > > Whatever changes we make, I would like to make sure there's no regres=
sions
> > > in performance of trace-cmd record.
> >
> > Well yes, The patchset seems sensible from a quality POV.  But to make
> > a decision we should first have a decent understanding of its downside
> > impact.
> >
> > I haven't seen a description of that impact in the discussion thus far.
> > And that description is owed, please.
> >
> > I assume a small number of specialized applications are using
> > vmsplice() to great effect?  What are those applications?  What is the
> > impact of this change?
>
> > Once we are armed with that information, is there some middle ground in
> > which we de-feature vmsplice()?  Fall back to pread/pwrite in the
> > tricky cases and still permit vmsplicing if the application is
> > appropriately restrictive in it usage?
>
> I'm using vmsplice() + tee() + splice() in high-performance applications,
> load generators to be precise, and soon a cache. This is super convenient
> and extremely efficient:
>
>   - vmsplice() is used to prepare a "master" pipe with data to be sent
>     over TCP or kTLS
>   - then for each request, we do tee() from this master pipe to per-reque=
st
>     pipes.
>   - the per-request pipes are those that are used to deliver the data to
>     the socket via splice().
>
> So we effectively use vmsplice(), tee() and splice() here, and for exactl=
y
> the reasons they were designed: only play with page refcount and not copy
> data. The code is here for the curious:
>
>    https://git.haproxy.org/?p=3Dhaproxy.git;a=3Dblob;f=3Dsrc/haterm.c
>
> and its ancestor is here:
>
>    https://github.com/wtarreau/httpterm/blob/master/httpterm.c
>
> It simply doubles the network bandwidth compared to not using that.
> (62 Gbps per core vs 31). I would seriously miss it if I couldn't use
> this anymore.
>

Wait a moment.  This is neat, but it's literally just a benchmark,
right?  I skimmed the code, and it doesn't look like a production
workload, either.  And you manage to get around the awfulness of the
vmsplice API's complete failure to tell you when it's done with a
buffer by ... never actually changing the contents of the buffer.  Do
you have any idea how you would write correct code that uses vmsplice
for sends and then *ever* mutates the data without literally
munmapping (or madvise or something) the data do you can safely mutate
it?

> I also have mid-term plans for using vmsplice() to deliver contents from
> a cache to sockets as well via splice(). Right now our cache is split int=
o
> too small chunks (1kB) to make that useful, but as soon as we can move to
> 4kB pages, it will make sense. There the same gains are expected, and I
> would particularly dislike the idea of no longer being able to implement
> zero-copy!

If I'm understanding you correctly, you see (and measured!) a
performance improvement, and you would like to use it in production.

It seems to me that this is an excellent opportunity to remember that
vmsplice gets a performance boost in a highly synthetic situation that
sort of resembles a cache scenario and then to deprecate vmsplice and
build something better!  Or discover that we already have something
better, perhaps :)

https://man7.org/linux/man-pages/man3/io_uring_prep_send_zc.3.html

I see that this can submit a buffer without a syscall (tee + splice is
*two* syscalls!) and that it has directly addressed what I see as the
really big deficiency in vmsplice: "This second notification tells the
application that the memory associated with the send is safe to get
reused."  If I were writing the user code, I would very much want that
notification to be an explicit part of the API instead of making a
wild guess as I think I would need to do with vmsplice.

--Andy
