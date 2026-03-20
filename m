Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C87CC3D3304
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Mar 2026 17:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774027512; cv=pass; b=RxgedjSMSF1Ndya0VRtyA/fb5GqniYs7uPWgqPwKf4xotdpc639G5nT03JreZzUS5b8iO+dsCLu5iyD69iQ+sGm62De0alLuTo5lkuhxOKDwK7TdIO2E09DdtPbLgeSkUmA60g6jUq1Cjdm2k0l27QjohuGHucWiQv8oGScyP0M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774027512; c=relaxed/simple;
	bh=UgeXQlPGDlPxGq3slSMV12stmd1VxJnpC2gcHGNFrPY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jwosFF1Ayb+akcUel62XFJQ5NxTwN3s1m9wPRbWG94DtW0n9bn8/k4Gq5mHiqGb+EDSDO0tD57h1bBL6qusk48FazYoCiEMSg5UWtkUl0kxaVN1aDPgoxAPwFqDzz4J72Kd+2bXWg0E0rUA45YnOBrf8UKlUO9Gk2naExUjUu8A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NiPiceKL; arc=pass smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NiPiceKL"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-486fd3a577eso7110995e9.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 Mar 2026 10:25:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774027506; cv=none;
        d=google.com; s=arc-20240605;
        b=E/eK57qIT5OXg8+BJze0SKam6S8Ryqd42k+gEGVJPa2CxOiLcluNiRqlE+FIcM8QE7
         0K086fQJFBTYEhd/FtaT+flVkDTJTyLG5ZiRNbuehk/87kCS4LfeM5sl1sdrxTd2Bshp
         ZuXAouTm7HuZzPqY0qJyeKEhxoyiMzvfgaKPaiWu9TYLGly44Mjsip3QujGg9SATgqAW
         AhUXaQi/JnxQ314jhrVHBffx9jxgZwa7EBtWuN9OCIls11ed2ml9H6R1M+Gh45l0Mp8e
         Wey+LMdbkUkBDiuRofkY+S/pDK4yAWe+cPnIn//No9tZ5JNvpSRqFDw4VZjNh60r8tAc
         HQLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cU/+nJJZ/L9CHYBm4FEMqeFeK60NO+uIvGUprvjyUlo=;
        fh=Rb7GnsONw77xGCRa3o7MlfNYKclax9l1rvoT05X3jfs=;
        b=Fsf8gKMWZAvd+/mUnemgXEpa6EZHOoIoN6H4XWlPmCErqmP8MM045mL5Oh/nHLyVtG
         GiThkLibX2Y5d20kW0EwsUrk1//Mu17gBWhtZ5pFCU98cObyiGEUg86wCe86W2fzTnOQ
         Pv56WQ3jpfyalHmFqsWYqcLkzjb9kPyEUKgdllaofPYxUiO1QxgJyXkN/aZviJ4zsLBR
         HpPivbiD0aifw+qcJi91FqtGg4mWSLhI+YJPGBGvVvAX0yOgcbi0WqDGcjY9c3YdIoYY
         AKBCOWlyN9Lo8Q0vxVE7FMrI9nKZMQxK2w9VgahOCZCRz0GXxv7wIb5RIelcTculzaTR
         x16w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774027506; x=1774632306; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cU/+nJJZ/L9CHYBm4FEMqeFeK60NO+uIvGUprvjyUlo=;
        b=NiPiceKLN1A6Qyr9IxLKS7YuN4qIr30cFWzdsH3qQFCr7gpLlZUT8hdmKsOYHjZcAJ
         1U8y694y8oJfpjE4mh0z4X3eW9SeX/oddLaG/4sHofx+iscx7bGqpd1sCLZyawhrQwWN
         TTv26aStgjJtW3ybBd3bu6Jm4YYmwFSogjPxVl2ZrBgUi+KElyBJoRnQqQQ1ZLEmqbD2
         gVAlKjOm3tVwJBhjb75VUhuPaI6AlnuOOvgd1foZTC9KWn4teBqKTbzSBI18A1Wj93k/
         sP5Epma6dovyrUctOBPN9LBzd4uGoCJyPkllJZHUm6gAmP3aUsviVU8OR+FGDEGSLoX/
         tBXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774027506; x=1774632306;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cU/+nJJZ/L9CHYBm4FEMqeFeK60NO+uIvGUprvjyUlo=;
        b=BHREwoDt93eFKHC56jgHBsn6kMFmOaagurKt73xjzg/M2TzWp381oNc47gbn0klHAw
         RatQRJYaUKsRQZV3ANzWuxRtQBM5fxfo+XEfjscRUJG9a2b0OajvZk4X9x5o9Lwp+hVW
         JtJVJRloacSfIn7mJhdYwOFhmGfOpcDOrLnqBn3LeRKzrXAlgpBbY37N1XiGeLDFkCjy
         pH6oBZDkIvZBTHvP4tRM1YB2+cdSWRv8YIN5gTFbJNCcWMrOrP1moHiGGuGJ4W7gaYj1
         oWoIGMNI7ca4SFyh9gGSuFezwhKsFhXb8hjUM1EsZ01kfBWZGhE709ZHfXvOAR8QE78Q
         5ZwA==
X-Forwarded-Encrypted: i=1; AJvYcCV71Csbz9ZwYtaU0RohK1jHT4BLZyneLgDD29WaV0ThLXOtf8NciE0WXXqojGruuVYc7I7F3RfcpkvB2L8C@vger.kernel.org
X-Gm-Message-State: AOJu0YxjOlul/HGjvwr455mg0W5RWLRKWh3k7Ntp1Ra7N9BAExeHwJ29
	VEIcxUoj8I65IsDY3unnYqWJseqtP6vu/N8mOKJvjaf1Il3b487ArpkDhrfq6OXn2gqbwOUi/Ek
	iVeAu2fMT5Ln82cHOo135qsA6N96gHI4=
X-Gm-Gg: ATEYQzw/VtQIE49gq/OPcBSU1PywmTt1uOSHUnD4T5hU4L+f6RZ4TX4slN1S5Wxc2wG
	hsPCSj/YKXvvtrJq9mKeY6w6HzBrGAbXf797DFJhPY8MGMt0pA5E6Fe2144agZmKyYuKhCdOkoU
	RGNG/fvmEikYSJcZNuSzhSdcCwaVDm1uHub90CK6yH+gCgBgI73hA2tVJGh0jaDJ5ZnxZarAVpF
	hWlLeZBRqGQKr//Jp0/yYrbkBiI1V/MrzKR8r5IvA5LFAxBGPRPJd1pPYcxq6DALH4PTcBB6hCC
	u1cgWA==
X-Received: by 2002:a05:600c:8583:b0:485:3f1c:d8a1 with SMTP id
 5b1f17b1804b1-486fedb9631mr50643855e9.9.1774027505549; Fri, 20 Mar 2026
 10:25:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260316-mark-dirty-per-folio-v1-1-8dc39c94b7ce@ddn.com>
 <CAJnrk1Yyp+3YDYNTzyTUQLUDsiQ9WB181-mu1FOpGyaVTu=_1Q@mail.gmail.com>
 <abhg4tbxDhYO_iHV@fedora.fritz.box> <CAJnrk1bBu5VJYnoZcV3uaS7+uyxK6TK9SLDtF2WpcRNfhUvO6w@mail.gmail.com>
 <abqvmS4adTXVxFIW@fedora.fritz.box> <CAJnrk1bF0JFAWOF=4hjMhiciSLrvob268fcQgv3P28Po8J=qwQ@mail.gmail.com>
 <60103445-0d45-427c-aa00-2fa79207b129@bsbernd.com> <CAJnrk1aWgWxzh0ETFkZXvJcfHFAC8KESEBLXa2S=ZqDfSSssvA@mail.gmail.com>
 <20260319042727.GA3496922@frogsfrogsfrogs>
In-Reply-To: <20260319042727.GA3496922@frogsfrogsfrogs>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Fri, 20 Mar 2026 10:24:53 -0700
X-Gm-Features: AaiRm52X3ArfsEAWqFoRiT8JwjUta7EPXY6wVM_TXwaut0sFg3oo1ARbLqXHNac
Message-ID: <CAJnrk1aorGz857YkO2VC5C5obieKVRqacOXoOT1=9unWFmzSKg@mail.gmail.com>
Subject: Re: [PATCH] fuse: when copying a folio delay the mark dirty until the end
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Bernd Schubert <bernd@bsbernd.com>, Horst Birthelmer <horst@birthelmer.com>, 
	Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Horst Birthelmer <hbirthelmer@ddn.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 18, 2026 at 9:27=E2=80=AFPM Darrick J. Wong <djwong@kernel.org>=
 wrote:
>
> On Wed, Mar 18, 2026 at 06:32:25PM -0700, Joanne Koong wrote:
> > On Wed, Mar 18, 2026 at 2:52=E2=80=AFPM Bernd Schubert <bernd@bsbernd.c=
om> wrote:
> > >
> > > Hi Joanne,
> > >
> > > On 3/18/26 22:19, Joanne Koong wrote:
> > > > On Wed, Mar 18, 2026 at 7:03=E2=80=AFAM Horst Birthelmer <horst@bir=
thelmer.de> wrote:
> > > >>
> > > >> Hi Joanne,
> > > >>
> > > >> I wonder, would something like this help for large folios?
> > > >
> > > > Hi Horst,
> > > >
> > > > I don't think it's likely that the pages backing the userspace buff=
er
> > > > are large folios, so I think this may actually add extra overhead w=
ith
> > > > the extra folio_test_dirty() check.
> > > >
> > > > From what I've seen, the main cost that dwarfs everything else for
> > > > writes/reads is the actual IO, the context switches, and the memcpy=
s.
> > > > I think compared to these things, the set_page_dirty_lock() cost is
> > > > negligible and pretty much undetectable.
> > >
> > >
> > > a little bit background here. We see in cpu flame graphs that the spi=
n
> > > lock taken in unlock_request() and unlock_request() takes about the s=
ame
> > > amount of CPU time as the memcpy. Interestingly, only on Intel, but n=
ot
> > > AMD CPUs. Note that we are running with out custom page pinning, whic=
h
> > > just takes the pages from an array, so iov_iter_get_pages2() is not u=
sed.
> > >
> > > The reason for that unlock/lock is documented at the end of
> > > Documentation/filesystems/fuse/fuse.rst as Kamikaze file system. Well=
 we
> > > don't have that, so for now these checks are modified in our branches=
 to
> > > avoid the lock. Although that is not upstreamable. Right solution is
> > > here to extract an array of pages and do that unlock/lock per pagevec=
.
> > >
> > > Next in the flame graph is setting that set_page_dirty_lock which als=
o
> > > takes as much CPU time as the memcpy. Again, Intel CPUs only.
> > > In the combination with the above pagevec method, I think right solut=
ion
> > > is to iterate over the pages, stores the last folio and then set to
> > > dirty once per folio.
> >
> > Thanks for the background context. The intel vs amd difference is
> > interesting. The approaches you mention sound reasonable. Are you able
> > to share the flame graph or is this easily repro-able using fio on the
> > passthrough_hp server?
> >
> >
> > > Also, I disagree about that the userspace buffers are not likely larg=
e
> > > folios, see commit
> > > 59ba47b6be9cd0146ef9a55c6e32e337e11e7625 "fuse: Check for large folio=
)
> > > with SPLICE_F_MOVE". Especially Horst persistently runs into it when
> > > doing xfstests with recent kernels. I think the issue came up first t=
ime
> >
> > I think that's because xfstests uses /tmp for scratch space, so the
> >
> >     "This is easily reproducible (on 6.19) with
> >     CONFIG_TRANSPARENT_HUGEPAGE_SHMEM_HUGE_ALWAYS=3Dy
> >     CONFIG_TRANSPARENT_HUGEPAGE_TMPFS_HUGE_ALWAYS=3Dy"
> >
> > triggers it but on production workloads I don't think it's likely that
> > those source pages are backed by shmem/tmpfs or exist in the page
> > cache already as a large folio as the server has no control over that.
>
> /me stumbles in-thread to note that xfs gets large folios for its files'
> pagecache fairly frequently now, especially as readahead ramps up.

Oh nice, I didn't realize that. Though I wonder if the pages are
backed by xfs/ext4/etc, it seems like any high-performance server
would just use passthrough and skip splice altogether?

Thanks,
Joanne
>
> Ok back to the hell that is deploying ClownStrike through a Java program
> while Firefox repeatedly drives my laptop to OOM.
>
> --D
>
> > I also don't think most applications use splice, though maybe I'm
> > wrong here.
> >
> > For non-splice, even if the user sets
> > "/sys/kernel/mm/transparent_hugepage/enabled" to 'always' or in
> > libfuse we do madvise on the buffer allocation for huge pages, that
> > has a 2 MB granularity requirement which depends on the user system
> > also having explicitly upped the max pages limit through the sysctl
> > since the kernel fuse max pages limit is 256 (1 MB) by default. I
> > don't think that is common on most servers.
> >
> > Thanks,
> > Joanne
> >
> > > with 3.18ish.
> > >
> > > One can further enforce that by setting
> > > "/sys/kernel/mm/transparent_hugepage/enabled" to 'always', what I did
> > > when I tested the above commit. And actually that points out that
> > > libfuse allocations should do the madvise. I'm going to do that durin=
g
> > > the next days, maybe tomorrow.
> > >
> > >
> > > Thanks,
> > > Bernd
> >
