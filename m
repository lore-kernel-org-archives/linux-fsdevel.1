Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AD121FD4
	for <linux-fsdevel@vger.kernel.org>; Thu, 14 May 2026 23:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778801061; cv=pass; b=YfH5zGP3NqmIsdMkWGzlqsV3BVrktMr172+zU+B1g7pEncymm5Nmi/djU/YGqjhk92LHzybhNS1cKWOxb23LkF2HVuLCAgzC27oEGCZYCSDQ3pPssx8HhGIGz+9OLdGecRSROjeh4N0UCFg2ZocwjXayWWKnuo0RUbF8eAn+BIw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778801061; c=relaxed/simple;
	bh=n2kI/vzB3YqxM63/gcxPKMamba/3wBKX7ld8X/RpSkY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X3CiqTmgk7fePyMfnxjc7XPitVtFWOTK9VolBn+0LEZ6c2YK42FmMSO8B5QRCA1e2b0YHviWlLK4u5Sj/twFb68+IflaAja6WDwx/6WAAMg6HMXUBy9AcSbukC+UCblyNVFE61FKNt6K4ddWIrCKKYT9JY/ce7cXIOzbSsJduxM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fgaCsfr0; arc=pass smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fgaCsfr0"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-43d7e23defbso5071957f8f.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 14 May 2026 16:24:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778801059; cv=none;
        d=google.com; s=arc-20240605;
        b=e5vrovgnYHEm20pRDnOMiLt+ByLH5xmUsSzTtM9u4mXLDT5jM9LMRUf3wbrmsPV3RF
         vuZ/cItR54NpEjRpegj9wgfVico4HuifxzgKCpGvCx3ZhlpgfFEvh24mc73/9It3MNfr
         +8Cg2SKBRQO1cbFsyzMSCEdENhoEo/E7tR6/rWdKd5L77tyoFh1t02PgozJ9WdnqboBF
         AQKfStXNGyRP6NVqvbvHWzJOciP7x7J1rTHrnHtR81NmE3w60hSASZIcOPrmFW3iz5uk
         dvnVYTKvxk1jXztTD7k4iaODZGziBIHsmpcxqeZpEUC10rwYicVTXsbclynBu495/8Pw
         AQZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bcaWx7Y47zh9+hIVWvCfvsIDsSTkboyGUiKVaWiAEaQ=;
        fh=csu8o+Hx+fqv9VMqN88mefSlB/xdZpofZ2M+K/fA7ys=;
        b=VH3ONb9o584BAUnPSmHVPTMze5DcNx2ScG8bHXpF32kHuOrIlFH+licxYeuaHtArWi
         pU75iHvWtOql8tTTEkbw6Xss13djtSrWfHxNADLcsPL7FeVzg8Pf4b/31lX3CGYhjLRr
         SWPmXeb7az4SUQ76U9SCssZ8SXqHl9zvaJ9LJQigKIHZhbUnGXOr8r2TJ28BsrGqmynM
         y3Zc2+4E4rAzypkQ3SLx6tggsZ8wzyRPCIPgvEokQNR0Yl14jKYWP/I5RL+dSsNTLBdg
         r8B3u8VHpdRtNl8w+bj/MeWHyVJK2Unzsexn6+0xrViZP2Fi2whqjmWeYRLM4PXiOb1X
         SqHg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778801059; x=1779405859; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bcaWx7Y47zh9+hIVWvCfvsIDsSTkboyGUiKVaWiAEaQ=;
        b=fgaCsfr0Bll/8FQL3MqV5jtqrFUTxgTgsxhVji8NS6ntXGfLxuNuZC0IWUzm7XKfxb
         qWxy2JYjdEnz2mTx4PX9jM00bJpn7dBtl13iVIRRjhqcfJXLlDZmyfdfueiFmjx6Uldt
         ErrvWDgZ3a+KnmNvFA6JdoF9XBy13apctayqaNMHG0qH16Bg/2XnWI1XqwYtrSAcP/NZ
         S+qWUyk8ThR3++KtFDhD24YcCgdibtf9ZQwEjpoDkDwBoEwzMXYU+UVy8SO30ScTpPAp
         gIm3N7Fn4KpKcWxkF+p1kpnGnlIrfqLjraF2FbH0HO1pUn5P4Lfdz4GwKrcGfHrJ/gmY
         QMow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778801059; x=1779405859;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bcaWx7Y47zh9+hIVWvCfvsIDsSTkboyGUiKVaWiAEaQ=;
        b=dS0RNPFrO22LZPhHoPTYAgzcVvaDcM7US51mqYQEycm8AarFw6qoJeY8vAUai4pkdz
         lKcmAdDdCc13RvKHbYaNwva4jJ6dEMqFv7b01h/zLh6R2eYdHLI09KI4UE8Co/08pcT1
         m7e9aRcsYgmQ94XGZulC6xX8CtPUejgJow7UQIHZzIi0Mmu6rRTWY7rBkoaIpPriH/lO
         B8Q5ef/0f0Oqa00ZsvHtqXmoORtrZF7etXH+qXk1i035rn0eIQ5qvOLzodKeHflIcazc
         B53hTWcKfdbVm0znzE7DzO9HSOeUKthm3V3lOkzbSIQh5+DApXRQrUAFIIVaLn6gAelW
         0UiQ==
X-Forwarded-Encrypted: i=1; AFNElJ9Ed2ihnJGZTmhSu5llIp5GJ3wAW35V0qCoR27X7Nj9uIknzXwRxKqbk2vX60zfIP3B1wB4lFkx1QGtpBM2@vger.kernel.org
X-Gm-Message-State: AOJu0Yyj8yTW9qiTTcacM5eRhp4oxr2qLt5baVVAcj5j6KWDzmmRHE4P
	Scxr5K5xDvhuK1Ph4bMfVarLDWae3FpkyhfFvqUPg5/A78UMoY/VU/u7hyx737LuUsdoBJfuQdu
	0+qZlcp/E73BnMHjB6LaCx2ujaLz4N5Y=
X-Gm-Gg: Acq92OEPEZGfhius6xADxnCO1tSjWsmGUtcTcIL2UjJyZYWxx7PPsdN5KV0WM/yiZQi
	kFLFrl9EtaAmpPfmS4JX4pP8mDvnDMXqCf6uPm7AN+9A8v328Tc2y90WNfFzL15Cq5ieb5GZD9O
	uNEstVU/aBnGj96iKJnFIEvn31FMPCy2exeW9rSr/Ulf0KsoldKEDBIRiSLWLyIGwovM7NdseS4
	JdX4oIiVxOz/n3y1lRW0i9ZytgEIPkglu8FljYP++o7gRZM6oRE6fzU6NcUujJSpd7hhEVBIXed
	nDwlJiywKZhoYHXl
X-Received: by 2002:a05:6000:1863:b0:43c:ffb1:2214 with SMTP id
 ffacd0b85a97d-45e5c5cbe3amr1481467f8f.16.1778801058585; Thu, 14 May 2026
 16:24:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260429102058.1362965-1-mszeredi@redhat.com> <CAJnrk1Z_JWtuA3UjucF9=YH63AH_-J_0hzr9jbY99Hx3O8YrAw@mail.gmail.com>
 <CAJfpegspraqMp1Z3mi_csiw6haawZPa4zWheSUN7MhBy47aYKQ@mail.gmail.com>
 <CAOQ4uxgV4_Pet0w3f+Sq4kLkvgKM6FyJwZ4AQsnvctC3w=dP6g@mail.gmail.com>
 <CAJnrk1ZvB-R3Szn-VxOZvPRgX_dXwMLouBphnT9_URCE8SxTvQ@mail.gmail.com> <CAOQ4uxidwSn69A08Urue7S7n8wrGQcyGuvRL387pD+rpSFP-Ew@mail.gmail.com>
In-Reply-To: <CAOQ4uxidwSn69A08Urue7S7n8wrGQcyGuvRL387pD+rpSFP-Ew@mail.gmail.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Thu, 14 May 2026 16:24:06 -0700
X-Gm-Features: AVHnY4KRTbyDYmFmjBDo8tWwUWvp3R6Xim4acRrdZRen_T-7cWVXIPm5HeZyFa0
Message-ID: <CAJnrk1ZJ1pVWn21HZATRes55RJD0F0+6SHbq-8FojPutQTiW6Q@mail.gmail.com>
Subject: Re: [PATCH] fuse: add fusex filesystem
To: Amir Goldstein <amir73il@gmail.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Miklos Szeredi <mszeredi@redhat.com>, fuse-devel@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 12, 2026 at 2:28=E2=80=AFPM Amir Goldstein <amir73il@gmail.com>=
 wrote:
>
> On Tue, May 12, 2026 at 9:22=E2=80=AFPM Joanne Koong <joannelkoong@gmail.=
com> wrote:
> >
> > On Tue, May 12, 2026 at 6:22=E2=80=AFAM Amir Goldstein <amir73il@gmail.=
com> wrote:
> > >
> > > On Tue, May 12, 2026 at 11:31=E2=80=AFAM Miklos Szeredi <miklos@szere=
di.hu> wrote:
> > > >
> > > > > * in passthrough: backing_fd passed at lookup/creation time only =
(not
> > > > > at open time), expanded struct fuse_backing_map
> > > >
> > > > Yes, this needs discussion.  Amir may have additional info on this.
> > > >
> > >
> > > Having the two different lifecycles (open-to-close, lookup-to-forget)
> > > is by design.
> > >
> > > This allows the server to potentially move files from passthrough mod=
e
> > > to caching mode and vice versa, as long as all fds are closed.
> >
> > I'm unsure how useful mode switching is between caching and
> > passthrough because the server has no control over when the client
> > application closes all its fds (eg it can only react but not trigger
> > it).
>
> This is debatable.
> My passthrough fs server coordinates state changes with HSM
> using flock on open files.
>
> Previous implementations used to allow using cached mode
> until the file content is fully downloaded, which could be beneficial
> when streaming large media files.
>
> Current implementation uses the DIO or PASSTHROUGH modes.
> I have not yet collected enough real world stats to know if this is
> a problem for large media files streaming, so would prefer to keep
> the options open for now and I see no reason to deprecate the
> open-to-close lifecycle. I don't think is adds that much complexity
> to the code (?).
>
> > For my internal use case of switching on passthrough, I was
> > envisioning the server handling everything through direct io until
> > passthrough is possible (eg the remote file has been fully downloaded
> > over the network) so that passthrough can be switched on even with the
> > application having open fds.
> >
>
> Indeed, being able to switch to passthrough for new fds is a big win,
> which is why I also changed to this method in the current implementation.
>
> > >
> > > Adding inode passthrough ops does not play well with this mode
> > > this is why it requires the lookup-to-forget lifecycle, but I see no =
reason
> > > kill the open-to-close lifecycle as it seems useful for servers that
> > > mostly care about I/O passthrough.
> > >
> > > w.r.t expanded struct fuse_backing_map, at the moment it does not
> > > sound right to me to map a backing id X with more than a single backi=
ng
> > > file or device.
> >
> > My thinking with the struct fuse_backing_map expansion was that future
> > ioctls for managing backing files (eg attaching a backing file to a
> > live inode or swapping one backing file for another) might benefit
> > from a shared struct instead of needing to add new structs for each
> > type.
> >
> > >
> > > I think that the maps of fuse_file to multiple fuse_backing is better
> > > handled by another layer of mapping (sort of a backing_mapper)
> > > which is what famfs and iomap need, but it is just my initial thought=
s.
> >
> > I like this idea a lot, it makes sense to me.
> >
> > >
> > >  Joanne, if you are a concrete use case for that, let's try to see
> > > how a design to this use case may look like.
> >
> > The internal team I'm working with is planning to start working on
> > their server in H2. They will run some benchmarks to see if current
> > passthrough and/or io-uring+zero-copy might get them the performance
> > gains they need, or whether they will still need the set of advanced
> > passthrough features they requested. I'll keep you posted once there's
> > performance data and if there is still a need for the more advanced
> > passthrough features (file mapping to multiple backing files, backing
> > files dynamically changing, enabling passthrough on a live inode),
> > I'll draft up a design doc to get your thoughts on.
>
> Sounds good.
> FYI, some of those issues we try to solve at application layer.
> Our HSM application always tries to keep the inode itself across
> state changes.
> For example, by using clone_file_range() to fill in content.
> With xfs, we could also try to use atomic swap extents, if file content
> can change, instead of changing inode, but we did not try this yet.

Thanks for the info. This is useful, I'll look into seeing if some of
these requests can be solved at the application layer.
>
> > In the meantime,
> > I'm planning to send out v2 of the inode metadata passthrough patchset
> > sometime this week or next with your feedback from v1.
> >
>
> Cool. Let's get this rolling.
> I need to get my test setup back in shape.

What is the test setup you are using? fstests with passthrough_hp or
are there other tests in addition to that? If there's other tests
you'd like me to run besides fstests, please let me know and I'd be
happy to do that.

When I ran fstests yesterday with passthrough_hp, I saw generic 683,
684, and 685 (dropping suid/sgid on fallocate, fpunch, and fzero)
start passing, but beyond that I didn't see any improvements (or
regressions).

Thanks,
Joanne

> There were a bunch of fstest failing last time I tested passthrough,
> mostly related to metadata cache coherency.
> I was hoping that GETATTR passthrough could solve some of them.
> If you have seen any improvements (or regressions) in fstests please
> share this info with the patch set.
>
> Thanks,
> Amir.
